include libmaster.cmd
###############################
###    CORN MAZE REDUX
###############################

###############################
###    VARIABLES
###############################
var halfling1 0
var halfling2 0
var halfling3 0
var halfling4 0
var halfling5 0
var halfling6 0
# Incidentals
var incidentalStorage $char.inv.defaultContainer
var incidentalSurfaces altar|weathered basket|small boulder|large boulder|burrow|broken fencepost|yellow hay|wooden hut|red pail|large rake|large spiderweb|dragon statue|Halfling statue|smooth stones|straw|wagon|broken wheelbarrow|stack of wood
# Keep Everything (0-Off/1-On)
var keepall 1
# Keep Specific Items
var keeplist null
var logWindow Log
var npcnum 0
var roomlist 5|15|16|17|22|26|30|38|42|47|52|59|61|69|79|86|93|96|99|104|111|115|120|125|133|137|141|147|152|158|163|169|174|178|186|195|201|208|211|218|222|231|234|239|244|251|260|262|271|273|282|289|293|297|311|317|320|324|327|333|336|340|349|386|359|366|371|377|382|388|394|398|402|420|425|413
eval roomcount count("%roomlist", "|")
var roomnum 0


###############################
###    ACTIONS
###############################
action goto EXIT when A cheerful looking Halfling wearing a wide brimmed hat comes up to you and says, "It looks like you got lost in the maze\!  I'm here to escort you out\."  He takes your hand and leads you through the twisting passages and brings you to the exit\.

# Logs
action put #echo >%logWindow Yellow [corn] Scarecrow found in room $roomid! when ^You also see.+the Scarecrow
action put #echo >%logWindow Yellow [corn] Harawep's Spider found in room $roomid! when ^You also see.+Harawep's Spider
action put #echo >%logWindow Yellow [corn] Scarecrow appears!;put #play NewRank when You hear sinister laughter as the Scarecrow invades the Corn Maze!
action put #echo >%logWindow Yellow [corn] Spider appears!;put #play NewRank when A hissing sound echoes through the Corn Maze as Harawep's Spider makes its appearance!
action put #echo >%logWindow Yellow [corn] $1 minutes remaining! when A barefoot Halfling trots up to you and says, "Hey, just to let you know you've only got (.+) minutes of time left.  You can either run to the exit and start over, or use another pass to keep exploring the maze."

# Variables
action put #var halfling1 $roomid when ^You also see.+cheerful Halfling
action put #var halfling2 $roomid when ^You also see.+carefree Halfling
action put #var halfling3 $roomid when ^You also see.+tired Halfling
action put #var halfling5 $roomid when ^You also see.+playful Halfling
action put #var halfling6 $roomid when ^You also see.+grumpy Halfling
action put #var halfling4 $roomid when ^You also see.+tall Gor'Tog
action var bottle $1 when You count the number of kernels inside the bottle and find that there are (\d+)\.
action var goodtask 10 when You think that you've gathered enough tokens and should return to one of the Halflings and ASK HALFLING ABOUT TASK again.
action var goodtask 10 when You think that you've gathered enough corn and should return to one of the Halflings and ASK HALFLING ABOUT TASK again.
action var goodtask 10 when You think that you've screamed enough and should return to one of the Halflings and ASK HALFLING ABOUT TASK again.
action var goodtask 10 when You think that you've touched enough random objects and should return to one of the Halflings and ASK HALFLING ABOUT TASK again.
action var goodtask 10 when You think that you've disarmed enough traps and should return to one of the Halflings and ASK HALFLING ABOUT TASK again.
action var goodtask 10 when You think that you've gathered enough grasshoppers and should return to one of the Halflings and ASK HALFLING ABOUT TASK again.
action var goodtask 10 when Getting down on your hands and knees, you manage to really get in and clear out the weeds.
action var goodtask 10 when You think that you've pulled enough weeds and should return to one of the Halflings and ASK HALFLING ABOUT TASK again.
action var goodtask $1 when You've completed (.+) of the (.+) things you were asked to do.
action var lootitem $1 when ^You manage to find (.*)!


