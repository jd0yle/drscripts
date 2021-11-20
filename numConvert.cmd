###############################
###    Number Convert
###############################

###############################
###    VARIABLES
###############################
var wordBig hundred|thousand
var wordTens twenty|thirty|forty|fifty|sixty|seventy|eighty|ninety|eighty
var wordOnes one|two|three|four|five|six|seven|eight|nine
var wordTeens ten|eleven|twelve|thirteen|fourteen|sixteen|seventeen|eighteen|nineteen


###############################
###    PARAMETERS
###############################
if_1 then {
    var varName %1
    var numWord %$1
    goto convert
} else {
    put #echo >Log Red [numConvert] Called without providing a parameter.  Usage:  .numConvert varName (Do not include the $.)
    exit
}


###############################
###    MAIN
###############################
convert:
    var str %numWord
    gosub replaceOnes
    gosub replaceTeens
    gosub replaceTens
    gosub replaceTeens
    replacere("%str", " thousand", "000 +")
    replacere("%str", " hundred", "00 +")
    evalmath num (%str)
    put #var $%varName %num
    put #echo >Log Green [numConvert] Called with %varName = %numWord.  Result is %varName = $varName.
    exit


###############################
###    UTILITY
###############################
replaceOnes:
    replacere("%str", "-one", "+ 1")
    replacere("%str", "-two", "+ 2")
    replacere("%str", "-three", "+ 3")
    replacere("%str", "-four", "+ 4")
    replacere("%str", "-five", "+ 5")
    replacere("%str", "-six", "+ 6")
    replacere("%str", "-seven", "+ 7")
    replacere("%str", "-eight", "+ 8")
    replacere("%str", "-nine", "+ 9")
    replacere("%str", "one", "1")
    replacere("%str", "two", "2")
    replacere("%str", "three", "3")
    replacere("%str", "four", "4")
    replacere("%str", "five", "5")
    replacere("%str", "six", "6")
    replacere("%str", "seven", "7")
    replacere("%str", "eight", "8")
    replacere("%str", "nine", "9")
    return


replaceTeens:
    replacere("%str", "ten", "10")
    replacere("%str", "eleven", "11")
    replacere("%str", "twelve", "12")
    replacere("%str", "thirteen", "13")
    replacere("%str", "fourteen", "14")
    replacere("%str", "fifteen", "15")
    replacere("%str", "sixteen", "16")
    replacere("%str", "seventeen", "17")
    replacere("%str", "eighteen", "18")
    replacere("%str", "nineteen", "19")
    return


replaceTens:
    replacere("%str", "twenty", "20")
    replacere("%str", "thirty", "30")
    replacere("%str", "forty", "40")
    replacere("%str", "fifty", "50")
    replacere("%str", "sixty", "60")
    replacere("%str", "seventy", "70")
    replacere("%str", "eighty", "80")
    replacere("%str", "ninety", "90")
    return