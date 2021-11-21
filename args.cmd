####################################################################################################
# Argument Parser
#
# Creates these variables:
# %argList: A pipe-delimited list of the names of the parameters
# %args.<argname>: The value of the <argName> argument
#
# EX: .someScript --from=foo bar --to=something else
# argList = from|to
# args.from = foo bar
# args.to = something else
#
####################################################################################################

# Check for valid parameter arguments.
if (!matchre("%0", "--\S+=")) then goto argsDone

gosub parseArgs
goto argsDone


###############################
###      parseArgs
###############################
parseArgs:
	var args %0
	echo .%scriptname %args
parseArgsCont:
    eval remainingArgLength length("%args")
	if (%remainingArgLength > 0) then {
	    gosub parseArgsLoop %args
	    goto parseArgsCont
	}
	return


###############################
###      parseArgsLoop
###############################
parseArgsLoop:
    var args $0
	if (matchre("%args", "(--(\S+)=(.*?))(-|$)")) then {
	    var argName $2
	    var args.%argName $3
	    eval args replacere("%args", "--%argName=%args.%argName", "")
	    if ("%argList" = "\%argList") then {
	        var argList %argName
	    } else {
	        var argList %argList|%argName
	    }
	}
	return


###############################
###      echoArgs
###############################
echoArgs:
	var argsIndex 0
	eval argsLength count("%argList", "|")
	echoArgLoop:
	    var thisArg %argList(%argsIndex)
	    echo args.%thisArg: %args.%thisArg
	    math argsIndex add 1
	    if (%argsIndex <= %argsLength) then goto echoArgLoop
	return



argsDone:
