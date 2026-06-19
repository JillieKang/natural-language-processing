# Natural Language Processing

## Overview
This repository contains Natural Language Processing (NLP) practices and Text-as-Data analysis exercises, using *Text Mining with R* by Julia Silge and David Robinson as the primary textbook. It documents the development of NLP skills and the implementation of text-as-data analysis methods in the social science context. R files, R Markdown files, and HTML files are available in the `practices` folder. Rendered HTML files can be accessed via the links below.

## Rendered HTML Files
[1. String Manipulation for Text Preprocessing](https://JillieKang.github.io/natural-language-processing/practices/001_string_manipulation.html)

[2. Text Mining for Word Frequency Analysis](https://JillieKang.github.io/natural-language-processing/practices/002_word_frequency_analysis.html)

[3. Sentiment Analysis](https://JillieKang.github.io/natural-language-processing/practices/003_sentiment_analysis.html)

[4. TF-IDF for Keyword Extraction](https://JillieKang.github.io/natural-language-processing/practices/004_tf_and_idf.html)

[5. Topic Modeling](https://JillieKang.github.io/natural-language-processing/practices/005_topic_modling.html)


## Packages Used
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
- janeaustenr
- gutenbergr


## Topics Covered

### String Manipulation

#### Functions
- `str_length()`
- `str_c()`
- `str_sub()`
- `str_view()`
- `str_subset()`

#### Data sets
- `words`
- `letters`

#### Key Operations
- Utilizing regular expressions and regex quantifiers
- Handling NAs in text data
- Implementing interactive web page message parsing
- Identifying matching patterns
- Handling quotation marks in text data
- Detecting proper nouns
- Searching words with specific characters

### Text Frequency Analysis

#### Data sets
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
- Tokenization and text strutcutring
- Stop word removal
- Word frequency count
- Visualization of word frequency
  
### Sentiment Analysis

#### Functions
- `inner_join()`
- `ggplot()`
- `facet_wrap()`
- `comparison.cloud()`
- `acast()`
- `str_subset()`

#### Sentiment Lexicons
- Bing
- NRC

#### Key Operations
- Extracting specific sentiment categories from sentiment lexicons
- Identifying the most frequent words associated with each sentiment
- Visualizing sentiment-specific word frequencies using bar charts
- Visualizing word frequencies using a basic word cloud
- Visualizing sentiment-specific word frequencies using a comparison word cloud

### TF-IDF (Term Frequency and Inverse Document Frequency)

#### Functions
- `bind_tf_idf()`
- `fct_reorder()`
  
#### Data sets
- `austen_books()`

#### Key Operations
- Calculating term frequency
- Calculating inverse document frequency
- Calculating TF-IDF
- Visualizing term frequency distributions using a histogram
- Visualizing Zipf's Law using a line chart
- Visualizing top TF-IDF scores using a bar chart




## Skills Developed

- Algorithm design
- Data structure implementation
- Problem-solving
- Computational thinking
- Code optimization
- Debugging


## Tools
- R
- Rmd
- knitr
- html


