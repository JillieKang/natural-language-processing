---
output:
  html_document:
    highlight: tango
    self_contained: true
    theme: journal
---
# String Manipulation for Tidying Text Data
## Requirements


``` r
library(stringr)
```

## Text Length Measurement with `str_length()`


``` r
str_length(c("a", "banana", NA))
```

```
## [1]  1  6 NA
```

## String Concatenation with `str_c()`


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
##  [1] "Letter: a" "Letter: b" "Letter: c" "Letter: d" "Letter: e" "Letter: f" "Letter: g"
##  [8] "Letter: h" "Letter: i" "Letter: j" "Letter: k" "Letter: l" "Letter: m" "Letter: n"
## [15] "Letter: o" "Letter: p" "Letter: q" "Letter: r" "Letter: s" "Letter: t" "Letter: u"
## [22] "Letter: v" "Letter: w" "Letter: x" "Letter: y" "Letter: z"
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

## Substring Extraction with `str_sub()`


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

## Pattern Matching with `str_view()`


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

## Pattern Filtering with `str_subset()`


``` r
str_subset(words, "^.{3}$")
```

```
##   [1] "act" "add" "age" "ago" "air" "all" "and" "any" "arm" "art" "ask" "bad" "bag" "bar"
##  [15] "bed" "bet" "big" "bit" "box" "boy" "bus" "but" "buy" "can" "car" "cat" "cup" "cut"
##  [29] "dad" "day" "die" "dog" "dry" "due" "eat" "egg" "end" "eye" "far" "few" "fit" "fly"
##  [43] "for" "fun" "gas" "get" "god" "guy" "hit" "hot" "how" "job" "key" "kid" "lad" "law"
##  [57] "lay" "leg" "let" "lie" "lot" "low" "man" "may" "mrs" "new" "non" "not" "now" "odd"
##  [71] "off" "old" "one" "out" "own" "pay" "per" "put" "red" "rid" "run" "say" "see" "set"
##  [85] "sex" "she" "sir" "sit" "six" "son" "sun" "tax" "tea" "ten" "the" "tie" "too" "top"
##  [99] "try" "two" "use" "war" "way" "wee" "who" "why" "win" "yes" "yet" "you"
```

``` r
str_subset(words, "^y")
```

```
## [1] "year"      "yes"       "yesterday" "yet"       "you"       "young"
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
##   [1] "absolute"    "account"     "achieve"     "address"     "advertise"   "afternoon"  
##   [7] "against"     "already"     "alright"     "although"    "america"     "another"    
##  [13] "apparent"    "appoint"     "approach"    "appropriate" "arrange"     "associate"  
##  [19] "authority"   "available"   "balance"     "because"     "believe"     "benefit"    
##  [25] "between"     "brilliant"   "britain"     "brother"     "business"    "certain"    
##  [31] "chairman"    "character"   "Christmas"   "colleague"   "collect"     "college"    
##  [37] "comment"     "committee"   "community"   "company"     "compare"     "complete"   
##  [43] "compute"     "concern"     "condition"   "consider"    "consult"     "contact"    
##  [49] "continue"    "contract"    "control"     "converse"    "correct"     "council"    
##  [55] "country"     "current"     "decision"    "definite"    "department"  "describe"   
##  [61] "develop"     "difference"  "difficult"   "discuss"     "district"    "document"   
##  [67] "economy"     "educate"     "electric"    "encourage"   "english"     "environment"
##  [73] "especial"    "evening"     "evidence"    "example"     "exercise"    "expense"    
##  [79] "experience"  "explain"     "express"     "finance"     "fortune"     "forward"    
##  [85] "function"    "further"     "general"     "germany"     "goodbye"     "history"    
##  [91] "holiday"     "hospital"    "however"     "hundred"     "husband"     "identify"   
##  [97] "imagine"     "important"   "improve"     "include"     "increase"    "individual" 
## [103] "industry"    "instead"     "interest"    "introduce"   "involve"     "kitchen"    
## [109] "language"    "machine"     "meaning"     "measure"     "mention"     "million"    
## [115] "minister"    "morning"     "necessary"   "obvious"     "occasion"    "operate"    
## [121] "opportunity" "organize"    "original"    "otherwise"   "paragraph"   "particular" 
## [127] "pension"     "percent"     "perfect"     "perhaps"     "photograph"  "picture"    
## [133] "politic"     "position"    "positive"    "possible"    "practise"    "prepare"    
## [139] "present"     "pressure"    "presume"     "previous"    "private"     "probable"   
## [145] "problem"     "proceed"     "process"     "produce"     "product"     "programme"  
## [151] "project"     "propose"     "protect"     "provide"     "purpose"     "quality"    
## [157] "quarter"     "question"    "realise"     "receive"     "recognize"   "recommend"  
## [163] "relation"    "remember"    "represent"   "require"     "research"    "resource"   
## [169] "respect"     "responsible" "saturday"    "science"     "scotland"    "secretary"  
## [175] "section"     "separate"    "serious"     "service"     "similar"     "situate"    
## [181] "society"     "special"     "specific"    "standard"    "station"     "straight"   
## [187] "strategy"    "structure"   "student"     "subject"     "succeed"     "suggest"    
## [193] "support"     "suppose"     "surprise"    "telephone"   "television"  "terrible"   
## [199] "therefore"   "thirteen"    "thousand"    "through"     "thursday"    "together"   
## [205] "tomorrow"    "tonight"     "traffic"     "transport"   "trouble"     "tuesday"    
## [211] "understand"  "university"  "various"     "village"     "wednesday"   "welcome"    
## [217] "whether"     "without"     "yesterday"
```

### Exercises


``` r
# Matches words consisting of exactly three characters
str_subset(words, "^.{3}$")
```

