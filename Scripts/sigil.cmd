include libsel.cmd

####### CONFIG #######
var burin abstract burin
######################

var startRoomId $roomid
var endRoomId 261
var currentRoomId 0

if "$guild" = "Moon Mage" then var doBuffArt 1

action var sigilType $1; echo FOUND A %sigilType when ^In your mind's eye you see the definition of an? (\S+) sigil before you.
action var sigilType $1; echo FOUND A %sigilType when ^After much scrutiny you are certain an? (\S+) sigil has revealed itself.
action var sigilType $1; echo FOUND A %sigilType when ^Though the seemingly mundane lighting you focus intently on a lurking (\S+) sigil.



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
    matchre percSigil YOU HAVE ARRIVED!
    match done MOVE FAILED
    if ($roomid != %currentRoomId) then {
        put #walk %currentRoomId
    } else {
        goto percSigil
    }
    matchwait


percSigil:
    var location percSigil
    matchre improve ^Sorting through the imagery, you find the designs of an almost imperceptible (\S+) sigil.
    matchre improve ^Almost obscured by the surround, you make out the details of a (\S+) sigil.
    matchre improve ^You have perceived a|an \S+ (\S+) sigil
    matchre improve ^In your mind's eye you see the definition of an? (\S+) sigil before you.
    matchre improve ^You are already working to improve the sigil discovered here.
    matchre improve ^You recall having already
    matchre imprive ^After much scrutiny you are certain an? \S+ sigil has revealed itself.
    matchre percSigil ^You scour the area
    matchre percSigil ^Back and forth you walk
    matchre percSigil ^You clear your mind
    matchre percSigil ^Whorls of dust
    matchre percSigil ^You close your eyes
    matchre percSigil ^The sky holds your interest
    matchre percSigil ^Roundtime
    matchre loop ^Having recently been searched
    #send perc sigil
    put perc sigil
    goto retry

    #matchwait 20
    #gosub percSigil


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
