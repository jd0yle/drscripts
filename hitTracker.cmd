####################################################################################################
# hitTracker.cmd
# Selesthiel - justin@jmdoyle.com
#
# Records and echoes a rolling record of combat misses, hits, and hit damage sums against the player
#
# USAGE
# .hitTracker
#
# ARGS
#   none
#
# EXAMPLES
# .hitTracker
####################################################################################################
var debug 0
var logToFile 1

var counts.misses 0
var counts.hits 0
var counts.hitSum 0


gosub hitTracker.init
goto hitTracker.waitForHit


###############################
###    hitTracker.init
###############################
hitTracker.init:
	gosub hitTracker.logToFile datetime,hitNumber,vitality,elapsedSeconds
	var index 0
	gosub hitTracker.init.loop
	timer start
	return


###############################
###    hitTracker.init.loop
###############################
hitTracker.init.loop:
		# Ensure %index is initialized...
	if (!(%index > -1)) then var index 0

	var counts.hitArray.%index 0
	evalmath index (%index + 1)
	if (%index > 23) then return
	goto hitTracker.init.loop



###############################
###    hitTracker.waitForHit
###############################
hitTracker.waitForHit:
	# There may be strings for missed attacks absent from this list!
	matchre hitTracker.parseHit ^(.*lands a.*)$
	matchre hitTracker.parseMiss You dodge|You parry|You slap away|You evade|You deflect|You beat off|You partially block
	matchwait



###############################
###    hitTracker.parseHit
###############################
hitTracker.parseHit:
	var hitString $0
	var hitNumber null

	if (!contains("%hitString", "to your")) then {
		gosub hitTracker.logDebug We hit them, ignoring hit
		goto hitTracker.waitForHit
	}

	if (contains("%hitString", "(a|an) (benign|brushing|gentle|glancing|grazing|harmless|ineffective|skimming) (blow|hit|strike)")) then var hitNumber 0
	if (contains("%hitString", "a light hit")) then var hitNumber 1
	if (contains("%hitString", "a good hit")) then var hitNumber 2
	if (contains("%hitString", "a good strike")) then var hitNumber 3
	if (contains("%hitString", "a solid hit")) then var hitNumber 4
	if (contains("%hitString", "a hard hit")) then var hitNumber 5
	if (contains("%hitString", "a strong hit")) then var hitNumber 6
	if (contains("%hitString", "a heavy strike")) then var hitNumber 7
	if (contains("%hitString", "a very heavy hit")) then var hitNumber 8
	if (contains("%hitString", "an extremely heavy hit")) then var hitNumber 9
	if (contains("%hitString", "a powerful strike")) then var hitNumber 10
	if (contains("%hitString", "a massive strike")) then var hitNumber 11
	if (contains("%hitString", "an awesome strike")) then var hitNumber 12
	if (contains("%hitString", "a vicious strike")) then var hitNumber 13
	if (contains("%hitString", "an earth-shaking strike")) then var hitNumber 14
	if (contains("%hitString", "a demolishing hit")) then var hitNumber 15
	if (contains("%hitString", "a spine-rattling strike")) then var hitNumber 16
	if (contains("%hitString", "a devastating hit(?! \(That'll leave a mark!\))")) then var hitNumber 17
	if (contains("%hitString", "a devastating hit \(That'll leave a mark!\)")) then var hitNumber 18
	if (contains("%hitString", "an overwhelming strike")) then var hitNumber 19
	if (contains("%hitString", "an obliterating hit")) then var hitNumber 20
	if (contains("%hitString", "an annihilating strike")) then var hitNumber 21
	if (contains("%hitString", "a cataclysmic strike")) then var hitNumber 22
	if (contains("%hitString", "an apocalyptic strike")) then var hitNumber 23

	gosub hitTracker.logDebug hitNumber is %hitNumber

	if ("%hitNumber" > -1) then {
		evalmath counts.hits (%counts.hits + 1)
		evalmath counts.hitSum (%counts.hitSum + %hitNumber)
		evalmath counts.hitArray.%hitNumber (%counts.hitArray.%hitNumber + 1)
		gosub logToFile %hitNumber
	} else {
		evalmath counts.misses (%counts.misses + 1)
		gosub logToFile -1
	}

	gosub hitTracker.logStatus
	goto hitTracker.waitForHit



###############################
###    hitTracker.parseMiss
###############################
hitTracker.parseMiss:
	evalmath counts.misses (%counts.misses + 1)
	gosub hitTracker.logStatus
	goto hitTracker.waitForHit



###############################
###    hitTracker.logDebug
###############################
hitTracker.logDebug:
	if (%debug = 1) then echo $0
	return



###############################
###    hitTracker.logToFile
###############################
hitTracker.logToFile:
	var hitNumber $0
	if (%hitTracker.logToFile = 1) then {
		if (!("%hitNumber" > -2)) then {
			put #log >hitTracker.csv %hitNumber
		} else {
			var elapsedSeconds %t
			put #log >hitTracker.csv $datetime,%hitNumber,$vitality,%elapsedSeconds
		}
	}
	return



###############################
###    hitTracker.logStatus
###############################
hitTracker.logStatus:
	echo Misses: %counts.misses  Hits: %counts.hits  HitSum: %counts.hitSum
	var msg Discrete Hits:
	var index 0
	gosub hitTracker.logStatus.loop
	echo %msg
	return

hitTracker.logStatus.loop:
	var msg %msg  %index: %counts.hitArray.%index
	evalmath index (%index + 1)
	if (%index > 23) then return
	goto hitTracker.logStatus.loop



