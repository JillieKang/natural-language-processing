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
##  [1] "Letter: a" "Letter: b" "Letter: c" "Letter: d" "Letter: e" "Letter: f" "Letter: g" "Letter: h"
##  [9] "Letter: i" "Letter: j" "Letter: k" "Letter: l" "Letter: m" "Letter: n" "Letter: o" "Letter: p"
## [17] "Letter: q" "Letter: r" "Letter: s" "Letter: t" "Letter: u" "Letter: v" "Letter: w" "Letter: x"
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
##   [1] "act" "add" "age" "ago" "air" "all" "and" "any" "arm" "art" "ask" "bad" "bag" "bar" "bed" "bet" "big"
##  [18] "bit" "box" "boy" "bus" "but" "buy" "can" "car" "cat" "cup" "cut" "dad" "day" "die" "dog" "dry" "due"
##  [35] "eat" "egg" "end" "eye" "far" "few" "fit" "fly" "for" "fun" "gas" "get" "god" "guy" "hit" "hot" "how"
##  [52] "job" "key" "kid" "lad" "law" "lay" "leg" "let" "lie" "lot" "low" "man" "may" "mrs" "new" "non" "not"
##  [69] "now" "odd" "off" "old" "one" "out" "own" "pay" "per" "put" "red" "rid" "run" "say" "see" "set" "sex"
##  [86] "she" "sir" "sit" "six" "son" "sun" "tax" "tea" "ten" "the" "tie" "too" "top" "try" "two" "use" "war"
## [103] "way" "wee" "who" "why" "win" "yes" "yet" "you"
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
##   [1] "absolute"    "account"     "achieve"     "address"     "advertise"   "afternoon"   "against"    
##   [8] "already"     "alright"     "although"    "america"     "another"     "apparent"    "appoint"    
##  [15] "approach"    "appropriate" "arrange"     "associate"   "authority"   "available"   "balance"    
##  [22] "because"     "believe"     "benefit"     "between"     "brilliant"   "britain"     "brother"    
##  [29] "business"    "certain"     "chairman"    "character"   "Christmas"   "colleague"   "collect"    
##  [36] "college"     "comment"     "committee"   "community"   "company"     "compare"     "complete"   
##  [43] "compute"     "concern"     "condition"   "consider"    "consult"     "contact"     "continue"   
##  [50] "contract"    "control"     "converse"    "correct"     "council"     "country"     "current"    
##  [57] "decision"    "definite"    "department"  "describe"    "develop"     "difference"  "difficult"  
##  [64] "discuss"     "district"    "document"    "economy"     "educate"     "electric"    "encourage"  
##  [71] "english"     "environment" "especial"    "evening"     "evidence"    "example"     "exercise"   
##  [78] "expense"     "experience"  "explain"     "express"     "finance"     "fortune"     "forward"    
##  [85] "function"    "further"     "general"     "germany"     "goodbye"     "history"     "holiday"    
##  [92] "hospital"    "however"     "hundred"     "husband"     "identify"    "imagine"     "important"  
##  [99] "improve"     "include"     "increase"    "individual"  "industry"    "instead"     "interest"   
## [106] "introduce"   "involve"     "kitchen"     "language"    "machine"     "meaning"     "measure"    
## [113] "mention"     "million"     "minister"    "morning"     "necessary"   "obvious"     "occasion"   
## [120] "operate"     "opportunity" "organize"    "original"    "otherwise"   "paragraph"   "particular" 
## [127] "pension"     "percent"     "perfect"     "perhaps"     "photograph"  "picture"     "politic"    
## [134] "position"    "positive"    "possible"    "practise"    "prepare"     "present"     "pressure"   
## [141] "presume"     "previous"    "private"     "probable"    "problem"     "proceed"     "process"    
## [148] "produce"     "product"     "programme"   "project"     "propose"     "protect"     "provide"    
## [155] "purpose"     "quality"     "quarter"     "question"    "realise"     "receive"     "recognize"  
## [162] "recommend"   "relation"    "remember"    "represent"   "require"     "research"    "resource"   
## [169] "respect"     "responsible" "saturday"    "science"     "scotland"    "secretary"   "section"    
## [176] "separate"    "serious"     "service"     "similar"     "situate"     "society"     "special"    
## [183] "specific"    "standard"    "station"     "straight"    "strategy"    "structure"   "student"    
## [190] "subject"     "succeed"     "suggest"     "support"     "suppose"     "surprise"    "telephone"  
## [197] "television"  "terrible"    "therefore"   "thirteen"    "thousand"    "through"     "thursday"   
## [204] "together"    "tomorrow"    "tonight"     "traffic"     "transport"   "trouble"     "tuesday"    
## [211] "understand"  "university"  "various"     "village"     "wednesday"   "welcome"     "whether"    
## [218] "without"     "yesterday"
```

### Exercises


``` r
# Matches words consisting of exactly three characters
str_subset(words, "^.{3}$")
```

```
##   [1] "act" "add" "age" "ago" "air" "all" "and" "any" "arm" "art" "ask" "bad" "bag" "bar" "bed" "bet" "big"
##  [18] "bit" "box" "boy" "bus" "but" "buy" "can" "car" "cat" "cup" "cut" "dad" "day" "die" "dog" "dry" "due"
##  [35] "eat" "egg" "end" "eye" "far" "few" "fit" "fly" "for" "fun" "gas" "get" "god" "guy" "hit" "hot" "how"
##  [52] "job" "key" "kid" "lad" "law" "lay" "leg" "let" "lie" "lot" "low" "man" "may" "mrs" "new" "non" "not"
##  [69] "now" "odd" "off" "old" "one" "out" "own" "pay" "per" "put" "red" "rid" "run" "say" "see" "set" "sex"
##  [86] "she" "sir" "sit" "six" "son" "sun" "tax" "tea" "ten" "the" "tie" "too" "top" "try" "two" "use" "war"
## [103] "way" "wee" "who" "why" "win" "yes" "yet" "you"
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
##   [1] "act" "add" "age" "ago" "air" "all" "and" "any" "arm" "art" "ask" "bad" "bag" "bar" "bed" "bet" "big"
##  [18] "bit" "box" "boy" "bus" "but" "buy" "can" "car" "cat" "cup" "cut" "dad" "day" "die" "dog" "dry" "due"
##  [35] "eat" "egg" "end" "eye" "far" "few" "fit" "fly" "for" "fun" "gas" "get" "god" "guy" "hit" "hot" "how"
##  [52] "job" "key" "kid" "lad" "law" "lay" "leg" "let" "lie" "lot" "low" "man" "may" "mrs" "new" "non" "not"
##  [69] "now" "odd" "off" "old" "one" "out" "own" "pay" "per" "put" "red" "rid" "run" "say" "see" "set" "sex"
##  [86] "she" "sir" "sit" "six" "son" "sun" "tax" "tea" "ten" "the" "tie" "too" "top" "try" "two" "use" "war"
## [103] "way" "wee" "who" "why" "win" "yes" "yet" "you"
```

``` r
# Matches words beginning with at least three characters (no upper limit)
str_subset(words, "^.{3}")
```

```
##   [1] "able"        "about"       "absolute"    "accept"      "account"     "achieve"     "across"     
##   [8] "act"         "active"      "actual"      "add"         "address"     "admit"       "advertise"  
##  [15] "affect"      "afford"      "after"       "afternoon"   "again"       "against"     "age"        
##  [22] "agent"       "ago"         "agree"       "air"         "all"         "allow"       "almost"     
##  [29] "along"       "already"     "alright"     "also"        "although"    "always"      "america"    
##  [36] "amount"      "and"         "another"     "answer"      "any"         "apart"       "apparent"   
##  [43] "appear"      "apply"       "appoint"     "approach"    "appropriate" "area"        "argue"      
##  [50] "arm"         "around"      "arrange"     "art"         "ask"         "associate"   "assume"     
##  [57] "attend"      "authority"   "available"   "aware"       "away"        "awful"       "baby"       
##  [64] "back"        "bad"         "bag"         "balance"     "ball"        "bank"        "bar"        
##  [71] "base"        "basis"       "bear"        "beat"        "beauty"      "because"     "become"     
##  [78] "bed"         "before"      "begin"       "behind"      "believe"     "benefit"     "best"       
##  [85] "bet"         "between"     "big"         "bill"        "birth"       "bit"         "black"      
##  [92] "bloke"       "blood"       "blow"        "blue"        "board"       "boat"        "body"       
##  [99] "book"        "both"        "bother"      "bottle"      "bottom"      "box"         "boy"        
## [106] "break"       "brief"       "brilliant"   "bring"       "britain"     "brother"     "budget"     
## [113] "build"       "bus"         "business"    "busy"        "but"         "buy"         "cake"       
## [120] "call"        "can"         "car"         "card"        "care"        "carry"       "case"       
## [127] "cat"         "catch"       "cause"       "cent"        "centre"      "certain"     "chair"      
## [134] "chairman"    "chance"      "change"      "chap"        "character"   "charge"      "cheap"      
## [141] "check"       "child"       "choice"      "choose"      "Christ"      "Christmas"   "church"     
## [148] "city"        "claim"       "class"       "clean"       "clear"       "client"      "clock"      
## [155] "close"       "closes"      "clothe"      "club"        "coffee"      "cold"        "colleague"  
## [162] "collect"     "college"     "colour"      "come"        "comment"     "commit"      "committee"  
## [169] "common"      "community"   "company"     "compare"     "complete"    "compute"     "concern"    
## [176] "condition"   "confer"      "consider"    "consult"     "contact"     "continue"    "contract"   
## [183] "control"     "converse"    "cook"        "copy"        "corner"      "correct"     "cost"       
## [190] "could"       "council"     "count"       "country"     "county"      "couple"      "course"     
## [197] "court"       "cover"       "create"      "cross"       "cup"         "current"     "cut"        
## [204] "dad"         "danger"      "date"        "day"         "dead"        "deal"        "dear"       
## [211] "debate"      "decide"      "decision"    "deep"        "definite"    "degree"      "department" 
## [218] "depend"      "describe"    "design"      "detail"      "develop"     "die"         "difference" 
## [225] "difficult"   "dinner"      "direct"      "discuss"     "district"    "divide"      "doctor"     
## [232] "document"    "dog"         "door"        "double"      "doubt"       "down"        "draw"       
## [239] "dress"       "drink"       "drive"       "drop"        "dry"         "due"         "during"     
## [246] "each"        "early"       "east"        "easy"        "eat"         "economy"     "educate"    
## [253] "effect"      "egg"         "eight"       "either"      "elect"       "electric"    "eleven"     
## [260] "else"        "employ"      "encourage"   "end"         "engine"      "english"     "enjoy"      
## [267] "enough"      "enter"       "environment" "equal"       "especial"    "europe"      "even"       
## [274] "evening"     "ever"        "every"       "evidence"    "exact"       "example"     "except"     
## [281] "excuse"      "exercise"    "exist"       "expect"      "expense"     "experience"  "explain"    
## [288] "express"     "extra"       "eye"         "face"        "fact"        "fair"        "fall"       
## [295] "family"      "far"         "farm"        "fast"        "father"      "favour"      "feed"       
## [302] "feel"        "few"         "field"       "fight"       "figure"      "file"        "fill"       
## [309] "film"        "final"       "finance"     "find"        "fine"        "finish"      "fire"       
## [316] "first"       "fish"        "fit"         "five"        "flat"        "floor"       "fly"        
## [323] "follow"      "food"        "foot"        "for"         "force"       "forget"      "form"       
## [330] "fortune"     "forward"     "four"        "france"      "free"        "friday"      "friend"     
## [337] "from"        "front"       "full"        "fun"         "function"    "fund"        "further"    
## [344] "future"      "game"        "garden"      "gas"         "general"     "germany"     "get"        
## [351] "girl"        "give"        "glass"       "god"         "good"        "goodbye"     "govern"     
## [358] "grand"       "grant"       "great"       "green"       "ground"      "group"       "grow"       
## [365] "guess"       "guy"         "hair"        "half"        "hall"        "hand"        "hang"       
## [372] "happen"      "happy"       "hard"        "hate"        "have"        "head"        "health"     
## [379] "hear"        "heart"       "heat"        "heavy"       "hell"        "help"        "here"       
## [386] "high"        "history"     "hit"         "hold"        "holiday"     "home"        "honest"     
## [393] "hope"        "horse"       "hospital"    "hot"         "hour"        "house"       "how"        
## [400] "however"     "hullo"       "hundred"     "husband"     "idea"        "identify"    "imagine"    
## [407] "important"   "improve"     "include"     "income"      "increase"    "indeed"      "individual" 
## [414] "industry"    "inform"      "inside"      "instead"     "insure"      "interest"    "into"       
## [421] "introduce"   "invest"      "involve"     "issue"       "item"        "jesus"       "job"        
## [428] "join"        "judge"       "jump"        "just"        "keep"        "key"         "kid"        
## [435] "kill"        "kind"        "king"        "kitchen"     "knock"       "know"        "labour"     
## [442] "lad"         "lady"        "land"        "language"    "large"       "last"        "late"       
## [449] "laugh"       "law"         "lay"         "lead"        "learn"       "leave"       "left"       
## [456] "leg"         "less"        "let"         "letter"      "level"       "lie"         "life"       
## [463] "light"       "like"        "likely"      "limit"       "line"        "link"        "list"       
## [470] "listen"      "little"      "live"        "load"        "local"       "lock"        "london"     
## [477] "long"        "look"        "lord"        "lose"        "lot"         "love"        "low"        
## [484] "luck"        "lunch"       "machine"     "main"        "major"       "make"        "man"        
## [491] "manage"      "many"        "mark"        "market"      "marry"       "match"       "matter"     
## [498] "may"         "maybe"       "mean"        "meaning"     "measure"     "meet"        "member"     
## [505] "mention"     "middle"      "might"       "mile"        "milk"        "million"     "mind"       
## [512] "minister"    "minus"       "minute"      "miss"        "mister"      "moment"      "monday"     
## [519] "money"       "month"       "more"        "morning"     "most"        "mother"      "motion"     
## [526] "move"        "mrs"         "much"        "music"       "must"        "name"        "nation"     
## [533] "nature"      "near"        "necessary"   "need"        "never"       "new"         "news"       
## [540] "next"        "nice"        "night"       "nine"        "non"         "none"        "normal"     
## [547] "north"       "not"         "note"        "notice"      "now"         "number"      "obvious"    
## [554] "occasion"    "odd"         "off"         "offer"       "office"      "often"       "okay"       
## [561] "old"         "once"        "one"         "only"        "open"        "operate"     "opportunity"
## [568] "oppose"      "order"       "organize"    "original"    "other"       "otherwise"   "ought"      
## [575] "out"         "over"        "own"         "pack"        "page"        "paint"       "pair"       
## [582] "paper"       "paragraph"   "pardon"      "parent"      "park"        "part"        "particular" 
## [589] "party"       "pass"        "past"        "pay"         "pence"       "pension"     "people"     
## [596] "per"         "percent"     "perfect"     "perhaps"     "period"      "person"      "photograph" 
## [603] "pick"        "picture"     "piece"       "place"       "plan"        "play"        "please"     
## [610] "plus"        "point"       "police"      "policy"      "politic"     "poor"        "position"   
## [617] "positive"    "possible"    "post"        "pound"       "power"       "practise"    "prepare"    
## [624] "present"     "press"       "pressure"    "presume"     "pretty"      "previous"    "price"      
## [631] "print"       "private"     "probable"    "problem"     "proceed"     "process"     "produce"    
## [638] "product"     "programme"   "project"     "proper"      "propose"     "protect"     "provide"    
## [645] "public"      "pull"        "purpose"     "push"        "put"         "quality"     "quarter"    
## [652] "question"    "quick"       "quid"        "quiet"       "quite"       "radio"       "rail"       
## [659] "raise"       "range"       "rate"        "rather"      "read"        "ready"       "real"       
## [666] "realise"     "really"      "reason"      "receive"     "recent"      "reckon"      "recognize"  
## [673] "recommend"   "record"      "red"         "reduce"      "refer"       "regard"      "region"     
## [680] "relation"    "remember"    "report"      "represent"   "require"     "research"    "resource"   
## [687] "respect"     "responsible" "rest"        "result"      "return"      "rid"         "right"      
## [694] "ring"        "rise"        "road"        "role"        "roll"        "room"        "round"      
## [701] "rule"        "run"         "safe"        "sale"        "same"        "saturday"    "save"       
## [708] "say"         "scheme"      "school"      "science"     "score"       "scotland"    "seat"       
## [715] "second"      "secretary"   "section"     "secure"      "see"         "seem"        "self"       
## [722] "sell"        "send"        "sense"       "separate"    "serious"     "serve"       "service"    
## [729] "set"         "settle"      "seven"       "sex"         "shall"       "share"       "she"        
## [736] "sheet"       "shoe"        "shoot"       "shop"        "short"       "should"      "show"       
## [743] "shut"        "sick"        "side"        "sign"        "similar"     "simple"      "since"      
## [750] "sing"        "single"      "sir"         "sister"      "sit"         "site"        "situate"    
## [757] "six"         "size"        "sleep"       "slight"      "slow"        "small"       "smoke"      
## [764] "social"      "society"     "some"        "son"         "soon"        "sorry"       "sort"       
## [771] "sound"       "south"       "space"       "speak"       "special"     "specific"    "speed"      
## [778] "spell"       "spend"       "square"      "staff"       "stage"       "stairs"      "stand"      
## [785] "standard"    "start"       "state"       "station"     "stay"        "step"        "stick"      
## [792] "still"       "stop"        "story"       "straight"    "strategy"    "street"      "strike"     
## [799] "strong"      "structure"   "student"     "study"       "stuff"       "stupid"      "subject"    
## [806] "succeed"     "such"        "sudden"      "suggest"     "suit"        "summer"      "sun"        
## [813] "sunday"      "supply"      "support"     "suppose"     "sure"        "surprise"    "switch"     
## [820] "system"      "table"       "take"        "talk"        "tape"        "tax"         "tea"        
## [827] "teach"       "team"        "telephone"   "television"  "tell"        "ten"         "tend"       
## [834] "term"        "terrible"    "test"        "than"        "thank"       "the"         "then"       
## [841] "there"       "therefore"   "they"        "thing"       "think"       "thirteen"    "thirty"     
## [848] "this"        "thou"        "though"      "thousand"    "three"       "through"     "throw"      
## [855] "thursday"    "tie"         "time"        "today"       "together"    "tomorrow"    "tonight"    
## [862] "too"         "top"         "total"       "touch"       "toward"      "town"        "trade"      
## [869] "traffic"     "train"       "transport"   "travel"      "treat"       "tree"        "trouble"    
## [876] "true"        "trust"       "try"         "tuesday"     "turn"        "twelve"      "twenty"     
## [883] "two"         "type"        "under"       "understand"  "union"       "unit"        "unite"      
## [890] "university"  "unless"      "until"       "upon"        "use"         "usual"       "value"      
## [897] "various"     "very"        "video"       "view"        "village"     "visit"       "vote"       
## [904] "wage"        "wait"        "walk"        "wall"        "want"        "war"         "warm"       
## [911] "wash"        "waste"       "watch"       "water"       "way"         "wear"        "wednesday"  
## [918] "wee"         "week"        "weigh"       "welcome"     "well"        "west"        "what"       
## [925] "when"        "where"       "whether"     "which"       "while"       "white"       "who"        
## [932] "whole"       "why"         "wide"        "wife"        "will"        "win"         "wind"       
## [939] "window"      "wish"        "with"        "within"      "without"     "woman"       "wonder"     
## [946] "wood"        "word"        "work"        "world"       "worry"       "worse"       "worth"      
## [953] "would"       "write"       "wrong"       "year"        "yes"         "yesterday"   "yet"        
## [960] "you"         "young"
```

``` r
# Matches words consisting of two to four characters
str_subset(words, "^.{2,4}$")
```

```
##   [1] "able" "act"  "add"  "age"  "ago"  "air"  "all"  "also" "and"  "any"  "area" "arm"  "art"  "as"   "ask" 
##  [16] "at"   "away" "baby" "back" "bad"  "bag"  "ball" "bank" "bar"  "base" "be"   "bear" "beat" "bed"  "best"
##  [31] "bet"  "big"  "bill" "bit"  "blow" "blue" "boat" "body" "book" "both" "box"  "boy"  "bus"  "busy" "but" 
##  [46] "buy"  "by"   "cake" "call" "can"  "car"  "card" "care" "case" "cat"  "cent" "chap" "city" "club" "cold"
##  [61] "come" "cook" "copy" "cost" "cup"  "cut"  "dad"  "date" "day"  "dead" "deal" "dear" "deep" "die"  "do"  
##  [76] "dog"  "door" "down" "draw" "drop" "dry"  "due"  "each" "east" "easy" "eat"  "egg"  "else" "end"  "even"
##  [91] "ever" "eye"  "face" "fact" "fair" "fall" "far"  "farm" "fast" "feed" "feel" "few"  "file" "fill" "film"
## [106] "find" "fine" "fire" "fish" "fit"  "five" "flat" "fly"  "food" "foot" "for"  "form" "four" "free" "from"
## [121] "full" "fun"  "fund" "game" "gas"  "get"  "girl" "give" "go"   "god"  "good" "grow" "guy"  "hair" "half"
## [136] "hall" "hand" "hang" "hard" "hate" "have" "he"   "head" "hear" "heat" "hell" "help" "here" "high" "hit" 
## [151] "hold" "home" "hope" "hot"  "hour" "how"  "idea" "if"   "in"   "into" "it"   "item" "job"  "join" "jump"
## [166] "just" "keep" "key"  "kid"  "kill" "kind" "king" "know" "lad"  "lady" "land" "last" "late" "law"  "lay" 
## [181] "lead" "left" "leg"  "less" "let"  "lie"  "life" "like" "line" "link" "list" "live" "load" "lock" "long"
## [196] "look" "lord" "lose" "lot"  "love" "low"  "luck" "main" "make" "man"  "many" "mark" "may"  "mean" "meet"
## [211] "mile" "milk" "mind" "miss" "more" "most" "move" "mrs"  "much" "must" "name" "near" "need" "new"  "news"
## [226] "next" "nice" "nine" "no"   "non"  "none" "not"  "note" "now"  "odd"  "of"   "off"  "okay" "old"  "on"  
## [241] "once" "one"  "only" "open" "or"   "out"  "over" "own"  "pack" "page" "pair" "park" "part" "pass" "past"
## [256] "pay"  "per"  "pick" "plan" "play" "plus" "poor" "post" "pull" "push" "put"  "quid" "rail" "rate" "read"
## [271] "real" "red"  "rest" "rid"  "ring" "rise" "road" "role" "roll" "room" "rule" "run"  "safe" "sale" "same"
## [286] "save" "say"  "seat" "see"  "seem" "self" "sell" "send" "set"  "sex"  "she"  "shoe" "shop" "show" "shut"
## [301] "sick" "side" "sign" "sing" "sir"  "sit"  "site" "six"  "size" "slow" "so"   "some" "son"  "soon" "sort"
## [316] "stay" "step" "stop" "such" "suit" "sun"  "sure" "take" "talk" "tape" "tax"  "tea"  "team" "tell" "ten" 
## [331] "tend" "term" "test" "than" "the"  "then" "they" "this" "thou" "tie"  "time" "to"   "too"  "top"  "town"
## [346] "tree" "true" "try"  "turn" "two"  "type" "unit" "up"   "upon" "use"  "very" "view" "vote" "wage" "wait"
## [361] "walk" "wall" "want" "war"  "warm" "wash" "way"  "we"   "wear" "wee"  "week" "well" "west" "what" "when"
## [376] "who"  "why"  "wide" "wife" "will" "win"  "wind" "wish" "with" "wood" "word" "work" "year" "yes"  "yet" 
## [391] "you"
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
##   [1] "act" "add" "age" "ago" "air" "all" "and" "any" "arm" "art" "ask" "bad" "bag" "bar" "bed" "bet" "big"
##  [18] "bit" "box" "boy" "bus" "but" "buy" "can" "car" "cat" "cup" "cut" "dad" "day" "die" "dog" "dry" "due"
##  [35] "eat" "egg" "end" "eye" "far" "few" "fit" "fly" "for" "fun" "gas" "get" "god" "guy" "hit" "hot" "how"
##  [52] "job" "key" "kid" "lad" "law" "lay" "leg" "let" "lie" "lot" "low" "man" "may" "mrs" "new" "non" "not"
##  [69] "now" "odd" "off" "old" "one" "out" "own" "pay" "per" "put" "red" "rid" "run" "say" "see" "set" "sex"
##  [86] "she" "sir" "sit" "six" "son" "sun" "tax" "tea" "ten" "the" "tie" "too" "top" "try" "two" "use" "war"
## [103] "way" "wee" "who" "why" "win" "yes" "yet" "you"
```

``` r
str_subset(words, "^...$")
```

```
##   [1] "act" "add" "age" "ago" "air" "all" "and" "any" "arm" "art" "ask" "bad" "bag" "bar" "bed" "bet" "big"
##  [18] "bit" "box" "boy" "bus" "but" "buy" "can" "car" "cat" "cup" "cut" "dad" "day" "die" "dog" "dry" "due"
##  [35] "eat" "egg" "end" "eye" "far" "few" "fit" "fly" "for" "fun" "gas" "get" "god" "guy" "hit" "hot" "how"
##  [52] "job" "key" "kid" "lad" "law" "lay" "leg" "let" "lie" "lot" "low" "man" "may" "mrs" "new" "non" "not"
##  [69] "now" "odd" "off" "old" "one" "out" "own" "pay" "per" "put" "red" "rid" "run" "say" "see" "set" "sex"
##  [86] "she" "sir" "sit" "six" "son" "sun" "tax" "tea" "ten" "the" "tie" "too" "top" "try" "two" "use" "war"
## [103] "way" "wee" "who" "why" "win" "yes" "yet" "you"
```

## Practice: Searching Words with Seven or More Characters


``` r
str_subset(words, "^.{7}.*$")
```

```
##   [1] "absolute"    "account"     "achieve"     "address"     "advertise"   "afternoon"   "against"    
##   [8] "already"     "alright"     "although"    "america"     "another"     "apparent"    "appoint"    
##  [15] "approach"    "appropriate" "arrange"     "associate"   "authority"   "available"   "balance"    
##  [22] "because"     "believe"     "benefit"     "between"     "brilliant"   "britain"     "brother"    
##  [29] "business"    "certain"     "chairman"    "character"   "Christmas"   "colleague"   "collect"    
##  [36] "college"     "comment"     "committee"   "community"   "company"     "compare"     "complete"   
##  [43] "compute"     "concern"     "condition"   "consider"    "consult"     "contact"     "continue"   
##  [50] "contract"    "control"     "converse"    "correct"     "council"     "country"     "current"    
##  [57] "decision"    "definite"    "department"  "describe"    "develop"     "difference"  "difficult"  
##  [64] "discuss"     "district"    "document"    "economy"     "educate"     "electric"    "encourage"  
##  [71] "english"     "environment" "especial"    "evening"     "evidence"    "example"     "exercise"   
##  [78] "expense"     "experience"  "explain"     "express"     "finance"     "fortune"     "forward"    
##  [85] "function"    "further"     "general"     "germany"     "goodbye"     "history"     "holiday"    
##  [92] "hospital"    "however"     "hundred"     "husband"     "identify"    "imagine"     "important"  
##  [99] "improve"     "include"     "increase"    "individual"  "industry"    "instead"     "interest"   
## [106] "introduce"   "involve"     "kitchen"     "language"    "machine"     "meaning"     "measure"    
## [113] "mention"     "million"     "minister"    "morning"     "necessary"   "obvious"     "occasion"   
## [120] "operate"     "opportunity" "organize"    "original"    "otherwise"   "paragraph"   "particular" 
## [127] "pension"     "percent"     "perfect"     "perhaps"     "photograph"  "picture"     "politic"    
## [134] "position"    "positive"    "possible"    "practise"    "prepare"     "present"     "pressure"   
## [141] "presume"     "previous"    "private"     "probable"    "problem"     "proceed"     "process"    
## [148] "produce"     "product"     "programme"   "project"     "propose"     "protect"     "provide"    
## [155] "purpose"     "quality"     "quarter"     "question"    "realise"     "receive"     "recognize"  
## [162] "recommend"   "relation"    "remember"    "represent"   "require"     "research"    "resource"   
## [169] "respect"     "responsible" "saturday"    "science"     "scotland"    "secretary"   "section"    
## [176] "separate"    "serious"     "service"     "similar"     "situate"     "society"     "special"    
## [183] "specific"    "standard"    "station"     "straight"    "strategy"    "structure"   "student"    
## [190] "subject"     "succeed"     "suggest"     "support"     "suppose"     "surprise"    "telephone"  
## [197] "television"  "terrible"    "therefore"   "thirteen"    "thousand"    "through"     "thursday"   
## [204] "together"    "tomorrow"    "tonight"     "traffic"     "transport"   "trouble"     "tuesday"    
## [211] "understand"  "university"  "various"     "village"     "wednesday"   "welcome"     "whether"    
## [218] "without"     "yesterday"
```

``` r
str_subset(words, "^.{7,}$")
```

```
##   [1] "absolute"    "account"     "achieve"     "address"     "advertise"   "afternoon"   "against"    
##   [8] "already"     "alright"     "although"    "america"     "another"     "apparent"    "appoint"    
##  [15] "approach"    "appropriate" "arrange"     "associate"   "authority"   "available"   "balance"    
##  [22] "because"     "believe"     "benefit"     "between"     "brilliant"   "britain"     "brother"    
##  [29] "business"    "certain"     "chairman"    "character"   "Christmas"   "colleague"   "collect"    
##  [36] "college"     "comment"     "committee"   "community"   "company"     "compare"     "complete"   
##  [43] "compute"     "concern"     "condition"   "consider"    "consult"     "contact"     "continue"   
##  [50] "contract"    "control"     "converse"    "correct"     "council"     "country"     "current"    
##  [57] "decision"    "definite"    "department"  "describe"    "develop"     "difference"  "difficult"  
##  [64] "discuss"     "district"    "document"    "economy"     "educate"     "electric"    "encourage"  
##  [71] "english"     "environment" "especial"    "evening"     "evidence"    "example"     "exercise"   
##  [78] "expense"     "experience"  "explain"     "express"     "finance"     "fortune"     "forward"    
##  [85] "function"    "further"     "general"     "germany"     "goodbye"     "history"     "holiday"    
##  [92] "hospital"    "however"     "hundred"     "husband"     "identify"    "imagine"     "important"  
##  [99] "improve"     "include"     "increase"    "individual"  "industry"    "instead"     "interest"   
## [106] "introduce"   "involve"     "kitchen"     "language"    "machine"     "meaning"     "measure"    
## [113] "mention"     "million"     "minister"    "morning"     "necessary"   "obvious"     "occasion"   
## [120] "operate"     "opportunity" "organize"    "original"    "otherwise"   "paragraph"   "particular" 
## [127] "pension"     "percent"     "perfect"     "perhaps"     "photograph"  "picture"     "politic"    
## [134] "position"    "positive"    "possible"    "practise"    "prepare"     "present"     "pressure"   
## [141] "presume"     "previous"    "private"     "probable"    "problem"     "proceed"     "process"    
## [148] "produce"     "product"     "programme"   "project"     "propose"     "protect"     "provide"    
## [155] "purpose"     "quality"     "quarter"     "question"    "realise"     "receive"     "recognize"  
## [162] "recommend"   "relation"    "remember"    "represent"   "require"     "research"    "resource"   
## [169] "respect"     "responsible" "saturday"    "science"     "scotland"    "secretary"   "section"    
## [176] "separate"    "serious"     "service"     "similar"     "situate"     "society"     "special"    
## [183] "specific"    "standard"    "station"     "straight"    "strategy"    "structure"   "student"    
## [190] "subject"     "succeed"     "suggest"     "support"     "suppose"     "surprise"    "telephone"  
## [197] "television"  "terrible"    "therefore"   "thirteen"    "thousand"    "through"     "thursday"   
## [204] "together"    "tomorrow"    "tonight"     "traffic"     "transport"   "trouble"     "tuesday"    
## [211] "understand"  "university"  "various"     "village"     "wednesday"   "welcome"     "whether"    
## [218] "without"     "yesterday"
```

``` r
str_subset(words, "^.......")
```

```
##   [1] "absolute"    "account"     "achieve"     "address"     "advertise"   "afternoon"   "against"    
##   [8] "already"     "alright"     "although"    "america"     "another"     "apparent"    "appoint"    
##  [15] "approach"    "appropriate" "arrange"     "associate"   "authority"   "available"   "balance"    
##  [22] "because"     "believe"     "benefit"     "between"     "brilliant"   "britain"     "brother"    
##  [29] "business"    "certain"     "chairman"    "character"   "Christmas"   "colleague"   "collect"    
##  [36] "college"     "comment"     "committee"   "community"   "company"     "compare"     "complete"   
##  [43] "compute"     "concern"     "condition"   "consider"    "consult"     "contact"     "continue"   
##  [50] "contract"    "control"     "converse"    "correct"     "council"     "country"     "current"    
##  [57] "decision"    "definite"    "department"  "describe"    "develop"     "difference"  "difficult"  
##  [64] "discuss"     "district"    "document"    "economy"     "educate"     "electric"    "encourage"  
##  [71] "english"     "environment" "especial"    "evening"     "evidence"    "example"     "exercise"   
##  [78] "expense"     "experience"  "explain"     "express"     "finance"     "fortune"     "forward"    
##  [85] "function"    "further"     "general"     "germany"     "goodbye"     "history"     "holiday"    
##  [92] "hospital"    "however"     "hundred"     "husband"     "identify"    "imagine"     "important"  
##  [99] "improve"     "include"     "increase"    "individual"  "industry"    "instead"     "interest"   
## [106] "introduce"   "involve"     "kitchen"     "language"    "machine"     "meaning"     "measure"    
## [113] "mention"     "million"     "minister"    "morning"     "necessary"   "obvious"     "occasion"   
## [120] "operate"     "opportunity" "organize"    "original"    "otherwise"   "paragraph"   "particular" 
## [127] "pension"     "percent"     "perfect"     "perhaps"     "photograph"  "picture"     "politic"    
## [134] "position"    "positive"    "possible"    "practise"    "prepare"     "present"     "pressure"   
## [141] "presume"     "previous"    "private"     "probable"    "problem"     "proceed"     "process"    
## [148] "produce"     "product"     "programme"   "project"     "propose"     "protect"     "provide"    
## [155] "purpose"     "quality"     "quarter"     "question"    "realise"     "receive"     "recognize"  
## [162] "recommend"   "relation"    "remember"    "represent"   "require"     "research"    "resource"   
## [169] "respect"     "responsible" "saturday"    "science"     "scotland"    "secretary"   "section"    
## [176] "separate"    "serious"     "service"     "similar"     "situate"     "society"     "special"    
## [183] "specific"    "standard"    "station"     "straight"    "strategy"    "structure"   "student"    
## [190] "subject"     "succeed"     "suggest"     "support"     "suppose"     "surprise"    "telephone"  
## [197] "television"  "terrible"    "therefore"   "thirteen"    "thousand"    "through"     "thursday"   
## [204] "together"    "tomorrow"    "tonight"     "traffic"     "transport"   "trouble"     "tuesday"    
## [211] "understand"  "university"  "various"     "village"     "wednesday"   "welcome"     "whether"    
## [218] "without"     "yesterday"
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
##   [1] "able"     "about"    "absolute" "accept"   "account"  "achieve"  "across"   "act"      "active"  
##  [10] "actual"   "add"      "address"  "admit"    "affect"   "afford"   "after"    "again"    "against" 
##  [19] "age"      "agent"    "ago"      "agree"    "air"      "all"      "allow"    "almost"   "along"   
##  [28] "already"  "alright"  "also"     "although" "always"   "america"  "amount"   "and"      "another" 
##  [37] "answer"   "any"      "apart"    "apparent" "appear"   "apply"    "appoint"  "approach" "area"    
##  [46] "argue"    "arm"      "around"   "arrange"  "art"      "as"       "ask"      "assume"   "at"      
##  [55] "attend"   "aware"    "away"     "awful"    "baby"     "back"     "bad"      "bag"      "balance" 
##  [64] "ball"     "bank"     "bar"      "base"     "basis"    "be"       "bear"     "beat"     "beauty"  
##  [73] "because"  "become"   "bed"      "before"   "begin"    "behind"   "believe"  "benefit"  "best"    
##  [82] "bet"      "between"  "big"      "bill"     "birth"    "bit"      "black"    "bloke"    "blood"   
##  [91] "blow"     "blue"     "board"    "boat"     "body"     "book"     "both"     "bother"   "bottle"  
## [100] "bottom"   "box"      "boy"      "break"    "brief"    "bring"    "britain"  "brother"  "budget"  
## [109] "build"    "bus"      "business" "busy"     "but"      "buy"      "by"       "cake"     "call"    
## [118] "can"      "car"      "card"     "care"     "carry"    "case"     "cat"      "catch"    "cause"   
## [127] "cent"     "centre"   "certain"  "chair"    "chairman" "chance"   "change"   "chap"     "charge"  
## [136] "cheap"    "check"    "child"    "choice"   "choose"   "Christ"   "church"   "city"     "claim"   
## [145] "class"    "clean"    "clear"    "client"   "clock"    "close"    "closes"   "clothe"   "club"    
## [154] "coffee"   "cold"     "collect"  "college"  "colour"   "come"     "comment"  "commit"   "common"  
## [163] "company"  "compare"  "complete" "compute"  "concern"  "confer"   "consider" "consult"  "contact" 
## [172] "continue" "contract" "control"  "converse" "cook"     "copy"     "corner"   "correct"  "cost"    
## [181] "could"    "council"  "count"    "country"  "county"   "couple"   "course"   "court"    "cover"   
## [190] "create"   "cross"    "cup"      "current"  "cut"      "dad"      "danger"   "date"     "day"     
## [199] "dead"     "deal"     "dear"     "debate"   "decide"   "decision" "deep"     "definite" "degree"  
## [208] "depend"   "describe" "design"   "detail"   "develop"  "die"      "dinner"   "direct"   "discuss" 
## [217] "district" "divide"   "do"       "doctor"   "document" "dog"      "door"     "double"   "doubt"   
## [226] "down"     "draw"     "dress"    "drink"    "drive"    "drop"     "dry"      "due"      "during"  
## [235] "each"     "early"    "east"     "easy"     "eat"      "economy"  "educate"  "effect"   "egg"     
## [244] "eight"    "either"   "elect"    "electric" "eleven"   "else"     "employ"   "end"      "engine"  
## [253] "english"  "enjoy"    "enough"   "enter"    "equal"    "especial" "europe"   "even"     "evening" 
## [262] "ever"     "every"    "evidence" "exact"    "example"  "except"   "excuse"   "exercise" "exist"   
## [271] "expect"   "expense"  "explain"  "express"  "extra"    "eye"      "face"     "fact"     "fair"    
## [280] "fall"     "family"   "far"      "farm"     "fast"     "father"   "favour"   "feed"     "feel"    
## [289] "few"      "field"    "fight"    "figure"   "file"     "fill"     "film"     "final"    "finance" 
## [298] "find"     "fine"     "finish"   "fire"     "first"    "fish"     "fit"      "five"     "flat"    
## [307] "floor"    "fly"      "follow"   "food"     "foot"     "for"      "force"    "forget"   "form"    
## [316] "fortune"  "forward"  "four"     "france"   "free"     "friday"   "friend"   "from"     "front"   
## [325] "full"     "fun"      "function" "fund"     "further"  "future"   "game"     "garden"   "gas"     
## [334] "general"  "germany"  "get"      "girl"     "give"     "glass"    "go"       "god"      "good"    
## [343] "goodbye"  "govern"   "grand"    "grant"    "great"    "green"    "ground"   "group"    "grow"    
## [352] "guess"    "guy"      "hair"     "half"     "hall"     "hand"     "hang"     "happen"   "happy"   
## [361] "hard"     "hate"     "have"     "he"       "head"     "health"   "hear"     "heart"    "heat"    
## [370] "heavy"    "hell"     "help"     "here"     "high"     "history"  "hit"      "hold"     "holiday" 
## [379] "home"     "honest"   "hope"     "horse"    "hospital" "hot"      "hour"     "house"    "how"     
## [388] "however"  "hullo"    "hundred"  "husband"  "idea"     "identify" "if"       "imagine"  "improve" 
## [397] "in"       "include"  "income"   "increase" "indeed"   "industry" "inform"   "inside"   "instead" 
## [406] "insure"   "interest" "into"     "invest"   "involve"  "issue"    "it"       "item"     "jesus"   
## [415] "job"      "join"     "judge"    "jump"     "just"     "keep"     "key"      "kid"      "kill"    
## [424] "kind"     "king"     "kitchen"  "knock"    "know"     "labour"   "lad"      "lady"     "land"    
## [433] "language" "large"    "last"     "late"     "laugh"    "law"      "lay"      "lead"     "learn"   
## [442] "leave"    "left"     "leg"      "less"     "let"      "letter"   "level"    "lie"      "life"    
## [451] "light"    "like"     "likely"   "limit"    "line"     "link"     "list"     "listen"   "little"  
## [460] "live"     "load"     "local"    "lock"     "london"   "long"     "look"     "lord"     "lose"    
## [469] "lot"      "love"     "low"      "luck"     "lunch"    "machine"  "main"     "major"    "make"    
## [478] "man"      "manage"   "many"     "mark"     "market"   "marry"    "match"    "matter"   "may"     
## [487] "maybe"    "mean"     "meaning"  "measure"  "meet"     "member"   "mention"  "middle"   "might"   
## [496] "mile"     "milk"     "million"  "mind"     "minister" "minus"    "minute"   "miss"     "mister"  
## [505] "moment"   "monday"   "money"    "month"    "more"     "morning"  "most"     "mother"   "motion"  
## [514] "move"     "mrs"      "much"     "music"    "must"     "name"     "nation"   "nature"   "near"    
## [523] "need"     "never"    "new"      "news"     "next"     "nice"     "night"    "nine"     "no"      
## [532] "non"      "none"     "normal"   "north"    "not"      "note"     "notice"   "now"      "number"  
## [541] "obvious"  "occasion" "odd"      "of"       "off"      "offer"    "office"   "often"    "okay"    
## [550] "old"      "on"       "once"     "one"      "only"     "open"     "operate"  "oppose"   "or"      
## [559] "order"    "organize" "original" "other"    "ought"    "out"      "over"     "own"      "pack"    
## [568] "page"     "paint"    "pair"     "paper"    "pardon"   "parent"   "park"     "part"     "party"   
## [577] "pass"     "past"     "pay"      "pence"    "pension"  "people"   "per"      "percent"  "perfect" 
## [586] "perhaps"  "period"   "person"   "pick"     "picture"  "piece"    "place"    "plan"     "play"    
## [595] "please"   "plus"     "point"    "police"   "policy"   "politic"  "poor"     "position" "positive"
## [604] "possible" "post"     "pound"    "power"    "practise" "prepare"  "present"  "press"    "pressure"
## [613] "presume"  "pretty"   "previous" "price"    "print"    "private"  "probable" "problem"  "proceed" 
## [622] "process"  "produce"  "product"  "project"  "proper"   "propose"  "protect"  "provide"  "public"  
## [631] "pull"     "purpose"  "push"     "put"      "quality"  "quarter"  "question" "quick"    "quid"    
## [640] "quiet"    "quite"    "radio"    "rail"     "raise"    "range"    "rate"     "rather"   "read"    
## [649] "ready"    "real"     "realise"  "really"   "reason"   "receive"  "recent"   "reckon"   "record"  
## [658] "red"      "reduce"   "refer"    "regard"   "region"   "relation" "remember" "report"   "require" 
## [667] "research" "resource" "respect"  "rest"     "result"   "return"   "rid"      "right"    "ring"    
## [676] "rise"     "road"     "role"     "roll"     "room"     "round"    "rule"     "run"      "safe"    
## [685] "sale"     "same"     "saturday" "save"     "say"      "scheme"   "school"   "science"  "score"   
## [694] "scotland" "seat"     "second"   "section"  "secure"   "see"      "seem"     "self"     "sell"    
## [703] "send"     "sense"    "separate" "serious"  "serve"    "service"  "set"      "settle"   "seven"   
## [712] "sex"      "shall"    "share"    "she"      "sheet"    "shoe"     "shoot"    "shop"     "short"   
## [721] "should"   "show"     "shut"     "sick"     "side"     "sign"     "similar"  "simple"   "since"   
## [730] "sing"     "single"   "sir"      "sister"   "sit"      "site"     "situate"  "six"      "size"    
## [739] "sleep"    "slight"   "slow"     "small"    "smoke"    "so"       "social"   "society"  "some"    
## [748] "son"      "soon"     "sorry"    "sort"     "sound"    "south"    "space"    "speak"    "special" 
## [757] "specific" "speed"    "spell"    "spend"    "square"   "staff"    "stage"    "stairs"   "stand"   
## [766] "standard" "start"    "state"    "station"  "stay"     "step"     "stick"    "still"    "stop"    
## [775] "story"    "straight" "strategy" "street"   "strike"   "strong"   "student"  "study"    "stuff"   
## [784] "stupid"   "subject"  "succeed"  "such"     "sudden"   "suggest"  "suit"     "summer"   "sun"     
## [793] "sunday"   "supply"   "support"  "suppose"  "sure"     "surprise" "switch"   "system"   "table"   
## [802] "take"     "talk"     "tape"     "tax"      "tea"      "teach"    "team"     "tell"     "ten"     
## [811] "tend"     "term"     "terrible" "test"     "than"     "thank"    "the"      "then"     "there"   
## [820] "they"     "thing"    "think"    "thirteen" "thirty"   "this"     "thou"     "though"   "thousand"
## [829] "three"    "through"  "throw"    "thursday" "tie"      "time"     "to"       "today"    "together"
## [838] "tomorrow" "tonight"  "too"      "top"      "total"    "touch"    "toward"   "town"     "trade"   
## [847] "traffic"  "train"    "travel"   "treat"    "tree"     "trouble"  "true"     "trust"    "try"     
## [856] "tuesday"  "turn"     "twelve"   "twenty"   "two"      "type"     "under"    "union"    "unit"    
## [865] "unite"    "unless"   "until"    "up"       "upon"     "use"      "usual"    "value"    "various" 
## [874] "very"     "video"    "view"     "village"  "visit"    "vote"     "wage"     "wait"     "walk"    
## [883] "wall"     "want"     "war"      "warm"     "wash"     "waste"    "watch"    "water"    "way"     
## [892] "we"       "wear"     "wee"      "week"     "weigh"    "welcome"  "well"     "west"     "what"    
## [901] "when"     "where"    "whether"  "which"    "while"    "white"    "who"      "whole"    "why"     
## [910] "wide"     "wife"     "will"     "win"      "wind"     "window"   "wish"     "with"     "within"  
## [919] "without"  "woman"    "wonder"   "wood"     "word"     "work"     "world"    "worry"    "worse"   
## [928] "worth"    "would"    "write"    "wrong"    "year"     "yes"      "yet"      "you"      "young"
```

