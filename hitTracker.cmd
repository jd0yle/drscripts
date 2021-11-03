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

var counts.misses 0
var counts.hits 0
var counts.hitSum 0


hitTracker.waitForHit:
	# There may be strings for missed attacks absent from this list!
	matchre hitTracker.parseHit ^(.*lands a.*)$
	matchre hitTracker.parseMiss You dodge|You parry|You slap away|You evade|You deflect|You beat off|You partially block
	matchwait


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
	} else {
		evalmath counts.misses (%counts.misses + 1)
	}

	gosub hitTracker.logStatus
	goto hitTracker.waitForHit


hitTracker.parseMiss:
	evalmath counts.misses (%counts.misses + 1)
	gosub hitTracker.logStatus
	goto hitTracker.waitForHit


hitTracker.logStatus:
	echo Misses: %counts.misses  Hits: %counts.hits  HitSum: %counts.hitSum
	return


hitTracker.logDebug:
	if (%debug = 1) then echo $0
	return