```
##   [1] "act" "add" "age" "ago" "air" "all" "and" "any" "arm" "art" "ask" "bad" "bag" "bar"
##  [15] "bed" "bet" "big" "bit" "box" "boy" "bus" "but" "buy" "can" "car" "cat" "cup" "cut"
##  [29] "dad" "day" "die" "dog" "dry" "due" "eat" "egg" "end" "eye" "far" "few" "fit" "fly"
##  [43] "for" "fun" "gas" "get" "god" "guy" "hit" "hot" "how" "job" "key" "kid" "lad" "law"
##  [57] "lay" "leg" "let" "lie" "lot" "low" "man" "may" "mrs" "new" "non" "not" "now" "odd"
##  [71] "off" "old" "one" "out" "own" "pay" "per" "put" "red" "rid" "run" "say" "see" "set"
##  [85] "sex" "she" "sir" "sit" "six" "son" "sun" "tax" "tea" "ten" "the" "tie" "too" "top"
##  [99] "try" "two" "use" "war" "way" "wee" "who" "why" "win" "yes" "yet" "you"
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
##   [1] "act" "add" "age" "ago" "air" "all" "and" "any" "arm" "art" "ask" "bad" "bag" "bar"
##  [15] "bed" "bet" "big" "bit" "box" "boy" "bus" "but" "buy" "can" "car" "cat" "cup" "cut"
##  [29] "dad" "day" "die" "dog" "dry" "due" "eat" "egg" "end" "eye" "far" "few" "fit" "fly"
##  [43] "for" "fun" "gas" "get" "god" "guy" "hit" "hot" "how" "job" "key" "kid" "lad" "law"
##  [57] "lay" "leg" "let" "lie" "lot" "low" "man" "may" "mrs" "new" "non" "not" "now" "odd"
##  [71] "off" "old" "one" "out" "own" "pay" "per" "put" "red" "rid" "run" "say" "see" "set"
##  [85] "sex" "she" "sir" "sit" "six" "son" "sun" "tax" "tea" "ten" "the" "tie" "too" "top"
##  [99] "try" "two" "use" "war" "way" "wee" "who" "why" "win" "yes" "yet" "you"
```

``` r
# Matches words beginning with at least three characters (no upper limit)
str_subset(words, "^.{3}")
```

```
##   [1] "able"        "about"       "absolute"    "accept"      "account"     "achieve"    
##   [7] "across"      "act"         "active"      "actual"      "add"         "address"    
##  [13] "admit"       "advertise"   "affect"      "afford"      "after"       "afternoon"  
##  [19] "again"       "against"     "age"         "agent"       "ago"         "agree"      
##  [25] "air"         "all"         "allow"       "almost"      "along"       "already"    
##  [31] "alright"     "also"        "although"    "always"      "america"     "amount"     
##  [37] "and"         "another"     "answer"      "any"         "apart"       "apparent"   
##  [43] "appear"      "apply"       "appoint"     "approach"    "appropriate" "area"       
##  [49] "argue"       "arm"         "around"      "arrange"     "art"         "ask"        
##  [55] "associate"   "assume"      "attend"      "authority"   "available"   "aware"      
##  [61] "away"        "awful"       "baby"        "back"        "bad"         "bag"        
##  [67] "balance"     "ball"        "bank"        "bar"         "base"        "basis"      
##  [73] "bear"        "beat"        "beauty"      "because"     "become"      "bed"        
##  [79] "before"      "begin"       "behind"      "believe"     "benefit"     "best"       
##  [85] "bet"         "between"     "big"         "bill"        "birth"       "bit"        
##  [91] "black"       "bloke"       "blood"       "blow"        "blue"        "board"      
##  [97] "boat"        "body"        "book"        "both"        "bother"      "bottle"     
## [103] "bottom"      "box"         "boy"         "break"       "brief"       "brilliant"  
## [109] "bring"       "britain"     "brother"     "budget"      "build"       "bus"        
## [115] "business"    "busy"        "but"         "buy"         "cake"        "call"       
## [121] "can"         "car"         "card"        "care"        "carry"       "case"       
## [127] "cat"         "catch"       "cause"       "cent"        "centre"      "certain"    
## [133] "chair"       "chairman"    "chance"      "change"      "chap"        "character"  
## [139] "charge"      "cheap"       "check"       "child"       "choice"      "choose"     
## [145] "Christ"      "Christmas"   "church"      "city"        "claim"       "class"      
## [151] "clean"       "clear"       "client"      "clock"       "close"       "closes"     
## [157] "clothe"      "club"        "coffee"      "cold"        "colleague"   "collect"    
## [163] "college"     "colour"      "come"        "comment"     "commit"      "committee"  
## [169] "common"      "community"   "company"     "compare"     "complete"    "compute"    
## [175] "concern"     "condition"   "confer"      "consider"    "consult"     "contact"    
## [181] "continue"    "contract"    "control"     "converse"    "cook"        "copy"       
## [187] "corner"      "correct"     "cost"        "could"       "council"     "count"      
## [193] "country"     "county"      "couple"      "course"      "court"       "cover"      
## [199] "create"      "cross"       "cup"         "current"     "cut"         "dad"        
## [205] "danger"      "date"        "day"         "dead"        "deal"        "dear"       
## [211] "debate"      "decide"      "decision"    "deep"        "definite"    "degree"     
## [217] "department"  "depend"      "describe"    "design"      "detail"      "develop"    
## [223] "die"         "difference"  "difficult"   "dinner"      "direct"      "discuss"    
## [229] "district"    "divide"      "doctor"      "document"    "dog"         "door"       
## [235] "double"      "doubt"       "down"        "draw"        "dress"       "drink"      
## [241] "drive"       "drop"        "dry"         "due"         "during"      "each"       
## [247] "early"       "east"        "easy"        "eat"         "economy"     "educate"    
## [253] "effect"      "egg"         "eight"       "either"      "elect"       "electric"   
## [259] "eleven"      "else"        "employ"      "encourage"   "end"         "engine"     
## [265] "english"     "enjoy"       "enough"      "enter"       "environment" "equal"      
## [271] "especial"    "europe"      "even"        "evening"     "ever"        "every"      
## [277] "evidence"    "exact"       "example"     "except"      "excuse"      "exercise"   
## [283] "exist"       "expect"      "expense"     "experience"  "explain"     "express"    
## [289] "extra"       "eye"         "face"        "fact"        "fair"        "fall"       
## [295] "family"      "far"         "farm"        "fast"        "father"      "favour"     
## [301] "feed"        "feel"        "few"         "field"       "fight"       "figure"     
## [307] "file"        "fill"        "film"        "final"       "finance"     "find"       
## [313] "fine"        "finish"      "fire"        "first"       "fish"        "fit"        
## [319] "five"        "flat"        "floor"       "fly"         "follow"      "food"       
## [325] "foot"        "for"         "force"       "forget"      "form"        "fortune"    
## [331] "forward"     "four"        "france"      "free"        "friday"      "friend"     
## [337] "from"        "front"       "full"        "fun"         "function"    "fund"       
## [343] "further"     "future"      "game"        "garden"      "gas"         "general"    
## [349] "germany"     "get"         "girl"        "give"        "glass"       "god"        
## [355] "good"        "goodbye"     "govern"      "grand"       "grant"       "great"      
## [361] "green"       "ground"      "group"       "grow"        "guess"       "guy"        
## [367] "hair"        "half"        "hall"        "hand"        "hang"        "happen"     
## [373] "happy"       "hard"        "hate"        "have"        "head"        "health"     
## [379] "hear"        "heart"       "heat"        "heavy"       "hell"        "help"       
## [385] "here"        "high"        "history"     "hit"         "hold"        "holiday"    
## [391] "home"        "honest"      "hope"        "horse"       "hospital"    "hot"        
## [397] "hour"        "house"       "how"         "however"     "hullo"       "hundred"    
## [403] "husband"     "idea"        "identify"    "imagine"     "important"   "improve"    
## [409] "include"     "income"      "increase"    "indeed"      "individual"  "industry"   
## [415] "inform"      "inside"      "instead"     "insure"      "interest"    "into"       
## [421] "introduce"   "invest"      "involve"     "issue"       "item"        "jesus"      
## [427] "job"         "join"        "judge"       "jump"        "just"        "keep"       
## [433] "key"         "kid"         "kill"        "kind"        "king"        "kitchen"    
## [439] "knock"       "know"        "labour"      "lad"         "lady"        "land"       
## [445] "language"    "large"       "last"        "late"        "laugh"       "law"        
## [451] "lay"         "lead"        "learn"       "leave"       "left"        "leg"        
## [457] "less"        "let"         "letter"      "level"       "lie"         "life"       
## [463] "light"       "like"        "likely"      "limit"       "line"        "link"       
## [469] "list"        "listen"      "little"      "live"        "load"        "local"      
## [475] "lock"        "london"      "long"        "look"        "lord"        "lose"       
## [481] "lot"         "love"        "low"         "luck"        "lunch"       "machine"    
## [487] "main"        "major"       "make"        "man"         "manage"      "many"       
## [493] "mark"        "market"      "marry"       "match"       "matter"      "may"        
## [499] "maybe"       "mean"        "meaning"     "measure"     "meet"        "member"     
## [505] "mention"     "middle"      "might"       "mile"        "milk"        "million"    
## [511] "mind"        "minister"    "minus"       "minute"      "miss"        "mister"     
## [517] "moment"      "monday"      "money"       "month"       "more"        "morning"    
## [523] "most"        "mother"      "motion"      "move"        "mrs"         "much"       
## [529] "music"       "must"        "name"        "nation"      "nature"      "near"       
## [535] "necessary"   "need"        "never"       "new"         "news"        "next"       
## [541] "nice"        "night"       "nine"        "non"         "none"        "normal"     
## [547] "north"       "not"         "note"        "notice"      "now"         "number"     
## [553] "obvious"     "occasion"    "odd"         "off"         "offer"       "office"     
## [559] "often"       "okay"        "old"         "once"        "one"         "only"       
## [565] "open"        "operate"     "opportunity" "oppose"      "order"       "organize"   
## [571] "original"    "other"       "otherwise"   "ought"       "out"         "over"       
## [577] "own"         "pack"        "page"        "paint"       "pair"        "paper"      
## [583] "paragraph"   "pardon"      "parent"      "park"        "part"        "particular" 
## [589] "party"       "pass"        "past"        "pay"         "pence"       "pension"    
## [595] "people"      "per"         "percent"     "perfect"     "perhaps"     "period"     
## [601] "person"      "photograph"  "pick"        "picture"     "piece"       "place"      
## [607] "plan"        "play"        "please"      "plus"        "point"       "police"     
## [613] "policy"      "politic"     "poor"        "position"    "positive"    "possible"   
## [619] "post"        "pound"       "power"       "practise"    "prepare"     "present"    
## [625] "press"       "pressure"    "presume"     "pretty"      "previous"    "price"      
## [631] "print"       "private"     "probable"    "problem"     "proceed"     "process"    
## [637] "produce"     "product"     "programme"   "project"     "proper"      "propose"    
## [643] "protect"     "provide"     "public"      "pull"        "purpose"     "push"       
## [649] "put"         "quality"     "quarter"     "question"    "quick"       "quid"       
## [655] "quiet"       "quite"       "radio"       "rail"        "raise"       "range"      
## [661] "rate"        "rather"      "read"        "ready"       "real"        "realise"    
## [667] "really"      "reason"      "receive"     "recent"      "reckon"      "recognize"  
## [673] "recommend"   "record"      "red"         "reduce"      "refer"       "regard"     
## [679] "region"      "relation"    "remember"    "report"      "represent"   "require"    
## [685] "research"    "resource"    "respect"     "responsible" "rest"        "result"     
## [691] "return"      "rid"         "right"       "ring"        "rise"        "road"       
## [697] "role"        "roll"        "room"        "round"       "rule"        "run"        
## [703] "safe"        "sale"        "same"        "saturday"    "save"        "say"        
## [709] "scheme"      "school"      "science"     "score"       "scotland"    "seat"       
## [715] "second"      "secretary"   "section"     "secure"      "see"         "seem"       
## [721] "self"        "sell"        "send"        "sense"       "separate"    "serious"    
## [727] "serve"       "service"     "set"         "settle"      "seven"       "sex"        
## [733] "shall"       "share"       "she"         "sheet"       "shoe"        "shoot"      
## [739] "shop"        "short"       "should"      "show"        "shut"        "sick"       
## [745] "side"        "sign"        "similar"     "simple"      "since"       "sing"       
## [751] "single"      "sir"         "sister"      "sit"         "site"        "situate"    
## [757] "six"         "size"        "sleep"       "slight"      "slow"        "small"      
## [763] "smoke"       "social"      "society"     "some"        "son"         "soon"       
## [769] "sorry"       "sort"        "sound"       "south"       "space"       "speak"      
## [775] "special"     "specific"    "speed"       "spell"       "spend"       "square"     
## [781] "staff"       "stage"       "stairs"      "stand"       "standard"    "start"      
## [787] "state"       "station"     "stay"        "step"        "stick"       "still"      
## [793] "stop"        "story"       "straight"    "strategy"    "street"      "strike"     
## [799] "strong"      "structure"   "student"     "study"       "stuff"       "stupid"     
## [805] "subject"     "succeed"     "such"        "sudden"      "suggest"     "suit"       
## [811] "summer"      "sun"         "sunday"      "supply"      "support"     "suppose"    
## [817] "sure"        "surprise"    "switch"      "system"      "table"       "take"       
## [823] "talk"        "tape"        "tax"         "tea"         "teach"       "team"       
## [829] "telephone"   "television"  "tell"        "ten"         "tend"        "term"       
## [835] "terrible"    "test"        "than"        "thank"       "the"         "then"       
## [841] "there"       "therefore"   "they"        "thing"       "think"       "thirteen"   
## [847] "thirty"      "this"        "thou"        "though"      "thousand"    "three"      
## [853] "through"     "throw"       "thursday"    "tie"         "time"        "today"      
## [859] "together"    "tomorrow"    "tonight"     "too"         "top"         "total"      
## [865] "touch"       "toward"      "town"        "trade"       "traffic"     "train"      
## [871] "transport"   "travel"      "treat"       "tree"        "trouble"     "true"       
## [877] "trust"       "try"         "tuesday"     "turn"        "twelve"      "twenty"     
## [883] "two"         "type"        "under"       "understand"  "union"       "unit"       
## [889] "unite"       "university"  "unless"      "until"       "upon"        "use"        
## [895] "usual"       "value"       "various"     "very"        "video"       "view"       
## [901] "village"     "visit"       "vote"        "wage"        "wait"        "walk"       
## [907] "wall"        "want"        "war"         "warm"        "wash"        "waste"      
## [913] "watch"       "water"       "way"         "wear"        "wednesday"   "wee"        
## [919] "week"        "weigh"       "welcome"     "well"        "west"        "what"       
## [925] "when"        "where"       "whether"     "which"       "while"       "white"      
## [931] "who"         "whole"       "why"         "wide"        "wife"        "will"       
## [937] "win"         "wind"        "window"      "wish"        "with"        "within"     
## [943] "without"     "woman"       "wonder"      "wood"        "word"        "work"       
## [949] "world"       "worry"       "worse"       "worth"       "would"       "write"      
## [955] "wrong"       "year"        "yes"         "yesterday"   "yet"         "you"        
## [961] "young"
```

``` r
# Matches words consisting of two to four characters
str_subset(words, "^.{2,4}$")
```

```
##   [1] "able" "act"  "add"  "age"  "ago"  "air"  "all"  "also" "and"  "any"  "area" "arm" 
##  [13] "art"  "as"   "ask"  "at"   "away" "baby" "back" "bad"  "bag"  "ball" "bank" "bar" 
##  [25] "base" "be"   "bear" "beat" "bed"  "best" "bet"  "big"  "bill" "bit"  "blow" "blue"
##  [37] "boat" "body" "book" "both" "box"  "boy"  "bus"  "busy" "but"  "buy"  "by"   "cake"
##  [49] "call" "can"  "car"  "card" "care" "case" "cat"  "cent" "chap" "city" "club" "cold"
##  [61] "come" "cook" "copy" "cost" "cup"  "cut"  "dad"  "date" "day"  "dead" "deal" "dear"
##  [73] "deep" "die"  "do"   "dog"  "door" "down" "draw" "drop" "dry"  "due"  "each" "east"
##  [85] "easy" "eat"  "egg"  "else" "end"  "even" "ever" "eye"  "face" "fact" "fair" "fall"
##  [97] "far"  "farm" "fast" "feed" "feel" "few"  "file" "fill" "film" "find" "fine" "fire"
## [109] "fish" "fit"  "five" "flat" "fly"  "food" "foot" "for"  "form" "four" "free" "from"
## [121] "full" "fun"  "fund" "game" "gas"  "get"  "girl" "give" "go"   "god"  "good" "grow"
## [133] "guy"  "hair" "half" "hall" "hand" "hang" "hard" "hate" "have" "he"   "head" "hear"
## [145] "heat" "hell" "help" "here" "high" "hit"  "hold" "home" "hope" "hot"  "hour" "how" 
## [157] "idea" "if"   "in"   "into" "it"   "item" "job"  "join" "jump" "just" "keep" "key" 
## [169] "kid"  "kill" "kind" "king" "know" "lad"  "lady" "land" "last" "late" "law"  "lay" 
## [181] "lead" "left" "leg"  "less" "let"  "lie"  "life" "like" "line" "link" "list" "live"
## [193] "load" "lock" "long" "look" "lord" "lose" "lot"  "love" "low"  "luck" "main" "make"
## [205] "man"  "many" "mark" "may"  "mean" "meet" "mile" "milk" "mind" "miss" "more" "most"
## [217] "move" "mrs"  "much" "must" "name" "near" "need" "new"  "news" "next" "nice" "nine"
## [229] "no"   "non"  "none" "not"  "note" "now"  "odd"  "of"   "off"  "okay" "old"  "on"  
## [241] "once" "one"  "only" "open" "or"   "out"  "over" "own"  "pack" "page" "pair" "park"
## [253] "part" "pass" "past" "pay"  "per"  "pick" "plan" "play" "plus" "poor" "post" "pull"
## [265] "push" "put"  "quid" "rail" "rate" "read" "real" "red"  "rest" "rid"  "ring" "rise"
## [277] "road" "role" "roll" "room" "rule" "run"  "safe" "sale" "same" "save" "say"  "seat"
## [289] "see"  "seem" "self" "sell" "send" "set"  "sex"  "she"  "shoe" "shop" "show" "shut"
## [301] "sick" "side" "sign" "sing" "sir"  "sit"  "site" "six"  "size" "slow" "so"   "some"
## [313] "son"  "soon" "sort" "stay" "step" "stop" "such" "suit" "sun"  "sure" "take" "talk"
## [325] "tape" "tax"  "tea"  "team" "tell" "ten"  "tend" "term" "test" "than" "the"  "then"
## [337] "they" "this" "thou" "tie"  "time" "to"   "too"  "top"  "town" "tree" "true" "try" 
## [349] "turn" "two"  "type" "unit" "up"   "upon" "use"  "very" "view" "vote" "wage" "wait"
## [361] "walk" "wall" "want" "war"  "warm" "wash" "way"  "we"   "wear" "wee"  "week" "well"
## [373] "west" "what" "when" "who"  "why"  "wide" "wife" "will" "win"  "wind" "wish" "with"
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
## [1] "year"      "yes"       "yesterday" "yet"       "you"       "young"
```

``` r
# Matches words beginning with "y" followed by exactly one character
str_subset(words, "^y.")
```

```
## [1] "year"      "yes"       "yesterday" "yet"       "you"       "young"
```

``` r
# Matches words beginning with "y" followed by zero or more characters
str_subset(words, "^y.*")
```

```
## [1] "year"      "yes"       "yesterday" "yet"       "you"       "young"
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
##   [1] "act" "add" "age" "ago" "air" "all" "and" "any" "arm" "art" "ask" "bad" "bag" "bar"
##  [15] "bed" "bet" "big" "bit" "box" "boy" "bus" "but" "buy" "can" "car" "cat" "cup" "cut"
##  [29] "dad" "day" "die" "dog" "dry" "due" "eat" "egg" "end" "eye" "far" "few" "fit" "fly"
##  [43] "for" "fun" "gas" "get" "god" "guy" "hit" "hot" "how" "job" "key" "kid" "lad" "law"
##  [57] "lay" "leg" "let" "lie" "lot" "low" "man" "may" "mrs" "new" "non" "not" "now" "odd"
##  [71] "off" "old" "one" "out" "own" "pay" "per" "put" "red" "rid" "run" "say" "see" "set"
##  [85] "sex" "she" "sir" "sit" "six" "son" "sun" "tax" "tea" "ten" "the" "tie" "too" "top"
##  [99] "try" "two" "use" "war" "way" "wee" "who" "why" "win" "yes" "yet" "you"
```

``` r
str_subset(words, "^...$")
```

```
##   [1] "act" "add" "age" "ago" "air" "all" "and" "any" "arm" "art" "ask" "bad" "bag" "bar"
##  [15] "bed" "bet" "big" "bit" "box" "boy" "bus" "but" "buy" "can" "car" "cat" "cup" "cut"
##  [29] "dad" "day" "die" "dog" "dry" "due" "eat" "egg" "end" "eye" "far" "few" "fit" "fly"
##  [43] "for" "fun" "gas" "get" "god" "guy" "hit" "hot" "how" "job" "key" "kid" "lad" "law"
##  [57] "lay" "leg" "let" "lie" "lot" "low" "man" "may" "mrs" "new" "non" "not" "now" "odd"
##  [71] "off" "old" "one" "out" "own" "pay" "per" "put" "red" "rid" "run" "say" "see" "set"
##  [85] "sex" "she" "sir" "sit" "six" "son" "sun" "tax" "tea" "ten" "the" "tie" "too" "top"
##  [99] "try" "two" "use" "war" "way" "wee" "who" "why" "win" "yes" "yet" "you"
```

## Practice: Searching Words with Seven or More Characters


``` r
str_subset(words, "^.{7}.*$")
```

```
##   [1] "absolute"    "account"     "achieve"     "address"     "advertise"   "afternoon"  
##   [7] "against"     "already"     "alright"     "although"    "america"     "another"    
##  [13] "apparent"    "appoint"     "approach"    "appropriate" "arrange"     "associate"  
##  [19] "authority"   "available"   "balance"     "because"     "believe"     "benefit"    
##  [25] "between"     "brilliant"   "britain"     "brother"     "business"    "certain"    
##  [31] "chairman"    "character"   "Christmas"   "colleague"   "collect"     "college"    
##  [37] "comment"     "committee"   "community"   "company"     "compare"     "complete"   
##  [43] "compute"     "concern"     "condition"   "consider"    "consult"     "contact"    
##  [49] "continue"    "contract"    "control"     "converse"    "correct"     "council"    
##  [55] "country"     "current"     "decision"    "definite"    "department"  "describe"   
##  [61] "develop"     "difference"  "difficult"   "discuss"     "district"    "document"   
##  [67] "economy"     "educate"     "electric"    "encourage"   "english"     "environment"
##  [73] "especial"    "evening"     "evidence"    "example"     "exercise"    "expense"    
##  [79] "experience"  "explain"     "express"     "finance"     "fortune"     "forward"    
##  [85] "function"    "further"     "general"     "germany"     "goodbye"     "history"    
##  [91] "holiday"     "hospital"    "however"     "hundred"     "husband"     "identify"   
##  [97] "imagine"     "important"   "improve"     "include"     "increase"    "individual" 
## [103] "industry"    "instead"     "interest"    "introduce"   "involve"     "kitchen"    
## [109] "language"    "machine"     "meaning"     "measure"     "mention"     "million"    
## [115] "minister"    "morning"     "necessary"   "obvious"     "occasion"    "operate"    
## [121] "opportunity" "organize"    "original"    "otherwise"   "paragraph"   "particular" 
## [127] "pension"     "percent"     "perfect"     "perhaps"     "photograph"  "picture"    
## [133] "politic"     "position"    "positive"    "possible"    "practise"    "prepare"    
## [139] "present"     "pressure"    "presume"     "previous"    "private"     "probable"   
## [145] "problem"     "proceed"     "process"     "produce"     "product"     "programme"  
## [151] "project"     "propose"     "protect"     "provide"     "purpose"     "quality"    
## [157] "quarter"     "question"    "realise"     "receive"     "recognize"   "recommend"  
## [163] "relation"    "remember"    "represent"   "require"     "research"    "resource"   
## [169] "respect"     "responsible" "saturday"    "science"     "scotland"    "secretary"  
## [175] "section"     "separate"    "serious"     "service"     "similar"     "situate"    
## [181] "society"     "special"     "specific"    "standard"    "station"     "straight"   
## [187] "strategy"    "structure"   "student"     "subject"     "succeed"     "suggest"    
## [193] "support"     "suppose"     "surprise"    "telephone"   "television"  "terrible"   
## [199] "therefore"   "thirteen"    "thousand"    "through"     "thursday"    "together"   
## [205] "tomorrow"    "tonight"     "traffic"     "transport"   "trouble"     "tuesday"    
## [211] "understand"  "university"  "various"     "village"     "wednesday"   "welcome"    
## [217] "whether"     "without"     "yesterday"
```

``` r
str_subset(words, "^.{7,}$")
```

```
##   [1] "absolute"    "account"     "achieve"     "address"     "advertise"   "afternoon"  
##   [7] "against"     "already"     "alright"     "although"    "america"     "another"    
##  [13] "apparent"    "appoint"     "approach"    "appropriate" "arrange"     "associate"  
##  [19] "authority"   "available"   "balance"     "because"     "believe"     "benefit"    
##  [25] "between"     "brilliant"   "britain"     "brother"     "business"    "certain"    
##  [31] "chairman"    "character"   "Christmas"   "colleague"   "collect"     "college"    
##  [37] "comment"     "committee"   "community"   "company"     "compare"     "complete"   
##  [43] "compute"     "concern"     "condition"   "consider"    "consult"     "contact"    
##  [49] "continue"    "contract"    "control"     "converse"    "correct"     "council"    
##  [55] "country"     "current"     "decision"    "definite"    "department"  "describe"   
##  [61] "develop"     "difference"  "difficult"   "discuss"     "district"    "document"   
##  [67] "economy"     "educate"     "electric"    "encourage"   "english"     "environment"
##  [73] "especial"    "evening"     "evidence"    "example"     "exercise"    "expense"    
##  [79] "experience"  "explain"     "express"     "finance"     "fortune"     "forward"    
##  [85] "function"    "further"     "general"     "germany"     "goodbye"     "history"    
##  [91] "holiday"     "hospital"    "however"     "hundred"     "husband"     "identify"   
##  [97] "imagine"     "important"   "improve"     "include"     "increase"    "individual" 
## [103] "industry"    "instead"     "interest"    "introduce"   "involve"     "kitchen"    
## [109] "language"    "machine"     "meaning"     "measure"     "mention"     "million"    
## [115] "minister"    "morning"     "necessary"   "obvious"     "occasion"    "operate"    
## [121] "opportunity" "organize"    "original"    "otherwise"   "paragraph"   "particular" 
## [127] "pension"     "percent"     "perfect"     "perhaps"     "photograph"  "picture"    
## [133] "politic"     "position"    "positive"    "possible"    "practise"    "prepare"    
## [139] "present"     "pressure"    "presume"     "previous"    "private"     "probable"   
## [145] "problem"     "proceed"     "process"     "produce"     "product"     "programme"  
## [151] "project"     "propose"     "protect"     "provide"     "purpose"     "quality"    
## [157] "quarter"     "question"    "realise"     "receive"     "recognize"   "recommend"  
## [163] "relation"    "remember"    "represent"   "require"     "research"    "resource"   
## [169] "respect"     "responsible" "saturday"    "science"     "scotland"    "secretary"  
## [175] "section"     "separate"    "serious"     "service"     "similar"     "situate"    
## [181] "society"     "special"     "specific"    "standard"    "station"     "straight"   
## [187] "strategy"    "structure"   "student"     "subject"     "succeed"     "suggest"    
## [193] "support"     "suppose"     "surprise"    "telephone"   "television"  "terrible"   
## [199] "therefore"   "thirteen"    "thousand"    "through"     "thursday"    "together"   
## [205] "tomorrow"    "tonight"     "traffic"     "transport"   "trouble"     "tuesday"    
## [211] "understand"  "university"  "various"     "village"     "wednesday"   "welcome"    
## [217] "whether"     "without"     "yesterday"
```

``` r
str_subset(words, "^.......")
```

```
##   [1] "absolute"    "account"     "achieve"     "address"     "advertise"   "afternoon"  
##   [7] "against"     "already"     "alright"     "although"    "america"     "another"    
##  [13] "apparent"    "appoint"     "approach"    "appropriate" "arrange"     "associate"  
##  [19] "authority"   "available"   "balance"     "because"     "believe"     "benefit"    
##  [25] "between"     "brilliant"   "britain"     "brother"     "business"    "certain"    
##  [31] "chairman"    "character"   "Christmas"   "colleague"   "collect"     "college"    
##  [37] "comment"     "committee"   "community"   "company"     "compare"     "complete"   
##  [43] "compute"     "concern"     "condition"   "consider"    "consult"     "contact"    
##  [49] "continue"    "contract"    "control"     "converse"    "correct"     "council"    
##  [55] "country"     "current"     "decision"    "definite"    "department"  "describe"   
##  [61] "develop"     "difference"  "difficult"   "discuss"     "district"    "document"   
##  [67] "economy"     "educate"     "electric"    "encourage"   "english"     "environment"
##  [73] "especial"    "evening"     "evidence"    "example"     "exercise"    "expense"    
##  [79] "experience"  "explain"     "express"     "finance"     "fortune"     "forward"    
##  [85] "function"    "further"     "general"     "germany"     "goodbye"     "history"    
##  [91] "holiday"     "hospital"    "however"     "hundred"     "husband"     "identify"   
##  [97] "imagine"     "important"   "improve"     "include"     "increase"    "individual" 
## [103] "industry"    "instead"     "interest"    "introduce"   "involve"     "kitchen"    
## [109] "language"    "machine"     "meaning"     "measure"     "mention"     "million"    
## [115] "minister"    "morning"     "necessary"   "obvious"     "occasion"    "operate"    
## [121] "opportunity" "organize"    "original"    "otherwise"   "paragraph"   "particular" 
## [127] "pension"     "percent"     "perfect"     "perhaps"     "photograph"  "picture"    
## [133] "politic"     "position"    "positive"    "possible"    "practise"    "prepare"    
## [139] "present"     "pressure"    "presume"     "previous"    "private"     "probable"   
## [145] "problem"     "proceed"     "process"     "produce"     "product"     "programme"  
## [151] "project"     "propose"     "protect"     "provide"     "purpose"     "quality"    
## [157] "quarter"     "question"    "realise"     "receive"     "recognize"   "recommend"  
## [163] "relation"    "remember"    "represent"   "require"     "research"    "resource"   
## [169] "respect"     "responsible" "saturday"    "science"     "scotland"    "secretary"  
## [175] "section"     "separate"    "serious"     "service"     "similar"     "situate"    
## [181] "society"     "special"     "specific"    "standard"    "station"     "straight"   
## [187] "strategy"    "structure"   "student"     "subject"     "succeed"     "suggest"    
## [193] "support"     "suppose"     "surprise"    "telephone"   "television"  "terrible"   
## [199] "therefore"   "thirteen"    "thousand"    "through"     "thursday"    "together"   
## [205] "tomorrow"    "tonight"     "traffic"     "transport"   "trouble"     "tuesday"    
## [211] "understand"  "university"  "various"     "village"     "wednesday"   "welcome"    
## [217] "whether"     "without"     "yesterday"
```

