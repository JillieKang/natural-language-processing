
setwd("c:/jillie/text_analysis_project/")
library(openxlsx)
library(stringr)
library(dplyr)
library(tidytext)
library(ggplot2)
library(ggwordcloud)
library(showtext)
library(sysfonts)
library(lubridate)
library(multilinguer)
library(KoNLP)
useNIADic()

post <- read.xlsx("권영국_게시글세부정보목록.xlsx")
comment <- read.xlsx("권영국_댓글목록.xlsx")
str(post)

### 키워드 '권영국' 포함 게시글이 작성된 날짜(x), 게시글 수(y) line plot ###

post$등록일
str(post)

# 날짜만 추출해서 새로운 열 생성
post <- post %>%
  mutate(date = as.Date(등록일))  

date_count <- post %>%
  count(date)
summary(date_count)
str(date_count)
date_count <- date_count %>% arrange(desc(n))

table(date_count)
date_count
post

# 시각화
ggplot(date_count, aes(x = date, y = n)) +
  geom_line(color = "steelblue", size = 1) +
  geom_point(color = "steelblue", size = 2) +
  labs(x = "날짜", y = "게시글 수") +
  theme_minimal() +
  theme(axis.text.x = element_text(size = 12))


### 키워드 '권영국' 포함 게시글의 일별 건수 elbow plot ###

# n값 기준으로 내림차순 정렬
date_count_sorted <- date_count %>%
  arrange(desc(n))

# 인덱스를 x축으로 사용 (1, 2, 3, ...)
date_count_sorted <- date_count_sorted %>%
  mutate(rank = row_number())

# 일별 게시글 수 elbow plot 시각화
ggplot(date_count_sorted, aes(x = rank, y = n)) +
  geom_line(color = "darkred", size = 1) +
  geom_point(size = 2, color = "darkred") +
  labs(x = "정렬 순위", y = "게시글 수 (n)") +
  theme_minimal()

# 날짜별 게시글 수 bar plot 시각화
ggplot(date_count, aes(x = date, y = n)) +
  geom_col() +
  theme_minimal()+
  theme(axis.text.x = element_text(size = 20))  

### 키워드: 권영국 수집한 제목, 게시글텍스트, 댓글텍스트 'final_df'에 정렬 ###

post1 <- post[,c("제목", "게시글텍스트", "게시글id")]
str(post1)

comment1 <- comment[,c("댓글텍스트","게시글id")]
str(comment1)


# 게시글id 하나에 대한 구조 예시 만들기
result_list <- split(comment1, comment1$게시글id)

# 게시글id 기준으로 병합한 리스트 생성
final_result <- lapply(names(result_list), function(pid) {
  post_row <- post1 %>% filter(게시글id == pid)
  comment_rows <- result_list[[pid]]
  
  # post row 먼저, 그 다음 댓글 rows
  bind_rows(
    post_row,
    comment_rows %>% mutate(제목 = NA, 게시글텍스트 = NA)
  )
})

# 최종 결과를 하나의 데이터프레임으로 병합
final_df <- bind_rows(final_result)
View(final_df)


# NA값은 빈문자열 ""로 대체
final_df$게시글텍스트 <- ifelse(is.na(final_df$게시글텍스트), "", final_df$게시글텍스트)
final_df$제목 <- ifelse(is.na(final_df$제목), "", final_df$제목)
final_df$댓글텍스트 <- ifelse(is.na(final_df$댓글텍스트), "", final_df$댓글텍스트)
final_df



### 텍스트 데이터 전처리 ###

# 한글 아닌 것 제거
UK <- final_df %>%
  mutate(
    제목 = str_replace_all(제목, "[^가-힣]", " "),
    게시글텍스트 = str_replace_all(게시글텍스트, "[^가-힣]", " "),
    댓글텍스트 = str_replace_all(댓글텍스트, "[^가-힣]", " ")
  )
UK


# 공백 제거
UK <- UK %>%
  mutate(
    제목 = str_squish(제목),
    게시글텍스트 = str_squish(게시글텍스트),
    댓글텍스트 = str_squish(댓글텍스트)
  )
UK

# UK를 tibble 형태로 변환
UK <- as_tibble(UK)
str(UK)


### 형태소 분석###

# 1. 제목 토큰화
title_n <- UK %>%
  select(게시글id, 제목) %>%
  rename(value = 제목) %>%
  unnest_tokens(input = value, output = word, token = extractNoun)

