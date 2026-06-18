# String Manipulation for Tidying Text Data
## Requirements


``` r
# library(stringr)
# library(dplyr)
# library(tidyr)
# library(ggplot2)
# library(tidyverse)
# library(tidytext)
# library(reshape2)
# library(wordcloud)
# library(rvest)
# library(textdata)
# library(janeaustenr)
```

## str_length()


``` r
str_length(c("a", "banana", NA))
```

```
## [1]  1  6 NA
```

## str_c()


``` r
str_c("x", "y")
```

```
## [1] "xy"
```

``` r
str_c("x", "y", "z")
```

```
## [1] "xyz"
```

``` r
str_c("x", "y", "z", sep=",")
```

```
## [1] "x,y,z"
```

### Checking Regular Expressions


``` r
str_c("Letter: ", letters)
```

```
##  [1] "Letter: a" "Letter: b" "Letter: c" "Letter: d" "Letter: e"
##  [6] "Letter: f" "Letter: g" "Letter: h" "Letter: i" "Letter: j"
## [11] "Letter: k" "Letter: l" "Letter: m" "Letter: n" "Letter: o"
## [16] "Letter: p" "Letter: q" "Letter: r" "Letter: s" "Letter: t"
## [21] "Letter: u" "Letter: v" "Letter: w" "Letter: x" "Letter: y"
## [26] "Letter: z"
```

### Handling NAs


``` r
x <- c("abc", NA)
str_c("|-", x, "-|")
```

```
## [1] "|-abc-|" NA
```

``` r
str_c("|-", str_replace_na(x), "-|")
```

```
## [1] "|-abc-|" "|-NA-|"
```

### Exercises


``` r
str_c(c("a", NA, "b"), "-d")
```

```
## [1] "a-d" NA    "b-d"
```

``` r
y <- c("a", NA, "b")

z <- str_c(c(y), "-d")
z
```

```
## [1] "a-d" NA    "b-d"
```

``` r
z <- str_c(c("a", NA, "b"), "-d")
z
```

```
## [1] "a-d" NA    "b-d"
```

``` r
str_c(str_replace_na(y), "-d")
```

```
## [1] "a-d"  "NA-d" "b-d"
```

### Practice: Interactive Web Page Message Implementation


``` r
name <- "David"
time <- "morning"
str_c("Good", " ", time, ",", " ", name, "!")
```

```
## [1] "Good morning, David!"
```

``` r
bday <- FALSE
bday <- TRUE
str_c("Good", " ", time, ",", " ", name, if (bday) " and Happy Birthday", "!")
```

```
## [1] "Good morning, David and Happy Birthday!"
```

## str_sub()


``` r
hw <- "Hadley Wickham"
str_sub(hw, 1, 6)
```

```
## [1] "Hadley"
```

``` r
str_sub(hw, end=6)
```

```
## [1] "Hadley"
```

``` r
str_sub(hw, 8, 14)
```

```
## [1] "Wickham"
```

``` r
str_sub(hw, 8)
```

```
## [1] "Wickham"
```

``` r
str_sub(hw, -1)
```

```
## [1] "m"
```

``` r
str_sub(hw, -7)
```

```
## [1] "Wickham"
```

### Exercises


``` r
x <- c("apple", "banana", "Pear")
str_sub(x, 1, 3)
```

```
## [1] "app" "ban" "Pea"
```

``` r
str_sub(x, 3)
```

```
## [1] "ple"  "nana" "ar"
```

``` r
str_sub(x, -3)
```

```
## [1] "ple" "ana" "ear"
```

``` r
str_sub(x, -3, -2)
```

```
## [1] "pl" "an" "ea"
```

``` r
str_sub(x, end=-3)
```

```
## [1] "app"  "bana" "Pe"
```

## str_view()


``` r
x <- c("blur", "oasis", "libertines")
str_view(x,"b")
```

```
## [1] │ <b>lur
## [3] │ li<b>ertines
```

``` r
str_view(x,"^o")
```

```
## [2] │ <o>asis
```

``` r
str_view(x, "s$")
```

```
## [2] │ oasi<s>
## [3] │ libertine<s>
```

``` r
str_view(x, "[oab]")
```

```
## [1] │ <b>lur
## [2] │ <o><a>sis
## [3] │ li<b>ertines
```

``` r
str_view(x, "..")
```

```
## [1] │ <bl><ur>
## [2] │ <oa><si>s
## [3] │ <li><be><rt><in><es>
```

### Exercises


``` r
# Matches any single character listed inside []
str_view(c("abc", "def", "fghi"), "[aeiou]")
```

```
## [1] │ <a>bc
## [2] │ d<e>f
## [3] │ fgh<i>
```

``` r
# .. matches any two consecutive characters
str_view(c("abc", "def", "fghi"), "..")
```

```
## [1] │ <ab>c
## [2] │ <de>f
## [3] │ <fg><hi>
```

``` r
# Displays only strings containing "e"
str_view(c("abc", "def", "fghi"), "e")
```

```
## [2] │ d<e>f
```

``` r
# Displays all strings; highlights matches for "e"
str_view(c("abc", "def", "fghi"), "e", match=NA)
```

```
## [1] │ abc
## [2] │ d<e>f
## [3] │ fghi
```

``` r
# Displays only strings that do not contain "e"
str_view(c("abc", "def", "fghi"), "e", match=FALSE)
```

```
## [1] │ abc
## [3] │ fghi
```

### Regular Expression Quantifiers
- `{2}`: precisely two characters
- `{n,}`: n or more characters
- `{,m}`: at most m characters
- `{n,m}`: between n and m characters


``` r
str_view(words, "e{2}")
```

```
##  [25] │ agr<ee>
##  [90] │ betw<ee>n
## [164] │ coff<ee>
## [173] │ committ<ee>
## [219] │ d<ee>p
## [221] │ degr<ee>
## [307] │ f<ee>d
## [308] │ f<ee>l
## [340] │ fr<ee>
## [368] │ gr<ee>n
## [422] │ ind<ee>d
## [443] │ k<ee>p
## [514] │ m<ee>t
## [547] │ n<ee>d
## [650] │ proc<ee>d
## [734] │ s<ee>
## [735] │ s<ee>m
## [751] │ sh<ee>t
## [774] │ sl<ee>p
## [793] │ sp<ee>d
## ... and 7 more
```

``` r
str_view(words, "e{1,}")
```

```
##  [2] │ abl<e>
##  [4] │ absolut<e>
##  [5] │ acc<e>pt
##  [7] │ achi<e>v<e>
## [10] │ activ<e>
## [13] │ addr<e>ss
## [15] │ adv<e>rtis<e>
## [16] │ aff<e>ct
## [18] │ aft<e>r
## [19] │ aft<e>rnoon
## [22] │ ag<e>
## [23] │ ag<e>nt
## [25] │ agr<ee>
## [31] │ alr<e>ady
## [36] │ am<e>rica
## [39] │ anoth<e>r
## [40] │ answ<e>r
## [43] │ appar<e>nt
## [44] │ app<e>ar
## [48] │ appropriat<e>
## ... and 516 more
```

``` r
str_view(words, "e{0,1}")
```

```
##  [1] │ <>a<>
##  [2] │ <>a<>b<>l<e><>
##  [3] │ <>a<>b<>o<>u<>t<>
##  [4] │ <>a<>b<>s<>o<>l<>u<>t<e><>
##  [5] │ <>a<>c<>c<e><>p<>t<>
##  [6] │ <>a<>c<>c<>o<>u<>n<>t<>
##  [7] │ <>a<>c<>h<>i<e><>v<e><>
##  [8] │ <>a<>c<>r<>o<>s<>s<>
##  [9] │ <>a<>c<>t<>
## [10] │ <>a<>c<>t<>i<>v<e><>
## [11] │ <>a<>c<>t<>u<>a<>l<>
## [12] │ <>a<>d<>d<>
## [13] │ <>a<>d<>d<>r<e><>s<>s<>
## [14] │ <>a<>d<>m<>i<>t<>
## [15] │ <>a<>d<>v<e><>r<>t<>i<>s<e><>
## [16] │ <>a<>f<>f<e><>c<>t<>
## [17] │ <>a<>f<>f<>o<>r<>d<>
## [18] │ <>a<>f<>t<e><>r<>
## [19] │ <>a<>f<>t<e><>r<>n<>o<>o<>n<>
## [20] │ <>a<>g<>a<>i<>n<>
## ... and 960 more
```