# Task Math
action math goodtask add 1 when You notice a grasshopper jumping around in between the corn stalks!  cYou chase after it and manage to scoop it up in your hands, then stash it away in the little bag the Halfling gave you.
action math goodtask add 1 when You wave your hands around wildly at the mice in the area and you see several of them scatter away from the corn in a panic!  You stomp and holler and manage to cause quite a ruckus.
action math goodtask add 1 when You manage to find some ripe corn!
action math goodtask add 1 when You manage to find a shiny golden token!  You quickly stash it in the little bag the Halfling gave you.
action math goodtask add 1 when Getting down on your hands and knees, you manage to really get in and clear out the weeds.
action math goodtask add 1 when You pull on some of the weeds and manage to get a whole bunch of them cleared away from the corn.
action math goodtask add 1 when You pull out some of the weeds in the area without harming the corn.
action math goodtask add 1 when You diligently grab at the grassy weeds between the stalks of corn, clearing some out.
action math goodtask add 1 when You manage to cut the webbing away without getting any of it on you.
action math goodtask add 1 when You manage to dismantle the clapper from the bell without setting it off.
action math goodtask add 1 when You manage to nudge the fragile bottle out of the thoroughfare and into a shallow ditch without breaking the glass.
action math goodtask add 1 when You guess this still counts as 'disarming the trap'.
action math goodtask add 1 when You're pretty sure that counted toward the total number.
action math goodtask add 1 when You put the finishing touches on your scarecrow.
#action math goodtask add 1 when As you bend over the contraption, suddenly the clapper releases and strikes the bell, sounding a cacophonic note that rings your ears!



###############################
###    PARAMETERS
###############################
if_1 then {
    if (matchre("%1", "sca")) then {
        var roomnum 102
        var roommax 149
        goto SCARESPIDER
    }
    if (matchre("%1", "spi")) then {
        var roomnum 290
        var roommax 350
        goto SCARESPIDER
    }
    if (matchre("%1", "tas")) then {
        gosub corn.initHalflingVars
        var firstrun 1
        gosub COUNTBOTTLE
        put #echo >%logWindow [corn] Starting task run with %bottle kernels.
        goto MAINTASKLOOP
    }
    if (matchre("%1", "inc")) then {
        gosub corn.clearHands
        gosub corn.incidentalStart
        exit
    }
    if (matchre("%1", "full")) then {
        gosub STOWALL
        gosub INCIDENTALSSTART
        gosub corn.initHalflingVars
        var firstrun 1
        gosub COUNTBOTTLE
        put #echo >%logWindow [corn] Starting task run with %bottle kernels.
        goto MAINTASKLOOP
    }
    echo BAD INPUT!
    exit
} else {
    echo OPTIONS:
    echo --full (collects all incidentals and then begins running tasks)
    echo --incidental (collects all incidentals on the map)
    echo --spider (attempts to locate the spider)
    echo --scarecrow (attempts to locate the scarecrow)
    echo --task (automatically performs all tasks except killing tasks).
    echo Can be abbreviated down to 3 letters.
    exit
}

corn.initHalflingVars:
    var halfling1 $halfling1
    if (%halfling1 > -1) then {
    } else {
        var halfling1 2
    }
    var halfling2 $halfling2
    if (%halfling2 > -1) then {
    } else {
        var halfling2 104
    }
    var halfling3 $halfling3
    if (%halfling3 > -1) then {
    } else {
        var halfling3 150
    }
    var halfling4 $halfling4
    if (%halfling4 > -1) then {
    } else {
        var halfling4 187
    }
    var halfling5 $halfling5
    if (%halfling5 > -1) then {
    } else {
        var halfling5 227
    }
    var halfling6 $halfling6
    if (%halfling6 > -1) then {
    } else {
        var halfling6 395
    }
    return