# 2. 게시글 텍스트 토큰화
post_n <- UK %>%
  select(게시글id, 게시글텍스트) %>%
  rename(value = 게시글텍스트) %>%
  unnest_tokens(input = value, output = word, token = extractNoun)

# 3. 댓글 텍스트 토큰화
comment_n <- UK %>%
  select(게시글id, 댓글텍스트) %>%
  rename(value = 댓글텍스트) %>%
  unnest_tokens(input = value, output = word, token = extractNoun)

### 빈도수 세기 ###
tin_freq <- title_n %>% count(word, sort = T) %>% filter(str_count(word) > 1)
pon_freq <- post_n %>% count(word, sort = T) %>% filter(str_count(word) > 1)
con_freq <- comment_n %>% count(word, sort = T) %>% filter(str_count(word) > 1)

# 문제가 있는 값 수정; 게시글 제목
tin_freq <- tin_freq %>%
  filter(!word %in% c("하네", "하게", "하면", "후보", "본인", "해서", "오늘", "이번", "들이", "어제")) %>%
  mutate(word = case_when(
    word %in% c("권영") ~ "권영국",
    word %in% c("심상", "상정", "심씨") ~ "심상정",
    word %in% c("이준", "준석", "섹이", "준섹이", "준섹", "스톤", "준스톤") ~ "이준석",
    word %in% c("이재", "재명") ~ "이재명",
    word %in% c("문수", "김문") ~ "김문수",
    word %in% c("민노당", "민주노동", "민노", "노당") ~ "민주노동당",
    word %in% c("더불어민주당", "더민주") ~ "민주당",
    TRUE ~ word
  )) %>%
  group_by(word) %>%
  summarise(n = sum(n), .groups = "drop") %>%
  arrange(desc(n))

# 문제가 있는 값 수정; 게시글 내용
pon_freq <- pon_freq %>%
  filter(!word %in% c("하네", "하게", "하면", "후보", "본인", "해서", "오늘", "이번", "들이", "어제")) %>%
  mutate(word = case_when(
    word %in% c("권영") ~ "권영국",
    word %in% c("심상", "상정") ~ "심상정",
    word %in% c("이준", "준석", "섹이", "준섹이", "준섹") ~ "이준석",
    word %in% c("이재", "재명") ~ "이재명",
    word %in% c("문수", "김문") ~ "김문수",
    word %in% c("민노동", "민주노동", "민노", "노당") ~ "민주노동당",
    word %in% c("더불어민주당", "더민주") ~ "민주당",
    TRUE ~ word
  )) %>%
  group_by(word) %>%
  summarise(n = sum(n), .groups = "drop") %>%
  arrange(desc(n))

# 문제가 있는 값 수정; 댓글 내용
con_freq <- con_freq %>%
  filter(!word %in% c("하네", "하게", "하면", "후보", "본인", "해서", "오늘", "이번", "들이", "어제")) %>%
  mutate(word = case_when(
    word %in% c("권영") ~ "권영국",
    word %in% c("심상", "상정") ~ "심상정",
    word %in% c("이준", "준석", "섹이", "준섹이", "준섹") ~ "이준석",
    word %in% c("이재", "재명") ~ "이재명",
    word %in% c("문수", "김문") ~ "김문수",
    word %in% c("민노동", "민주노동", "민노", "노당") ~ "민주노동당",
    word %in% c("더불어민주당", "더민주") ~ "민주당",
    TRUE ~ word
  )) %>%
  group_by(word) %>%
  summarise(n = sum(n), .groups = "drop") %>%
  arrange(desc(n))

# 상위 20개 단어 추출
tin_freq20 <- tin_freq %>% head(20)
pon_freq20 <- pon_freq %>% head(20)
con_freq20 <- con_freq %>% head(20)

# 재정렬
tin_freq20 <- tin_freq %>%
  arrange(desc(n)) %>%
  slice_head(n = 20) %>%
  mutate(word = factor(word, levels = rev(unique(word))))

pon_freq20 <- pon_freq %>%
  arrange(desc(n)) %>%
  slice_head(n = 20) %>%
  mutate(word = factor(word, levels = rev(unique(word))))

con_freq20 <- con_freq %>%
  arrange(desc(n)) %>%
  slice_head(n = 20) %>%
  mutate(word = factor(word, levels = rev(unique(word))))

# 단순빈도수 plot
ggplot(tin_freq20, aes(x = word, y = n)) + 
  geom_col() +
  coord_flip() +
  labs(x = NULL, y = NULL)

