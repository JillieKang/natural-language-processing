#' # Term Frequency and Inverse Document Frequency

#' ## Term Frequency
# Measures how frequently a word appears in a document
# Removing stop words is necessary
# If the word "the" appears 10 times in a document containing 100 words: TF = 10/100 = 0.1
# If the word "the" appears 90 times in a document containing 100 words: TF = 90/100 = 0.9

#' ## Inverse Document Frequency
# Assigns lower weights to common words
# Assigns higher weights to rare words
# Rare words are generally more informative
# Calculated based on the number of documents containing a given word
# Numerator: Total number of documents
# If the word "the" appears in all 6 documents: IDF = log(6/6) = 0
# If the word "Darcy" appears in only 1 out of 6 documents: IDF = log(6/1) = 1.8

#' ## TF-IDF = (Term Frequency) × (Inverse Document Frequency)
#' ### If the word "the" appears 100 times in a document containing 10,000 words and appears in all 6 documents
100/10000 * log(1)

#' ### If the word "Darcy" appears 200 times in a document containing 122,204 words and appears in only 1 out of 6 documents
200/122204 * log(6)

#' ### "Darcy" receives a higher TF-IDF score than "the"

#' ## Zipf's Law
# Word frequency is inversely proportional to rank
# Frequency = (1 / Rank)
# Zipf's Law 1: Human language favors efficiency
# Zipf's Law 2: People tend to reuse familiar words
# Zipf's Law 3: Common words are more predictable

#' ## Requirements
library(dplyr)
library(janeaustenr)
library(tidytext)
library(ggplot2)
library(forcats)

#' ## Calculating Word Frequencies

#' ### Counting the number of occurrences of each word per document
book_words <- austen_books() %>%
  unnest_tokens(word, text) %>%
  count(book, word, sort = TRUE)

#' ### Calculating the total number of words per document
total_words <- book_words %>%
  group_by(book) %>%
  summarize(total = sum(n))

#' ### `left_join()`
book_words <- left_join(book_words, total_words)

book_words

#' ### Term Frequency = (Word Count in a Document) / (Total Number of Words in the Document)
freq_by_rank <- book_words %>%
  group_by(book) %>%
  mutate(
    rank = row_number(),
    `term frequency` = n / total
  ) %>%
  ungroup()

freq_by_rank

#' ### TF-IDF = (Term Frequency) × (Inverse Document Frequency)
book_tf_idf <- book_words %>%
  bind_tf_idf(word, book, n)

book_tf_idf

#' ### Sorting Words by TF-IDF
book_tf_idf %>%
  select(-total) %>%
  arrange(desc(tf_idf))

#' ## Visualization

#' ### Histogram: Term Frequency Distribution by Document
ggplot(book_words, aes(n / total, fill = book)) +
  geom_histogram(show.legend = FALSE) +
  xlim(NA, 0.0009) +
  facet_wrap(~book, ncol = 2, scales = "free_y")

#' ### Line Chart: Visualizing Zipf's Law
freq_by_rank %>%
  ggplot(aes(rank, `term frequency`, color = book)) +
  geom_line(size = 1.1, alpha = 0.8, show.legend = FALSE) +
  scale_x_log10() +
  scale_y_log10()

#' ### Bar Chart: Top TF-IDF Scores
book_tf_idf %>%
  group_by(book) %>%
  slice_max(tf_idf, n = 15) %>%
  ungroup() %>%
  ggplot(aes(tf_idf, fct_reorder(word, tf_idf), fill = book)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~book, ncol = 2, scales = "free") +
  labs(x = "TF-IDF", y = NULL)
