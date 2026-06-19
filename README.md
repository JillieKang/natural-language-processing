# Natural Language Processing

## Overview
This repository contains Natural Language Processing (NLP) practices and Text-as-Data analysis exercises based on *Text Mining with R* by Julia Silge and David Robinson. It documents the development of NLP skills and the implementation of text-as-data analysis methods in a social science context.

R scripts, R Markdown files, and HTML files are available in the `practices` folder. The rendered HTML files can be accessed via the links below.

## Rendered HTML Files
[1. String Manipulation for Text Preprocessing](https://JillieKang.github.io/natural-language-processing/practices/001_string_manipulation.html)

[2. Word Frequency Analysis](https://JillieKang.github.io/natural-language-processing/practices/002_word_frequency_analysis.html)

[3. Sentiment Analysis](https://JillieKang.github.io/natural-language-processing/practices/003_sentiment_analysis.html)

[4. TF-IDF for Keyword Extraction](https://JillieKang.github.io/natural-language-processing/practices/004_tf_and_idf.html)

[5. Topic Modeling](https://JillieKang.github.io/natural-language-processing/practices/005_topic_modeling.html)


## R Packages
- stringr
- dplyr
- tidyr
- ggplot2
- tidytext
- tidyverse
- reshape2
- wordcloud
- rvest
- textdata
- forcats
- topicmodels
- janeaustenr
- gutenbergr


## Topics Covered

### 1. String Manipulation for Text Preprocessing

#### Functions
- `str_length()`
- `str_c()`
- `str_sub()`
- `str_view()`
- `str_subset()`

#### Data Sets
- `words`
- `letters`

#### Key Operations
- Utilizing regular expressions and regex quantifiers
- Identifying matching patterns
- Detecting proper nouns
- Implementing interactive web page message parsing
- Handling NAs in text data

### 2. Word Frequency Analysis

#### Data Sets
- `stop_words`
- `austen_books()`
- `gutenberg_download()`

#### Functions
- `unnest_tokens()`
- `anti_join()`
- `count()`
- `filter()`
- `ggplot()`

#### Key Operations
- Tidying text data
- Tokenization and text structuring
- Removing stop words
- Counting word frequencies
- Visualizing word frequencies
  
### 3. Sentiment Analysis

#### Functions
- `inner_join()`
- `ggplot()`
- `facet_wrap()`
- `comparison.cloud()`
- `acast()`

#### Sentiment Lexicons
- Bing
- NRC

#### Key Operations
- Extracting specific sentiment categories from sentiment lexicons
- Identifying the most frequent words associated with each sentiment
- Visualizing sentiment-specific word frequencies using bar charts
- Visualizing word frequencies using basic word clouds
- Visualizing sentiment-specific word frequencies using comparison word clouds

### 4. TF-IDF (Term Frequency and Inverse Document Frequency) for Keyword Extraction

#### Functions
- `bind_tf_idf()`
- `fct_reorder()`
  
#### Data Sets
- `austen_books()`

#### Key Operations
- Calculating term frequency
- Calculating inverse document frequency
- Calculating TF-IDF
- Visualizing term frequency distributions using histograms
- Visualizing Zipf's Law using line charts
- Visualizing top TF-IDF scores using bar charts

### 5. Topic Modeling

#### Functions
- `LDA()`
- `tidy()`
  
#### Data Sets
- `AssociatedPress`
- `austen_books()`

#### Key Operations
- Fitting LDA models with different numbers of topics
- Extracting beta values from the model
- Identifying the top terms for each topic
- Visualizing the top terms for each topic using bar charts

## Skills Developed
- Natural language processing (NLP)
- Text mining
- Topic modeling
- Sentiment analysis
- Feature extraction using TF-IDF
- Data visualization

## Tools
- R
- R Markdown
- knitr
- HTML
