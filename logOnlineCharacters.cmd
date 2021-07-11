####################################################################################################
# .logOnlineCharacters
# Selesthiel - Justin Doyle - justin@jmdoyle.com
# 2021/07/11
#
# Uses WHO FULL to check if specific characters are logged in.
# Logs those character names to "characterTracker.txt" with timestamps
#
# USAGE
# .logOnlineCharacters
#
####################################################################################################

###############################
###      CONFIG
###############################
	# Pipe (|) separated list of names to look for
var namesToCheck Navesi|Asherasa|Valuta|Sorhhn|Saragos|Selesthiel|Qizhmur|Izqhhrzu|Inauri|Khurnaarti|Xomfor|Venshen|Tadhiel

	# Minimum number of seconds to wait before allowing another check
var whoFullCooldownInterval 60



###############################
###      MAIN
###############################
	# Initialize the last check time var if undefined or invalid
if (!($lastLogOnlineCharactersGametime > -1)) then put #tvar lastLogOnlineCharactersGametime 0

	# Ensure enough time has passed since the last check, otherwise exit
evalmath tmp.nextLogOnlineCharactersGametime ($lastLogOnlineCharactersGametime + %whoFullCooldownInterval)
if (%tmp.nextLogOnlineCharactersGametime > $gametime) then goto logOnlineCharacters.done
unvar tmp.nextLogOnlineCharactersGametime

action if matchre("$1", "%namesToCheck") then put #log >characterTracker.txt [$datetime]:  $1; if matchre("$2", "%namesToCheck") then put #log >characterTracker.txt [$datetime]:  $2; if matchre("$3", "%namesToCheck") then put #log >characterTracker.txt [$datetime]:  $3;if matchre("$4", "%namesToCheck") then put #log >characterTracker.txt [$datetime]:  $4 when ^([a-zA-Z]+)\W+([a-zA-Z]+)\W+([a-zA-Z]+)\W+([a-zA-Z]+)$

	# Matchwait instead of waitforre so that it will timeout if the match string is never found
matchre logOnlineCharacters.done ^Staff On Duty|^You cannot do that again yet
put who full
put #tvar lastLogOnlineCharactersGametime $gametime
matchwait 30



###############################
###  logOnlineCharacters.done
###############################
logOnlineCharacters.done:
	pause 2
	put #parse LOGONLINECHARACTERS DONE
	exit