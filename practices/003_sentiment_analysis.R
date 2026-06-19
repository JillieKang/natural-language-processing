#' Sentiment Analysis
#' 
#' 
#' 
#' ## Requirements

library(tidyverse)
library(stringr)
library(rvest)
library(dplyr)
library(tidytext)
library(textdata)
library(ggplot2)
library(wordcloud)
library(reshape2)
library(topicmodels)
library(janeaustenr)


#' ## Sentiment Lexicons

#' ### AFINN: With Scores e.g.) -5, -4, -3, ..., 3, 4, 5
get_sentiments("afinn") 

#' ### Bing: Positive or Negative
get_sentiments("bing")

#' ### NRC: Various Sentiments such as Trust, Fear, Sadness, etc.
textdata::lexicon_nrc()

#' #### Collecting Negative Words Only in NRC
nrc <- get_sentiments("nrc") %>% filter(word=="negative")



#' ## Tidying Text First
tidy_books <- austen_books() %>%
  group_by(book) %>%
  mutate(
    linenumber = row_number(),
    chapter = cumsum(str_detect(text, 
                                regex("^chapter [\\divxlc]", 
                                      ignore_case = TRUE)))) %>%
  ungroup() %>% unnest_tokens(word, text)

tidy_books



#' ## Sentiment Analysis with NRC

#' ### `filter()` for the Joy Words with NRC Lexcicon 
nrc_joy <- get_sentiments("nrc") %>% 
  filter(sentiment == "joy")

#' ### `inner_join()` to find most common joy words in Emma  
tidy_books %>%
  filter(book == "Emma") %>%
  inner_join(nrc_joy) %>%
  count(word, sort = TRUE)


#' ## Sentiment Analysis with Bing

#' ### Analyzing Word Counts That Contribute to Each Sentiment 
bing_word_counts <- tidy_books %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  ungroup()

bing_word_counts

#' ## Visualization: Bar Chart

bing_word_counts %>%
  group_by(sentiment) %>%
  slice_max(n, n = 10) %>% 
  ungroup() %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(n, word, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~sentiment, scales = "free_y") +
  labs(x = "Contribution to sentiment",
       y = NULL)


#' ## Visualization: Basic Word Cloud
tidy_books %>%
  anti_join(stop_words) %>%
  count(word) %>%
  with(wordcloud(word, n, max.words = 100))



#' ## Visualization: Word Cloud with Sentiments

# acast() converts long form into wide form so that i can execute comparison.cloud()
tidy_books %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  acast(word ~ sentiment, value.var = "n", fill = 0) %>%
  comparison.cloud(colors = c("gray20", "gray80"),
                   max.words = 100)


#' ## Exercise: Sentiment Analysis of Emma by Jane Austen Corpus with Bing Lexicon

#' ### Tidying Text Data
data("stop_words")
tidy_books <- austen_books() %>%
  filter(book == "Emma") %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words)

#' ### `inner_join()` with Bing Lexicon
# There can be a warning message becuase it's in many-to-many relationship
bing_word_counts <- tidy_books %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE)

#' ### Visualization: Bar Chart

# Sort the bars on the chart by `reorder()`
# Delete the legend
# Divide the chart by its sentiment
# Add labels
bing_word_counts %>%
  group_by(sentiment) %>%
  slice_max(n, n = 10) %>% 
  ungroup() %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(n, word, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~sentiment, scales = "free_y") +
  labs(x = "Contribution to sentiment",
       y = NULL)

#' ### Visualization: Word Cloud with Sentiments
tidy_books %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  acast(word ~ sentiment, value.var = "n", fill = 0) %>%
  comparison.cloud(colors = c("pink", "lightblue"),
                   max.words = 100)




#' ## Exercise: Sentiment Analysis of Emma by Jane Austen Corpus with NRC Lexicon

#' ### `inner_join()` with NRC Lexicon 
nrc_counts <- tidy_books %>%
  inner_join(get_sentiments("nrc")) %>%
  filter(sentiment == "positive" | sentiment == "negative") %>%
  count(word, sentiment, sort = TRUE)

#' ### Visualization: Bar Chart
nrc_counts %>%
  group_by(sentiment) %>%
  slice_max(order_by= n, n = 10) %>% 
  ungroup() %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(n, word, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~sentiment, scales = "free_y") +
  labs(x = "Contribution to sentiment",
       y = NULL)

#' ### Visualization: Word Cloud with Sentiments
tidy_books %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  acast(word ~ sentiment, value.var = "n", fill = 0) %>%
  comparison.cloud(colors = c("peachpuff", "lavender"),
                   max.words = 100)


