include libmaster.cmd

var nextIsFinalPrize 0

action var mostRecentWinner $1; goto raffle.collectPrize when ^(\w+)'s name appears on the result board!$
action var nextIsFinalPrize 1; echo NEXT IS FINAL when The winning ticket number for the \*Grand\* prize is

action put #play Just Arrived; put #echo ***;put #echo YOU WON A RAFFLE!;put #echo ***; when ^$charactername's name appears on the result board!


if ("$righthand" = "raffle ticket" || "$lefthand" = "raffle ticket") then gosub put my raffle ticket on counter

raffle.loop:
	pause 2
	pause 2
	goto raffle.loop


raffle.collectPrize:
	echo
	echo WINNER IS %mostRecentWinner
	echo
	if ("%mostRecentWinner" = "$charactername") then {
		echo
		echo YOU WON!
		echo
		gosub put my raffle ticket on counter
		pause
	}
	if (%nextIsFinalPrize = 1) then {
		echo
		echo RAFFLE DONE, DUMPING TICKET
		echo
		pause 2
		echo put ticket in bucket
		gosub put my raffle ticket on counter
		pause
		gosub put my raffle ticket in bucket
		gosub stow my ticket
		var nextIsFinalPrize 0
	}
	goto raffle.loop