``` r
# Invalid: nothing follows "^" before the quantifier
# str_subset(words, "^{,7}.$")
# 
# Invalid: "{,m}" requires a preceding element to quantify
# str_subset(words, "^.{,7}.$")
# 
# Invalid: "{,m}" is not supported in R's default regex engine
# str_subset(words, "^.{,7}$")
# 
# Invalid: same issue as above
# str_subset(words, "^.{,7}")

# Valid syntax, but does not produce the intended result
# a minimum bound should be specified for clarity
str_subset(words, "^.{1,7}.$")
```

```
##   [1] "able"     "about"    "absolute" "accept"   "account"  "achieve"  "across"   "act"     
##   [9] "active"   "actual"   "add"      "address"  "admit"    "affect"   "afford"   "after"   
##  [17] "again"    "against"  "age"      "agent"    "ago"      "agree"    "air"      "all"     
##  [25] "allow"    "almost"   "along"    "already"  "alright"  "also"     "although" "always"  
##  [33] "america"  "amount"   "and"      "another"  "answer"   "any"      "apart"    "apparent"
##  [41] "appear"   "apply"    "appoint"  "approach" "area"     "argue"    "arm"      "around"  
##  [49] "arrange"  "art"      "as"       "ask"      "assume"   "at"       "attend"   "aware"   
##  [57] "away"     "awful"    "baby"     "back"     "bad"      "bag"      "balance"  "ball"    
##  [65] "bank"     "bar"      "base"     "basis"    "be"       "bear"     "beat"     "beauty"  
##  [73] "because"  "become"   "bed"      "before"   "begin"    "behind"   "believe"  "benefit" 
##  [81] "best"     "bet"      "between"  "big"      "bill"     "birth"    "bit"      "black"   
##  [89] "bloke"    "blood"    "blow"     "blue"     "board"    "boat"     "body"     "book"    
##  [97] "both"     "bother"   "bottle"   "bottom"   "box"      "boy"      "break"    "brief"   
## [105] "bring"    "britain"  "brother"  "budget"   "build"    "bus"      "business" "busy"    
## [113] "but"      "buy"      "by"       "cake"     "call"     "can"      "car"      "card"    
## [121] "care"     "carry"    "case"     "cat"      "catch"    "cause"    "cent"     "centre"  
## [129] "certain"  "chair"    "chairman" "chance"   "change"   "chap"     "charge"   "cheap"   
## [137] "check"    "child"    "choice"   "choose"   "Christ"   "church"   "city"     "claim"   
## [145] "class"    "clean"    "clear"    "client"   "clock"    "close"    "closes"   "clothe"  
## [153] "club"     "coffee"   "cold"     "collect"  "college"  "colour"   "come"     "comment" 
## [161] "commit"   "common"   "company"  "compare"  "complete" "compute"  "concern"  "confer"  
## [169] "consider" "consult"  "contact"  "continue" "contract" "control"  "converse" "cook"    
## [177] "copy"     "corner"   "correct"  "cost"     "could"    "council"  "count"    "country" 
## [185] "county"   "couple"   "course"   "court"    "cover"    "create"   "cross"    "cup"     
## [193] "current"  "cut"      "dad"      "danger"   "date"     "day"      "dead"     "deal"    
## [201] "dear"     "debate"   "decide"   "decision" "deep"     "definite" "degree"   "depend"  
## [209] "describe" "design"   "detail"   "develop"  "die"      "dinner"   "direct"   "discuss" 
## [217] "district" "divide"   "do"       "doctor"   "document" "dog"      "door"     "double"  
## [225] "doubt"    "down"     "draw"     "dress"    "drink"    "drive"    "drop"     "dry"     
## [233] "due"      "during"   "each"     "early"    "east"     "easy"     "eat"      "economy" 
## [241] "educate"  "effect"   "egg"      "eight"    "either"   "elect"    "electric" "eleven"  
## [249] "else"     "employ"   "end"      "engine"   "english"  "enjoy"    "enough"   "enter"   
## [257] "equal"    "especial" "europe"   "even"     "evening"  "ever"     "every"    "evidence"
## [265] "exact"    "example"  "except"   "excuse"   "exercise" "exist"    "expect"   "expense" 
## [273] "explain"  "express"  "extra"    "eye"      "face"     "fact"     "fair"     "fall"    
## [281] "family"   "far"      "farm"     "fast"     "father"   "favour"   "feed"     "feel"    
## [289] "few"      "field"    "fight"    "figure"   "file"     "fill"     "film"     "final"   
## [297] "finance"  "find"     "fine"     "finish"   "fire"     "first"    "fish"     "fit"     
## [305] "five"     "flat"     "floor"    "fly"      "follow"   "food"     "foot"     "for"     
## [313] "force"    "forget"   "form"     "fortune"  "forward"  "four"     "france"   "free"    
## [321] "friday"   "friend"   "from"     "front"    "full"     "fun"      "function" "fund"    
## [329] "further"  "future"   "game"     "garden"   "gas"      "general"  "germany"  "get"     
## [337] "girl"     "give"     "glass"    "go"       "god"      "good"     "goodbye"  "govern"  
## [345] "grand"    "grant"    "great"    "green"    "ground"   "group"    "grow"     "guess"   
## [353] "guy"      "hair"     "half"     "hall"     "hand"     "hang"     "happen"   "happy"   
## [361] "hard"     "hate"     "have"     "he"       "head"     "health"   "hear"     "heart"   
## [369] "heat"     "heavy"    "hell"     "help"     "here"     "high"     "history"  "hit"     
## [377] "hold"     "holiday"  "home"     "honest"   "hope"     "horse"    "hospital" "hot"     
## [385] "hour"     "house"    "how"      "however"  "hullo"    "hundred"  "husband"  "idea"    
## [393] "identify" "if"       "imagine"  "improve"  "in"       "include"  "income"   "increase"
## [401] "indeed"   "industry" "inform"   "inside"   "instead"  "insure"   "interest" "into"    
## [409] "invest"   "involve"  "issue"    "it"       "item"     "jesus"    "job"      "join"    
## [417] "judge"    "jump"     "just"     "keep"     "key"      "kid"      "kill"     "kind"    
## [425] "king"     "kitchen"  "knock"    "know"     "labour"   "lad"      "lady"     "land"    
## [433] "language" "large"    "last"     "late"     "laugh"    "law"      "lay"      "lead"    
## [441] "learn"    "leave"    "left"     "leg"      "less"     "let"      "letter"   "level"   
## [449] "lie"      "life"     "light"    "like"     "likely"   "limit"    "line"     "link"    
## [457] "list"     "listen"   "little"   "live"     "load"     "local"    "lock"     "london"  
## [465] "long"     "look"     "lord"     "lose"     "lot"      "love"     "low"      "luck"    
## [473] "lunch"    "machine"  "main"     "major"    "make"     "man"      "manage"   "many"    
## [481] "mark"     "market"   "marry"    "match"    "matter"   "may"      "maybe"    "mean"    
## [489] "meaning"  "measure"  "meet"     "member"   "mention"  "middle"   "might"    "mile"    
## [497] "milk"     "million"  "mind"     "minister" "minus"    "minute"   "miss"     "mister"  
## [505] "moment"   "monday"   "money"    "month"    "more"     "morning"  "most"     "mother"  
## [513] "motion"   "move"     "mrs"      "much"     "music"    "must"     "name"     "nation"  
## [521] "nature"   "near"     "need"     "never"    "new"      "news"     "next"     "nice"    
## [529] "night"    "nine"     "no"       "non"      "none"     "normal"   "north"    "not"     
## [537] "note"     "notice"   "now"      "number"   "obvious"  "occasion" "odd"      "of"      
## [545] "off"      "offer"    "office"   "often"    "okay"     "old"      "on"       "once"    
## [553] "one"      "only"     "open"     "operate"  "oppose"   "or"       "order"    "organize"
## [561] "original" "other"    "ought"    "out"      "over"     "own"      "pack"     "page"    
## [569] "paint"    "pair"     "paper"    "pardon"   "parent"   "park"     "part"     "party"   
## [577] "pass"     "past"     "pay"      "pence"    "pension"  "people"   "per"      "percent" 
## [585] "perfect"  "perhaps"  "period"   "person"   "pick"     "picture"  "piece"    "place"   
## [593] "plan"     "play"     "please"   "plus"     "point"    "police"   "policy"   "politic" 
## [601] "poor"     "position" "positive" "possible" "post"     "pound"    "power"    "practise"
## [609] "prepare"  "present"  "press"    "pressure" "presume"  "pretty"   "previous" "price"   
## [617] "print"    "private"  "probable" "problem"  "proceed"  "process"  "produce"  "product" 
## [625] "project"  "proper"   "propose"  "protect"  "provide"  "public"   "pull"     "purpose" 
## [633] "push"     "put"      "quality"  "quarter"  "question" "quick"    "quid"     "quiet"   
## [641] "quite"    "radio"    "rail"     "raise"    "range"    "rate"     "rather"   "read"    
## [649] "ready"    "real"     "realise"  "really"   "reason"   "receive"  "recent"   "reckon"  
## [657] "record"   "red"      "reduce"   "refer"    "regard"   "region"   "relation" "remember"
## [665] "report"   "require"  "research" "resource" "respect"  "rest"     "result"   "return"  
## [673] "rid"      "right"    "ring"     "rise"     "road"     "role"     "roll"     "room"    
## [681] "round"    "rule"     "run"      "safe"     "sale"     "same"     "saturday" "save"    
## [689] "say"      "scheme"   "school"   "science"  "score"    "scotland" "seat"     "second"  
## [697] "section"  "secure"   "see"      "seem"     "self"     "sell"     "send"     "sense"   
## [705] "separate" "serious"  "serve"    "service"  "set"      "settle"   "seven"    "sex"     
## [713] "shall"    "share"    "she"      "sheet"    "shoe"     "shoot"    "shop"     "short"   
## [721] "should"   "show"     "shut"     "sick"     "side"     "sign"     "similar"  "simple"  
## [729] "since"    "sing"     "single"   "sir"      "sister"   "sit"      "site"     "situate" 
## [737] "six"      "size"     "sleep"    "slight"   "slow"     "small"    "smoke"    "so"      
## [745] "social"   "society"  "some"     "son"      "soon"     "sorry"    "sort"     "sound"   
## [753] "south"    "space"    "speak"    "special"  "specific" "speed"    "spell"    "spend"   
## [761] "square"   "staff"    "stage"    "stairs"   "stand"    "standard" "start"    "state"   
## [769] "station"  "stay"     "step"     "stick"    "still"    "stop"     "story"    "straight"
## [777] "strategy" "street"   "strike"   "strong"   "student"  "study"    "stuff"    "stupid"  
## [785] "subject"  "succeed"  "such"     "sudden"   "suggest"  "suit"     "summer"   "sun"     
## [793] "sunday"   "supply"   "support"  "suppose"  "sure"     "surprise" "switch"   "system"  
## [801] "table"    "take"     "talk"     "tape"     "tax"      "tea"      "teach"    "team"    
## [809] "tell"     "ten"      "tend"     "term"     "terrible" "test"     "than"     "thank"   
## [817] "the"      "then"     "there"    "they"     "thing"    "think"    "thirteen" "thirty"  
## [825] "this"     "thou"     "though"   "thousand" "three"    "through"  "throw"    "thursday"
## [833] "tie"      "time"     "to"       "today"    "together" "tomorrow" "tonight"  "too"     
## [841] "top"      "total"    "touch"    "toward"   "town"     "trade"    "traffic"  "train"   
## [849] "travel"   "treat"    "tree"     "trouble"  "true"     "trust"    "try"      "tuesday" 
## [857] "turn"     "twelve"   "twenty"   "two"      "type"     "under"    "union"    "unit"    
## [865] "unite"    "unless"   "until"    "up"       "upon"     "use"      "usual"    "value"   
## [873] "various"  "very"     "video"    "view"     "village"  "visit"    "vote"     "wage"    
## [881] "wait"     "walk"     "wall"     "want"     "war"      "warm"     "wash"     "waste"   
## [889] "watch"    "water"    "way"      "we"       "wear"     "wee"      "week"     "weigh"   
## [897] "welcome"  "well"     "west"     "what"     "when"     "where"    "whether"  "which"   
## [905] "while"    "white"    "who"      "whole"    "why"      "wide"     "wife"     "will"    
## [913] "win"      "wind"     "window"   "wish"     "with"     "within"   "without"  "woman"   
## [921] "wonder"   "wood"     "word"     "work"     "world"    "worry"    "worse"    "worth"   
## [929] "would"    "write"    "wrong"    "year"     "yes"      "yet"      "you"      "young"
```

