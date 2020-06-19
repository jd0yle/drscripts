include libsel.cmd

var ignoreScribing 0
if ("%1" = "noscribe") then {
    var ignoreScribing 1
}

#debug 3

####### CONFIG #######
var burin silversteel burin
######################

var sigilsToIgnore abolition|congruence|permutation|clarification|decay|integration|metamorphosis|nurture|evolution|rarefaction

var primary abolition|congruence|induction|permutation|rarefaction
var secondary antipode|ascension|clarification|decay|evolution|integration|metamorphosis|nurture|paradox|unity

var startRoomId $roomid
var endRoomId 261
var currentRoomId 0

if "$guild" = "Moon Mage" then var doBuffArt 1

var sigilType null
var isRoomEmpty 0
var improveTypes null
var doImprove 0
var doScribe 0
var alreadyImproving 0

var reIndexSigils 1

action var isRoomEmpty 1; echo isRoomEmpty: %isRoomEmpty when ^Having recently been searched
action var isRoomEmpty 1; echo isRoomEmpty: %isRoomEmpty when ^You lose track of your surroundings.


action var sigilType $1; echo FOUND A %sigilType;put #log >sigils.txt $zoneid $roomid $Time.season %sigilType when ^In your mind's eye you see the definition of an? (\S+) sigil before you.
action var sigilType $1; echo FOUND A %sigilType;put #log >sigils.txt $zoneid $roomid $Time.season %sigilType when ^After much scrutiny you are certain an? (\S+) sigil has revealed itself.
action var sigilType $1; echo FOUND A %sigilType;put #log >sigils.txt $zoneid $roomid $Time.season %sigilType when ^Though the seemingly mundane lighting you focus intently on a lurking (\S+) sigil.
action var sigilType $1; echo FOUND A %sigilType;put #log >sigils.txt $zoneid $roomid $Time.season %sigilType when ^Sorting through the imagery, you find the designs of .* (\S+) sigil\.$
action var sigilType $1; echo FOUND A %sigilType;put #log >sigils.txt $zoneid $roomid $Time.season %sigilType when ^You recall having already identified the (\S+) (secondary|primary) sigil
action var sigilType $1; echo FOUND A %sigilType;put #log >sigils.txt $zoneid $roomid $Time.season %sigilType when ^Almost obscured by the surround, you make out the details of an? (\S+) sigil.
action var sigilType $1; echo FOUND A %sigilType;put #log >sigils.txt $zoneid $roomid $Time.season %sigilType when ^Subtleties in the surroundings reveal themselves as the origins of an? (\S+) sigil.



action var doImprove 1; echo doImprove: %doImprove when ^You are already working to improve

action var improveTypes $4; echo Improve %improveTypes when ^\.\.\.a (\S+), (\S+) (\S+) (\S+) (to|for)
                                #...a difficult, focus disrupting FORM for enhancing the sigil quality.
                                #...a difficult, resolve taxing EFFORT for recovering your focus.

action var doScribe 1; echo doScribe: %doScribe when ^You are unable to perceive any opportunities for improving the sigil.



#########################
# USE ZONEID TO FIND MAP FOR LOGGING
#########################



testing:
    #pause 2
    #goto testing

loop:
    if (%currentRoomId = 0) then {
        var currentRoomId %startRoomId
    } else {
        math currentRoomId add 1
    }

    if $SpellTimer.ArtificersEye.duration < 5 then {
        put .cast art
        waitforre ^CAST DONE
    }

    #gosub percSigil
    #goto done

    #if %currentRoomId > %endRoomId then exit
    var sigilType null
    var isRoomEmpty 0
    var improveTypes null
    var doImprove 0
    var doScribe 0


    if ($roomid != %currentRoomId) then {
        put #walk %currentRoomId
        waitfor YOU HAVE ARRIVED
    }
    if (%reIndexSigils = 1 && %ignoreScribing != 1) then {
        put .findSigil store
        waitforre ^FINDSIGIL DONE
        put .findSigil list
        waitforre ^FINDSIGIL DONE
        var reIndexSigils 0
    }
    gosub roomLoop
    goto loop



roomLoop:
    if (%isRoomEmpty = 1) then return

    if (%ignoreScribing = 1) then {
        gosub perc sigil
        if ("%sigilType" != "null") then {
            #put #log >sigils.txt $zoneid $roomid $Time.season %sigilType
            if (contains("%secondary", "%sigilType")) then return
            var sigilType null
            var improveTypes null
            var doImprove 0
            var doScribe 0
        }
        goto roomLoop
    }

    if ($sigilCounts.%sigilType > 10) then {
        #put #log >sigils.txt $zoneid $roomid $Time.season %sigilType
        var doReturn 1
        if (contains("%primary", "%sigilType")) then var doReturn 0
        var sigilType null
        var improveTypes null
        var doImprove 0
        var doScribe 0
        if (%doReturn = 1) then {
            return
        } else {
            gosub perc sigil
        }
    }
    if (%doScribe = 1) then {
            var reIndexSigils 1
            #put #log >sigils.txt $zoneid $roomid $Time.season %sigilType
            gosub scribeSigil
            goto roomLoop
    }
    if ("%sigilType" = "null" && %doImprove != 1) then {
        var doImprove 0
        gosub perc sigil
    } else {
        if ("%improveTypes" = "null") then {
            if (%alreadyImproving = 1) then {
                gosub scribeSigil
                var isRoomEmpty 1
                goto roomLoop
            } else {
                gosub perc sigil improve
            }
        } else {
            var improveType %improveTypes
            var improveTypes null
            gosub perc sigil %improveType

        }
    }
    goto roomLoop


percSigil:
    #var location percSigil
    #matchre improve ^Sorting through the imagery, you find the designs of an almost imperceptible (\S+) sigil.
    #matchre improve ^Almost obscured by the surround, you make out the details of a (\S+) sigil.
    #matchre improve ^You have perceived a|an \S+ (\S+) sigil
    #matchre improve ^In your mind's eye you see the definition of an? (\S+) sigil before you.
    #matchre improve ^You are already working to improve the sigil discovered here.
    #matchre improve ^You recall having already
    #matchre imprive ^After much scrutiny you are certain an? \S+ sigil has revealed itself.
    #matchre percSigil ^You scour the area
    #matchre percSigil ^Back and forth you walk
    #matchre percSigil ^You clear your mind
    #matchre percSigil ^Whorls of dust
    #matchre percSigil ^You close your eyes
    #matchre percSigil ^The sky holds your interest
    #matchre percSigil ^Roundtime
    #matchre loop ^Having recently been searched
    #put perc sigil
    #goto retry



improve:
    var sigilType $1
    improve1:
    var location improve1
    matchre done ^You lose track of your surroundings.
    matchre percImproveType ^\..*(PROCESS|TECHNIQUE|APPROACH|EFFORT|TASK|RITUAL|ACTION|METHOD|FORM)
    match scribeSigil Roundtime
    put perc sigil improve
    goto retry

    #matchwait


percImproveType:
    var type $1

    var improveTypeTemp $4
    var improveType none
    percImproveType1:
    var location percImproveType1
    matchre done ^You lose track of your surroundings.
    matchre percImproveType ^\..*(PROCESS|TECHNIQUE|APPROACH|EFFORT|TASK|RITUAL|ACTION|METHOD|FORM)
    matchre improve You are unaware of any sigil's capable of that method of improvement in this area.
    match scribeSigil Roundtime
    put perc sigil %type
    goto retry



scribeSigil:
    var location scribeSigil
    if "$righthandnoun" != "burin" then {
        gosub stow right
        gosub get my %burin
        pause
    }
    if "$lefthandnoun" != "scrolls" then {
        gosub stow left
        gosub get my scrolls
        pause
    }

    match done You should probably seek knowledge of a sigil before trying to scribe one.
    match scribeSigil You carefully scribe the sigil
    match scribeSigil Remnants of the sigil pattern linger, allowing for additional scribing.
    put scribe sigil
    goto retry
    matchwait


done:
    gosub stow right
    gosub stow left
    gosub get scrolls
    pause .2
    gosub stowing
    goto loop
