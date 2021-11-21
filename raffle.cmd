include libmaster.cmd

var nextIsFinalPrize 0

action var mostRecentWinner $1; goto raffle.collectPrize when ^(\w+)'s name appears on the result board!$

action var nextIsFinalPrize 1; echo NEXT IS FINAL when The winning ticket number for the \*Grand\* prize is


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
		put put ticket on counter
		pause
	}
	if (%nextIsFinalPrize = 1) then {
		echo
		echo RAFFLE DONE, DUMPING TICKET
		echo
		pause 2
		echo put ticket in bucket
		put put ticket on counter
		gosub stow my ticket
		var nextIsFinalPrize 0
	}
	goto raffle.loop