ggplot(pon_freq20, aes(x = word, y = n)) + 
  geom_col() +
  coord_flip() +
  labs(x = NULL, y = NULL)

ggplot(con_freq20, aes(x = word, y = n)) + 
  geom_col() +
  coord_flip() +
  labs(x = NULL, y = NULL)

# patch work로 붙이기
library(patchwork)

# 각각의 plot 저장
p1 <- ggplot(tin_freq20, aes(x = word, y = n)) + 
  geom_col() +
  coord_flip() +
  labs(x = NULL, y = NULL)

p2 <- ggplot(pon_freq20, aes(x = word, y = n)) + 
  geom_col() +
  coord_flip() +
  labs(x = NULL, y = NULL)

p3 <- ggplot(con_freq20, aes(x = word, y = n)) + 
  geom_col() +
  coord_flip() +
  labs(x = NULL, y = NULL)

# 3개 plot을 세로로 나란히 배치
p1 / p2 / p3      

# 게시글 제목, 게시글 내용 기술통계량 확인
summary(tin_freq)
summary(pon_freq)

### word cloud ###
# 명사 추출본으로 word cloud 생성; 게시글 제목
ggplot(tin_freq, aes(label = word, size = n, col = n)) +
  geom_text_wordcloud(seed = 1234, family = "blackhansans") +
  scale_radius(limits = c(5, NA),
               range = c(6, 30)) +
  scale_color_gradient(low = "#66aaf2", high = "#004EA1") +
  theme_minimal()
# 3.087이 mean이나
# 시각화 가독성을 위해 임의의 값 5를 limit으로 설정

# 명사 추출본으로 word cloud 생성; 게시글 내용
ggplot(pon_freq, aes(label = word, size = n, col = n)) +
  geom_text_wordcloud(seed = 1234, family = "blackhansans") +
  scale_radius(limits = c(30, NA),
               range = c(6, 30)) +
  scale_color_gradient(low = "#66aaf2", high = "#004EA1") +
  theme_minimal()
# 4.814 가 평균이나
# 시각화 가독성을 위해 임의의 값 30을 limit으로 설정

# 명사 추출본으로 word cloud 생성; 댓글 내용
ggplot(con_freq, aes(label = word, size = n, col = n)) +
  geom_text_wordcloud(seed = 1234, family = "blackhansans") +
  scale_radius(limits = c(30, NA),
               range = c(4, 30)) +
  scale_color_gradient(low = "#66aaf2", high = "#004EA1") +
  theme_minimal()
# 시각화 가독성을 위해 임의의 값 30을 limit으로 설정정

#댓글에서 언급된 정치인 이름
con_freq %>%
  filter(word %in% c("권영국", "이준석", "이재명", "심상정", "김문수"))

# 주요 인물 필터링
top5 <- con_freq %>%
  filter(word %in% c("권영국", "이준석", "이재명", "심상정", "김문수")) %>%
  arrange(desc(n))

# 시각화
ggplot(top5, aes(x = reorder(word, -n), y = n)) +
  geom_col(fill = "#004EA1") +
  geom_text(aes(label = n), vjust = -0.5, size = 5) +  # 막대 위에 라벨
  labs(x = NULL,
       y = NULL) +
  theme_minimal() +
  theme(axis.text = element_text(size = 12),
        plot.title = element_text(hjust = 0.5, size = 14, face = "bold"))



####################키워드: '정의당' 텍스트 분석####################

### 키워드: 정의당 수집한 제목, 게시글텍스트, 댓글텍스트 하나의 데이터프레임에 정렬 ###
jpost <- read.xlsx("정의당_게시글세부정보목록.xlsx")
jcomment <- read.xlsx("정의당_댓글목록.xlsx")
str(jpost)

jpost1 <- jpost[,c("제목", "게시글텍스트", "게시글id")]
str(jpost1)

jcomment1 <- jcomment[,c("댓글텍스트","게시글id")]
str(jcomment1)


# 게시글id 하나에 대한 구조 예시 만들기
jresult_list <- split(jcomment1, jcomment1$게시글id)

# 게시글id 기준으로 병합한 리스트 생성
jfinal_result <- lapply(names(jresult_list), function(pid) {
  jpost_row <- jpost1 %>% filter(게시글id == pid)
  jcomment_rows <- jresult_list[[pid]]
  
  # post row 먼저, 그 다음 댓글 rows
  bind_rows(
    jpost_row,
    jcomment_rows %>% mutate(제목 = NA, 게시글텍스트 = NA)
  )
})

