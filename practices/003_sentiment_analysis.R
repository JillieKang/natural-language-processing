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

#' ### AFINN: With Scores (e.g., -5, -4, ..., 4, 5)
get_sentiments("afinn") 

#' ### Bing: Binary Sentiment Labels (Positive or Negative)
get_sentiments("bing")

#' ### NRC: Various Sentiments (e.g., Trust, Fear, Sadness)
textdata::lexicon_nrc()

#' #### Extracting Negative Words from the NRC Lexicon
nrc <- get_sentiments("nrc") %>% filter(sentiment =="negative")



#' ## Text Preprocessing
tidy_books <- austen_books() %>%
  group_by(book) %>%
  mutate(
    linenumber = row_number(),
    chapter = cumsum(str_detect(text, 
                                regex("^chapter [\\divxlc]", 
                                      ignore_case = TRUE)))) %>%
  ungroup() %>% unnest_tokens(word, text)

tidy_books


#' ## Sentiment Analysis

#' ### Sentiment Analysis with NRC Lexicon

#' #### Extracting Joy Words with `filter()`
nrc_joy <- get_sentiments("nrc") %>% 
  filter(sentiment == "joy")

#' #### Finding the Most Frequent Words in Emma with `inner_join()`
tidy_books %>%
  filter(book == "Emma") %>%
  inner_join(nrc_joy) %>%
  count(word, sort = TRUE)


#' ### Sentiment Analysis with Bing Lexicon

#' #### Word Frequency by Sentiment
bing_word_counts <- tidy_books %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  ungroup()

bing_word_counts

#' ## Visualization:

#' ### Bar Chart

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


#' ### Basic Word Cloud
tidy_books %>%
  anti_join(stop_words) %>%
  count(word) %>%
  with(wordcloud(word, n, max.words = 100))



#' ### Comparison Word Cloud

# Convert long format data into a wide format for `comparison.cloud()`
tidy_books %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  acast(word ~ sentiment, value.var = "n", fill = 0) %>%
  comparison.cloud(colors = c("gray20", "gray80"),
                   max.words = 100)


#' ## Exercise: Sentiment Analysis of Emma by Jane Austen Corpus with Bing Lexicon

#' ### Text Preprocessing
data("stop_words")
tidy_books <- austen_books() %>%
  filter(book == "Emma") %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words)

#' ### `inner_join()` with Bing Lexicon
# A many-to-many relationship may produce a warning message
bing_word_counts <- tidy_books %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE)

#' ### Visualization: Bar Chart

# Reorder bars using `reorder()`
# Remove the legend
# Separate panels by sentiment
# Add axis labels
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

#' ### Visualization: Comparison Word Cloud
tidy_books %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  acast(word ~ sentiment, value.var = "n", fill = 0) %>%
  comparison.cloud(colors = c("pink", "lightblue"),
                   max.words = 100)




#' ## Exercise: Sentiment Analysis of Emma by Jane Austen Corpus with NRC Lexicon

#' ### Text Preprocessing
data("stop_words")
tidy_books <- austen_books() %>%
  filter(book == "Emma") %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words)

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

#' ### Visualization: Comparison Word Cloud
tidy_books %>%
  inner_join(get_sentiments("nrc")) %>%
  filter(sentiment %in% c("positive", "negative")) %>%
  count(word, sentiment, sort = TRUE) %>%
  acast(word ~ sentiment, value.var = "n", fill = 0) %>%
  comparison.cloud(colors = c("peachpuff", "lavender"),
                   max.words = 100)