MAINTASKLOOP:
    if (%firstrun = 1) then {
        var firstrun 0
        gosub AUTO
        gosub stand
    }
    echo halfling1: %halfling1
    if (matchre("$roomobjs", "cheerful Halfling")) then {
        var halfling1 $roomid
        put #var halfling1 $roomid
        echo halfling1 set with $roomid
    } else {
        echo Searching the specific room
        var roomtarget %halfling1
        gosub MOVE
        if (matchre("$roomobjs", "cheerful Halfling")) then {
        } else {
            var npcnum 1
            gosub FINDHALF
        }
    }
    gosub ASKABOUT
    goto MAINTASKLOOP


INCIDENTALSSTART:
    put #echo >%logWindow [corn] Starting incidental run.
INCIDENTALS:
    gosub ROOMTEST
    var roomtarget %roomlist(%roomnum)
    gosub MOVE
    gosub SEARCH
    math roomnum add 1
    if (%roomnum > %roomcount) then {
        put #echo >%logWindow [corn] Completed incidental run.
        return
    }
    goto INCIDENTALS


SEARCH:
    if (matchre("$roomobjs", "%incidentalSurfaces")) then {
        var searchtarget $1
        if (matchre("$roomobjs", "hut")) then {
            var searchtarget hut
        }
        matchre RETURN The .* has already been picked clean\.
        match RETURN Sadly, you don't find anything.
        matchre BADSEARCH I could not find what you were referring to.|You find nothing of special interest about it.
        matchre LOOTSORT You manage to find
        matchre RETURN You've
        put search %searchtarget
        matchwait
    } else {
        put #echo >%logWindow [corn] Could not find the expected item to search in room %roomlist(%roomnum)!
        return
    }


BADSEARCH:
    put #echo >%logWindow [corn] Could not find the expected item to search in room %roomlist(%roomnum)!
    return


LOOTSORT:
    if (%keepall = 1 || (matchre("%lootitem", "%keeplist"))) then {
        put #echo >%logWindow [corn] Found %lootitem!
        var stowhand right
        gosub STOW
    } else {
        put #echo >%logWindow [corn] Not keeping %lootitem in $roomid!
        var dumpitemname $righthandnoun
        gosub DROPITEM
    }
    return


SCARESPIDER:
    var roomtarget %roomnum
    gosub MOVE
    if (matchre("$roomobjs", "the Scarecrow")) then {
        put #echo >%logWindow Yellow [corn] Scarecrow found in room $roomid!
        put #echo NewRank
        exit
    }
    if (matchre("$roomobjs", "Harawep's Spider")) then {
        put #echo >%logWindow Yellow [corn] Spider found in room $roomid!
        put #echo NewRank
        exit
    }
    math roomnum add 1
    if (%roomnum > %roommax) then {
        put #echo >%logWindow Yellow [corn] Boss not found!
        put #echo NewRank
        exit
    }
    goto SCARESPIDER


ASKABOUTP:
    pause
ASKABOUT:
    matchre ASKABOUTP \.\.\.wait|type ahead|stunned|while entangled in a web\.|You don't seem to be able to move
    matchre ASKFOR "Looks like you've finished the task!"|To whom are you speaking?|"We've got lots of tasks for you to do here!  Just ask me FOR a task and I'll give you one."|, "We've got lots of tasks for you to do here!  Just ask me FOR a task and I'll give you one."
    if (matchre("$roomobjs", "Gor'Tog")) then {
        put ask gor about task
    } else {
        put ask halfling about task
    }
    matchwait


ASKFORP:
    pause
ASKFOR:
    matchre ASKFORP \.\.\.wait|type ahead|stunned|while entangled in a web\.|You don't seem to be able to move
    matchre AUTO "Sure, I can give you a task to complete!"|To whom are you speaking?
    match ASKFORPAUSE "You already had a task and you abandoned it.  You'll need to wait a bit before you can have another one."
    if (matchre("$roomobjs", "Gor'Tog")) then {
        put ask gor for task
    } else {
        put ask halfling for task
    }
    matchwait

ASKFORPAUSE:
    pause 20
    goto ASKFOR


######TASKS######