### Practice: Identifying Matching Patterns


``` r
x <- c("apple", "banana", "pear")
str_view(x, "an")
```

```
## [2] │ b<an><an>a
```

``` r
str_view(x, "^a")
```

```
## [1] │ <a>pple
```

``` r
str_view(x, "a$")
```

```
## [2] │ banan<a>
```

``` r
y <- c("apple pie", "apple", "apple cake")
str_view(y, "apple")
```

```
## [1] │ <apple> pie
## [2] │ <apple>
## [3] │ <apple> cake
```

``` r
str_view(y, "^apple$")
```

```
## [2] │ <apple>
```

``` r
str_view(c("abc", "def", "fghi"), "[aeiou]")
```

```
## [1] │ <a>bc
## [2] │ d<e>f
## [3] │ fgh<i>
```

``` r
str_view(c("abc", "def", "fghi"), "..")
```

```
## [1] │ <ab>c
## [2] │ <de>f
## [3] │ <fg><hi>
```

``` r
str_view(c("abc", "def", "fghi"), "..$")
```

```
## [1] │ a<bc>
## [2] │ d<ef>
## [3] │ fg<hi>
```

``` r
str_view(c("abc", "def", "fghi"), "e")
```

```
## [2] │ d<e>f
```

### Practice: Handling Quotation Marks


``` r
Str1 <- "This is a string"
Str2 <- 'If I want to include a "quote" inside a string, I use single quotes'
```

## str_subset()


``` r
str_subset(words, "^.{3}$")
```

```
##   [1] "act" "add" "age" "ago" "air" "all" "and" "any" "arm" "art"
##  [11] "ask" "bad" "bag" "bar" "bed" "bet" "big" "bit" "box" "boy"
##  [21] "bus" "but" "buy" "can" "car" "cat" "cup" "cut" "dad" "day"
##  [31] "die" "dog" "dry" "due" "eat" "egg" "end" "eye" "far" "few"
##  [41] "fit" "fly" "for" "fun" "gas" "get" "god" "guy" "hit" "hot"
##  [51] "how" "job" "key" "kid" "lad" "law" "lay" "leg" "let" "lie"
##  [61] "lot" "low" "man" "may" "mrs" "new" "non" "not" "now" "odd"
##  [71] "off" "old" "one" "out" "own" "pay" "per" "put" "red" "rid"
##  [81] "run" "say" "see" "set" "sex" "she" "sir" "sit" "six" "son"
##  [91] "sun" "tax" "tea" "ten" "the" "tie" "too" "top" "try" "two"
## [101] "use" "war" "way" "wee" "who" "why" "win" "yes" "yet" "you"
```

``` r
str_subset(words, "^y")
```

```
## [1] "year"      "yes"       "yesterday" "yet"       "you"      
## [6] "young"
```

``` r
str_subset(words, "x$")
```

```
## [1] "box" "sex" "six" "tax"
```

``` r
str_subset(words, "^.{7}")
```

```
##   [1] "absolute"    "account"     "achieve"     "address"    
##   [5] "advertise"   "afternoon"   "against"     "already"    
##   [9] "alright"     "although"    "america"     "another"    
##  [13] "apparent"    "appoint"     "approach"    "appropriate"
##  [17] "arrange"     "associate"   "authority"   "available"  
##  [21] "balance"     "because"     "believe"     "benefit"    
##  [25] "between"     "brilliant"   "britain"     "brother"    
##  [29] "business"    "certain"     "chairman"    "character"  
##  [33] "Christmas"   "colleague"   "collect"     "college"    
##  [37] "comment"     "committee"   "community"   "company"    
##  [41] "compare"     "complete"    "compute"     "concern"    
##  [45] "condition"   "consider"    "consult"     "contact"    
##  [49] "continue"    "contract"    "control"     "converse"   
##  [53] "correct"     "council"     "country"     "current"    
##  [57] "decision"    "definite"    "department"  "describe"   
##  [61] "develop"     "difference"  "difficult"   "discuss"    
##  [65] "district"    "document"    "economy"     "educate"    
##  [69] "electric"    "encourage"   "english"     "environment"
##  [73] "especial"    "evening"     "evidence"    "example"    
##  [77] "exercise"    "expense"     "experience"  "explain"    
##  [81] "express"     "finance"     "fortune"     "forward"    
##  [85] "function"    "further"     "general"     "germany"    
##  [89] "goodbye"     "history"     "holiday"     "hospital"   
##  [93] "however"     "hundred"     "husband"     "identify"   
##  [97] "imagine"     "important"   "improve"     "include"    
## [101] "increase"    "individual"  "industry"    "instead"    
## [105] "interest"    "introduce"   "involve"     "kitchen"    
## [109] "language"    "machine"     "meaning"     "measure"    
## [113] "mention"     "million"     "minister"    "morning"    
## [117] "necessary"   "obvious"     "occasion"    "operate"    
## [121] "opportunity" "organize"    "original"    "otherwise"  
## [125] "paragraph"   "particular"  "pension"     "percent"    
## [129] "perfect"     "perhaps"     "photograph"  "picture"    
## [133] "politic"     "position"    "positive"    "possible"   
## [137] "practise"    "prepare"     "present"     "pressure"   
## [141] "presume"     "previous"    "private"     "probable"   
## [145] "problem"     "proceed"     "process"     "produce"    
## [149] "product"     "programme"   "project"     "propose"    
## [153] "protect"     "provide"     "purpose"     "quality"    
## [157] "quarter"     "question"    "realise"     "receive"    
## [161] "recognize"   "recommend"   "relation"    "remember"   
## [165] "represent"   "require"     "research"    "resource"   
## [169] "respect"     "responsible" "saturday"    "science"    
## [173] "scotland"    "secretary"   "section"     "separate"   
## [177] "serious"     "service"     "similar"     "situate"    
## [181] "society"     "special"     "specific"    "standard"   
## [185] "station"     "straight"    "strategy"    "structure"  
## [189] "student"     "subject"     "succeed"     "suggest"    
## [193] "support"     "suppose"     "surprise"    "telephone"  
## [197] "television"  "terrible"    "therefore"   "thirteen"   
## [201] "thousand"    "through"     "thursday"    "together"   
## [205] "tomorrow"    "tonight"     "traffic"     "transport"  
## [209] "trouble"     "tuesday"     "understand"  "university" 
## [213] "various"     "village"     "wednesday"   "welcome"    
## [217] "whether"     "without"     "yesterday"
```

### Exercises


``` r
# Matches words consisting of exactly three characters
str_subset(words, "^.{3}$")
```

```
##   [1] "act" "add" "age" "ago" "air" "all" "and" "any" "arm" "art"
##  [11] "ask" "bad" "bag" "bar" "bed" "bet" "big" "bit" "box" "boy"
##  [21] "bus" "but" "buy" "can" "car" "cat" "cup" "cut" "dad" "day"
##  [31] "die" "dog" "dry" "due" "eat" "egg" "end" "eye" "far" "few"
##  [41] "fit" "fly" "for" "fun" "gas" "get" "god" "guy" "hit" "hot"
##  [51] "how" "job" "key" "kid" "lad" "law" "lay" "leg" "let" "lie"
##  [61] "lot" "low" "man" "may" "mrs" "new" "non" "not" "now" "odd"
##  [71] "off" "old" "one" "out" "own" "pay" "per" "put" "red" "rid"
##  [81] "run" "say" "see" "set" "sex" "she" "sir" "sit" "six" "son"
##  [91] "sun" "tax" "tea" "ten" "the" "tie" "too" "top" "try" "two"
## [101] "use" "war" "way" "wee" "who" "why" "win" "yes" "yet" "you"
```

### Regular Expression Quantifiers
- `*`: zero or more times
- `+`: one or more times
- `?`: zero or one time


``` r
Regex_ex <- c("apple", "banana", "bat", "ant", "z", "aa", "ab", "a", "b", "")

# Matches strings starting with "a", followed by zero or more characters
str_subset(Regex_ex, "^a.*")
```

```
## [1] "apple" "ant"   "aa"    "ab"    "a"
```

``` r
# Matches strings starting with "a", followed by one or more characters
str_subset(Regex_ex, "^a.+")
```

```
## [1] "apple" "ant"   "aa"    "ab"
```

``` r
# Matches strings starting with "a", followed by zero or one character
str_subset(Regex_ex, "^a.?")
```

```
## [1] "apple" "ant"   "aa"    "ab"    "a"
```

``` r
# Matches strings starting with "a", followed by zero or one character, with no further characters
str_subset(Regex_ex, "^a.?$")
```

```
## [1] "aa" "ab" "a"
```

``` r
# Matches words consisting of exactly three characters
str_subset(words, "^.{3}$")
```

```
##   [1] "act" "add" "age" "ago" "air" "all" "and" "any" "arm" "art"
##  [11] "ask" "bad" "bag" "bar" "bed" "bet" "big" "bit" "box" "boy"
##  [21] "bus" "but" "buy" "can" "car" "cat" "cup" "cut" "dad" "day"
##  [31] "die" "dog" "dry" "due" "eat" "egg" "end" "eye" "far" "few"
##  [41] "fit" "fly" "for" "fun" "gas" "get" "god" "guy" "hit" "hot"
##  [51] "how" "job" "key" "kid" "lad" "law" "lay" "leg" "let" "lie"
##  [61] "lot" "low" "man" "may" "mrs" "new" "non" "not" "now" "odd"
##  [71] "off" "old" "one" "out" "own" "pay" "per" "put" "red" "rid"
##  [81] "run" "say" "see" "set" "sex" "she" "sir" "sit" "six" "son"
##  [91] "sun" "tax" "tea" "ten" "the" "tie" "too" "top" "try" "two"
## [101] "use" "war" "way" "wee" "who" "why" "win" "yes" "yet" "you"
```

``` r
# Matches words beginning with at least three characters (no upper limit)
str_subset(words, "^.{3}")
```

