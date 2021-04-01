include libsel.cmd

var researchProject null
var project sorcery

if_1 then {
    var project %1
}


var doIdle 1

if_2 then {
    var doIdle 0
}


var useSanowret 0
var usingCrystal 0

if ("$charactername" = "Qizhmur") then var useSanowret 1

action var researchProject $1 when ^You.*begin to bend the mana streams.*(utility|augmentation|ward)
action var researchProject stream when ^You focus your magical perception as tightly as possible
action var researchProject sorcery when ^Abandoning the normal discipline required to manipulate the mana streams
action var researchProject fundamental when ^You tentatively reach out and begin manipulating the mana streams

action var researchProject notNull when ^You are already busy at research!

action var researchProject null when ^You decide to cancel your project
action var researchProject null when ^Breakthrough!
action var researchProject null when However, there is still more to learn before you arrive at a breakthrough.

action echo researchProject %researchProject when eval %researchProject


action var usingCrystal 0 when ^The light and crystal sound of your sanowret crystal fades slightly as you come to the end

#put .idle

var stallCheckGametime $gametime

loop:
    if ("%researchProject" = "null") then {
        if ($Sorcery.LearningRate > 30) then goto done
        if ($SpellTimer.GaugeFlow.duration < 10) then {
            put .cast gaf
            waitforre ^CAST DONE$
        }

        if ("$guild" = "Moon Mage" && %doIdle = 1) then gosub runScript astro

        pause
        put research %project 300
        var stallCheckGametime $gametime
    } else {
        evalmath diff ($gametime - %stallCheckGametime)
        if (%diff > 300) then {
            pause
            put research %project 300
        }
    }

    if (%doIdle = 1) then {
        if (%useSanowret = 1 && $Arcana.LearningRate < 33 && $concentration = 100) then {
            if (%usingCrystal = 0) then put gaze my sanowret crystal
            var usingCrystal 1
        }
	    if ("$guild" = "Moon Mage") then gosub observe.onTimer

	    if ("$guild" = "Moon Mage" && $Astrology.LearningRate < 25) then gosub runScript predict

	    if ($Appraisal.LearningRate < 33) then gosub appraise.onTimer

	    if ($Attunement.LearningRate < 33) then gosub perc.onTimer
    }

pause 10
goto loop


done:
    #put #script abort idle
    pause .2
    put #parse RESEARCH DONE
    exit