AUTO:
    var goodtask 0
    matchre ALAND "Okay, we'd like you to find and touch some of the landmarks in the maze!  It'll be fun!"
    matchre ATOKEN "Okay, we'd like you to search out some golden tokens in the maze.  About ten pieces will do!"
    matchre SCREAMMOVE "Okay, we'd like you to go to each section of the maze and let out a good scream!  It'll make the corn maze extra spooky.  There are nine sections of the maze, but if you scream in five that'll be enough."
    matchre AMICE "Okay, we'd like you to chase out some of the mice that are hiding in the maze.  I know they might be cute, but they're pests.  You just have to WAVE your hands at them until they run from the maze.  If you chase away about ten that'll be great!"
    matchre ACORN "Okay, we'd like you to forage some corn in the maze and bring it to me.  Make sure it's ripe!  Ten pieces will do."
    matchre ATRAP "Okay, we'd like you to disarm some of the traps that have been put around the maze by some mischief-makers.  Five will do."
    matchre AGRASS "Okay, we'd like you to search out some of the grasshoppers that are running around in the maze, snag them and bring them back to us.  About ten will do."
    matchre APULL "Okay, we'd like you to go pull some weeds out from between the corn.  It's pretty thick in some areas.  Clearing out ten areas will be appreciated."
    matchre ABUILD "Okay, we'd like you to make some scarecrows in different sections of the maze!  To do this, find a good spot and BUILD it until it's done.  Five total should do it."
    matchre ABAD "Okay, we'd like you to kill some of the murder crows in the ripened field area of the maze.  Ten of them will do."|"Okay, we'd like you to kill some of the locusts in the green growth area of the maze.  Ten of them will do."
    matchre POKEHALF "Okay, we'd like you to go find my fellow Halflings working in the maze and give them a good poke in the ribs for me!  There are five of them."
    matchre RETURN You are not currently on a task.
    put task
    matchwait

ABAD:
    #echo goodtask: %goodtask
    if (%goodtask >= 10) then {
        put #echo >%logWindow [corn] Task complete - killing!
        return
    } else {
        put #echo >%logWindow Yellow [corn] Unable to perform this task!  Please do it manually!
        put #play NewRank
        exit
    }

AMICE:
    var task mice
    var tasknum 10
    goto TASK

APULL:
    var task pull
    var tasknum 10
    goto TASK

ATOKEN:
    var task token
    var tasknum 10
    goto TASK

AGRASS:
    var task grass
    var tasknum 10
    goto TASK

ACORN:
    var task corn
    var tasknum 10
    goto TASK

ATRAP:
    var task trap
    var tasknum 5
    goto TASK

ABUILD:
    var task build
    var tasknum 5
    goto TASK

ALAND:
    var roomnum 0
    goto LANDMARKS


TASK:
    send task
    pause .5
    if (%goodtask >= %tasknum) then {
        put #echo >%logWindow [corn] Task complete - %task!
        return
    }
    gosub ROOMTEST
    var roomtarget $roomid
    math roomtarget add 1
    if (%roomtarget > 425) then var roomtarget 3
    gosub MOVE
    if ("%task" = "mice") then gosub WAVE
    if ("%task" = "pull") then gosub PULL
    if ("%task" = "token") then gosub SEARCHTOKEN
    if ("%task" = "grass") then gosub SEARCHGRASS
    if ("%task" = "corn") then gosub FORAGECORN
    if ("%task" = "trap") then gosub SEARCHTRAP
    if ("%task" = "build") then gosub BUILD
    goto TASK

WAVEP:
    pause
WAVE:
    matchre WAVEP \.\.\.wait|type ahead|stunned|while entangled in a web\.|You don't seem to be able to move
    matchre RETURN You've already tried to scare the mice around here.|You jump up and down while waving your arms|You flail your arms about wildly|You wave your hands around wildly at the mice in the area and you see several of them scatter away from the corn in a panic!  You stomp and holler and manage to cause quite a ruckus.
    put wave
    matchwait

PULLP:
    pause
