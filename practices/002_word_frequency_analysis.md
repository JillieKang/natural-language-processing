# Tidying Text Data

## Requirements


``` r
library(dplyr)
library(tidytext)
library(stringr)
library(ggplot2)
library(janeaustenr)
library(gutenbergr)
```

## Tokenization with `unnest_tokens()`

### Structuring Text by Book, Line Number, and Chapter


``` r
original_books <- austen_books() %>% group_by(book) %>%
  mutate(
    linenumber = row_number(),
    chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]+", ignore_case = TRUE)))
  ) %>%
  ungroup()
original_books
```

```
## # A tibble: 73,422 × 4
##    text                    book                linenumber chapter
##    <chr>                   <fct>                    <int>   <int>
##  1 "SENSE AND SENSIBILITY" Sense & Sensibility          1       0
##  2 ""                      Sense & Sensibility          2       0
##  3 "by Jane Austen"        Sense & Sensibility          3       0
##  4 ""                      Sense & Sensibility          4       0
##  5 "(1811)"                Sense & Sensibility          5       0
##  6 ""                      Sense & Sensibility          6       0
##  7 ""                      Sense & Sensibility          7       0
##  8 ""                      Sense & Sensibility          8       0
##  9 ""                      Sense & Sensibility          9       0
## 10 "CHAPTER 1"             Sense & Sensibility         10       1
## # ℹ 73,412 more rows
```

### Word-Level Tokenization


``` r
tidy_books <- original_books %>% unnest_tokens(word, text)
tidy_books
```

```
## # A tibble: 725,055 × 4
##    book                linenumber chapter word       
##    <fct>                    <int>   <int> <chr>      
##  1 Sense & Sensibility          1       0 sense      
##  2 Sense & Sensibility          1       0 and        
##  3 Sense & Sensibility          1       0 sensibility
##  4 Sense & Sensibility          3       0 by         
##  5 Sense & Sensibility          3       0 jane       
##  6 Sense & Sensibility          3       0 austen     
##  7 Sense & Sensibility          5       0 1811       
##  8 Sense & Sensibility         10       1 chapter    
##  9 Sense & Sensibility         10       1 1          
## 10 Sense & Sensibility         13       1 the        
## # ℹ 725,045 more rows
```

## Stop Word Removal

Stop words are high-frequency function words (e.g., "the", "of", "to")
that carry minimal semantic content and are typically excluded prior to analysis.

### Filtering with `anti_join()`


``` r
# Retains only tokens not found in the stop_words lexicon.
data(stop_words)
tidy_books <- tidy_books %>% anti_join(stop_words, by = "word")
tidy_books
```

```
## # A tibble: 217,609 × 4
##    book                linenumber chapter word       
##    <fct>                    <int>   <int> <chr>      
##  1 Sense & Sensibility          1       0 sense      
##  2 Sense & Sensibility          1       0 sensibility
##  3 Sense & Sensibility          3       0 jane       
##  4 Sense & Sensibility          3       0 austen     
##  5 Sense & Sensibility          5       0 1811       
##  6 Sense & Sensibility         10       1 chapter    
##  7 Sense & Sensibility         10       1 1          
##  8 Sense & Sensibility         13       1 family     
##  9 Sense & Sensibility         13       1 dashwood   
## 10 Sense & Sensibility         13       1 settled    
## # ℹ 217,599 more rows
```

## Word Frequency

### Most Frequent Words Across All Books


``` r
tidy_books %>% count(word, sort = TRUE)
```

```
## # A tibble: 13,914 × 2
##    word       n
##    <chr>  <int>
##  1 miss    1855
##  2 time    1337
##  3 fanny    862
##  4 dear     822
##  5 lady     817
##  6 sir      806
##  7 day      797
##  8 emma     787
##  9 sister   727
## 10 house    699
## # ℹ 13,904 more rows
```

### Visualization


``` r
tidy_books %>%
  count(word, sort = TRUE) %>%
  filter(n > 600) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(n, word)) +
  geom_col()
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6-1.png)

---
## Exercise: Word Frequency Analysis of the H.G. Wells Corpus

Replicates the preceding pipeline on three H.G. Wells novels
retrieved from Project Gutenberg (IDs: 35, 36, 5230).


``` r
hgwells <- gutenberg_download(c(35, 36, 5230), mirror = "https://gutenberg.pglaf.org")
hgwells
```

```
## # A tibble: 15,301 × 2
##    gutenberg_id text              
##           <int> <chr>             
##  1           35 "The Time Machine"
##  2           35 ""                
##  3           35 "An Invention"    
##  4           35 ""                
##  5           35 "by H. G. Wells"  
##  6           35 ""                
##  7           35 ""                
##  8           35 "CONTENTS"        
##  9           35 ""                
## 10           35 " I Introduction" 
## # ℹ 15,291 more rows
```

### Assigning Line Numbers and Chapter Indices


``` r
original_books <- hgwells %>%
  mutate(
    linenumber = row_number(),
    chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]+", ignore_case = TRUE)))
  ) %>%
  ungroup()
original_books
```

```
## # A tibble: 15,301 × 4
##    gutenberg_id text               linenumber chapter
##           <int> <chr>                   <int>   <int>
##  1           35 "The Time Machine"          1       0
##  2           35 ""                          2       0
##  3           35 "An Invention"              3       0
##  4           35 ""                          4       0
##  5           35 "by H. G. Wells"            5       0
##  6           35 ""                          6       0
##  7           35 ""                          7       0
##  8           35 "CONTENTS"                  8       0
##  9           35 ""                          9       0
## 10           35 " I Introduction"          10       0
## # ℹ 15,291 more rows
```

### Word-Level Tokenization


``` r
tidy_books <- original_books %>% unnest_tokens(word, text)
tidy_books
```

```
## # A tibble: 142,563 × 4
##    gutenberg_id linenumber chapter word     
##           <int>      <int>   <int> <chr>    
##  1           35          1       0 the      
##  2           35          1       0 time     
##  3           35          1       0 machine  
##  4           35          3       0 an       
##  5           35          3       0 invention
##  6           35          5       0 by       
##  7           35          5       0 h        
##  8           35          5       0 g        
##  9           35          5       0 wells    
## 10           35          8       0 contents 
## # ℹ 142,553 more rows
```

### Stop Word Removal


``` r
data(stop_words)
tidy_books <- tidy_books %>% anti_join(stop_words, by = "word")
```

### Word Frequency Count


``` r
tidy_books %>% count(word, sort = TRUE)
```

```
## # A tibble: 10,319 × 2
##    word          n
##    <chr>     <int>
##  1 time        396
##  2 people      249
##  3 door        224
##  4 kemp        213
##  5 invisible   197
##  6 black       178
##  7 stood       174
##  8 night       168
##  9 heard       167
## 10 hall        165
## # ℹ 10,309 more rows
```

### Visualization


``` r
tidy_books %>%
  count(word, sort = TRUE) %>%
  filter(n > 150) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(n, word)) +
  geom_col()
```

![plot of chunk unnamed-chunk-12](figure/unnamed-chunk-12-1.png)