# 최종 결과를 하나의 데이터프레임으로 병합
jfinal_df <- bind_rows(jfinal_result)
jfinal_df


#NA값은 빈문자열 ""로 대체
jfinal_df$게시글텍스트 <- ifelse(is.na(jfinal_df$게시글텍스트), "", jfinal_df$게시글텍스트)
jfinal_df$제목 <- ifelse(is.na(jfinal_df$제목), "", jfinal_df$제목)
jfinal_df$댓글텍스트 <- ifelse(is.na(jfinal_df$댓글텍스트), "", jfinal_df$댓글텍스트)
View(jfinal_df)


### 텍스트 전처리 ###
JU <- jfinal_df %>%
  mutate(
    제목 = str_replace_all(제목, "[^가-힣]", " "),
    게시글텍스트 = str_replace_all(게시글텍스트, "[^가-힣]", " "),
    댓글텍스트 = str_replace_all(댓글텍스트, "[^가-힣]", " ")
  )
View(JU)


# 공백 제거
JU <- JU %>%
  mutate(
    제목 = str_squish(제목),
    게시글텍스트 = str_squish(게시글텍스트),
    댓글텍스트 = str_squish(댓글텍스트)
  )
View(JU)

# tibble 형태로 변환
JU <- as_tibble(JU)
str(JU)


### 형태소 분석 ###

# 게시글 제목 토큰화
jtitle_n <- JU %>%
  select(게시글id, 제목) %>%
  rename(value = 제목) %>%
  unnest_tokens(input = value, output = word, token = extractNoun)

# 게시글 내용 토큰화
jpost_n <- JU %>%
  select(게시글id, 게시글텍스트) %>%
  rename(value = 게시글텍스트) %>%
  unnest_tokens(input = value, output = word, token = extractNoun)

# 댓글 내용 토큰화
jcomment_n <- JU %>%
  select(게시글id, 댓글텍스트) %>%
  rename(value = 댓글텍스트) %>%
  unnest_tokens(input = value, output = word, token = "words", drop=F)

### 빈도수 분석 ###

# 빈도수 세기
jtin_freq <- jtitle_n %>% count(word, sort = T) %>% filter(str_count(word) > 1)
jpon_freq <- jpost_n %>% count(word, sort = T) %>% filter(str_count(word) > 1)
jcon_freq <- jcomment_n %>% count(word, sort = T) %>% filter(str_count(word) > 1)

# 문제가 있는 값 수정
jtin_freq <- jtin_freq %>%
  filter(!word %in% c("하네", "하게", "하면", "후보", "본인", "해서", "오늘", "이번", "들이", "어제")) %>%
  mutate(word = case_when(
    word %in% c("권영") ~ "권영국",
    word %in% c("심상", "상정") ~ "심상정",
    word %in% c("이준", "준석", "섹이", "준섹이", "준섹") ~ "이준석",
    word %in% c("이재", "재명") ~ "이재명",
    word %in% c("문수", "김문") ~ "김문수",
    word %in% c("민노동", "민주노동", "민노", "노당") ~ "민주노동당",
    word %in% c("더불어민주당", "더민주") ~ "민주당",
    TRUE ~ word
  )) %>%
  group_by(word) %>%
  summarise(n = sum(n), .groups = "drop") %>%
  arrange(desc(n))

jpon_freq <- jpon_freq %>%
  filter(!word %in% c("하네", "하게", "하면", "후보", "본인", "해서", "오늘", "이번", "들이", "어제")) %>%
  mutate(word = case_when(
    word %in% c("권영") ~ "권영국",
    word %in% c("심상", "상정") ~ "심상정",
    word %in% c("이준", "준석", "섹이", "준섹이", "준섹") ~ "이준석",
    word %in% c("이재", "재명") ~ "이재명",
    word %in% c("문수", "김문") ~ "김문수",
    word %in% c("민노동", "민주노동", "민노", "노당") ~ "민주노동당",
    word %in% c("더불어민주당", "더민주") ~ "민주당",
    TRUE ~ word
  )) %>%
  group_by(word) %>%
  summarise(n = sum(n), .groups = "drop") %>%
  arrange(desc(n))


