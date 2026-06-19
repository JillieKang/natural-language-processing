#' # Topic Modeling
#'
#' ## Requirements
library(topicmodels)
library(tidytext)
library(reshape2)
library(ggplot2)
library(dplyr)
library(janeaustenr)

#' ## Concepts
# Documents: Units of analysis (e.g., articles, posts, or books)
# Corpus: A collection of documents (e.g., the six novels by Jane Austen)
# Topic: A latent theme shared across documents

#' ## Steps of Topic Modeling
# 1. Preprocessing the text
# 2. Building the Document-Term Matrix (DTM)
# 3. Applying the LDA algorithm
# 4. Evaluating the model
# 5. Interpreting the results

#' ## Document-Term Matrix (DTM)
# Rows represent documents
# Columns represent terms
# A document-term matrix is typically sparse, with most cells containing zero counts

#' ## Latent Dirichlet Allocation (LDA)
# Topic modeling is an unsupervised learning technique that requires an algorithm
# Assumptions of the LDA algorithm
# 1. Each document is a mixture of topics
# 2. Each topic is a mixture of words

#' ## LDA(data, k = ..., control = list(seed = 1234))
# k refers to the number of topics
# A suitable value of k should be selected based on domain knowledge and intuition

# Beta represents the probability of a word belonging to a given topic
# Topic 1: aaron -> 1.69e-12
# Topic 2: aaron -> 3.90e-5
# Therefore, the word "aaron" is more strongly associated with Topic 2

#' ## Implementation of Topic Modeling

#' ### Data Set
data("AssociatedPress")
AssociatedPress

#' ### Fitting an LDA Model with Two Topics
# Set a seed to ensure reproducible results
ap_lda <- LDA(AssociatedPress, k = 2, control = list(seed = 1234))

ap_lda

#' ### Extracting Beta Values from the Two-Topic Model
ap_topics <- tidy(ap_lda, matrix = "beta")

ap_topics

#' ### Finding the Top 10 Terms for Each Topic
ap_top_terms <- ap_topics %>%
  group_by(topic) %>%
  slice_max(beta, n = 10) %>%
  ungroup() %>%
  arrange(topic, -beta)

ap_top_terms

#' ### Visualizing the Top 10 Terms for Each Topic
ap_top_terms %>%
  mutate(term = reorder_within(term, beta, topic)) %>%
  ggplot(aes(beta, term, fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~topic, scales = "free") +
  scale_y_reordered()


#' ## Exercise 1: Topic Modeling of `AssociatedPress`

data("AssociatedPress")
AssociatedPress

#' ### Fitting an LDA Model with Five Topics
ap_lda <- LDA(AssociatedPress, k = 5, control = list(seed = 1234))

ap_lda

#' ### Extracting Beta Values from the Five-Topic Model
ap_topics <- tidy(ap_lda, matrix = "beta")

ap_topics

#' ### Finding the Top 10 Terms for Each Topic
# Sort terms by descending beta values
ap_top_terms <- ap_topics %>%
  group_by(topic) %>%
  slice_max(beta, n = 10) %>%
  ungroup() %>%
  arrange(topic, -beta)

ap_top_terms

# Display additional rows
ap_top_terms <- ap_topics %>%
  group_by(topic) %>%
  slice_max(beta, n = 10) %>%
  ungroup() %>%
  arrange(topic, -beta) %>%
  print(n = 30)

#' ### Visualizing the Top 10 Terms for Each Topic
ap_top_terms %>%
  mutate(term = reorder_within(term, beta, topic)) %>%
  ggplot(aes(beta, term, fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~topic, scales = "free") +
  scale_y_reordered()


#' ## Exercise 2: Topic Modeling of novels by Jane Austen

#' ### Preprocessing the Text
tidy_books <- austen_books() %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words) %>%
  count(book, word, sort = TRUE) %>%
  ungroup()

#' ### Creating a Document-Term Matrix
# cast_dtm(document, term, frequency)
dtm <- tidy_books %>%
  cast_dtm(book, word, n)

#' ### Fitting an LDA Model with Four Topics
ap_lda4 <- LDA(dtm, k = 4, control = list(seed = 1234))

#' ### Extracting Per-Topic Word Probabilities (Beta Values)
ap_topics4 <- tidy(ap_lda4, matrix = "beta")

ap_topics4

#' ### Displaying the Top Terms for Each Topic
ap_top_terms4 <- ap_topics4 %>%
  group_by(topic) %>%
  slice_max(beta, n = 10) %>%
  ungroup() %>%
  arrange(topic, -beta)

ap_top_terms4
