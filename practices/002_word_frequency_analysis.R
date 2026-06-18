#' Text Mining: Tokenization and Word Frequency Analysis
#'
#' ## Requirements
library(dplyr)
library(tidytext)
library(stringr)
library(ggplot2)
library(janeaustenr)
library(gutenbergr)

#' ## Tokenization with `unnest_tokens()`
#'
#' ### Structuring Text by Book, Line Number, and Chapter

original_books <- austen_books() %>% group_by(book) %>%
  mutate(
    linenumber = row_number(),
    chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]+", ignore_case = TRUE)))
  ) %>%
  ungroup()
original_books

#' ### Word-Level Tokenization

tidy_books <- original_books %>% unnest_tokens(word, text)
tidy_books

#' ## Stop Word Removal
#'
#' Stop words are high-frequency function words (e.g., "the", "of", "to")
#' that carry minimal semantic content and are typically excluded prior to analysis.
#'
#' ### Filtering with `anti_join()`

# Retains only tokens not found in the stop_words lexicon.
data(stop_words)
tidy_books <- tidy_books %>% anti_join(stop_words, by = "word")
tidy_books

#' ## Word Frequency
#'
#' ### Most Frequent Words Across All Books

tidy_books %>% count(word, sort = TRUE)

#' ### Visualization

tidy_books %>%
  count(word, sort = TRUE) %>%
  filter(n > 600) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(n, word)) +
  geom_col()

#' ---
#' ## Exercise: Word Frequency Analysis of the H.G. Wells Corpus
#'
#' Replicates the preceding pipeline on three H.G. Wells novels
#' retrieved from Project Gutenberg (IDs: 35, 36, 5230).

hgwells <- gutenberg_download(c(35, 36, 5230), mirror = "https://gutenberg.pglaf.org")
hgwells

#' ### Assigning Line Numbers and Chapter Indices

original_books <- hgwells %>%
  mutate(
    linenumber = row_number(),
    chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]+", ignore_case = TRUE)))
  ) %>%
  ungroup()
original_books

#' ### Word-Level Tokenization

tidy_books <- original_books %>% unnest_tokens(word, text)
tidy_books

#' ### Stop Word Removal

data(stop_words)
tidy_books <- tidy_books %>% anti_join(stop_words, by = "word")

#' ### Word Frequency Count

tidy_books %>% count(word, sort = TRUE)

#' ### Visualization

tidy_books %>%
  count(word, sort = TRUE) %>%
  filter(n > 150) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(n, word)) +
  geom_col()