```
##   [1] "able"        "about"       "absolute"    "accept"     
##   [5] "account"     "achieve"     "across"      "act"        
##   [9] "active"      "actual"      "add"         "address"    
##  [13] "admit"       "advertise"   "affect"      "afford"     
##  [17] "after"       "afternoon"   "again"       "against"    
##  [21] "age"         "agent"       "ago"         "agree"      
##  [25] "air"         "all"         "allow"       "almost"     
##  [29] "along"       "already"     "alright"     "also"       
##  [33] "although"    "always"      "america"     "amount"     
##  [37] "and"         "another"     "answer"      "any"        
##  [41] "apart"       "apparent"    "appear"      "apply"      
##  [45] "appoint"     "approach"    "appropriate" "area"       
##  [49] "argue"       "arm"         "around"      "arrange"    
##  [53] "art"         "ask"         "associate"   "assume"     
##  [57] "attend"      "authority"   "available"   "aware"      
##  [61] "away"        "awful"       "baby"        "back"       
##  [65] "bad"         "bag"         "balance"     "ball"       
##  [69] "bank"        "bar"         "base"        "basis"      
##  [73] "bear"        "beat"        "beauty"      "because"    
##  [77] "become"      "bed"         "before"      "begin"      
##  [81] "behind"      "believe"     "benefit"     "best"       
##  [85] "bet"         "between"     "big"         "bill"       
##  [89] "birth"       "bit"         "black"       "bloke"      
##  [93] "blood"       "blow"        "blue"        "board"      
##  [97] "boat"        "body"        "book"        "both"       
## [101] "bother"      "bottle"      "bottom"      "box"        
## [105] "boy"         "break"       "brief"       "brilliant"  
## [109] "bring"       "britain"     "brother"     "budget"     
## [113] "build"       "bus"         "business"    "busy"       
## [117] "but"         "buy"         "cake"        "call"       
## [121] "can"         "car"         "card"        "care"       
## [125] "carry"       "case"        "cat"         "catch"      
## [129] "cause"       "cent"        "centre"      "certain"    
## [133] "chair"       "chairman"    "chance"      "change"     
## [137] "chap"        "character"   "charge"      "cheap"      
## [141] "check"       "child"       "choice"      "choose"     
## [145] "Christ"      "Christmas"   "church"      "city"       
## [149] "claim"       "class"       "clean"       "clear"      
## [153] "client"      "clock"       "close"       "closes"     
## [157] "clothe"      "club"        "coffee"      "cold"       
## [161] "colleague"   "collect"     "college"     "colour"     
## [165] "come"        "comment"     "commit"      "committee"  
## [169] "common"      "community"   "company"     "compare"    
## [173] "complete"    "compute"     "concern"     "condition"  
## [177] "confer"      "consider"    "consult"     "contact"    
## [181] "continue"    "contract"    "control"     "converse"   
## [185] "cook"        "copy"        "corner"      "correct"    
## [189] "cost"        "could"       "council"     "count"      
## [193] "country"     "county"      "couple"      "course"     
## [197] "court"       "cover"       "create"      "cross"      
## [201] "cup"         "current"     "cut"         "dad"        
## [205] "danger"      "date"        "day"         "dead"       
## [209] "deal"        "dear"        "debate"      "decide"     
## [213] "decision"    "deep"        "definite"    "degree"     
## [217] "department"  "depend"      "describe"    "design"     
## [221] "detail"      "develop"     "die"         "difference" 
## [225] "difficult"   "dinner"      "direct"      "discuss"    
## [229] "district"    "divide"      "doctor"      "document"   
## [233] "dog"         "door"        "double"      "doubt"      
## [237] "down"        "draw"        "dress"       "drink"      
## [241] "drive"       "drop"        "dry"         "due"        
## [245] "during"      "each"        "early"       "east"       
## [249] "easy"        "eat"         "economy"     "educate"    
## [253] "effect"      "egg"         "eight"       "either"     
## [257] "elect"       "electric"    "eleven"      "else"       
## [261] "employ"      "encourage"   "end"         "engine"     
## [265] "english"     "enjoy"       "enough"      "enter"      
## [269] "environment" "equal"       "especial"    "europe"     
## [273] "even"        "evening"     "ever"        "every"      
## [277] "evidence"    "exact"       "example"     "except"     
## [281] "excuse"      "exercise"    "exist"       "expect"     
## [285] "expense"     "experience"  "explain"     "express"    
## [289] "extra"       "eye"         "face"        "fact"       
## [293] "fair"        "fall"        "family"      "far"        
## [297] "farm"        "fast"        "father"      "favour"     
## [301] "feed"        "feel"        "few"         "field"      
## [305] "fight"       "figure"      "file"        "fill"       
## [309] "film"        "final"       "finance"     "find"       
## [313] "fine"        "finish"      "fire"        "first"      
## [317] "fish"        "fit"         "five"        "flat"       
## [321] "floor"       "fly"         "follow"      "food"       
## [325] "foot"        "for"         "force"       "forget"     
## [329] "form"        "fortune"     "forward"     "four"       
## [333] "france"      "free"        "friday"      "friend"     
## [337] "from"        "front"       "full"        "fun"        
## [341] "function"    "fund"        "further"     "future"     
## [345] "game"        "garden"      "gas"         "general"    
## [349] "germany"     "get"         "girl"        "give"       
## [353] "glass"       "god"         "good"        "goodbye"    
## [357] "govern"      "grand"       "grant"       "great"      
## [361] "green"       "ground"      "group"       "grow"       
## [365] "guess"       "guy"         "hair"        "half"       
## [369] "hall"        "hand"        "hang"        "happen"     
## [373] "happy"       "hard"        "hate"        "have"       
## [377] "head"        "health"      "hear"        "heart"      
## [381] "heat"        "heavy"       "hell"        "help"       
## [385] "here"        "high"        "history"     "hit"        
## [389] "hold"        "holiday"     "home"        "honest"     
## [393] "hope"        "horse"       "hospital"    "hot"        
## [397] "hour"        "house"       "how"         "however"    
## [401] "hullo"       "hundred"     "husband"     "idea"       
## [405] "identify"    "imagine"     "important"   "improve"    
## [409] "include"     "income"      "increase"    "indeed"     
## [413] "individual"  "industry"    "inform"      "inside"     
## [417] "instead"     "insure"      "interest"    "into"       
## [421] "introduce"   "invest"      "involve"     "issue"      
## [425] "item"        "jesus"       "job"         "join"       
## [429] "judge"       "jump"        "just"        "keep"       
## [433] "key"         "kid"         "kill"        "kind"       
## [437] "king"        "kitchen"     "knock"       "know"       
## [441] "labour"      "lad"         "lady"        "land"       
## [445] "language"    "large"       "last"        "late"       
## [449] "laugh"       "law"         "lay"         "lead"       
## [453] "learn"       "leave"       "left"        "leg"        
## [457] "less"        "let"         "letter"      "level"      
## [461] "lie"         "life"        "light"       "like"       
## [465] "likely"      "limit"       "line"        "link"       
## [469] "list"        "listen"      "little"      "live"       
## [473] "load"        "local"       "lock"        "london"     
## [477] "long"        "look"        "lord"        "lose"       
## [481] "lot"         "love"        "low"         "luck"       
## [485] "lunch"       "machine"     "main"        "major"      
## [489] "make"        "man"         "manage"      "many"       
## [493] "mark"        "market"      "marry"       "match"      
## [497] "matter"      "may"         "maybe"       "mean"       
## [501] "meaning"     "measure"     "meet"        "member"     
## [505] "mention"     "middle"      "might"       "mile"       
## [509] "milk"        "million"     "mind"        "minister"   
## [513] "minus"       "minute"      "miss"        "mister"     
## [517] "moment"      "monday"      "money"       "month"      
## [521] "more"        "morning"     "most"        "mother"     
## [525] "motion"      "move"        "mrs"         "much"       
## [529] "music"       "must"        "name"        "nation"     
## [533] "nature"      "near"        "necessary"   "need"       
## [537] "never"       "new"         "news"        "next"       
## [541] "nice"        "night"       "nine"        "non"        
## [545] "none"        "normal"      "north"       "not"        
## [549] "note"        "notice"      "now"         "number"     
## [553] "obvious"     "occasion"    "odd"         "off"        
## [557] "offer"       "office"      "often"       "okay"       
## [561] "old"         "once"        "one"         "only"       
## [565] "open"        "operate"     "opportunity" "oppose"     
## [569] "order"       "organize"    "original"    "other"      
## [573] "otherwise"   "ought"       "out"         "over"       
## [577] "own"         "pack"        "page"        "paint"      
## [581] "pair"        "paper"       "paragraph"   "pardon"     
## [585] "parent"      "park"        "part"        "particular" 
## [589] "party"       "pass"        "past"        "pay"        
## [593] "pence"       "pension"     "people"      "per"        
## [597] "percent"     "perfect"     "perhaps"     "period"     
## [601] "person"      "photograph"  "pick"        "picture"    
## [605] "piece"       "place"       "plan"        "play"       
## [609] "please"      "plus"        "point"       "police"     
## [613] "policy"      "politic"     "poor"        "position"   
## [617] "positive"    "possible"    "post"        "pound"      
## [621] "power"       "practise"    "prepare"     "present"    
## [625] "press"       "pressure"    "presume"     "pretty"     
## [629] "previous"    "price"       "print"       "private"    
## [633] "probable"    "problem"     "proceed"     "process"    
## [637] "produce"     "product"     "programme"   "project"    
## [641] "proper"      "propose"     "protect"     "provide"    
## [645] "public"      "pull"        "purpose"     "push"       
## [649] "put"         "quality"     "quarter"     "question"   
## [653] "quick"       "quid"        "quiet"       "quite"      
## [657] "radio"       "rail"        "raise"       "range"      
## [661] "rate"        "rather"      "read"        "ready"      
## [665] "real"        "realise"     "really"      "reason"     
## [669] "receive"     "recent"      "reckon"      "recognize"  
## [673] "recommend"   "record"      "red"         "reduce"     
## [677] "refer"       "regard"      "region"      "relation"   
## [681] "remember"    "report"      "represent"   "require"    
## [685] "research"    "resource"    "respect"     "responsible"
## [689] "rest"        "result"      "return"      "rid"        
## [693] "right"       "ring"        "rise"        "road"       
## [697] "role"        "roll"        "room"        "round"      
## [701] "rule"        "run"         "safe"        "sale"       
## [705] "same"        "saturday"    "save"        "say"        
## [709] "scheme"      "school"      "science"     "score"      
## [713] "scotland"    "seat"        "second"      "secretary"  
## [717] "section"     "secure"      "see"         "seem"       
## [721] "self"        "sell"        "send"        "sense"      
## [725] "separate"    "serious"     "serve"       "service"    
## [729] "set"         "settle"      "seven"       "sex"        
## [733] "shall"       "share"       "she"         "sheet"      
## [737] "shoe"        "shoot"       "shop"        "short"      
## [741] "should"      "show"        "shut"        "sick"       
## [745] "side"        "sign"        "similar"     "simple"     
## [749] "since"       "sing"        "single"      "sir"        
## [753] "sister"      "sit"         "site"        "situate"    
## [757] "six"         "size"        "sleep"       "slight"     
## [761] "slow"        "small"       "smoke"       "social"     
## [765] "society"     "some"        "son"         "soon"       
## [769] "sorry"       "sort"        "sound"       "south"      
## [773] "space"       "speak"       "special"     "specific"   
## [777] "speed"       "spell"       "spend"       "square"     
## [781] "staff"       "stage"       "stairs"      "stand"      
## [785] "standard"    "start"       "state"       "station"    
## [789] "stay"        "step"        "stick"       "still"      
## [793] "stop"        "story"       "straight"    "strategy"   
## [797] "street"      "strike"      "strong"      "structure"  
## [801] "student"     "study"       "stuff"       "stupid"     
## [805] "subject"     "succeed"     "such"        "sudden"     
## [809] "suggest"     "suit"        "summer"      "sun"        
## [813] "sunday"      "supply"      "support"     "suppose"    
## [817] "sure"        "surprise"    "switch"      "system"     
## [821] "table"       "take"        "talk"        "tape"       
## [825] "tax"         "tea"         "teach"       "team"       
## [829] "telephone"   "television"  "tell"        "ten"        
## [833] "tend"        "term"        "terrible"    "test"       
## [837] "than"        "thank"       "the"         "then"       
## [841] "there"       "therefore"   "they"        "thing"      
## [845] "think"       "thirteen"    "thirty"      "this"       
## [849] "thou"        "though"      "thousand"    "three"      
## [853] "through"     "throw"       "thursday"    "tie"        
## [857] "time"        "today"       "together"    "tomorrow"   
## [861] "tonight"     "too"         "top"         "total"      
## [865] "touch"       "toward"      "town"        "trade"      
## [869] "traffic"     "train"       "transport"   "travel"     
## [873] "treat"       "tree"        "trouble"     "true"       
## [877] "trust"       "try"         "tuesday"     "turn"       
## [881] "twelve"      "twenty"      "two"         "type"       
## [885] "under"       "understand"  "union"       "unit"       
## [889] "unite"       "university"  "unless"      "until"      
## [893] "upon"        "use"         "usual"       "value"      
## [897] "various"     "very"        "video"       "view"       
## [901] "village"     "visit"       "vote"        "wage"       
## [905] "wait"        "walk"        "wall"        "want"       
## [909] "war"         "warm"        "wash"        "waste"      
## [913] "watch"       "water"       "way"         "wear"       
## [917] "wednesday"   "wee"         "week"        "weigh"      
## [921] "welcome"     "well"        "west"        "what"       
## [925] "when"        "where"       "whether"     "which"      
## [929] "while"       "white"       "who"         "whole"      
## [933] "why"         "wide"        "wife"        "will"       
## [937] "win"         "wind"        "window"      "wish"       
## [941] "with"        "within"      "without"     "woman"      
## [945] "wonder"      "wood"        "word"        "work"       
## [949] "world"       "worry"       "worse"       "worth"      
## [953] "would"       "write"       "wrong"       "year"       
## [957] "yes"         "yesterday"   "yet"         "you"        
## [961] "young"
```

``` r
# Matches words consisting of two to four characters
str_subset(words, "^.{2,4}$")
```