jcon_freq <- jcon_freq %>%
  filter(!word %in% c("하네", "하게", "하면", "후보", "본인", "해서", "오늘", "이번", "들이", "어제")) %>%
  mutate(word = case_when(
    word %in% c("권영") ~ "권영국",
    word %in% c("심상", "상정") ~ "심상정",
    word %in% c("이준", "준석", "섹이", "준섹이", "준섹") ~ "이준석",
    word %in% c("이재", "재명") ~ "이재명",
    word %in% c("문수", "김문") ~ "김문수",
    word %in% c("민노동", "민주노동", "민노", "노당") ~ "민주노동당",
    word %in% c("더불어민주당", "더민주") ~ "민주당",
    word %in% c("노동") ~ "노동자",
    TRUE ~ word
  )) %>%
  group_by(word) %>%
  summarise(n = sum(n), .groups = "drop") %>%
  arrange(desc(n))

jcon_freq <- jcon_freq %>%
  filter(!word %in% c("정의당", "민주당", "민주노동당", "이재명", "이준석", "조국", "개혁신당", "조국당", "김문수", "혁신당", "생각", "자기", "진짜"))

# 빈도수 상위 20개 단어 추출 
jtin_freq20 <- jtin_freq %>% head(20)
jpon_freq20 <- jpon_freq %>% head(20)
jcon_freq20 <- jcon_freq %>% head(20)

# 재정렬
jtin_freq20 <- jtin_freq %>%
  arrange(desc(n)) %>%
  slice_head(n = 20) %>%
  mutate(word = factor(word, levels = rev(unique(word))))

jpon_freq20 <- jpon_freq %>%
  arrange(desc(n)) %>%
  slice_head(n = 20) %>%
  mutate(word = factor(word, levels = rev(unique(word))))

jcon_freq20 <- jcon_freq %>%
  arrange(desc(n)) %>%
  slice_head(n = 20) %>%
  mutate(word = factor(word, levels = rev(unique(word))))

# 단순빈도수 plot
ggplot(jtin_freq20, aes(x = word, y = n)) + 
  geom_col() +
  coord_flip() +
  labs(x = NULL, y = NULL)

ggplot(jpon_freq20, aes(x = word, y = n)) + 
  geom_col() +
  coord_flip() +
  labs(x = NULL, y = NULL)

ggplot(jcon_freq20, aes(x = word, y = n)) + 
  geom_col() +
  coord_flip() +
  labs(x = NULL, y = NULL)

# 명사 추출본으로 wordcloud 생성
ggplot(jtin_freq, aes(label = word, size = n, col = n)) +
  geom_text_wordcloud(seed = 1234, family = "blackhansans") +
  scale_radius(limits = c(5, NA),
               range = c(6, 30)) +
  scale_color_gradient(low = "#66aaf2", high = "#004EA1") +
  theme_minimal()

ggplot(jpon_freq, aes(label = word, size = n, col = n)) +
  geom_text_wordcloud(seed = 1234, family = "blackhansans") +
  scale_radius(limits = c(30, NA),
               range = c(6, 30)) +
  scale_color_gradient(low = "#66aaf2", high = "#004EA1") +
  theme_minimal()

ggplot(jcon_freq, aes(label = word, size = n, col = n)) +
  geom_text_wordcloud(seed = 1234, family = "blackhansans") +
  scale_radius(limits = c(30, NA),
               range = c(4, 30)) +
  scale_color_gradient(low = "#66aaf2", high = "#004EA1") +
  theme_minimal()



####################키워드: '심상정' 텍스트 분석####################

### 키워드: 심상정 수집한 제목, 게시글텍스트, 댓글텍스트 하나의 데이터프레임에 정렬 ###

spost <- read.xlsx("심상정_게시글세부정보목록.xlsx")
scomment <- read.xlsx("심상정_댓글목록.xlsx")
#str(post)

spost1 <- spost[,c("제목", "게시글텍스트", "게시글id")]
#str(post1)

scomment1 <- scomment[,c("댓글텍스트","게시글id")]
#str(comment1)


# 게시글id 하나에 대한 구조 예시 만들기
sresult_list <- split(scomment1, scomment1$게시글id)

# 게시글id 기준으로 병합한 리스트 생성
sfinal_result <- lapply(names(sresult_list), function(pid) {
  spost_row <- spost1 %>% filter(게시글id == pid)
  scomment_rows <- sresult_list[[pid]]
  
  # post row 먼저, 그 다음 댓글 rows
  bind_rows(
    spost_row,
    scomment_rows %>% mutate(제목 = NA, 게시글텍스트 = NA)
  )
})

# 최종 결과를 하나의 데이터프레임으로 병합
sfinal_df <- bind_rows(sfinal_result)
View(sfinal_df)


