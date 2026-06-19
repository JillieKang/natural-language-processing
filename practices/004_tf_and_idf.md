# Term Frequency and Inverse Document Frequency
## Term Frequency
### Measures how frequently a word appears in a document
### Removing stop words is necessary
### If the word "the" appears 10 times in a document containing 100 words: TF = 10/100 = 0.1
### If the word "the" appears 90 times in a document containing 100 words: TF = 90/100 = 0.9
## Inverse Document Frequency
### Assigns lower weights to common words
### Assigns higher weights to rare words
### Rare words are generally more informative
### Calculated based on the number of documents containing a given word
### Numerator: Total number of documents
### If the word "the" appears in all 6 documents: IDF = log(6/6) = 0
### If the word "Darcy" appears in only 1 out of 6 documents: IDF = log(6/1) = 1.8
## TF-IDF = (Term Frequency) × (Inverse Document Frequency)
### If the word "the" appears 100 times in a document containing 10,000 words and appears in all 6 documents


``` r
100/10000 * log(1)
```

```
## [1] 0
```

### If the word "Darcy" appears 200 times in a document containing 122,204 words and appears in only 1 out of 6 documents


``` r
200/122204 * log(6)
```

```
## [1] 0.002932407
```

### "Darcy" receives a higher TF-IDF score than "the"
## Zipf's Law
### Word frequency is inversely proportional to rank
### Frequency = 1 / Rank
### Zipf's Law 1: Human language favors efficiency
### Zipf's Law 2: People tend to reuse familiar words
### Zipf's Law 3: Common words are more predictable
## Requirements


``` r
library(dplyr)
library(janeaustenr)
library(tidytext)
library(ggplot2)
library(forcats)
```

## Calculating Word Frequencies
### Counting the number of occurrences of each word per document


``` r
book_words <- austen_books() %>%
  unnest_tokens(word, text) %>%
  count(book, word, sort = TRUE)
```

### Calculating the total number of words per document


``` r
total_words <- book_words %>%
  group_by(book) %>%
  summarize(total = sum(n))
```

### `left_join()`


``` r
book_words <- left_join(book_words, total_words)
```

```
## Joining with `by = join_by(book)`
```

``` r
book_words
```

```
## # A tibble: 40,379 × 4
##    book              word      n  total
##    <fct>             <chr> <int>  <int>
##  1 Mansfield Park    the    6206 160460
##  2 Mansfield Park    to     5475 160460
##  3 Mansfield Park    and    5438 160460
##  4 Emma              to     5239 160996
##  5 Emma              the    5201 160996
##  6 Emma              and    4896 160996
##  7 Mansfield Park    of     4778 160460
##  8 Pride & Prejudice the    4331 122204
##  9 Emma              of     4291 160996
## 10 Pride & Prejudice to     4162 122204
## # ℹ 40,369 more rows
```

### Term Frequency = (Word Count in a Document) / (Total Number of Words in the Document)


``` r
freq_by_rank <- book_words %>%
  group_by(book) %>%
  mutate(
    rank = row_number(),
    `term frequency` = n / total
  ) %>%
  ungroup()

freq_by_rank
```

```
## # A tibble: 40,379 × 6
##    book              word      n  total  rank `term frequency`
##    <fct>             <chr> <int>  <int> <int>            <dbl>
##  1 Mansfield Park    the    6206 160460     1           0.0387
##  2 Mansfield Park    to     5475 160460     2           0.0341
##  3 Mansfield Park    and    5438 160460     3           0.0339
##  4 Emma              to     5239 160996     1           0.0325
##  5 Emma              the    5201 160996     2           0.0323
##  6 Emma              and    4896 160996     3           0.0304
##  7 Mansfield Park    of     4778 160460     4           0.0298
##  8 Pride & Prejudice the    4331 122204     1           0.0354
##  9 Emma              of     4291 160996     4           0.0267
## 10 Pride & Prejudice to     4162 122204     2           0.0341
## # ℹ 40,369 more rows
```

### TF-IDF = (Term Frequency) × (Inverse Document Frequency)


``` r
book_tf_idf <- book_words %>%
  bind_tf_idf(word, book, n)

book_tf_idf
```

```
## # A tibble: 40,379 × 7
##    book              word      n  total     tf   idf tf_idf
##    <fct>             <chr> <int>  <int>  <dbl> <dbl>  <dbl>
##  1 Mansfield Park    the    6206 160460 0.0387     0      0
##  2 Mansfield Park    to     5475 160460 0.0341     0      0
##  3 Mansfield Park    and    5438 160460 0.0339     0      0
##  4 Emma              to     5239 160996 0.0325     0      0
##  5 Emma              the    5201 160996 0.0323     0      0
##  6 Emma              and    4896 160996 0.0304     0      0
##  7 Mansfield Park    of     4778 160460 0.0298     0      0
##  8 Pride & Prejudice the    4331 122204 0.0354     0      0
##  9 Emma              of     4291 160996 0.0267     0      0
## 10 Pride & Prejudice to     4162 122204 0.0341     0      0
## # ℹ 40,369 more rows
```

### Sorting Words by TF-IDF


``` r
book_tf_idf %>%
  select(-total) %>%
  arrange(desc(tf_idf))
```

```
## # A tibble: 40,379 × 6
##    book                word          n      tf   idf  tf_idf
##    <fct>               <chr>     <int>   <dbl> <dbl>   <dbl>
##  1 Sense & Sensibility elinor      623 0.00519  1.79 0.00931
##  2 Sense & Sensibility marianne    492 0.00410  1.79 0.00735
##  3 Mansfield Park      crawford    493 0.00307  1.79 0.00551
##  4 Pride & Prejudice   darcy       373 0.00305  1.79 0.00547
##  5 Persuasion          elliot      254 0.00304  1.79 0.00544
##  6 Emma                emma        786 0.00488  1.10 0.00536
##  7 Northanger Abbey    tilney      196 0.00252  1.79 0.00452
##  8 Emma                weston      389 0.00242  1.79 0.00433
##  9 Pride & Prejudice   bennet      294 0.00241  1.79 0.00431
## 10 Persuasion          wentworth   191 0.00228  1.79 0.00409
## # ℹ 40,369 more rows
```

## Visualization
### Histogram: Term Frequency Distribution by Document


``` r
ggplot(book_words, aes(n / total, fill = book)) +
  geom_histogram(show.legend = FALSE) +
  xlim(NA, 0.0009) +
  facet_wrap(~book, ncol = 2, scales = "free_y")
```

```
## `stat_bin()` using `bins = 30`. Pick better value `binwidth`.
```

```
## Warning: Removed 896 rows containing non-finite outside the scale range (`stat_bin()`).
```

```
## Warning: Removed 6 rows containing missing values or values outside the scale range (`geom_bar()`).
```

![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-10-1.png)

### Line Chart: Visualizing Zipf's Law


``` r
freq_by_rank %>%
  ggplot(aes(rank, `term frequency`, color = book)) +
  geom_line(size = 1.1, alpha = 0.8, show.legend = FALSE) +
  scale_x_log10() +
  scale_y_log10()
```

![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-11-1.png)

### Bar Chart: Top TF-IDF Scores


``` r
book_tf_idf %>%
  group_by(book) %>%
  slice_max(tf_idf, n = 15) %>%
  ungroup() %>%
  ggplot(aes(tf_idf, fct_reorder(word, tf_idf), fill = book)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~book, ncol = 2, scales = "free") +
  labs(x = "TF-IDF", y = NULL)
```

![plot of chunk unnamed-chunk-12](figure/unnamed-chunk-12-1.png)