PULL:
    matchre PULLP \.\.\.wait|type ahead|stunned|while entangled in a web\.|You don't seem to be able to move
    matchre PULLRETURN Getting down on your hands and knees, you manage to really get in and clear out the weeds.|You pull and pull on the weeds, but they're very stubborn and after a while you have to give up.|You pull on some of the weeds and manage to get a whole bunch of them cleared away from the corn.|You scrabble futily at the weeds with your hands.  They're probably too tough here.|You pull and pull on the weeds, but they're very stubborn and after a while you have to give up.|You pull out some of the weeds in the area without harming the corn.|You pull at what looks like a few weeds, but then realize that it's actually a weird looking corn plant, so you stop.|You've already tried to pull the weeds around here.  You should move to a different area.|You diligently grab at the grassy weeds between the stalks of corn, clearing some out.
    matchre PULLRETURN You pull at some of the weeds, but misjudge the strength of the stalks and a small portion suddenly comes loose in your hands, sending you toppling backwards!
    put pull weed
    matchwait

PULLRETURN:
    if ($standing != 1) then {
        gosub stand
    }
    return

SEARCHTOKENP:
    pause
SEARCHTOKEN:
    matchre SEARCHTOKENP \.\.\.wait|type ahead|stunned|while entangled in a web\.|You don't seem to be able to move
    matchre RETURN You manage to find a shiny golden token!  You quickly stash it in the little bag the Halfling gave you.|You've already looked for tokens around here.  You should move to a different area.
    put search
    matchwait

SEARCHGRASSP:
    pause
SEARCHGRASS:
    matchre SEARCHGRASSP \.\.\.wait|type ahead|stunned|while entangled in a web\.|You don't seem to be able to move
    matchre RETURN You notice a grasshopper jumping around in between the corn stalks!  You chase after it and manage to scoop it up in your hands, then stash it away in the little bag the Halfling gave you.|You've already tried to catch grasshoppers around here.  You should move to a different area.
    matchre RETURN You've already tried
    put search
    matchwait


FORAGECORN:
    matchre RETURN You manage to find some ripe corn!|You've already looked around here.  You should move to a different area.
    matchre RETURN Sadly, all you find is unripe corn
    put forage corn
    matchwait


SEARCHTRAPP:
    pause
SEARCHTRAP:
    matchre SEARCHTRAPP \.\.\.wait|type ahead|stunned|while entangled in a web\.|You don't seem to be able to move
    matchre DISARM You notice a nearly invisible spiderweb that's strung up along the thoroughfare.|You notice a complex looking device lying in the thoroughfare that appears to be holding a small clapper|You notice a small corked bottle laying in the middle of the thoroughfare that looks like it'd be easily stepped on.  It appears to be filled with a greenish substance.
    match RETURN You notice a small corked bottle laying in the middle of the thoroughfare that looks like it'd be easily stepped on.  It looks like tiny black dots are jumping around inside.
    match RETURN You've already looked for traps around here.  You should disarm any traps you've found and then move to a different area.
    put search
    matchwait


DISARMP:
    pause
DISARM:
    matchre DISARMP \.\.\.wait|type ahead|stunned|while entangled in a web\.|You don't seem to be able to move
    matchre RETURN You manage to cut the webbing away without getting any of it on you.|You manage to dismantle the clapper from the bell without setting it off.|You manage to nudge the fragile bottle out of the thoroughfare and into a shallow ditch without breaking the glass.|As you try to carefully nudge the vial away from the thoroughfare, it shatters and a cloud of greenish gas forms right in|As you try to cut the webbing away, it wafts in the wind and the whole thing wraps around you!
    matchre DISARMFALL As you bend over the contraption, suddenly the clapper releases and strikes the bell, sounding a cacophonic note that rings your ears!
    put disarm trap
    matchwait

DISARMFALL:
    gosub stand
    return

BUILDP:
    pause
BUILD:
    matchre BUILDP \.\.\.wait|type ahead|stunned|while entangled in a web\.|You don't seem to be able to move
    matchre RETURN You put the finishing touches on your scarecrow.|You've already built a scarecrow here.  You should move to a different area.
    matchre BUILD You get a piece of corn cob and put a stick in it, creating a pipe for the scarecrow's mouth.|You add a funny looking hat made out of corn husks to the scarecrow.|You keep adding to the scarecrow, using a rolled up husk for its nose.|You continue adding onto the scarecrow, using corn husks to build arms and legs for it.|You slowly and carefully start creating a scarecrow out of bits of woven together corn stalks and leaves.
    put build
    matchwait