#NA값은 빈문자열 ""로 대체
sfinal_df$게시글텍스트 <- ifelse(is.na(sfinal_df$게시글텍스트), "", sfinal_df$게시글텍스트)
sfinal_df$제목 <- ifelse(is.na(sfinal_df$제목), "", sfinal_df$제목)
sfinal_df$댓글텍스트 <- ifelse(is.na(sfinal_df$댓글텍스트), "", sfinal_df$댓글텍스트)
View(sfinal_df)


### 텍스트 전처리 ###

# 한글 아닌 것 제거
SS <- sfinal_df %>%
  mutate(
    제목 = str_replace_all(제목, "[^가-힣]", " "),
    게시글텍스트 = str_replace_all(게시글텍스트, "[^가-힣]", " "),
    댓글텍스트 = str_replace_all(댓글텍스트, "[^가-힣]", " ")
  )
View(SS)


# 공백 제거
SS <- SS %>%
  mutate(
    제목 = str_squish(제목),
    게시글텍스트 = str_squish(게시글텍스트),
    댓글텍스트 = str_squish(댓글텍스트)
  )
View(SS)

# tibble 형태로 변환
SS <- as_tibble(SS)
str(SS)

### 형태소 분석 ###
# 게시글 제목 토큰화
stitle_n <- SS %>%
  select(게시글id, 제목) %>%
  rename(value = 제목) %>%
  unnest_tokens(input = value, output = word, token = extractNoun)

# 게시글 내용 토큰화
spost_n <- SS %>%
  select(게시글id, 게시글텍스트) %>%
  rename(value = 게시글텍스트) %>%
  unnest_tokens(input = value, output = word, token = extractNoun)

# 댓글 내용 토큰화
scomment_n <- SS %>%
  select(게시글id, 댓글텍스트) %>%
  rename(value = 댓글텍스트) %>%
  unnest_tokens(input = value, output = word, token = "words")

# 빈도수 세기
stin_freq <- stitle_n %>% count(word, sort = T) %>% filter(str_count(word) > 1)
spon_freq <- spost_n %>% count(word, sort = T) %>% filter(str_count(word) > 1)
scon_freq <- scomment_n %>% count(word, sort = T) %>% filter(str_count(word) > 1)

# 문제가 있는 값 수정
stin_freq <- stin_freq %>%
  filter(!word %in% c("하네", "하게", "하면", "후보", "본인", "해서", "오늘", "이번", "들이", "어제")) %>%
  mutate(word = case_when(
    word %in% c("권영") ~ "권영국",
    word %in% c("심상", "상정") ~ "심상정",
    word %in% c("이준", "준석", "섹이", "준섹이", "준섹") ~ "이준석",
    word %in% c("이재", "재명") ~ "이재명",
    word %in% c("문수", "김문") ~ "김문수",
    word %in% c("민노동", "민주노동", "민노", "노당") ~ "민주노동당",
    word %in% c("더불어민주당", "더민주") ~ "민주당",
    TRUE ~ word
  )) %>%
  group_by(word) %>%
  summarise(n = sum(n), .groups = "drop") %>%
  arrange(desc(n))

spon_freq <- spon_freq %>%
  filter(!word %in% c("하네", "하게", "하면", "후보", "본인", "해서", "오늘", "이번", "들이", "어제")) %>%
  mutate(word = case_when(
    word %in% c("권영") ~ "권영국",
    word %in% c("심상", "상정") ~ "심상정",
    word %in% c("이준", "준석", "섹이", "준섹이", "준섹") ~ "이준석",
    word %in% c("이재", "재명") ~ "이재명",
    word %in% c("문수", "김문") ~ "김문수",
    word %in% c("민노동", "민주노동", "민노", "노당") ~ "민주노동당",
    word %in% c("더불어민주당", "더민주") ~ "민주당",
    TRUE ~ word
  )) %>%
  group_by(word) %>%
  summarise(n = sum(n), .groups = "drop") %>%
  arrange(desc(n))


scon_freq <- scon_freq %>%
  filter(!word %in% c("하네", "하게", "하면", "후보", "본인", "해서", "오늘", "이번", "들이", "어제")) %>%
  mutate(word = case_when(
    word %in% c("권영") ~ "권영국",
    word %in% c("심상", "상정") ~ "심상정",
    word %in% c("이준", "준석", "섹이", "준섹이", "준섹") ~ "이준석",
    word %in% c("이재", "재명") ~ "이재명",
    word %in% c("문수", "김문") ~ "김문수",
    word %in% c("민노동", "민주노동", "민노", "노당") ~ "민주노동당",
    word %in% c("더불어민주당", "더민주") ~ "민주당",
    word %in% c("노동") ~ "노동자",
    TRUE ~ word
  )) %>%
  group_by(word) %>%
  summarise(n = sum(n), .groups = "drop") %>%
  arrange(desc(n))

