# String Manipulation for Tidying Text Data


``` r
---
  title: "Text Mining: Word Frequency Analysis"
output:
  html_document:
  highlight: tango
self_contained: true
---
```

```
## Error in parse(text = input): <text>:8:0: 예상하지 못한 입력의 끝(end of input)입니다.
## 6: self_contained: true
## 7: ---
##   ^
```

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
##  [1] "Letter: a" "Letter: b" "Letter: c" "Letter: d" "Letter: e" "Letter: f" "Letter: g" "Letter: h" "Letter: i" "Letter: j" "Letter: k" "Letter: l"
## [13] "Letter: m" "Letter: n" "Letter: o" "Letter: p" "Letter: q" "Letter: r" "Letter: s" "Letter: t" "Letter: u" "Letter: v" "Letter: w" "Letter: x"
## [25] "Letter: y" "Letter: z"
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
##   [1] "act" "add" "age" "ago" "air" "all" "and" "any" "arm" "art" "ask" "bad" "bag" "bar" "bed" "bet" "big" "bit" "box" "boy" "bus" "but" "buy"
##  [24] "can" "car" "cat" "cup" "cut" "dad" "day" "die" "dog" "dry" "due" "eat" "egg" "end" "eye" "far" "few" "fit" "fly" "for" "fun" "gas" "get"
##  [47] "god" "guy" "hit" "hot" "how" "job" "key" "kid" "lad" "law" "lay" "leg" "let" "lie" "lot" "low" "man" "may" "mrs" "new" "non" "not" "now"
##  [70] "odd" "off" "old" "one" "out" "own" "pay" "per" "put" "red" "rid" "run" "say" "see" "set" "sex" "she" "sir" "sit" "six" "son" "sun" "tax"
##  [93] "tea" "ten" "the" "tie" "too" "top" "try" "two" "use" "war" "way" "wee" "who" "why" "win" "yes" "yet" "you"
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
##   [1] "absolute"    "account"     "achieve"     "address"     "advertise"   "afternoon"   "against"     "already"     "alright"     "although"   
##  [11] "america"     "another"     "apparent"    "appoint"     "approach"    "appropriate" "arrange"     "associate"   "authority"   "available"  
##  [21] "balance"     "because"     "believe"     "benefit"     "between"     "brilliant"   "britain"     "brother"     "business"    "certain"    
##  [31] "chairman"    "character"   "Christmas"   "colleague"   "collect"     "college"     "comment"     "committee"   "community"   "company"    
##  [41] "compare"     "complete"    "compute"     "concern"     "condition"   "consider"    "consult"     "contact"     "continue"    "contract"   
##  [51] "control"     "converse"    "correct"     "council"     "country"     "current"     "decision"    "definite"    "department"  "describe"   
##  [61] "develop"     "difference"  "difficult"   "discuss"     "district"    "document"    "economy"     "educate"     "electric"    "encourage"  
##  [71] "english"     "environment" "especial"    "evening"     "evidence"    "example"     "exercise"    "expense"     "experience"  "explain"    
##  [81] "express"     "finance"     "fortune"     "forward"     "function"    "further"     "general"     "germany"     "goodbye"     "history"    
##  [91] "holiday"     "hospital"    "however"     "hundred"     "husband"     "identify"    "imagine"     "important"   "improve"     "include"    
## [101] "increase"    "individual"  "industry"    "instead"     "interest"    "introduce"   "involve"     "kitchen"     "language"    "machine"    
## [111] "meaning"     "measure"     "mention"     "million"     "minister"    "morning"     "necessary"   "obvious"     "occasion"    "operate"    
## [121] "opportunity" "organize"    "original"    "otherwise"   "paragraph"   "particular"  "pension"     "percent"     "perfect"     "perhaps"    
## [131] "photograph"  "picture"     "politic"     "position"    "positive"    "possible"    "practise"    "prepare"     "present"     "pressure"   
## [141] "presume"     "previous"    "private"     "probable"    "problem"     "proceed"     "process"     "produce"     "product"     "programme"  
## [151] "project"     "propose"     "protect"     "provide"     "purpose"     "quality"     "quarter"     "question"    "realise"     "receive"    
## [161] "recognize"   "recommend"   "relation"    "remember"    "represent"   "require"     "research"    "resource"    "respect"     "responsible"
## [171] "saturday"    "science"     "scotland"    "secretary"   "section"     "separate"    "serious"     "service"     "similar"     "situate"    
## [181] "society"     "special"     "specific"    "standard"    "station"     "straight"    "strategy"    "structure"   "student"     "subject"    
## [191] "succeed"     "suggest"     "support"     "suppose"     "surprise"    "telephone"   "television"  "terrible"    "therefore"   "thirteen"   
## [201] "thousand"    "through"     "thursday"    "together"    "tomorrow"    "tonight"     "traffic"     "transport"   "trouble"     "tuesday"    
## [211] "understand"  "university"  "various"     "village"     "wednesday"   "welcome"     "whether"     "without"     "yesterday"
```

### Exercises


``` r
# Matches words consisting of exactly three characters
str_subset(words, "^.{3}$")
```

```
##   [1] "act" "add" "age" "ago" "air" "all" "and" "any" "arm" "art" "ask" "bad" "bag" "bar" "bed" "bet" "big" "bit" "box" "boy" "bus" "but" "buy"
##  [24] "can" "car" "cat" "cup" "cut" "dad" "day" "die" "dog" "dry" "due" "eat" "egg" "end" "eye" "far" "few" "fit" "fly" "for" "fun" "gas" "get"
##  [47] "god" "guy" "hit" "hot" "how" "job" "key" "kid" "lad" "law" "lay" "leg" "let" "lie" "lot" "low" "man" "may" "mrs" "new" "non" "not" "now"
##  [70] "odd" "off" "old" "one" "out" "own" "pay" "per" "put" "red" "rid" "run" "say" "see" "set" "sex" "she" "sir" "sit" "six" "son" "sun" "tax"
##  [93] "tea" "ten" "the" "tie" "too" "top" "try" "two" "use" "war" "way" "wee" "who" "why" "win" "yes" "yet" "you"
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
##   [1] "act" "add" "age" "ago" "air" "all" "and" "any" "arm" "art" "ask" "bad" "bag" "bar" "bed" "bet" "big" "bit" "box" "boy" "bus" "but" "buy"
##  [24] "can" "car" "cat" "cup" "cut" "dad" "day" "die" "dog" "dry" "due" "eat" "egg" "end" "eye" "far" "few" "fit" "fly" "for" "fun" "gas" "get"
##  [47] "god" "guy" "hit" "hot" "how" "job" "key" "kid" "lad" "law" "lay" "leg" "let" "lie" "lot" "low" "man" "may" "mrs" "new" "non" "not" "now"
##  [70] "odd" "off" "old" "one" "out" "own" "pay" "per" "put" "red" "rid" "run" "say" "see" "set" "sex" "she" "sir" "sit" "six" "son" "sun" "tax"
##  [93] "tea" "ten" "the" "tie" "too" "top" "try" "two" "use" "war" "way" "wee" "who" "why" "win" "yes" "yet" "you"
```

``` r
# Matches words beginning with at least three characters (no upper limit)
str_subset(words, "^.{3}")
```

```
##   [1] "able"        "about"       "absolute"    "accept"      "account"     "achieve"     "across"      "act"         "active"      "actual"     
##  [11] "add"         "address"     "admit"       "advertise"   "affect"      "afford"      "after"       "afternoon"   "again"       "against"    
##  [21] "age"         "agent"       "ago"         "agree"       "air"         "all"         "allow"       "almost"      "along"       "already"    
##  [31] "alright"     "also"        "although"    "always"      "america"     "amount"      "and"         "another"     "answer"      "any"        
##  [41] "apart"       "apparent"    "appear"      "apply"       "appoint"     "approach"    "appropriate" "area"        "argue"       "arm"        
##  [51] "around"      "arrange"     "art"         "ask"         "associate"   "assume"      "attend"      "authority"   "available"   "aware"      
##  [61] "away"        "awful"       "baby"        "back"        "bad"         "bag"         "balance"     "ball"        "bank"        "bar"        
##  [71] "base"        "basis"       "bear"        "beat"        "beauty"      "because"     "become"      "bed"         "before"      "begin"      
##  [81] "behind"      "believe"     "benefit"     "best"        "bet"         "between"     "big"         "bill"        "birth"       "bit"        
##  [91] "black"       "bloke"       "blood"       "blow"        "blue"        "board"       "boat"        "body"        "book"        "both"       
## [101] "bother"      "bottle"      "bottom"      "box"         "boy"         "break"       "brief"       "brilliant"   "bring"       "britain"    
## [111] "brother"     "budget"      "build"       "bus"         "business"    "busy"        "but"         "buy"         "cake"        "call"       
## [121] "can"         "car"         "card"        "care"        "carry"       "case"        "cat"         "catch"       "cause"       "cent"       
## [131] "centre"      "certain"     "chair"       "chairman"    "chance"      "change"      "chap"        "character"   "charge"      "cheap"      
## [141] "check"       "child"       "choice"      "choose"      "Christ"      "Christmas"   "church"      "city"        "claim"       "class"      
## [151] "clean"       "clear"       "client"      "clock"       "close"       "closes"      "clothe"      "club"        "coffee"      "cold"       
## [161] "colleague"   "collect"     "college"     "colour"      "come"        "comment"     "commit"      "committee"   "common"      "community"  
## [171] "company"     "compare"     "complete"    "compute"     "concern"     "condition"   "confer"      "consider"    "consult"     "contact"    
## [181] "continue"    "contract"    "control"     "converse"    "cook"        "copy"        "corner"      "correct"     "cost"        "could"      
## [191] "council"     "count"       "country"     "county"      "couple"      "course"      "court"       "cover"       "create"      "cross"      
## [201] "cup"         "current"     "cut"         "dad"         "danger"      "date"        "day"         "dead"        "deal"        "dear"       
## [211] "debate"      "decide"      "decision"    "deep"        "definite"    "degree"      "department"  "depend"      "describe"    "design"     
## [221] "detail"      "develop"     "die"         "difference"  "difficult"   "dinner"      "direct"      "discuss"     "district"    "divide"     
## [231] "doctor"      "document"    "dog"         "door"        "double"      "doubt"       "down"        "draw"        "dress"       "drink"      
## [241] "drive"       "drop"        "dry"         "due"         "during"      "each"        "early"       "east"        "easy"        "eat"        
## [251] "economy"     "educate"     "effect"      "egg"         "eight"       "either"      "elect"       "electric"    "eleven"      "else"       
## [261] "employ"      "encourage"   "end"         "engine"      "english"     "enjoy"       "enough"      "enter"       "environment" "equal"      
## [271] "especial"    "europe"      "even"        "evening"     "ever"        "every"       "evidence"    "exact"       "example"     "except"     
## [281] "excuse"      "exercise"    "exist"       "expect"      "expense"     "experience"  "explain"     "express"     "extra"       "eye"        
## [291] "face"        "fact"        "fair"        "fall"        "family"      "far"         "farm"        "fast"        "father"      "favour"     
## [301] "feed"        "feel"        "few"         "field"       "fight"       "figure"      "file"        "fill"        "film"        "final"      
## [311] "finance"     "find"        "fine"        "finish"      "fire"        "first"       "fish"        "fit"         "five"        "flat"       
## [321] "floor"       "fly"         "follow"      "food"        "foot"        "for"         "force"       "forget"      "form"        "fortune"    
## [331] "forward"     "four"        "france"      "free"        "friday"      "friend"      "from"        "front"       "full"        "fun"        
## [341] "function"    "fund"        "further"     "future"      "game"        "garden"      "gas"         "general"     "germany"     "get"        
## [351] "girl"        "give"        "glass"       "god"         "good"        "goodbye"     "govern"      "grand"       "grant"       "great"      
## [361] "green"       "ground"      "group"       "grow"        "guess"       "guy"         "hair"        "half"        "hall"        "hand"       
## [371] "hang"        "happen"      "happy"       "hard"        "hate"        "have"        "head"        "health"      "hear"        "heart"      
## [381] "heat"        "heavy"       "hell"        "help"        "here"        "high"        "history"     "hit"         "hold"        "holiday"    
## [391] "home"        "honest"      "hope"        "horse"       "hospital"    "hot"         "hour"        "house"       "how"         "however"    
## [401] "hullo"       "hundred"     "husband"     "idea"        "identify"    "imagine"     "important"   "improve"     "include"     "income"     
## [411] "increase"    "indeed"      "individual"  "industry"    "inform"      "inside"      "instead"     "insure"      "interest"    "into"       
## [421] "introduce"   "invest"      "involve"     "issue"       "item"        "jesus"       "job"         "join"        "judge"       "jump"       
## [431] "just"        "keep"        "key"         "kid"         "kill"        "kind"        "king"        "kitchen"     "knock"       "know"       
## [441] "labour"      "lad"         "lady"        "land"        "language"    "large"       "last"        "late"        "laugh"       "law"        
## [451] "lay"         "lead"        "learn"       "leave"       "left"        "leg"         "less"        "let"         "letter"      "level"      
## [461] "lie"         "life"        "light"       "like"        "likely"      "limit"       "line"        "link"        "list"        "listen"     
## [471] "little"      "live"        "load"        "local"       "lock"        "london"      "long"        "look"        "lord"        "lose"       
## [481] "lot"         "love"        "low"         "luck"        "lunch"       "machine"     "main"        "major"       "make"        "man"        
## [491] "manage"      "many"        "mark"        "market"      "marry"       "match"       "matter"      "may"         "maybe"       "mean"       
## [501] "meaning"     "measure"     "meet"        "member"      "mention"     "middle"      "might"       "mile"        "milk"        "million"    
## [511] "mind"        "minister"    "minus"       "minute"      "miss"        "mister"      "moment"      "monday"      "money"       "month"      
## [521] "more"        "morning"     "most"        "mother"      "motion"      "move"        "mrs"         "much"        "music"       "must"       
## [531] "name"        "nation"      "nature"      "near"        "necessary"   "need"        "never"       "new"         "news"        "next"       
## [541] "nice"        "night"       "nine"        "non"         "none"        "normal"      "north"       "not"         "note"        "notice"     
## [551] "now"         "number"      "obvious"     "occasion"    "odd"         "off"         "offer"       "office"      "often"       "okay"       
## [561] "old"         "once"        "one"         "only"        "open"        "operate"     "opportunity" "oppose"      "order"       "organize"   
## [571] "original"    "other"       "otherwise"   "ought"       "out"         "over"        "own"         "pack"        "page"        "paint"      
## [581] "pair"        "paper"       "paragraph"   "pardon"      "parent"      "park"        "part"        "particular"  "party"       "pass"       
## [591] "past"        "pay"         "pence"       "pension"     "people"      "per"         "percent"     "perfect"     "perhaps"     "period"     
## [601] "person"      "photograph"  "pick"        "picture"     "piece"       "place"       "plan"        "play"        "please"      "plus"       
## [611] "point"       "police"      "policy"      "politic"     "poor"        "position"    "positive"    "possible"    "post"        "pound"      
## [621] "power"       "practise"    "prepare"     "present"     "press"       "pressure"    "presume"     "pretty"      "previous"    "price"      
## [631] "print"       "private"     "probable"    "problem"     "proceed"     "process"     "produce"     "product"     "programme"   "project"    
## [641] "proper"      "propose"     "protect"     "provide"     "public"      "pull"        "purpose"     "push"        "put"         "quality"    
## [651] "quarter"     "question"    "quick"       "quid"        "quiet"       "quite"       "radio"       "rail"        "raise"       "range"      
## [661] "rate"        "rather"      "read"        "ready"       "real"        "realise"     "really"      "reason"      "receive"     "recent"     
## [671] "reckon"      "recognize"   "recommend"   "record"      "red"         "reduce"      "refer"       "regard"      "region"      "relation"   
## [681] "remember"    "report"      "represent"   "require"     "research"    "resource"    "respect"     "responsible" "rest"        "result"     
## [691] "return"      "rid"         "right"       "ring"        "rise"        "road"        "role"        "roll"        "room"        "round"      
## [701] "rule"        "run"         "safe"        "sale"        "same"        "saturday"    "save"        "say"         "scheme"      "school"     
## [711] "science"     "score"       "scotland"    "seat"        "second"      "secretary"   "section"     "secure"      "see"         "seem"       
## [721] "self"        "sell"        "send"        "sense"       "separate"    "serious"     "serve"       "service"     "set"         "settle"     
## [731] "seven"       "sex"         "shall"       "share"       "she"         "sheet"       "shoe"        "shoot"       "shop"        "short"      
## [741] "should"      "show"        "shut"        "sick"        "side"        "sign"        "similar"     "simple"      "since"       "sing"       
## [751] "single"      "sir"         "sister"      "sit"         "site"        "situate"     "six"         "size"        "sleep"       "slight"     
## [761] "slow"        "small"       "smoke"       "social"      "society"     "some"        "son"         "soon"        "sorry"       "sort"       
## [771] "sound"       "south"       "space"       "speak"       "special"     "specific"    "speed"       "spell"       "spend"       "square"     
## [781] "staff"       "stage"       "stairs"      "stand"       "standard"    "start"       "state"       "station"     "stay"        "step"       
## [791] "stick"       "still"       "stop"        "story"       "straight"    "strategy"    "street"      "strike"      "strong"      "structure"  
## [801] "student"     "study"       "stuff"       "stupid"      "subject"     "succeed"     "such"        "sudden"      "suggest"     "suit"       
## [811] "summer"      "sun"         "sunday"      "supply"      "support"     "suppose"     "sure"        "surprise"    "switch"      "system"     
## [821] "table"       "take"        "talk"        "tape"        "tax"         "tea"         "teach"       "team"        "telephone"   "television" 
## [831] "tell"        "ten"         "tend"        "term"        "terrible"    "test"        "than"        "thank"       "the"         "then"       
## [841] "there"       "therefore"   "they"        "thing"       "think"       "thirteen"    "thirty"      "this"        "thou"        "though"     
## [851] "thousand"    "three"       "through"     "throw"       "thursday"    "tie"         "time"        "today"       "together"    "tomorrow"   
## [861] "tonight"     "too"         "top"         "total"       "touch"       "toward"      "town"        "trade"       "traffic"     "train"      
## [871] "transport"   "travel"      "treat"       "tree"        "trouble"     "true"        "trust"       "try"         "tuesday"     "turn"       
## [881] "twelve"      "twenty"      "two"         "type"        "under"       "understand"  "union"       "unit"        "unite"       "university" 
## [891] "unless"      "until"       "upon"        "use"         "usual"       "value"       "various"     "very"        "video"       "view"       
## [901] "village"     "visit"       "vote"        "wage"        "wait"        "walk"        "wall"        "want"        "war"         "warm"       
## [911] "wash"        "waste"       "watch"       "water"       "way"         "wear"        "wednesday"   "wee"         "week"        "weigh"      
## [921] "welcome"     "well"        "west"        "what"        "when"        "where"       "whether"     "which"       "while"       "white"      
## [931] "who"         "whole"       "why"         "wide"        "wife"        "will"        "win"         "wind"        "window"      "wish"       
## [941] "with"        "within"      "without"     "woman"       "wonder"      "wood"        "word"        "work"        "world"       "worry"      
## [951] "worse"       "worth"       "would"       "write"       "wrong"       "year"        "yes"         "yesterday"   "yet"         "you"        
## [961] "young"
```

``` r
# Matches words consisting of two to four characters
str_subset(words, "^.{2,4}$")
```

```
##   [1] "able" "act"  "add"  "age"  "ago"  "air"  "all"  "also" "and"  "any"  "area" "arm"  "art"  "as"   "ask"  "at"   "away" "baby" "back" "bad" 
##  [21] "bag"  "ball" "bank" "bar"  "base" "be"   "bear" "beat" "bed"  "best" "bet"  "big"  "bill" "bit"  "blow" "blue" "boat" "body" "book" "both"
##  [41] "box"  "boy"  "bus"  "busy" "but"  "buy"  "by"   "cake" "call" "can"  "car"  "card" "care" "case" "cat"  "cent" "chap" "city" "club" "cold"
##  [61] "come" "cook" "copy" "cost" "cup"  "cut"  "dad"  "date" "day"  "dead" "deal" "dear" "deep" "die"  "do"   "dog"  "door" "down" "draw" "drop"
##  [81] "dry"  "due"  "each" "east" "easy" "eat"  "egg"  "else" "end"  "even" "ever" "eye"  "face" "fact" "fair" "fall" "far"  "farm" "fast" "feed"
## [101] "feel" "few"  "file" "fill" "film" "find" "fine" "fire" "fish" "fit"  "five" "flat" "fly"  "food" "foot" "for"  "form" "four" "free" "from"
## [121] "full" "fun"  "fund" "game" "gas"  "get"  "girl" "give" "go"   "god"  "good" "grow" "guy"  "hair" "half" "hall" "hand" "hang" "hard" "hate"
## [141] "have" "he"   "head" "hear" "heat" "hell" "help" "here" "high" "hit"  "hold" "home" "hope" "hot"  "hour" "how"  "idea" "if"   "in"   "into"
## [161] "it"   "item" "job"  "join" "jump" "just" "keep" "key"  "kid"  "kill" "kind" "king" "know" "lad"  "lady" "land" "last" "late" "law"  "lay" 
## [181] "lead" "left" "leg"  "less" "let"  "lie"  "life" "like" "line" "link" "list" "live" "load" "lock" "long" "look" "lord" "lose" "lot"  "love"
## [201] "low"  "luck" "main" "make" "man"  "many" "mark" "may"  "mean" "meet" "mile" "milk" "mind" "miss" "more" "most" "move" "mrs"  "much" "must"
## [221] "name" "near" "need" "new"  "news" "next" "nice" "nine" "no"   "non"  "none" "not"  "note" "now"  "odd"  "of"   "off"  "okay" "old"  "on"  
## [241] "once" "one"  "only" "open" "or"   "out"  "over" "own"  "pack" "page" "pair" "park" "part" "pass" "past" "pay"  "per"  "pick" "plan" "play"
## [261] "plus" "poor" "post" "pull" "push" "put"  "quid" "rail" "rate" "read" "real" "red"  "rest" "rid"  "ring" "rise" "road" "role" "roll" "room"
## [281] "rule" "run"  "safe" "sale" "same" "save" "say"  "seat" "see"  "seem" "self" "sell" "send" "set"  "sex"  "she"  "shoe" "shop" "show" "shut"
## [301] "sick" "side" "sign" "sing" "sir"  "sit"  "site" "six"  "size" "slow" "so"   "some" "son"  "soon" "sort" "stay" "step" "stop" "such" "suit"
## [321] "sun"  "sure" "take" "talk" "tape" "tax"  "tea"  "team" "tell" "ten"  "tend" "term" "test" "than" "the"  "then" "they" "this" "thou" "tie" 
## [341] "time" "to"   "too"  "top"  "town" "tree" "true" "try"  "turn" "two"  "type" "unit" "up"   "upon" "use"  "very" "view" "vote" "wage" "wait"
## [361] "walk" "wall" "want" "war"  "warm" "wash" "way"  "we"   "wear" "wee"  "week" "well" "west" "what" "when" "who"  "why"  "wide" "wife" "will"
## [381] "win"  "wind" "wish" "with" "wood" "word" "work" "year" "yes"  "yet"  "you"
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
##   [1] "act" "add" "age" "ago" "air" "all" "and" "any" "arm" "art" "ask" "bad" "bag" "bar" "bed" "bet" "big" "bit" "box" "boy" "bus" "but" "buy"
##  [24] "can" "car" "cat" "cup" "cut" "dad" "day" "die" "dog" "dry" "due" "eat" "egg" "end" "eye" "far" "few" "fit" "fly" "for" "fun" "gas" "get"
##  [47] "god" "guy" "hit" "hot" "how" "job" "key" "kid" "lad" "law" "lay" "leg" "let" "lie" "lot" "low" "man" "may" "mrs" "new" "non" "not" "now"
##  [70] "odd" "off" "old" "one" "out" "own" "pay" "per" "put" "red" "rid" "run" "say" "see" "set" "sex" "she" "sir" "sit" "six" "son" "sun" "tax"
##  [93] "tea" "ten" "the" "tie" "too" "top" "try" "two" "use" "war" "way" "wee" "who" "why" "win" "yes" "yet" "you"
```

``` r
str_subset(words, "^...$")
```

```
##   [1] "act" "add" "age" "ago" "air" "all" "and" "any" "arm" "art" "ask" "bad" "bag" "bar" "bed" "bet" "big" "bit" "box" "boy" "bus" "but" "buy"
##  [24] "can" "car" "cat" "cup" "cut" "dad" "day" "die" "dog" "dry" "due" "eat" "egg" "end" "eye" "far" "few" "fit" "fly" "for" "fun" "gas" "get"
##  [47] "god" "guy" "hit" "hot" "how" "job" "key" "kid" "lad" "law" "lay" "leg" "let" "lie" "lot" "low" "man" "may" "mrs" "new" "non" "not" "now"
##  [70] "odd" "off" "old" "one" "out" "own" "pay" "per" "put" "red" "rid" "run" "say" "see" "set" "sex" "she" "sir" "sit" "six" "son" "sun" "tax"
##  [93] "tea" "ten" "the" "tie" "too" "top" "try" "two" "use" "war" "way" "wee" "who" "why" "win" "yes" "yet" "you"
```

## Practice: Searching Words with Seven or More Characters


``` r
str_subset(words, "^.{7}.*$")
```

```
##   [1] "absolute"    "account"     "achieve"     "address"     "advertise"   "afternoon"   "against"     "already"     "alright"     "although"   
##  [11] "america"     "another"     "apparent"    "appoint"     "approach"    "appropriate" "arrange"     "associate"   "authority"   "available"  
##  [21] "balance"     "because"     "believe"     "benefit"     "between"     "brilliant"   "britain"     "brother"     "business"    "certain"    
##  [31] "chairman"    "character"   "Christmas"   "colleague"   "collect"     "college"     "comment"     "committee"   "community"   "company"    
##  [41] "compare"     "complete"    "compute"     "concern"     "condition"   "consider"    "consult"     "contact"     "continue"    "contract"   
##  [51] "control"     "converse"    "correct"     "council"     "country"     "current"     "decision"    "definite"    "department"  "describe"   
##  [61] "develop"     "difference"  "difficult"   "discuss"     "district"    "document"    "economy"     "educate"     "electric"    "encourage"  
##  [71] "english"     "environment" "especial"    "evening"     "evidence"    "example"     "exercise"    "expense"     "experience"  "explain"    
##  [81] "express"     "finance"     "fortune"     "forward"     "function"    "further"     "general"     "germany"     "goodbye"     "history"    
##  [91] "holiday"     "hospital"    "however"     "hundred"     "husband"     "identify"    "imagine"     "important"   "improve"     "include"    
## [101] "increase"    "individual"  "industry"    "instead"     "interest"    "introduce"   "involve"     "kitchen"     "language"    "machine"    
## [111] "meaning"     "measure"     "mention"     "million"     "minister"    "morning"     "necessary"   "obvious"     "occasion"    "operate"    
## [121] "opportunity" "organize"    "original"    "otherwise"   "paragraph"   "particular"  "pension"     "percent"     "perfect"     "perhaps"    
## [131] "photograph"  "picture"     "politic"     "position"    "positive"    "possible"    "practise"    "prepare"     "present"     "pressure"   
## [141] "presume"     "previous"    "private"     "probable"    "problem"     "proceed"     "process"     "produce"     "product"     "programme"  
## [151] "project"     "propose"     "protect"     "provide"     "purpose"     "quality"     "quarter"     "question"    "realise"     "receive"    
## [161] "recognize"   "recommend"   "relation"    "remember"    "represent"   "require"     "research"    "resource"    "respect"     "responsible"
## [171] "saturday"    "science"     "scotland"    "secretary"   "section"     "separate"    "serious"     "service"     "similar"     "situate"    
## [181] "society"     "special"     "specific"    "standard"    "station"     "straight"    "strategy"    "structure"   "student"     "subject"    
## [191] "succeed"     "suggest"     "support"     "suppose"     "surprise"    "telephone"   "television"  "terrible"    "therefore"   "thirteen"   
## [201] "thousand"    "through"     "thursday"    "together"    "tomorrow"    "tonight"     "traffic"     "transport"   "trouble"     "tuesday"    
## [211] "understand"  "university"  "various"     "village"     "wednesday"   "welcome"     "whether"     "without"     "yesterday"
```

``` r
str_subset(words, "^.{7,}$")
```

```
##   [1] "absolute"    "account"     "achieve"     "address"     "advertise"   "afternoon"   "against"     "already"     "alright"     "although"   
##  [11] "america"     "another"     "apparent"    "appoint"     "approach"    "appropriate" "arrange"     "associate"   "authority"   "available"  
##  [21] "balance"     "because"     "believe"     "benefit"     "between"     "brilliant"   "britain"     "brother"     "business"    "certain"    
##  [31] "chairman"    "character"   "Christmas"   "colleague"   "collect"     "college"     "comment"     "committee"   "community"   "company"    
##  [41] "compare"     "complete"    "compute"     "concern"     "condition"   "consider"    "consult"     "contact"     "continue"    "contract"   
##  [51] "control"     "converse"    "correct"     "council"     "country"     "current"     "decision"    "definite"    "department"  "describe"   
##  [61] "develop"     "difference"  "difficult"   "discuss"     "district"    "document"    "economy"     "educate"     "electric"    "encourage"  
##  [71] "english"     "environment" "especial"    "evening"     "evidence"    "example"     "exercise"    "expense"     "experience"  "explain"    
##  [81] "express"     "finance"     "fortune"     "forward"     "function"    "further"     "general"     "germany"     "goodbye"     "history"    
##  [91] "holiday"     "hospital"    "however"     "hundred"     "husband"     "identify"    "imagine"     "important"   "improve"     "include"    
## [101] "increase"    "individual"  "industry"    "instead"     "interest"    "introduce"   "involve"     "kitchen"     "language"    "machine"    
## [111] "meaning"     "measure"     "mention"     "million"     "minister"    "morning"     "necessary"   "obvious"     "occasion"    "operate"    
## [121] "opportunity" "organize"    "original"    "otherwise"   "paragraph"   "particular"  "pension"     "percent"     "perfect"     "perhaps"    
## [131] "photograph"  "picture"     "politic"     "position"    "positive"    "possible"    "practise"    "prepare"     "present"     "pressure"   
## [141] "presume"     "previous"    "private"     "probable"    "problem"     "proceed"     "process"     "produce"     "product"     "programme"  
## [151] "project"     "propose"     "protect"     "provide"     "purpose"     "quality"     "quarter"     "question"    "realise"     "receive"    
## [161] "recognize"   "recommend"   "relation"    "remember"    "represent"   "require"     "research"    "resource"    "respect"     "responsible"
## [171] "saturday"    "science"     "scotland"    "secretary"   "section"     "separate"    "serious"     "service"     "similar"     "situate"    
## [181] "society"     "special"     "specific"    "standard"    "station"     "straight"    "strategy"    "structure"   "student"     "subject"    
## [191] "succeed"     "suggest"     "support"     "suppose"     "surprise"    "telephone"   "television"  "terrible"    "therefore"   "thirteen"   
## [201] "thousand"    "through"     "thursday"    "together"    "tomorrow"    "tonight"     "traffic"     "transport"   "trouble"     "tuesday"    
## [211] "understand"  "university"  "various"     "village"     "wednesday"   "welcome"     "whether"     "without"     "yesterday"
```

``` r
str_subset(words, "^.......")
```

```
##   [1] "absolute"    "account"     "achieve"     "address"     "advertise"   "afternoon"   "against"     "already"     "alright"     "although"   
##  [11] "america"     "another"     "apparent"    "appoint"     "approach"    "appropriate" "arrange"     "associate"   "authority"   "available"  
##  [21] "balance"     "because"     "believe"     "benefit"     "between"     "brilliant"   "britain"     "brother"     "business"    "certain"    
##  [31] "chairman"    "character"   "Christmas"   "colleague"   "collect"     "college"     "comment"     "committee"   "community"   "company"    
##  [41] "compare"     "complete"    "compute"     "concern"     "condition"   "consider"    "consult"     "contact"     "continue"    "contract"   
##  [51] "control"     "converse"    "correct"     "council"     "country"     "current"     "decision"    "definite"    "department"  "describe"   
##  [61] "develop"     "difference"  "difficult"   "discuss"     "district"    "document"    "economy"     "educate"     "electric"    "encourage"  
##  [71] "english"     "environment" "especial"    "evening"     "evidence"    "example"     "exercise"    "expense"     "experience"  "explain"    
##  [81] "express"     "finance"     "fortune"     "forward"     "function"    "further"     "general"     "germany"     "goodbye"     "history"    
##  [91] "holiday"     "hospital"    "however"     "hundred"     "husband"     "identify"    "imagine"     "important"   "improve"     "include"    
## [101] "increase"    "individual"  "industry"    "instead"     "interest"    "introduce"   "involve"     "kitchen"     "language"    "machine"    
## [111] "meaning"     "measure"     "mention"     "million"     "minister"    "morning"     "necessary"   "obvious"     "occasion"    "operate"    
## [121] "opportunity" "organize"    "original"    "otherwise"   "paragraph"   "particular"  "pension"     "percent"     "perfect"     "perhaps"    
## [131] "photograph"  "picture"     "politic"     "position"    "positive"    "possible"    "practise"    "prepare"     "present"     "pressure"   
## [141] "presume"     "previous"    "private"     "probable"    "problem"     "proceed"     "process"     "produce"     "product"     "programme"  
## [151] "project"     "propose"     "protect"     "provide"     "purpose"     "quality"     "quarter"     "question"    "realise"     "receive"    
## [161] "recognize"   "recommend"   "relation"    "remember"    "represent"   "require"     "research"    "resource"    "respect"     "responsible"
## [171] "saturday"    "science"     "scotland"    "secretary"   "section"     "separate"    "serious"     "service"     "similar"     "situate"    
## [181] "society"     "special"     "specific"    "standard"    "station"     "straight"    "strategy"    "structure"   "student"     "subject"    
## [191] "succeed"     "suggest"     "support"     "suppose"     "surprise"    "telephone"   "television"  "terrible"    "therefore"   "thirteen"   
## [201] "thousand"    "through"     "thursday"    "together"    "tomorrow"    "tonight"     "traffic"     "transport"   "trouble"     "tuesday"    
## [211] "understand"  "university"  "various"     "village"     "wednesday"   "welcome"     "whether"     "without"     "yesterday"
```

``` r
# Invalid: nothing follows "^" before the quantifier
str_subset(words, "^{,7}.$")
```

```
## Error in stri_subset_regex(string, pattern, omit_na = TRUE, negate = negate, : Error in {min,max} interval. (U_REGEX_BAD_INTERVAL, context=`^{,7}.$`)
```

``` r
# Invalid: "{,m}" requires a preceding element to quantify
str_subset(words, "^.{,7}.$")
```

```
## Error in stri_subset_regex(string, pattern, omit_na = TRUE, negate = negate, : Error in {min,max} interval. (U_REGEX_BAD_INTERVAL, context=`^.{,7}.$`)
```

``` r
# Invalid: "{,m}" is not supported in R's default regex engine
str_subset(words, "^.{,7}$")
```

```
## Error in stri_subset_regex(string, pattern, omit_na = TRUE, negate = negate, : Error in {min,max} interval. (U_REGEX_BAD_INTERVAL, context=`^.{,7}$`)
```

``` r
# Invalid: same issue as above
str_subset(words, "^.{,7}")
```

```
## Error in stri_subset_regex(string, pattern, omit_na = TRUE, negate = negate, : Error in {min,max} interval. (U_REGEX_BAD_INTERVAL, context=`^.{,7}`)
```

``` r
# Valid syntax, but does not produce the intended result;
# a minimum bound should be specified for clarity
str_subset(words, "^.{1,7}.$")
```

```
##   [1] "able"     "about"    "absolute" "accept"   "account"  "achieve"  "across"   "act"      "active"   "actual"   "add"      "address"  "admit"   
##  [14] "affect"   "afford"   "after"    "again"    "against"  "age"      "agent"    "ago"      "agree"    "air"      "all"      "allow"    "almost"  
##  [27] "along"    "already"  "alright"  "also"     "although" "always"   "america"  "amount"   "and"      "another"  "answer"   "any"      "apart"   
##  [40] "apparent" "appear"   "apply"    "appoint"  "approach" "area"     "argue"    "arm"      "around"   "arrange"  "art"      "as"       "ask"     
##  [53] "assume"   "at"       "attend"   "aware"    "away"     "awful"    "baby"     "back"     "bad"      "bag"      "balance"  "ball"     "bank"    
##  [66] "bar"      "base"     "basis"    "be"       "bear"     "beat"     "beauty"   "because"  "become"   "bed"      "before"   "begin"    "behind"  
##  [79] "believe"  "benefit"  "best"     "bet"      "between"  "big"      "bill"     "birth"    "bit"      "black"    "bloke"    "blood"    "blow"    
##  [92] "blue"     "board"    "boat"     "body"     "book"     "both"     "bother"   "bottle"   "bottom"   "box"      "boy"      "break"    "brief"   
## [105] "bring"    "britain"  "brother"  "budget"   "build"    "bus"      "business" "busy"     "but"      "buy"      "by"       "cake"     "call"    
## [118] "can"      "car"      "card"     "care"     "carry"    "case"     "cat"      "catch"    "cause"    "cent"     "centre"   "certain"  "chair"   
## [131] "chairman" "chance"   "change"   "chap"     "charge"   "cheap"    "check"    "child"    "choice"   "choose"   "Christ"   "church"   "city"    
## [144] "claim"    "class"    "clean"    "clear"    "client"   "clock"    "close"    "closes"   "clothe"   "club"     "coffee"   "cold"     "collect" 
## [157] "college"  "colour"   "come"     "comment"  "commit"   "common"   "company"  "compare"  "complete" "compute"  "concern"  "confer"   "consider"
## [170] "consult"  "contact"  "continue" "contract" "control"  "converse" "cook"     "copy"     "corner"   "correct"  "cost"     "could"    "council" 
## [183] "count"    "country"  "county"   "couple"   "course"   "court"    "cover"    "create"   "cross"    "cup"      "current"  "cut"      "dad"     
## [196] "danger"   "date"     "day"      "dead"     "deal"     "dear"     "debate"   "decide"   "decision" "deep"     "definite" "degree"   "depend"  
## [209] "describe" "design"   "detail"   "develop"  "die"      "dinner"   "direct"   "discuss"  "district" "divide"   "do"       "doctor"   "document"
## [222] "dog"      "door"     "double"   "doubt"    "down"     "draw"     "dress"    "drink"    "drive"    "drop"     "dry"      "due"      "during"  
## [235] "each"     "early"    "east"     "easy"     "eat"      "economy"  "educate"  "effect"   "egg"      "eight"    "either"   "elect"    "electric"
## [248] "eleven"   "else"     "employ"   "end"      "engine"   "english"  "enjoy"    "enough"   "enter"    "equal"    "especial" "europe"   "even"    
## [261] "evening"  "ever"     "every"    "evidence" "exact"    "example"  "except"   "excuse"   "exercise" "exist"    "expect"   "expense"  "explain" 
## [274] "express"  "extra"    "eye"      "face"     "fact"     "fair"     "fall"     "family"   "far"      "farm"     "fast"     "father"   "favour"  
## [287] "feed"     "feel"     "few"      "field"    "fight"    "figure"   "file"     "fill"     "film"     "final"    "finance"  "find"     "fine"    
## [300] "finish"   "fire"     "first"    "fish"     "fit"      "five"     "flat"     "floor"    "fly"      "follow"   "food"     "foot"     "for"     
## [313] "force"    "forget"   "form"     "fortune"  "forward"  "four"     "france"   "free"     "friday"   "friend"   "from"     "front"    "full"    
## [326] "fun"      "function" "fund"     "further"  "future"   "game"     "garden"   "gas"      "general"  "germany"  "get"      "girl"     "give"    
## [339] "glass"    "go"       "god"      "good"     "goodbye"  "govern"   "grand"    "grant"    "great"    "green"    "ground"   "group"    "grow"    
## [352] "guess"    "guy"      "hair"     "half"     "hall"     "hand"     "hang"     "happen"   "happy"    "hard"     "hate"     "have"     "he"      
## [365] "head"     "health"   "hear"     "heart"    "heat"     "heavy"    "hell"     "help"     "here"     "high"     "history"  "hit"      "hold"    
## [378] "holiday"  "home"     "honest"   "hope"     "horse"    "hospital" "hot"      "hour"     "house"    "how"      "however"  "hullo"    "hundred" 
## [391] "husband"  "idea"     "identify" "if"       "imagine"  "improve"  "in"       "include"  "income"   "increase" "indeed"   "industry" "inform"  
## [404] "inside"   "instead"  "insure"   "interest" "into"     "invest"   "involve"  "issue"    "it"       "item"     "jesus"    "job"      "join"    
## [417] "judge"    "jump"     "just"     "keep"     "key"      "kid"      "kill"     "kind"     "king"     "kitchen"  "knock"    "know"     "labour"  
## [430] "lad"      "lady"     "land"     "language" "large"    "last"     "late"     "laugh"    "law"      "lay"      "lead"     "learn"    "leave"   
## [443] "left"     "leg"      "less"     "let"      "letter"   "level"    "lie"      "life"     "light"    "like"     "likely"   "limit"    "line"    
## [456] "link"     "list"     "listen"   "little"   "live"     "load"     "local"    "lock"     "london"   "long"     "look"     "lord"     "lose"    
## [469] "lot"      "love"     "low"      "luck"     "lunch"    "machine"  "main"     "major"    "make"     "man"      "manage"   "many"     "mark"    
## [482] "market"   "marry"    "match"    "matter"   "may"      "maybe"    "mean"     "meaning"  "measure"  "meet"     "member"   "mention"  "middle"  
## [495] "might"    "mile"     "milk"     "million"  "mind"     "minister" "minus"    "minute"   "miss"     "mister"   "moment"   "monday"   "money"   
## [508] "month"    "more"     "morning"  "most"     "mother"   "motion"   "move"     "mrs"      "much"     "music"    "must"     "name"     "nation"  
## [521] "nature"   "near"     "need"     "never"    "new"      "news"     "next"     "nice"     "night"    "nine"     "no"       "non"      "none"    
## [534] "normal"   "north"    "not"      "note"     "notice"   "now"      "number"   "obvious"  "occasion" "odd"      "of"       "off"      "offer"   
## [547] "office"   "often"    "okay"     "old"      "on"       "once"     "one"      "only"     "open"     "operate"  "oppose"   "or"       "order"   
## [560] "organize" "original" "other"    "ought"    "out"      "over"     "own"      "pack"     "page"     "paint"    "pair"     "paper"    "pardon"  
## [573] "parent"   "park"     "part"     "party"    "pass"     "past"     "pay"      "pence"    "pension"  "people"   "per"      "percent"  "perfect" 
## [586] "perhaps"  "period"   "person"   "pick"     "picture"  "piece"    "place"    "plan"     "play"     "please"   "plus"     "point"    "police"  
## [599] "policy"   "politic"  "poor"     "position" "positive" "possible" "post"     "pound"    "power"    "practise" "prepare"  "present"  "press"   
## [612] "pressure" "presume"  "pretty"   "previous" "price"    "print"    "private"  "probable" "problem"  "proceed"  "process"  "produce"  "product" 
## [625] "project"  "proper"   "propose"  "protect"  "provide"  "public"   "pull"     "purpose"  "push"     "put"      "quality"  "quarter"  "question"
## [638] "quick"    "quid"     "quiet"    "quite"    "radio"    "rail"     "raise"    "range"    "rate"     "rather"   "read"     "ready"    "real"    
## [651] "realise"  "really"   "reason"   "receive"  "recent"   "reckon"   "record"   "red"      "reduce"   "refer"    "regard"   "region"   "relation"
## [664] "remember" "report"   "require"  "research" "resource" "respect"  "rest"     "result"   "return"   "rid"      "right"    "ring"     "rise"    
## [677] "road"     "role"     "roll"     "room"     "round"    "rule"     "run"      "safe"     "sale"     "same"     "saturday" "save"     "say"     
## [690] "scheme"   "school"   "science"  "score"    "scotland" "seat"     "second"   "section"  "secure"   "see"      "seem"     "self"     "sell"    
## [703] "send"     "sense"    "separate" "serious"  "serve"    "service"  "set"      "settle"   "seven"    "sex"      "shall"    "share"    "she"     
## [716] "sheet"    "shoe"     "shoot"    "shop"     "short"    "should"   "show"     "shut"     "sick"     "side"     "sign"     "similar"  "simple"  
## [729] "since"    "sing"     "single"   "sir"      "sister"   "sit"      "site"     "situate"  "six"      "size"     "sleep"    "slight"   "slow"    
## [742] "small"    "smoke"    "so"       "social"   "society"  "some"     "son"      "soon"     "sorry"    "sort"     "sound"    "south"    "space"   
## [755] "speak"    "special"  "specific" "speed"    "spell"    "spend"    "square"   "staff"    "stage"    "stairs"   "stand"    "standard" "start"   
## [768] "state"    "station"  "stay"     "step"     "stick"    "still"    "stop"     "story"    "straight" "strategy" "street"   "strike"   "strong"  
## [781] "student"  "study"    "stuff"    "stupid"   "subject"  "succeed"  "such"     "sudden"   "suggest"  "suit"     "summer"   "sun"      "sunday"  
## [794] "supply"   "support"  "suppose"  "sure"     "surprise" "switch"   "system"   "table"    "take"     "talk"     "tape"     "tax"      "tea"     
## [807] "teach"    "team"     "tell"     "ten"      "tend"     "term"     "terrible" "test"     "than"     "thank"    "the"      "then"     "there"   
## [820] "they"     "thing"    "think"    "thirteen" "thirty"   "this"     "thou"     "though"   "thousand" "three"    "through"  "throw"    "thursday"
## [833] "tie"      "time"     "to"       "today"    "together" "tomorrow" "tonight"  "too"      "top"      "total"    "touch"    "toward"   "town"    
## [846] "trade"    "traffic"  "train"    "travel"   "treat"    "tree"     "trouble"  "true"     "trust"    "try"      "tuesday"  "turn"     "twelve"  
## [859] "twenty"   "two"      "type"     "under"    "union"    "unit"     "unite"    "unless"   "until"    "up"       "upon"     "use"      "usual"   
## [872] "value"    "various"  "very"     "video"    "view"     "village"  "visit"    "vote"     "wage"     "wait"     "walk"     "wall"     "want"    
## [885] "war"      "warm"     "wash"     "waste"    "watch"    "water"    "way"      "we"       "wear"     "wee"      "week"     "weigh"    "welcome" 
## [898] "well"     "west"     "what"     "when"     "where"    "whether"  "which"    "while"    "white"    "who"      "whole"    "why"      "wide"    
## [911] "wife"     "will"     "win"      "wind"     "window"   "wish"     "with"     "within"   "without"  "woman"    "wonder"   "wood"     "word"    
## [924] "work"     "world"    "worry"    "worse"    "worth"    "would"    "write"    "wrong"    "year"     "yes"      "yet"      "you"      "young"
```