```
##   [1] "able" "act"  "add"  "age"  "ago"  "air"  "all"  "also"
##   [9] "and"  "any"  "area" "arm"  "art"  "as"   "ask"  "at"  
##  [17] "away" "baby" "back" "bad"  "bag"  "ball" "bank" "bar" 
##  [25] "base" "be"   "bear" "beat" "bed"  "best" "bet"  "big" 
##  [33] "bill" "bit"  "blow" "blue" "boat" "body" "book" "both"
##  [41] "box"  "boy"  "bus"  "busy" "but"  "buy"  "by"   "cake"
##  [49] "call" "can"  "car"  "card" "care" "case" "cat"  "cent"
##  [57] "chap" "city" "club" "cold" "come" "cook" "copy" "cost"
##  [65] "cup"  "cut"  "dad"  "date" "day"  "dead" "deal" "dear"
##  [73] "deep" "die"  "do"   "dog"  "door" "down" "draw" "drop"
##  [81] "dry"  "due"  "each" "east" "easy" "eat"  "egg"  "else"
##  [89] "end"  "even" "ever" "eye"  "face" "fact" "fair" "fall"
##  [97] "far"  "farm" "fast" "feed" "feel" "few"  "file" "fill"
## [105] "film" "find" "fine" "fire" "fish" "fit"  "five" "flat"
## [113] "fly"  "food" "foot" "for"  "form" "four" "free" "from"
## [121] "full" "fun"  "fund" "game" "gas"  "get"  "girl" "give"
## [129] "go"   "god"  "good" "grow" "guy"  "hair" "half" "hall"
## [137] "hand" "hang" "hard" "hate" "have" "he"   "head" "hear"
## [145] "heat" "hell" "help" "here" "high" "hit"  "hold" "home"
## [153] "hope" "hot"  "hour" "how"  "idea" "if"   "in"   "into"
## [161] "it"   "item" "job"  "join" "jump" "just" "keep" "key" 
## [169] "kid"  "kill" "kind" "king" "know" "lad"  "lady" "land"
## [177] "last" "late" "law"  "lay"  "lead" "left" "leg"  "less"
## [185] "let"  "lie"  "life" "like" "line" "link" "list" "live"
## [193] "load" "lock" "long" "look" "lord" "lose" "lot"  "love"
## [201] "low"  "luck" "main" "make" "man"  "many" "mark" "may" 
## [209] "mean" "meet" "mile" "milk" "mind" "miss" "more" "most"
## [217] "move" "mrs"  "much" "must" "name" "near" "need" "new" 
## [225] "news" "next" "nice" "nine" "no"   "non"  "none" "not" 
## [233] "note" "now"  "odd"  "of"   "off"  "okay" "old"  "on"  
## [241] "once" "one"  "only" "open" "or"   "out"  "over" "own" 
## [249] "pack" "page" "pair" "park" "part" "pass" "past" "pay" 
## [257] "per"  "pick" "plan" "play" "plus" "poor" "post" "pull"
## [265] "push" "put"  "quid" "rail" "rate" "read" "real" "red" 
## [273] "rest" "rid"  "ring" "rise" "road" "role" "roll" "room"
## [281] "rule" "run"  "safe" "sale" "same" "save" "say"  "seat"
## [289] "see"  "seem" "self" "sell" "send" "set"  "sex"  "she" 
## [297] "shoe" "shop" "show" "shut" "sick" "side" "sign" "sing"
## [305] "sir"  "sit"  "site" "six"  "size" "slow" "so"   "some"
## [313] "son"  "soon" "sort" "stay" "step" "stop" "such" "suit"
## [321] "sun"  "sure" "take" "talk" "tape" "tax"  "tea"  "team"
## [329] "tell" "ten"  "tend" "term" "test" "than" "the"  "then"
## [337] "they" "this" "thou" "tie"  "time" "to"   "too"  "top" 
## [345] "town" "tree" "true" "try"  "turn" "two"  "type" "unit"
## [353] "up"   "upon" "use"  "very" "view" "vote" "wage" "wait"
## [361] "walk" "wall" "want" "war"  "warm" "wash" "way"  "we"  
## [369] "wear" "wee"  "week" "well" "west" "what" "when" "who" 
## [377] "why"  "wide" "wife" "will" "win"  "wind" "wish" "with"
## [385] "wood" "word" "work" "year" "yes"  "yet"  "you"
```

### Practice: Detecting Proper Nouns


``` r
# Matches strings beginning with an uppercase letter
str_subset(words, "^[A-Z].*$")
```

```
## [1] "Christ"    "Christmas"
```

``` r
str_subset(words, "^[A-Z].*")
```

```
## [1] "Christ"    "Christmas"
```

``` r
# Matches words beginning with "y"
str_subset(words, "^y")
```

```
## [1] "year"      "yes"       "yesterday" "yet"       "you"      
## [6] "young"
```

``` r
# Matches words beginning with "y" followed by exactly one character
str_subset(words, "^y.")
```

```
## [1] "year"      "yes"       "yesterday" "yet"       "you"      
## [6] "young"
```

``` r
# Matches words beginning with "y" followed by zero or more characters
str_subset(words, "^y.*")
```

```
## [1] "year"      "yes"       "yesterday" "yet"       "you"      
## [6] "young"
```

``` r
# Matches words ending with "x"
str_subset(words, "x$")
```

```
## [1] "box" "sex" "six" "tax"
```

``` r
str_subset(words, "^.{3}$")
```

```
##   [1] "act" "add" "age" "ago" "air" "all" "and" "any" "arm" "art"
##  [11] "ask" "bad" "bag" "bar" "bed" "bet" "big" "bit" "box" "boy"
##  [21] "bus" "but" "buy" "can" "car" "cat" "cup" "cut" "dad" "day"
##  [31] "die" "dog" "dry" "due" "eat" "egg" "end" "eye" "far" "few"
##  [41] "fit" "fly" "for" "fun" "gas" "get" "god" "guy" "hit" "hot"
##  [51] "how" "job" "key" "kid" "lad" "law" "lay" "leg" "let" "lie"
##  [61] "lot" "low" "man" "may" "mrs" "new" "non" "not" "now" "odd"
##  [71] "off" "old" "one" "out" "own" "pay" "per" "put" "red" "rid"
##  [81] "run" "say" "see" "set" "sex" "she" "sir" "sit" "six" "son"
##  [91] "sun" "tax" "tea" "ten" "the" "tie" "too" "top" "try" "two"
## [101] "use" "war" "way" "wee" "who" "why" "win" "yes" "yet" "you"
```

``` r
str_subset(words, "^...$")
```

```
##   [1] "act" "add" "age" "ago" "air" "all" "and" "any" "arm" "art"
##  [11] "ask" "bad" "bag" "bar" "bed" "bet" "big" "bit" "box" "boy"
##  [21] "bus" "but" "buy" "can" "car" "cat" "cup" "cut" "dad" "day"
##  [31] "die" "dog" "dry" "due" "eat" "egg" "end" "eye" "far" "few"
##  [41] "fit" "fly" "for" "fun" "gas" "get" "god" "guy" "hit" "hot"
##  [51] "how" "job" "key" "kid" "lad" "law" "lay" "leg" "let" "lie"
##  [61] "lot" "low" "man" "may" "mrs" "new" "non" "not" "now" "odd"
##  [71] "off" "old" "one" "out" "own" "pay" "per" "put" "red" "rid"
##  [81] "run" "say" "see" "set" "sex" "she" "sir" "sit" "six" "son"
##  [91] "sun" "tax" "tea" "ten" "the" "tie" "too" "top" "try" "two"
## [101] "use" "war" "way" "wee" "who" "why" "win" "yes" "yet" "you"
```

## Practice: Searching Words with Seven or More Characters


``` r
str_subset(words, "^.{7}.*$")
```