scon_freq <- scon_freq %>%
  filter(!word %in% c("정의당", "민주당", "민주노동당", "이재명", "이준석", "조국", "개혁신당", "조국당", "김문수", "혁신당", "생각", "자기", "진짜", "문재인", "박근혜"))

# 빈도수 상위 20개 단어 추출
stin_freq20 <- stin_freq %>% head(20)
spon_freq20 <- spon_freq %>% head(20)
scon_freq20 <- scon_freq %>% head(20)

# 재정렬
stin_freq20 <- stin_freq %>%
  arrange(desc(n)) %>%
  slice_head(n = 20) %>%
  mutate(word = factor(word, levels = rev(unique(word))))

spon_freq20 <- spon_freq %>%
  arrange(desc(n)) %>%
  slice_head(n = 20) %>%
  mutate(word = factor(word, levels = rev(unique(word))))

scon_freq20 <- scon_freq %>%
  arrange(desc(n)) %>%
  slice_head(n = 20) %>%
  mutate(word = factor(word, levels = rev(unique(word))))

# 단순빈도수 plot
ggplot(stin_freq20, aes(x = word, y = n)) + 
  geom_col() +
  coord_flip() +
  labs(x = NULL, y = NULL)

ggplot(spon_freq20, aes(x = word, y = n)) + 
  geom_col() +
  coord_flip() +
  labs(x = NULL, y = NULL)

ggplot(scon_freq20, aes(x = word, y = n)) + 
  geom_col() +
  coord_flip() +
  labs(x = NULL, y = NULL)

# 명사 추출본으로 word cloud 생성
ggplot(stin_freq, aes(label = word, size = n, col = n)) +
  geom_text_wordcloud(seed = 1234, family = "blackhansans") +
  scale_radius(limits = c(3, NA),
               range = c(6, 30)) +
  scale_color_gradient(low = "#66aaf2", high = "#004EA1") +
  theme_minimal()

ggplot(spon_freq, aes(label = word, size = n, col = n)) +
  geom_text_wordcloud(seed = 1234, family = "blackhansans") +
  scale_radius(limits = c(10, NA),
               range = c(6, 30)) +
  scale_color_gradient(low = "#66aaf2", high = "#004EA1") +
  theme_minimal()

ggplot(scon_freq, aes(label = word, size = n, col = n)) +
  geom_text_wordcloud(seed = 1234, family = "blackhansans") +
  scale_radius(limits = c(10, NA),
               range = c(4, 30)) +
  scale_color_gradient(low = "#66aaf2", high = "#004EA1") +
  theme_minimal()


####################권영국, 정의당, 심상정 TF_IDF 값 계산####################
#UK JU SS에서 댓글 내용만 선택, 각각에 아이디(1,2,3) 할당

con_freq
jcon_freq
scon_freq

con_freq <- con_freq %>%
  filter(!word %in% c("정의당", "민주당", "민주노동당", "이재명", "이준석", "조국", "개혁신당", "조국당", "김문수", "혁신당", "생각", "자기", "진짜", "문재인", "박근혜", "생각"))

jcon_freq <- scon_freq %>%
  filter(!word %in% c("정의당", "민주당", "민주노동당", "이재명", "이준석", "조국", "개혁신당", "조국당", "김문수", "혁신당", "생각", "자기", "진짜", "문재인", "박근혜", "생각"))

scon_freq <- scon_freq %>%
  filter(!word %in% c("정의당", "민주당", "민주노동당", "이재명", "이준석", "조국", "개혁신당", "조국당", "김문수", "혁신당", "생각", "자기", "진짜", "문재인", "박근혜", "생각"))

con_freq  <- con_freq  %>% mutate(book = 1)
jcon_freq <- jcon_freq %>% mutate(book = 2)
scon_freq <- scon_freq %>% mutate(book = 3)

total_freq <- bind_rows(con_freq, jcon_freq, scon_freq)

frequecy <- total_freq %>%
  bind_tf_idf(term = word,           
              document = book,  
              n = n) %>%            
  arrange(-tf_idf)
frequecy


frequecy <- frequecy %>%
  filter(!word %in% c("익명", "신고", "표정", "하버드", "한게", 
                      "저질", "진성자", "성희롱", "여성성", "퇴출", 
                      "흑자", "전국민"))


