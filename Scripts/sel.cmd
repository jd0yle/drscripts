include libsel.cmd

var labels Warding|First_Aid|Astrology
#var labels Warding|First_Aid
eval length count("%labels", "|")
var index 0

var lowestRateIndex 0

var firstRun 1
var skipToNext 0

action var skipToNext 1 when ^OBS DONE

#put #script abort all except sel
#put .idle
#put .logafter
put #script abort almanac

gosub resetState


initloop:
    if ($%labels(%index).LearningRate < $%labels(%lowestRateIndex).LearningRate) then var lowestRateIndex %index
    math index add 1
    if (%index > length) then goto initDone
    goto initloop

initDone:
    var index %lowestRateIndex
    #var index 1
    timer start
    var nextCheckAt
    var scriptRunning 0

selLoop:
    if ($%labels(%index).LearningRate > 32 || %skipToNext = 1) then {
        # put #script abort all except sel
        put #script abort magic
        put #script abort obs
        put #script abort cast
        put #script abort astro
        put #script abort comp

        var scriptRunning 0
        var skipToNext 0
        math index add 1
        if (%index > %length) then var index 0
        gosub resetState
        pause 150
    }
    if (%scriptRunning = 0) then {
        if (%firstRun = 1) then {
            var firstRun 0
        } else {
            evalmath waitUntil (%t + 30)
            gosub waitItOut
        }
    }
    if ("%labels(%index)" = "First_Aid") then {
        if (%scriptRunning = 0) then {
            if ($Astrology.LearningRate < 10) then {
                put .astro
                waitforre ^ASTRO DONE$
                gosub align lore
                gosub get my divination bones
                gosub roll bones at selesthiel
                gosub align survival                
                gosub roll bones at selesthiel
                gosub put my divination bones in my telescope case
            }
            put .comp
            var scriptRunning 1
        }
    } else if ("%labels(%index)" = "Warding") then {
       if (%scriptRunning = 0) then {
           if ($Astrology.LearningRate < 10) then {
               put .astro
               waitforre ^ASTRO DONE$
               gosub align offense
               gosub get my divination bones
               gosub roll bones at selesthiel
               gosub align defense
               gosub get my divination bones
               gosub roll bones at selesthiel
               gosub put my divination bones in my telescope case
           }
           put .magic
           var scriptRunning 1
       }
    } else if ("%labels(%index)" = "Astrology") then {
        if (%scriptRunning = 0) then {
            put .obs
            var scriptRunning 1
        }
    }
    pause 2
    goto selLoop

waitItOut:
    if (%t > %waitUntil) then return
    pause 10
    goto waitItOut


resetState:
    if ("$righthandnoun" = "compendium" || "$lefthandnoun" = "compendium") then gosub put my compendium in my bag
    if ("$righthandnoun" = "telescope" || "$lefthandnoun" = "telescope") then gosub put my telescope in my bag
    gosub stow right
    gosub stow left
    gosub release spell
    gosub release mana
    gosub release symbi
    return