POKEHALF:
    send task
    pause .5
    if (%goodtask >= 5) then {
        put #echo >%logWindow [corn] Task complete - poke!
        return
    }
    var badpoke 0
    var npcnum 2
    gosub POKEHALFLOOP
    send task
    pause .5
    if (%goodtask < 5) then {
        put #echo >%logWindow [corn] Poke task incomplete.  Running through the loop again.
        return
    }
    put #echo >%logWindow [corn] Task complete - poke!
    return


POKEHALFLOOP:
    echo NPCNum: %npcnum
    if (%npcnum > 6) then {
        return
    }
    gosub FINDHALF
    gosub POKE
    if (%badpoke = 1) then {
        var badpoke 0
        goto POKEHALFLOOP
    }
    math npcnum add 1
    goto POKEHALFLOOP


POKEP:
    pause
POKE:
    if ((matchre("$roomobjs", "Gor'Tog")) || (matchre("$roomobjs", "Halfling"))) then {
        matchre POKEP \.\.\.wait|type ahead|stunned|while entangled in a web\.|You don't seem to be able to move
        matchre POKERETURN You think that definitely counted toward your 'task'.|You poke a tall Gor'Tog right in the ribs!|You poke a .+ Halfling right in the ribs!|You're pretty sure you're going to have to move on
        matchre BADPOKE What were you referring to?
        if (matchre("$roomobjs", "Gor'Tog")) then {
            put poke gor'tog
        } else {
            put poke halfling
        }
        matchwait
    }
    else goto BADPOKE


BADPOKE:
    var badpoke 1
    return


POKERETURN:
    math goodtask add 1
    if ($standing != 1) then {
        gosub STAND
        pause 1
    }
    return


SCREAMMOVE:
    var roomtarget 39
    gosub MOVE
    gosub SCREAM
    var roomtarget 104
    gosub MOVE
    gosub SCREAM
    var roomtarget 150
    gosub MOVE
    gosub SCREAM
    var roomtarget 100
    gosub MOVE
    gosub SCREAM
    var roomtarget 227
    gosub MOVE
    gosub SCREAM
    put #echo >%logWindow [corn] Task complete - scream!
    return


SCREAMP:
    pause
SCREAM:
    matchre SCREAMP \.\.\.wait|type ahead|stunned|while entangled in a web\.|You don't seem to be able to move
    matchre RETURN The sound carries through the maze, and you are confident it counted toward your task.|You've already screamed in this section of the maze.  You'll need to move to a different section entirely to scream again.
    put scream
    matchwait


LANDMARKS:
    var roomtarget %roomlist(%roomnum)
    gosub MOVE
    gosub TOUCHLAND
    math roomnum add 1
    if ((%roomnum > %roomcount) || (%goodtask > 9)) then {
        put #echo >%logWindow [corn] Task complete - landmark!
        return
    }
    goto LANDMARKS

TOUCHLANDP:
    pause
TOUCHLAND:
    matchre TOUCHLANDP \.\.\.wait|type ahead|stunned|while entangled in a web\.|You don't seem to be able to move
    if (matchre("$roomobjs", "%incidentalSurfaces")) then var touchtarget $1
    if (matchre("$roomobjs", "hut")) then var touchtarget hut
    matchre RETURN You're pretty sure that counted toward the total number.|You reach out and touch|Touch what?
    matchre RETURN You've already
    put touch %touchtarget
    matchwait


FINDHALF:
    gosub HALFLINGSET
    echo Searching around the last known room.
    var roomstart %halfling%npcnum
    math roomstart subtract 7
    if (%roomstart < 2) then {
        var roomstart 2
    }
    var roomend %halfling%npcnum
    math roomend add 7
    if (%roomend > 426) then {
        var roomend 426
    }
    var foundhalf 0
    var halfcount %roomstart
    gosub FINDHALFLOOP
    if (%foundhalf = 1) then {
        return
    } else {
        echo Searching the area start to finish.
        gosub HALFLINGSET
        var foundhalf 0
        var halfcount %roomstart
        gosub FINDHALFLOOP
        if (%foundhalf = 0) then {
            put #echo >%logWindow Yellow [corn] Unable to find Halfling!  Error!
            put #play NewRank
            exit
        }
    }
    return