frequency <- total_freq %>%
  bind_tf_idf(term = word,          
              document = book,  
              n = n) %>%             
  arrange(tf_idf)

frequency



### 토픽모델링 ###

library(tm)
library(topicmodels)

# DTM 만들기
dtm_comment <- con_freq %>%
  cast_dtm(document = id, term = word, value = n)
dtm_comment

con_freq$id <- 1

# 토픽 모델 만들기
lda_model <- LDA(dtm_comment,
                 k = 3,
                 method = "Gibbs",
                 control = list(seed = 1234))

glimpse(lda_model)

terms(lda_model, 20) %>%
  data.frame()

sentences_UK <- UK %>%
  str_squish() %>%
  as_tibble() %>%
  unnest_tokens(input = value,
                output = sentence,
                token = "sentences")

sentences_UK

sentences_S <- sentences_UK %>%
  filter(str_detect(sentence, "심상정"))

sentences_S

sentences_J <- sentences_UK %>%
  filter(str_detect(sentence, "정의당"))

sentences_J


### 감성분석 ###
library(readr)
library(dplyr)

# knu 감성 사전에 '내란' 추가, 점수는 -2 부여
dic <- read_csv("knu_sentiment_lexicon.csv")
dic <- dic %>%
  add_row(word = "내란", polarity = -2)


jcomment_n

jcomment_sen <- jcomment_n %>%
  left_join(dic, by = "word") %>%
  mutate(polarity = ifelse(is.na(polarity), 0, polarity))

jcomment_sen1 <- jcomment_sen %>%
  mutate(sentiment = ifelse(polarity ==  2, "pos",
                            ifelse(polarity == -2, "neg", "neu")))
jcomment_sen1 %>% count(sentiment)



scomment_sen <- scomment_n %>%
  left_join(dic, by = "word") %>%
  mutate(polarity = ifelse(is.na(polarity), 0, polarity))

scomment_sen1 <- scomment_sen %>%
  mutate(sentiment = ifelse(polarity ==  2, "pos",
                            ifelse(polarity == -2, "neg", "neu")))
scomment_sen1 %>% count(sentiment)


jp <- jcomment_sen1 %>%
  filter(sentiment != "neu") %>%
  count(sentiment, word) %>%
  group_by(sentiment) %>%
  slice_max(n, n = 10)

sp <- scomment_sen1 %>%
  filter(sentiment != "neu") %>%
  count(sentiment, word) %>%
  group_by(sentiment) %>%
  slice_max(n, n = 10)

jp <- jcomment_sen1 %>%
  filter(sentiment != "neu") %>%
  mutate(word = case_when(
    word %in% c("욕을") ~ "욕",
    TRUE ~ word
  )) %>%
  filter(!word %in% c("해", "하게", "하면", "후보", "본인", "해서", "오늘", "이번", "들이", "어제")) %>%
  count(sentiment, word) %>%
  group_by(sentiment) %>%
  slice_max(n, n = 10) %>%
  ungroup()

sp <- scomment_sen1 %>%
  filter(sentiment != "neu") %>%
  mutate(word = case_when(
    word %in% c("범죄를") ~ "범죄",
    word %in% c("욕을") ~ "욕",
    TRUE ~ word
  )) %>%
  filter(!word %in% c("해", "하게", "하면", "후보", "본인", "해서", "오늘", "이번", "들이", "어제")) %>%
  count(sentiment, word) %>%
  group_by(sentiment) %>%
  slice_max(n, n = 10) %>%
  ungroup()


ggplot(jp, aes(x = reorder(word, n),
               y = n,
               fill = sentiment)) +
  geom_col() +
  coord_flip() +
  geom_text(aes(label = n), hjust = -0.3) +
  facet_wrap(~ sentiment, scales = "free") +
  scale_y_continuous(expand = expansion(mult = c(0.05, 0.15))) +
  labs(x = NULL) +
  theme(text = element_text(family = "nanumgothic"))

ggplot(sp, aes(x = reorder(word, n),
               y = n,
               fill = sentiment)) +
  geom_col() +
  coord_flip() +
  geom_text(aes(label = n), hjust = -0.3) +
  facet_wrap(~ sentiment, scales = "free") +
  scale_y_continuous(expand = expansion(mult = c(0.05, 0.15))) +
  labs(x = NULL) +
  theme(text = element_text(family = "nanumgothic"))

dic[word="씨알",]
dic %>% 
  filter(word == "선거비")

