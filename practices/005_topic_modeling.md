# Topic Modeling

## Requirements


``` r
library(topicmodels)
library(tidytext)
library(reshape2)
library(ggplot2)
library(dplyr)
library(janeaustenr)
```

## Concepts


``` r
# Documents: Units of analysis (e.g., articles, posts, or books)
# Corpus: A collection of documents (e.g., the six novels by Jane Austen)
# Topic: A latent theme shared across documents
```

## Steps of Topic Modeling


``` r
# 1. Preprocessing the text
# 2. Building the Document-Term Matrix (DTM)
# 3. Applying the LDA algorithm
# 4. Evaluating the model
# 5. Interpreting the results
```

## Document-Term Matrix (DTM)


``` r
# Rows represent documents
# Columns represent terms
# A document-term matrix is typically sparse, with most cells containing zero counts
```

## Latent Dirichlet Allocation (LDA)


``` r
# Topic modeling is an unsupervised learning technique that requires an algorithm
# Assumptions of the LDA algorithm
# 1. Each document is a mixture of topics
# 2. Each topic is a mixture of words
```

## LDA(data, k = ..., control = list(seed = 1234))


``` r
# k refers to the number of topics
# A suitable value of k should be selected based on domain knowledge and intuition

# Beta represents the probability of a word belonging to a given topic
# Topic 1: aaron -> 1.69e-12
# Topic 2: aaron -> 3.90e-5
# Therefore, the word "aaron" is more strongly associated with Topic 2
```

## Implementation of Topic Modeling
### Data Set


``` r
data("AssociatedPress")
AssociatedPress
```

```
## <<DocumentTermMatrix (documents: 2246, terms: 10473)>>
## Non-/sparse entries: 302031/23220327
## Sparsity           : 99%
## Maximal term length: 18
## Weighting          : term frequency (tf)
```

### Fitting an LDA Model with Two Topics


``` r
# Set a seed to ensure reproducible results
ap_lda <- LDA(AssociatedPress, k = 2, control = list(seed = 1234))

ap_lda
```

```
## A LDA_VEM topic model with 2 topics.
```

### Extracting Beta Values from the Two-Topic Model


``` r
ap_topics <- tidy(ap_lda, matrix = "beta")

ap_topics
```

```
## # A tibble: 20,946 × 3
##    topic term           beta
##    <int> <chr>         <dbl>
##  1     1 aaron      1.69e-12
##  2     2 aaron      3.90e- 5
##  3     1 abandon    2.65e- 5
##  4     2 abandon    3.99e- 5
##  5     1 abandoned  1.39e- 4
##  6     2 abandoned  5.88e- 5
##  7     1 abandoning 2.45e-33
##  8     2 abandoning 2.34e- 5
##  9     1 abbott     2.13e- 6
## 10     2 abbott     2.97e- 5
## # ℹ 20,936 more rows
```

### Finding the Top 10 Terms for Each Topic


``` r
ap_top_terms <- ap_topics %>%
  group_by(topic) %>%
  slice_max(beta, n = 10) %>%
  ungroup() %>%
  arrange(topic, -beta)

ap_top_terms
```

```
## # A tibble: 20 × 3
##    topic term          beta
##    <int> <chr>        <dbl>
##  1     1 percent    0.00981
##  2     1 million    0.00684
##  3     1 new        0.00594
##  4     1 year       0.00575
##  5     1 billion    0.00427
##  6     1 last       0.00368
##  7     1 two        0.00360
##  8     1 company    0.00348
##  9     1 people     0.00345
## 10     1 market     0.00333
## 11     2 i          0.00705
## 12     2 president  0.00489
## 13     2 government 0.00452
## 14     2 people     0.00407
## 15     2 soviet     0.00372
## 16     2 new        0.00370
## 17     2 bush       0.00370
## 18     2 two        0.00361
## 19     2 years      0.00339
## 20     2 states     0.00320
```

### Visualizing the Top 10 Terms for Each Topic


``` r
ap_top_terms %>%
  mutate(term = reorder_within(term, beta, topic)) %>%
  ggplot(aes(beta, term, fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~topic, scales = "free") +
  scale_y_reordered()
```

![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-11-1.png)

## Exercise 1: Topic Modeling of `AssociatedPress`


``` r
data("AssociatedPress")
AssociatedPress
```

```
## <<DocumentTermMatrix (documents: 2246, terms: 10473)>>
## Non-/sparse entries: 302031/23220327
## Sparsity           : 99%
## Maximal term length: 18
## Weighting          : term frequency (tf)
```

### Fitting an LDA Model with Five Topics


``` r
ap_lda <- LDA(AssociatedPress, k = 5, control = list(seed = 1234))

ap_lda
```

```
## A LDA_VEM topic model with 5 topics.
```

### Extracting Beta Values from the Five-Topic Model


``` r
ap_topics <- tidy(ap_lda, matrix = "beta")

ap_topics
```

