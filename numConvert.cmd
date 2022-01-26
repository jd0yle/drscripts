###############################
###    Number Convert
###############################
# This script will accept a global variable OR a string of text and attempt to convert it from a string to an integer.
# If providing a global variable, the script will overwrite the variable provided with the integer result.
# If providing a string, the script will set the global variable numConvertResult equal to the integer result.
#
# It is suggested that you have a trigger set up to make the initial variable setting as well as the script call.
# Example Triggers:
#  #trigger {^You sense (.*) slivers from (Katamba|Xibar|Yavash) suitable for use in Telekinetic Throw orbiting your head\.$} {#var slivers $1; #send .numConvert slivers ; #echo >Log [Moonblade] Slivers - $slivers} {moonblade}
#  #trigger {^There are (.*) non-ammunition items inside your .*.$} {#var nonAmmo $1; #send .numConvert nonAmmo}
#  #trigger {^You count .* in .* and see there (is|are) (.*) left\.$} {#var ammoCount $2; #send .numConvert ammoCount}
#  #trigger {^You count .* bolt(s)? in .* and see there (is|are) (.*) left\.$} {#var boltCount $3; #send .numConvert boltCount}
#
# Usage:  .scriptName variableName
#    ie:  .numConvert ammo
#         .scriptName textToConvert
#         .numConvert thirty-two
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
    if ((matchre("%1", "^\d+$")) || (matchre("$%1", "^\d+$"))) then {
        echo [numConvert] Detected integer provided.  Exiting.
        exit
    }
    if (contains("$%1", "$")) then {
        echo [numConvert] Detected non-variable provided.  Returning results in \\$numConvertResult.
        var varName numConvertResult
        var numWord %0
        # Initialize numConvertResult.
        if (!($numConvertResult > 0)) then {
            put #var numConvertResult 0
        }
    } else {
        var varName %1
        var numWord $%varName
    }
    goto convert-main
} else {
    goto convert-error
}


###############################
###    MAIN
###############################
convert-main:
    var str %numWord
    gosub convert-replaceTeens
    gosub convert-replaceOnes
    gosub convert-replaceTens
    eval str replacere("%str", " thousand", "000 +")
    eval str replacere("%str", " hundred", "00 +")
    evalmath num (%str)
    put #var %varName %num
    goto convert-exit


###############################
###    UTILITY
###############################
convert-error:
    put #echo >Log [numConvert] Called without providing a parameter.  Usage:  .numConvert varName or .numConvert stringToConvert.
    echo *********************
    echo Number Convert Error
    echo *********************
    echo You must call this script with a parameter of either a global variable such as ammoCount or with a string of text to convert.
    echo If providing a global variable, the script will overwrite the variable provided with the integer result.
    echo If providing a string, the script will set the global variable numConvertResult equal to the integer result.
    echo
    echo Examples:
    echo            .scriptName ammoCount
    echo            .scriptName thirty-two
    exit


convert-exit:
    pause .2
    echo [numConvert] \\$%varName = $%varName.
    # Parse added below for users calling this script from another or using triggers to capture the result.  Uncomment it if you prefer this method.
    # put #parse [numConvert] $%varName
    exit


convert-replaceOnes:
    eval str replacere("%str", "zero", " 0")
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


convert-replaceTeens:
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


convert-replaceTens:
    eval str replacere("%str", "twenty", " 20")
    eval str replacere("%str", "thirty", " 30")
    eval str replacere("%str", "forty", " 40")
    eval str replacere("%str", "fifty", " 50")
    eval str replacere("%str", "sixty", " 60")
    eval str replacere("%str", "seventy", " 70")
    eval str replacere("%str", "eighty", " 80")
    eval str replacere("%str", "ninety", " 90")
    return