HALFLINGSET:
    if (%npcnum = 1) then{
        var roomstart 2
        var roomend 48
    }
    if (%npcnum = 2) then {
        var roomstart 50
        var roomend 101
    }
    if (%npcnum = 3) then {
        var roomstart 150
        var roomend 186
    }
    if (%npcnum = 4) then {
        var roomstart 186
        var roomend 225
    }
    if (%npcnum = 5) then {
        var roomstart 227
        var roomend 291
    }
    if (%npcnum = 6) then {
        var roomstart 395
        var roomend 425
    }
    return


FINDHALFLOOP:
    gosub ROOMTEST
    if (%halfcount > %roomend) then return
    var roomtarget %halfcount
    gosub MOVE
    gosub LOOKROOM
    echo Looking for Halfling %npcnum!
    if (%npcnum = 1) then {
        if (matchre("$roomobjs", "cheerful Halfling")) then {
            put #var halfling1 $roomid
            var halfling%npcnum $roomid
            var foundhalf 1
            return
        }
    }
    if (%npcnum = 2) then {
        if (matchre("$roomobjs", "carefree Halfling")) then {
            put #var halfling2 $roomid
            var halfling%npcnum $roomid
            var foundhalf 1
            return
        }
    }
    if (%npcnum = 3) then {
        if (matchre("$roomobjs", "tired Halfling")) then {
            put #var halfling3 $roomid
            var halfling%npcnum $roomid
            var foundhalf 1
            return
        }
    }
    if (%npcnum = 4) then {
        if (matchre("$roomobjs", "Gor'Tog")) then {
            put #var halfling4 $roomid
            var halfling%npcnum $roomid
            var foundhalf 1
            return
        }
    }
    if (%npcnum = 5) then {
        if (matchre("$roomobjs", "playful Halfling")) then {
            put #var halfling5 $roomid
            var halfling%npcnum $roomid
            var foundhalf 1
            return
        }
    }
    if (%npcnum = 6) then {
        if (matchre("$roomobjs", "grumpy Halfling")) then {
            put #var halfling6 $roomid
            var halfling%npcnum $roomid
            var foundhalf 1
            return
        }
    }
    math halfcount add 1
    goto FINDHALFLOOP


COUNTBOTTLEP:
    pause
COUNTBOTTLE:
    matchre COUNTBOTTLEP \.\.\.wait|type ahead|stunned|while entangled in a web\.|You don't seem to be able to move
    matchre RETURN You count the number of kernels
    put count bottle
    matchwait


TASKCANCELP:
    pause
TASKCANCEL:
    matchre TASKCANCELP \.\.\.wait|type ahead|stunned|while entangled in a web\.|You don't seem to be able to move
    match RETURN Your current task has been canceled.  You can see a Halfling in the maze for another after five minutes.
    match TASKCANCEL If you cancel your current task, you won't be able to get another one for five minutes.  If you still want to do this, TASK CANCEL again in 30 seconds.
    put task cancel
    matchwait


######LIBRARY######


DROPITEMP:
	pause
DROPITEM:
	matchre DROPITEMP \.\.\.wait|type ahead|stunned|while entangled in a web\.|You don't seem to be able to move
	matchre RETURN You drop some|What were you referring to?|You drop|In a moment of foolishness you loosen your grip on|But you aren't holding that\.|shatters as it hits the ground
	match DROPITEM Whoah!  Dropping a
	put drop my %dumpitemname
	matchwait


ROOMTEST:
    if ($roomid = 0) then {
        put #mapper reset
        pause 1
        if ($roomid = 0) then {
            put #flash
            put #play JustArrived
            put #echo >%logWindow Yellow [corn] You are in an unrecognized room and the script is unable to correct!  Move around until the script reacquires a room number and it should take over.
            gosub ROOMRESET
        }
    }
    return