```
## # A tibble: 52,365 × 3
##    topic term        beta
##    <int> <chr>      <dbl>
##  1     1 aaron   2.80e- 5
##  2     2 aaron   8.47e- 9
##  3     3 aaron   3.74e-18
##  4     4 aaron   7.37e- 5
##  5     5 aaron   1.81e- 7
##  6     1 abandon 2.59e- 5
##  7     2 abandon 7.12e- 5
##  8     3 abandon 4.75e- 5
##  9     4 abandon 1.86e-24
## 10     5 abandon 2.98e- 5
## # ℹ 52,355 more rows
```

### Finding the Top 10 Terms for Each Topic


``` r
# Sort terms by descending beta values
ap_top_terms <- ap_topics %>%
  group_by(topic) %>%
  slice_max(beta, n = 10) %>%
  ungroup() %>%
  arrange(topic, -beta)

ap_top_terms
```

```
## # A tibble: 50 × 3
##    topic term          beta
##    <int> <chr>        <dbl>
##  1     1 percent    0.0198 
##  2     1 year       0.00908
##  3     1 million    0.00674
##  4     1 billion    0.00628
##  5     1 new        0.00573
##  6     1 report     0.00518
##  7     1 last       0.00489
##  8     1 years      0.00409
##  9     1 workers    0.00386
## 10     1 department 0.00372
## # ℹ 40 more rows
```

``` r
# Display additional rows
ap_top_terms <- ap_topics %>%
  group_by(topic) %>%
  slice_max(beta, n = 10) %>%
  ungroup() %>%
  arrange(topic, -beta) %>%
  print(n = 30)
```

```
## # A tibble: 50 × 3
##    topic term          beta
##    <int> <chr>        <dbl>
##  1     1 percent    0.0198 
##  2     1 year       0.00908
##  3     1 million    0.00674
##  4     1 billion    0.00628
##  5     1 new        0.00573
##  6     1 report     0.00518
##  7     1 last       0.00489
##  8     1 years      0.00409
##  9     1 workers    0.00386
## 10     1 department 0.00372
## 11     2 bush       0.00866
## 12     2 soviet     0.00850
## 13     2 president  0.00828
## 14     2 i          0.00658
## 15     2 united     0.00556
## 16     2 states     0.00549
## 17     2 new        0.00480
## 18     2 house      0.00438
## 19     2 dukakis    0.00412
## 20     2 government 0.00374
## 21     3 million    0.0129 
## 22     3 new        0.00900
## 23     3 company    0.00850
## 24     3 market     0.00821
## 25     3 stock      0.00792
## 26     3 billion    0.00586
## 27     3 percent    0.00579
## 28     3 year       0.00549
## 29     3 york       0.00547
## 30     3 dollar     0.00528
## # ℹ 20 more rows
```

### Visualizing the Top 10 Terms for Each Topic


``` r
ap_top_terms %>%
  mutate(term = reorder_within(term, beta, topic)) %>%
  ggplot(aes(beta, term, fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~topic, scales = "free") +
  scale_y_reordered()
```

![plot of chunk unnamed-chunk-16](figure/unnamed-chunk-16-1.png)

## Exercise 2: Topic Modeling of novels by Jane Austen
### Preprocessing the Text


``` r
tidy_books <- austen_books() %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words) %>%
  count(book, word, sort = TRUE) %>%
  ungroup()
```

```
## Joining with `by = join_by(word)`
```

### Creating a Document-Term Matrix


``` r
# cast_dtm(document, term, frequency)
dtm <- tidy_books %>%
  cast_dtm(book, word, n)
```

### Fitting an LDA Model with Four Topics


``` r
ap_lda4 <- LDA(dtm, k = 4, control = list(seed = 1234))
```

### Extracting Per-Topic Word Probabilities (Beta Values)


``` r
ap_topics4 <- tidy(ap_lda4, matrix = "beta")

ap_topics4
```

```
## # A tibble: 55,656 × 3
##    topic term        beta
##    <int> <chr>      <dbl>
##  1     1 fanny  4.96e-  4
##  2     2 fanny  1.57e-  4
##  3     3 fanny  1.70e-  2
##  4     4 fanny  5.58e-128
##  5     1 emma   9.28e-  3
##  6     2 emma   3.92e-  5
##  7     3 emma   1.06e- 71
##  8     4 emma   5.13e-190
##  9     1 elinor 7.36e-  3
## 10     2 elinor 1.20e-123
## # ℹ 55,646 more rows
```

### Displaying the Top Terms for Each Topic


``` r
ap_top_terms4 <- ap_topics4 %>%
  group_by(topic) %>%
  slice_max(beta, n = 10) %>%
  ungroup() %>%
  arrange(topic, -beta)

ap_top_terms4
```

```
## # A tibble: 40 × 3
##    topic term         beta
##    <int> <chr>       <dbl>
##  1     1 miss      0.00975
##  2     1 emma      0.00928
##  3     1 elinor    0.00736
##  4     1 time      0.00624
##  5     1 marianne  0.00581
##  6     1 harriet   0.00492
##  7     1 weston    0.00459
##  8     1 dear      0.00431
##  9     1 knightley 0.00420
## 10     1 day       0.00397
## # ℹ 30 more rows
```