```
##   [1] "absolute"    "account"     "achieve"     "address"    
##   [5] "advertise"   "afternoon"   "against"     "already"    
##   [9] "alright"     "although"    "america"     "another"    
##  [13] "apparent"    "appoint"     "approach"    "appropriate"
##  [17] "arrange"     "associate"   "authority"   "available"  
##  [21] "balance"     "because"     "believe"     "benefit"    
##  [25] "between"     "brilliant"   "britain"     "brother"    
##  [29] "business"    "certain"     "chairman"    "character"  
##  [33] "Christmas"   "colleague"   "collect"     "college"    
##  [37] "comment"     "committee"   "community"   "company"    
##  [41] "compare"     "complete"    "compute"     "concern"    
##  [45] "condition"   "consider"    "consult"     "contact"    
##  [49] "continue"    "contract"    "control"     "converse"   
##  [53] "correct"     "council"     "country"     "current"    
##  [57] "decision"    "definite"    "department"  "describe"   
##  [61] "develop"     "difference"  "difficult"   "discuss"    
##  [65] "district"    "document"    "economy"     "educate"    
##  [69] "electric"    "encourage"   "english"     "environment"
##  [73] "especial"    "evening"     "evidence"    "example"    
##  [77] "exercise"    "expense"     "experience"  "explain"    
##  [81] "express"     "finance"     "fortune"     "forward"    
##  [85] "function"    "further"     "general"     "germany"    
##  [89] "goodbye"     "history"     "holiday"     "hospital"   
##  [93] "however"     "hundred"     "husband"     "identify"   
##  [97] "imagine"     "important"   "improve"     "include"    
## [101] "increase"    "individual"  "industry"    "instead"    
## [105] "interest"    "introduce"   "involve"     "kitchen"    
## [109] "language"    "machine"     "meaning"     "measure"    
## [113] "mention"     "million"     "minister"    "morning"    
## [117] "necessary"   "obvious"     "occasion"    "operate"    
## [121] "opportunity" "organize"    "original"    "otherwise"  
## [125] "paragraph"   "particular"  "pension"     "percent"    
## [129] "perfect"     "perhaps"     "photograph"  "picture"    
## [133] "politic"     "position"    "positive"    "possible"   
## [137] "practise"    "prepare"     "present"     "pressure"   
## [141] "presume"     "previous"    "private"     "probable"   
## [145] "problem"     "proceed"     "process"     "produce"    
## [149] "product"     "programme"   "project"     "propose"    
## [153] "protect"     "provide"     "purpose"     "quality"    
## [157] "quarter"     "question"    "realise"     "receive"    
## [161] "recognize"   "recommend"   "relation"    "remember"   
## [165] "represent"   "require"     "research"    "resource"   
## [169] "respect"     "responsible" "saturday"    "science"    
## [173] "scotland"    "secretary"   "section"     "separate"   
## [177] "serious"     "service"     "similar"     "situate"    
## [181] "society"     "special"     "specific"    "standard"   
## [185] "station"     "straight"    "strategy"    "structure"  
## [189] "student"     "subject"     "succeed"     "suggest"    
## [193] "support"     "suppose"     "surprise"    "telephone"  
## [197] "television"  "terrible"    "therefore"   "thirteen"   
## [201] "thousand"    "through"     "thursday"    "together"   
## [205] "tomorrow"    "tonight"     "traffic"     "transport"  
## [209] "trouble"     "tuesday"     "understand"  "university" 
## [213] "various"     "village"     "wednesday"   "welcome"    
## [217] "whether"     "without"     "yesterday"
```

``` r
str_subset(words, "^.{7,}$")
```

```
##   [1] "absolute"    "account"     "achieve"     "address"    
##   [5] "advertise"   "afternoon"   "against"     "already"    
##   [9] "alright"     "although"    "america"     "another"    
##  [13] "apparent"    "appoint"     "approach"    "appropriate"
##  [17] "arrange"     "associate"   "authority"   "available"  
##  [21] "balance"     "because"     "believe"     "benefit"    
##  [25] "between"     "brilliant"   "britain"     "brother"    
##  [29] "business"    "certain"     "chairman"    "character"  
##  [33] "Christmas"   "colleague"   "collect"     "college"    
##  [37] "comment"     "committee"   "community"   "company"    
##  [41] "compare"     "complete"    "compute"     "concern"    
##  [45] "condition"   "consider"    "consult"     "contact"    
##  [49] "continue"    "contract"    "control"     "converse"   
##  [53] "correct"     "council"     "country"     "current"    
##  [57] "decision"    "definite"    "department"  "describe"   
##  [61] "develop"     "difference"  "difficult"   "discuss"    
##  [65] "district"    "document"    "economy"     "educate"    
##  [69] "electric"    "encourage"   "english"     "environment"
##  [73] "especial"    "evening"     "evidence"    "example"    
##  [77] "exercise"    "expense"     "experience"  "explain"    
##  [81] "express"     "finance"     "fortune"     "forward"    
##  [85] "function"    "further"     "general"     "germany"    
##  [89] "goodbye"     "history"     "holiday"     "hospital"   
##  [93] "however"     "hundred"     "husband"     "identify"   
##  [97] "imagine"     "important"   "improve"     "include"    
## [101] "increase"    "individual"  "industry"    "instead"    
## [105] "interest"    "introduce"   "involve"     "kitchen"    
## [109] "language"    "machine"     "meaning"     "measure"    
## [113] "mention"     "million"     "minister"    "morning"    
## [117] "necessary"   "obvious"     "occasion"    "operate"    
## [121] "opportunity" "organize"    "original"    "otherwise"  
## [125] "paragraph"   "particular"  "pension"     "percent"    
## [129] "perfect"     "perhaps"     "photograph"  "picture"    
## [133] "politic"     "position"    "positive"    "possible"   
## [137] "practise"    "prepare"     "present"     "pressure"   
## [141] "presume"     "previous"    "private"     "probable"   
## [145] "problem"     "proceed"     "process"     "produce"    
## [149] "product"     "programme"   "project"     "propose"    
## [153] "protect"     "provide"     "purpose"     "quality"    
## [157] "quarter"     "question"    "realise"     "receive"    
## [161] "recognize"   "recommend"   "relation"    "remember"   
## [165] "represent"   "require"     "research"    "resource"   
## [169] "respect"     "responsible" "saturday"    "science"    
## [173] "scotland"    "secretary"   "section"     "separate"   
## [177] "serious"     "service"     "similar"     "situate"    
## [181] "society"     "special"     "specific"    "standard"   
## [185] "station"     "straight"    "strategy"    "structure"  
## [189] "student"     "subject"     "succeed"     "suggest"    
## [193] "support"     "suppose"     "surprise"    "telephone"  
## [197] "television"  "terrible"    "therefore"   "thirteen"   
## [201] "thousand"    "through"     "thursday"    "together"   
## [205] "tomorrow"    "tonight"     "traffic"     "transport"  
## [209] "trouble"     "tuesday"     "understand"  "university" 
## [213] "various"     "village"     "wednesday"   "welcome"    
## [217] "whether"     "without"     "yesterday"
```

``` r
str_subset(words, "^.......")
```