ROOMRESET:
    if ($roomid != 0) then return
    pause 1
    goto ROOMRESET


LOOKROOMP:
    pause
LOOKROOM:
    matchre LOOKROOMP \.\.\.wait|type ahead|stunned|while entangled in a web\.|You don't seem to be able to move
    matchre RETURN ^Obvious exits\:|^Obvious paths\:
    put look
    matchwait


MOVE:
    delay 0.0001
    var move.skip 0
    var move.retry 0
    var move.fail 0
    var move.room $0
    if ($roomid = 0) then {
        put #mapper reset
        pause 1
        if ($roomid = 0) then {
            put #play JustArrived
            put #echo Yellow >%logWindow [corn] Genie has lost track of your room number and cannot move!
        }
    }
    goto MOVE.GOTO


MOVECONT:
	 match MOVECONT2 Bonk! You smash your nose.
	 match RETURN YOU HAVE ARRIVED
	 match MOVECONT1 YOU HAVE FAILED
	 match MOVECONT1 MOVE FAILED
	 echo goto %roomtarget
	 put #goto %roomtarget
	 matchwait


MOVECONT1:
	pause
	put look
	pause
	goto MOVECONT


MOVECONT2:
	 pause
	 if (matchre("$scriptlist", "automapper")) then {
	    send #script abort automapper
	 }
	 pause
	 return


MOVE.RETRY:
    math move.retry add 1
    if (%move.retry > 3) then {
        goto move.fail
    }
    echo ***
    echo *** Retrying move to $1 $2 in %move.retry second(s).
    echo ***
    pause %move.retry
    goto MOVE.GOTO


MOVE.GOTO:
    matchre MOVE.GOTO ^\.\.\.wait|^Sorry\,
    matchre MOVE.RETURN ^YOU HAVE ARRIVED
    matchre MOVE.RETURN ^Darkness settles like a thick cloak
    matchre MOVE.SKIP ^SHOP CLOSED
    matchre MOVE.RETRY ^MOVE FAILED
    matchre MOVE.FAIL ^DESTINATION NOT FOUND
    matchre MOVE.RETRY ^You can't go
    matchre MOVE.RETRY ^You're still recovering from your recent attack\.
    matchre MOVE.RETREAT ^You are engaged
    matchre MOVE.RETREAT ^You can't do that while engaged\!
    put #goto %roomtarget
    matchwait 120
    var timeoutsub MOVE.GOTO
    var timeoutcommand #goto %roomtarget
	goto TIMEOUT


MOVE.FAIL:
    var move.fail 1
    goto MOVE.RETURN


MOVE.RETREAT:
    pause 0.1
    gosub RETREAT
    pause 0.1
    goto MOVE.RETRY


MOVE.SKIP:
    var move.skip 1

MOVE.RETURN:
    pause 0.001
    pause 0.001
    return


RETREATP:
    pause
RETREAT:
    matchre RETREAT You retreat back to pole range.|You try to back away from|You stop advancing on|You sneak back out|You try to back out of combat but are unable to get away!|You try to sneak out of combat,|discovers you trying to sneak out of combat, revealing your hiding place!|You stop advancing.
    matchre RETURN You retreat from combat.|You are already as far away as you can get!
    match STAND You must stand first.
    matchre RETREATP %waitstring
    put retreat
    matchwait 5
    var timeoutsub RETREAT
    var timeoutcommand retreat
    goto TIMEOUT


STOWALL:
    if ("$lefthand" != "Empty") then {
        var stowhand left
        gosub STOW
    }
    if ("$righthand" != "Empty") then {
        var stowhand right
        gosub STOW
    }
    return


corn.clearHands:
    if (matchre("$righthand|$lefthand" != "Empty")) then {
        gosub stow
        gosub stow left
    }
    return


EXIT:
    gosub COUNTBOTTLE
    put #echo >%logWindow [corn] Run ended with %bottle kernels.
    pause .002
    put #parse CORN END
    exit


RETURN:
    return