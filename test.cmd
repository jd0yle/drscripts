
put .var_$charactername.cmd
var char.test asdf
echo %char.test







exit

if (1 = 0 || ($Warding.LearningRate > 29 && $Utility.LearningRate > 29 && $Augmentation.LearningRate > 29 && $Arcana.LearningRate > 29)) then {
    echo ready
} else {
    echo not ready
}


exit

# Dynamic character trainer
# if
var sections magic|combat
var sectionIndex 0

var magic.startState $Warding.LearningRate < 10 || $Augmentation.LearningRate < 10 || $Utility.LearningRate < 10
var magic.doneState $Warding.LearningRate > 31 && $Augmentation.LearningRate > 31 && $Utility.LearningRate > 31

var combat.startState


if (eval(%%sections(%sectionIndex).startState)) then {
    echo doing %sections(%sectionIndex)
} else {
    echo not starting %sections(%sectionIndex)
}

if (eval(%%sections(%sectionIndex).doneState)) then {
    echo Done with %sections(%sectionIndex)
} else {
    echo Not done with %sections(%sectionIndex)
}

exit

var cond "foo" = "foo"

if (eval(%cond)) then {
    echo true
} else {
    echo false
}

var cond "foo" = "bar"
if (%cond) then {
    echo true
} else {
    echo false
}







exit



if (contains("$roomplayers", "Selesthiel") && contains("$roomplayers", "Inauri")) then {
    gosub listen to Selesthiel
    gosub listen to Inauri
    gosub teach tm to inauri
} else {
    if (contains("$roomplayers", "Inauri")) then {
        gosub teach tm to inauri
    }
}


exit



action goto ejectFromHouse when eval "$roomplayers" != ""

ejectFromHouse:
	eval names replacere("$roomplayers", "Also here: ", "")
	eval names replacere("%names", "(,| and)", "|")
	eval names replacere("%names", "\.", "")

	var index 0
	eval namesLength count("%names", "|")

	ejectloop:
	    if ("%names(%index)" != "Inauri") then {
	        put show %names(%index) to door
	        pause .5
	        put show %names(%index) to door
	        pause .5
	    }
	    math index add 1
	    if (%index > %namesLength) then goto ejectdone
	    goto ejectloop

	ejectdone:
	exit





#include libsel.cmd


var mobs armored warklin|warklin mauler

#if (matchre ("$roomobjs", "(%mobs)") then {
if (matchre ("$roomobjs", "(%mobs) ((which|that) appears dead|(dead))") then {
    var mobName $1
    echo mob: %mobName
} else {
    echo not found
}


exit







exit

pouchloop:
    gosub get gem pouch from my skull
    if ("$righthand" = "Empty") then exit
    matchre stowportal find \d+ gems
    matchre stowsatch empty
    put count my gem pouch
    matchwait


stowportal:
    gosub put my gem pouch in my portal
    goto pouchloop


stowsatch:
    gosub put my gem pouch in my satchel
    goto pouchloop





var scrolls tablet|scroll|vellum|ostracon|bark|roll
var typeIndex 0
eval typeLength count("%scrolls", "|")

matloop:

    gosub get my %scrolls(%typeIndex) from my satchel
    if ("$righthand" = "Empty") then {
        math typeIndex add 1
        if (%typeIndex > %typeLength) then exit
        goto matloop
    }
    gosub stow right
    goto matloop


exit

var calculatedGametime $gametime

testloop:
    evalmath elapsedGametime (%calculatedGametime - $gametime)
    if (%elapsedGametime > 30) then {
        echo %elapsedGametime since gametime updated (%elapsedGametime - $gametime > %calculatedGametime + 30)
        var lastGameTime $gametime
    }
    echo gametime: $gametime  calculatedGametime: %calculatedGametime  elapsedGametime: %elapsedGametime
    math calculatedGametime add 1
    delay 1
    goto testloop



exit


var args first second third 4 "five plus" 6 7 8 9 10
echo test %args
put .shift %args
matchre shiftArgs ^SHIFT (.*)$
matchwait

shiftArgs:
    var newArgs $0
    echo newArgs %newArgs

exit


testlabel:
    var args $0
    echo $5
    eval args replacere(%args, ", DQUOTE)
    echo args %args

    if (matchre("%args", "\S+(.*)")) then {
	    eval newArgs trim($1)
	    echo newArgs %newArgs
    }

    return

exit



exit

include var_characters.cmd

var spells maf|obf|ch|php
var index 0
eval spellLength count("%spells", "|")


loop:
echo cast..prep  %cast.%spells(%index).prep
echo cast.maf.charge %cast.%spell.charge
echo cast.maf.times %cast.%spell.times







exit
var mobs spirit dancer|blood warrior|shadow mage

if (matchre("$roomobjs", (%mobs)) then {
    var zero $0
    var one $1
    var two $2
    echo zero: %zero
    echo one: %one
    echo two: %two
}