```
##   [1] "absolute"    "account"     "achieve"     "address"    
##   [5] "advertise"   "afternoon"   "against"     "already"    
##   [9] "alright"     "although"    "america"     "another"    
##  [13] "apparent"    "appoint"     "approach"    "appropriate"
##  [17] "arrange"     "associate"   "authority"   "available"  
##  [21] "balance"     "because"     "believe"     "benefit"    
##  [25] "between"     "brilliant"   "britain"     "brother"    
##  [29] "business"    "certain"     "chairman"    "character"  
##  [33] "Christmas"   "colleague"   "collect"     "college"    
##  [37] "comment"     "committee"   "community"   "company"    
##  [41] "compare"     "complete"    "compute"     "concern"    
##  [45] "condition"   "consider"    "consult"     "contact"    
##  [49] "continue"    "contract"    "control"     "converse"   
##  [53] "correct"     "council"     "country"     "current"    
##  [57] "decision"    "definite"    "department"  "describe"   
##  [61] "develop"     "difference"  "difficult"   "discuss"    
##  [65] "district"    "document"    "economy"     "educate"    
##  [69] "electric"    "encourage"   "english"     "environment"
##  [73] "especial"    "evening"     "evidence"    "example"    
##  [77] "exercise"    "expense"     "experience"  "explain"    
##  [81] "express"     "finance"     "fortune"     "forward"    
##  [85] "function"    "further"     "general"     "germany"    
##  [89] "goodbye"     "history"     "holiday"     "hospital"   
##  [93] "however"     "hundred"     "husband"     "identify"   
##  [97] "imagine"     "important"   "improve"     "include"    
## [101] "increase"    "individual"  "industry"    "instead"    
## [105] "interest"    "introduce"   "involve"     "kitchen"    
## [109] "language"    "machine"     "meaning"     "measure"    
## [113] "mention"     "million"     "minister"    "morning"    
## [117] "necessary"   "obvious"     "occasion"    "operate"    
## [121] "opportunity" "organize"    "original"    "otherwise"  
## [125] "paragraph"   "particular"  "pension"     "percent"    
## [129] "perfect"     "perhaps"     "photograph"  "picture"    
## [133] "politic"     "position"    "positive"    "possible"   
## [137] "practise"    "prepare"     "present"     "pressure"   
## [141] "presume"     "previous"    "private"     "probable"   
## [145] "problem"     "proceed"     "process"     "produce"    
## [149] "product"     "programme"   "project"     "propose"    
## [153] "protect"     "provide"     "purpose"     "quality"    
## [157] "quarter"     "question"    "realise"     "receive"    
## [161] "recognize"   "recommend"   "relation"    "remember"   
## [165] "represent"   "require"     "research"    "resource"   
## [169] "respect"     "responsible" "saturday"    "science"    
## [173] "scotland"    "secretary"   "section"     "separate"   
## [177] "serious"     "service"     "similar"     "situate"    
## [181] "society"     "special"     "specific"    "standard"   
## [185] "station"     "straight"    "strategy"    "structure"  
## [189] "student"     "subject"     "succeed"     "suggest"    
## [193] "support"     "suppose"     "surprise"    "telephone"  
## [197] "television"  "terrible"    "therefore"   "thirteen"   
## [201] "thousand"    "through"     "thursday"    "together"   
## [205] "tomorrow"    "tonight"     "traffic"     "transport"  
## [209] "trouble"     "tuesday"     "understand"  "university" 
## [213] "various"     "village"     "wednesday"   "welcome"    
## [217] "whether"     "without"     "yesterday"
```

``` r
# Invalid: nothing follows "^" before the quantifier
str_subset(words, "^{,7}.$")
```

```
## Error in `stri_detect_regex()`:
## ! Error in {min,max} interval. (U_REGEX_BAD_INTERVAL, context=`^{,7}.$`)
```

``` r
# Invalid: "{,m}" requires a preceding element to quantify
str_subset(words, "^.{,7}.$")
```

```
## Error in `stri_detect_regex()`:
## ! Error in {min,max} interval. (U_REGEX_BAD_INTERVAL, context=`^.{,7}.$`)
```

``` r
# Invalid: "{,m}" is not supported in R's default regex engine
str_subset(words, "^.{,7}$")
```

```
## Error in `stri_detect_regex()`:
## ! Error in {min,max} interval. (U_REGEX_BAD_INTERVAL, context=`^.{,7}$`)
```

``` r
# Invalid: same issue as above
str_subset(words, "^.{,7}")
```

```
## Error in `stri_detect_regex()`:
## ! Error in {min,max} interval. (U_REGEX_BAD_INTERVAL, context=`^.{,7}`)
```

``` r
# Valid syntax, but does not produce the intended result;
# a minimum bound should be specified for clarity
str_subset(words, "^.{1,7}.$")
```

