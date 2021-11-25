###############################
###    Number Convert
###############################

###############################
###    VARIABLES
###############################
var num 0
var wordBig hundred|thousand
var wordTens twenty|thirty|forty|fifty|sixty|seventy|eighty|ninety|eighty
var wordOnes one|two|three|four|five|six|seven|eight|nine
var wordTeens ten|eleven|twelve|thirteen|fourteen|sixteen|seventeen|eighteen|nineteen


###############################
###    PARAMETERS
###############################
if_1 then {
    var varName %1
    var numWord $%varName
    goto convert
} else {
    put #echo >Log Debug [numConvert] Called without providing a parameter.  Usage:  .numConvert varName (Do not include the $.)
    exit
}


###############################
###    MAIN
###############################
convert:
    var str %numWord
    gosub replaceTeens
    gosub replaceOnes
    gosub replaceTens
    eval str replacere("%str", " thousand", "000 +")
    eval str replacere("%str", " hundred", "00 +")
    evalmath num (%str)
    put #var %varName %num
    put #echo >Debug Green [numConvert] Called with %varName = %numWord.  Result is %varName = $%varName.
    exit


###############################
###    UTILITY
###############################
replaceOnes:
    eval str replacere("%str", "-one", " + 1")
    eval str replacere("%str", "-two", " + 2")
    eval str replacere("%str", "-three", " + 3")
    eval str replacere("%str", "-four", " + 4")
    eval str replacere("%str", "-five", " + 5")
    eval str replacere("%str", "-six", " + 6")
    eval str replacere("%str", "-seven", " + 7")
    eval str replacere("%str", "-eight", " + 8")
    eval str replacere("%str", "-nine", " + 9")
    eval str replacere("%str", "one", " 1")
    eval str replacere("%str", "two", " 2")
    eval str replacere("%str", "three", " 3")
    eval str replacere("%str", "four", " 4")
    eval str replacere("%str", "five", " 5")
    eval str replacere("%str", "six", " 6")
    eval str replacere("%str", "seven", " 7")
    eval str replacere("%str", "eight", " 8")
    eval str replacere("%str", "nine", " 9")
    return


replaceTeens:
    eval str replacere("%str", "ten", " 10")
    eval str replacere("%str", "eleven", " 11")
    eval str replacere("%str", "twelve", " 12")
    eval str replacere("%str", "thirteen", " 13")
    eval str replacere("%str", "fourteen", " 14")
    eval str replacere("%str", "fifteen", " 15")
    eval str replacere("%str", "sixteen", " 16")
    eval str replacere("%str", "seventeen", " 17")
    eval str replacere("%str", "eighteen", " 18")
    eval str replacere("%str", "nineteen", " 19")
    return


replaceTens:
    eval str replacere("%str", "twenty", " 20")
    eval str replacere("%str", "thirty", " 30")
    eval str replacere("%str", "forty", " 40")
    eval str replacere("%str", "fifty", " 50")
    eval str replacere("%str", "sixty", " 60")
    eval str replacere("%str", "seventy", " 70")
    eval str replacere("%str", "eighty", " 80")
    eval str replacere("%str", "ninety", " 90")
    return