```
##   [1] "able"     "about"    "absolute" "accept"   "account" 
##   [6] "achieve"  "across"   "act"      "active"   "actual"  
##  [11] "add"      "address"  "admit"    "affect"   "afford"  
##  [16] "after"    "again"    "against"  "age"      "agent"   
##  [21] "ago"      "agree"    "air"      "all"      "allow"   
##  [26] "almost"   "along"    "already"  "alright"  "also"    
##  [31] "although" "always"   "america"  "amount"   "and"     
##  [36] "another"  "answer"   "any"      "apart"    "apparent"
##  [41] "appear"   "apply"    "appoint"  "approach" "area"    
##  [46] "argue"    "arm"      "around"   "arrange"  "art"     
##  [51] "as"       "ask"      "assume"   "at"       "attend"  
##  [56] "aware"    "away"     "awful"    "baby"     "back"    
##  [61] "bad"      "bag"      "balance"  "ball"     "bank"    
##  [66] "bar"      "base"     "basis"    "be"       "bear"    
##  [71] "beat"     "beauty"   "because"  "become"   "bed"     
##  [76] "before"   "begin"    "behind"   "believe"  "benefit" 
##  [81] "best"     "bet"      "between"  "big"      "bill"    
##  [86] "birth"    "bit"      "black"    "bloke"    "blood"   
##  [91] "blow"     "blue"     "board"    "boat"     "body"    
##  [96] "book"     "both"     "bother"   "bottle"   "bottom"  
## [101] "box"      "boy"      "break"    "brief"    "bring"   
## [106] "britain"  "brother"  "budget"   "build"    "bus"     
## [111] "business" "busy"     "but"      "buy"      "by"      
## [116] "cake"     "call"     "can"      "car"      "card"    
## [121] "care"     "carry"    "case"     "cat"      "catch"   
## [126] "cause"    "cent"     "centre"   "certain"  "chair"   
## [131] "chairman" "chance"   "change"   "chap"     "charge"  
## [136] "cheap"    "check"    "child"    "choice"   "choose"  
## [141] "Christ"   "church"   "city"     "claim"    "class"   
## [146] "clean"    "clear"    "client"   "clock"    "close"   
## [151] "closes"   "clothe"   "club"     "coffee"   "cold"    
## [156] "collect"  "college"  "colour"   "come"     "comment" 
## [161] "commit"   "common"   "company"  "compare"  "complete"
## [166] "compute"  "concern"  "confer"   "consider" "consult" 
## [171] "contact"  "continue" "contract" "control"  "converse"
## [176] "cook"     "copy"     "corner"   "correct"  "cost"    
## [181] "could"    "council"  "count"    "country"  "county"  
## [186] "couple"   "course"   "court"    "cover"    "create"  
## [191] "cross"    "cup"      "current"  "cut"      "dad"     
## [196] "danger"   "date"     "day"      "dead"     "deal"    
## [201] "dear"     "debate"   "decide"   "decision" "deep"    
## [206] "definite" "degree"   "depend"   "describe" "design"  
## [211] "detail"   "develop"  "die"      "dinner"   "direct"  
## [216] "discuss"  "district" "divide"   "do"       "doctor"  
## [221] "document" "dog"      "door"     "double"   "doubt"   
## [226] "down"     "draw"     "dress"    "drink"    "drive"   
## [231] "drop"     "dry"      "due"      "during"   "each"    
## [236] "early"    "east"     "easy"     "eat"      "economy" 
## [241] "educate"  "effect"   "egg"      "eight"    "either"  
## [246] "elect"    "electric" "eleven"   "else"     "employ"  
## [251] "end"      "engine"   "english"  "enjoy"    "enough"  
## [256] "enter"    "equal"    "especial" "europe"   "even"    
## [261] "evening"  "ever"     "every"    "evidence" "exact"   
## [266] "example"  "except"   "excuse"   "exercise" "exist"   
## [271] "expect"   "expense"  "explain"  "express"  "extra"   
## [276] "eye"      "face"     "fact"     "fair"     "fall"    
## [281] "family"   "far"      "farm"     "fast"     "father"  
## [286] "favour"   "feed"     "feel"     "few"      "field"   
## [291] "fight"    "figure"   "file"     "fill"     "film"    
## [296] "final"    "finance"  "find"     "fine"     "finish"  
## [301] "fire"     "first"    "fish"     "fit"      "five"    
## [306] "flat"     "floor"    "fly"      "follow"   "food"    
## [311] "foot"     "for"      "force"    "forget"   "form"    
## [316] "fortune"  "forward"  "four"     "france"   "free"    
## [321] "friday"   "friend"   "from"     "front"    "full"    
## [326] "fun"      "function" "fund"     "further"  "future"  
## [331] "game"     "garden"   "gas"      "general"  "germany" 
## [336] "get"      "girl"     "give"     "glass"    "go"      
## [341] "god"      "good"     "goodbye"  "govern"   "grand"   
## [346] "grant"    "great"    "green"    "ground"   "group"   
## [351] "grow"     "guess"    "guy"      "hair"     "half"    
## [356] "hall"     "hand"     "hang"     "happen"   "happy"   
## [361] "hard"     "hate"     "have"     "he"       "head"    
## [366] "health"   "hear"     "heart"    "heat"     "heavy"   
## [371] "hell"     "help"     "here"     "high"     "history" 
## [376] "hit"      "hold"     "holiday"  "home"     "honest"  
## [381] "hope"     "horse"    "hospital" "hot"      "hour"    
## [386] "house"    "how"      "however"  "hullo"    "hundred" 
## [391] "husband"  "idea"     "identify" "if"       "imagine" 
## [396] "improve"  "in"       "include"  "income"   "increase"
## [401] "indeed"   "industry" "inform"   "inside"   "instead" 
## [406] "insure"   "interest" "into"     "invest"   "involve" 
## [411] "issue"    "it"       "item"     "jesus"    "job"     
## [416] "join"     "judge"    "jump"     "just"     "keep"    
## [421] "key"      "kid"      "kill"     "kind"     "king"    
## [426] "kitchen"  "knock"    "know"     "labour"   "lad"     
## [431] "lady"     "land"     "language" "large"    "last"    
## [436] "late"     "laugh"    "law"      "lay"      "lead"    
## [441] "learn"    "leave"    "left"     "leg"      "less"    
## [446] "let"      "letter"   "level"    "lie"      "life"    
## [451] "light"    "like"     "likely"   "limit"    "line"    
## [456] "link"     "list"     "listen"   "little"   "live"    
## [461] "load"     "local"    "lock"     "london"   "long"    
## [466] "look"     "lord"     "lose"     "lot"      "love"    
## [471] "low"      "luck"     "lunch"    "machine"  "main"    
## [476] "major"    "make"     "man"      "manage"   "many"    
## [481] "mark"     "market"   "marry"    "match"    "matter"  
## [486] "may"      "maybe"    "mean"     "meaning"  "measure" 
## [491] "meet"     "member"   "mention"  "middle"   "might"   
## [496] "mile"     "milk"     "million"  "mind"     "minister"
## [501] "minus"    "minute"   "miss"     "mister"   "moment"  
## [506] "monday"   "money"    "month"    "more"     "morning" 
## [511] "most"     "mother"   "motion"   "move"     "mrs"     
## [516] "much"     "music"    "must"     "name"     "nation"  
## [521] "nature"   "near"     "need"     "never"    "new"     
## [526] "news"     "next"     "nice"     "night"    "nine"    
## [531] "no"       "non"      "none"     "normal"   "north"   
## [536] "not"      "note"     "notice"   "now"      "number"  
## [541] "obvious"  "occasion" "odd"      "of"       "off"     
## [546] "offer"    "office"   "often"    "okay"     "old"     
## [551] "on"       "once"     "one"      "only"     "open"    
## [556] "operate"  "oppose"   "or"       "order"    "organize"
## [561] "original" "other"    "ought"    "out"      "over"    
## [566] "own"      "pack"     "page"     "paint"    "pair"    
## [571] "paper"    "pardon"   "parent"   "park"     "part"    
## [576] "party"    "pass"     "past"     "pay"      "pence"   
## [581] "pension"  "people"   "per"      "percent"  "perfect" 
## [586] "perhaps"  "period"   "person"   "pick"     "picture" 
## [591] "piece"    "place"    "plan"     "play"     "please"  
## [596] "plus"     "point"    "police"   "policy"   "politic" 
## [601] "poor"     "position" "positive" "possible" "post"    
## [606] "pound"    "power"    "practise" "prepare"  "present" 
## [611] "press"    "pressure" "presume"  "pretty"   "previous"
## [616] "price"    "print"    "private"  "probable" "problem" 
## [621] "proceed"  "process"  "produce"  "product"  "project" 
## [626] "proper"   "propose"  "protect"  "provide"  "public"  
## [631] "pull"     "purpose"  "push"     "put"      "quality" 
## [636] "quarter"  "question" "quick"    "quid"     "quiet"   
## [641] "quite"    "radio"    "rail"     "raise"    "range"   
## [646] "rate"     "rather"   "read"     "ready"    "real"    
## [651] "realise"  "really"   "reason"   "receive"  "recent"  
## [656] "reckon"   "record"   "red"      "reduce"   "refer"   
## [661] "regard"   "region"   "relation" "remember" "report"  
## [666] "require"  "research" "resource" "respect"  "rest"    
## [671] "result"   "return"   "rid"      "right"    "ring"    
## [676] "rise"     "road"     "role"     "roll"     "room"    
## [681] "round"    "rule"     "run"      "safe"     "sale"    
## [686] "same"     "saturday" "save"     "say"      "scheme"  
## [691] "school"   "science"  "score"    "scotland" "seat"    
## [696] "second"   "section"  "secure"   "see"      "seem"    
## [701] "self"     "sell"     "send"     "sense"    "separate"
## [706] "serious"  "serve"    "service"  "set"      "settle"  
## [711] "seven"    "sex"      "shall"    "share"    "she"     
## [716] "sheet"    "shoe"     "shoot"    "shop"     "short"   
## [721] "should"   "show"     "shut"     "sick"     "side"    
## [726] "sign"     "similar"  "simple"   "since"    "sing"    
## [731] "single"   "sir"      "sister"   "sit"      "site"    
## [736] "situate"  "six"      "size"     "sleep"    "slight"  
## [741] "slow"     "small"    "smoke"    "so"       "social"  
## [746] "society"  "some"     "son"      "soon"     "sorry"   
## [751] "sort"     "sound"    "south"    "space"    "speak"   
## [756] "special"  "specific" "speed"    "spell"    "spend"   
## [761] "square"   "staff"    "stage"    "stairs"   "stand"   
## [766] "standard" "start"    "state"    "station"  "stay"    
## [771] "step"     "stick"    "still"    "stop"     "story"   
## [776] "straight" "strategy" "street"   "strike"   "strong"  
## [781] "student"  "study"    "stuff"    "stupid"   "subject" 
## [786] "succeed"  "such"     "sudden"   "suggest"  "suit"    
## [791] "summer"   "sun"      "sunday"   "supply"   "support" 
## [796] "suppose"  "sure"     "surprise" "switch"   "system"  
## [801] "table"    "take"     "talk"     "tape"     "tax"     
## [806] "tea"      "teach"    "team"     "tell"     "ten"     
## [811] "tend"     "term"     "terrible" "test"     "than"    
## [816] "thank"    "the"      "then"     "there"    "they"    
## [821] "thing"    "think"    "thirteen" "thirty"   "this"    
## [826] "thou"     "though"   "thousand" "three"    "through" 
## [831] "throw"    "thursday" "tie"      "time"     "to"      
## [836] "today"    "together" "tomorrow" "tonight"  "too"     
## [841] "top"      "total"    "touch"    "toward"   "town"    
## [846] "trade"    "traffic"  "train"    "travel"   "treat"   
## [851] "tree"     "trouble"  "true"     "trust"    "try"     
## [856] "tuesday"  "turn"     "twelve"   "twenty"   "two"     
## [861] "type"     "under"    "union"    "unit"     "unite"   
## [866] "unless"   "until"    "up"       "upon"     "use"     
## [871] "usual"    "value"    "various"  "very"     "video"   
## [876] "view"     "village"  "visit"    "vote"     "wage"    
## [881] "wait"     "walk"     "wall"     "want"     "war"     
## [886] "warm"     "wash"     "waste"    "watch"    "water"   
## [891] "way"      "we"       "wear"     "wee"      "week"    
## [896] "weigh"    "welcome"  "well"     "west"     "what"    
## [901] "when"     "where"    "whether"  "which"    "while"   
## [906] "white"    "who"      "whole"    "why"      "wide"    
## [911] "wife"     "will"     "win"      "wind"     "window"  
## [916] "wish"     "with"     "within"   "without"  "woman"   
## [921] "wonder"   "wood"     "word"     "work"     "world"   
## [926] "worry"    "worse"    "worth"    "would"    "write"   
## [931] "wrong"    "year"     "yes"      "yet"      "you"     
## [936] "young"
```

