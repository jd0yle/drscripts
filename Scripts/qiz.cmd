include libsel.cmd

var labels Utility|First_Aid
eval length count("%labels", "|")
var index 0

var lowestRateIndex 0

var firstRun 1
var skipToNext 0

action var skipToNext 1 when ^OBS DONE

gosub put my comp in my bag
gosub put my telescope in my telescope case
gosub stow right
gosub stow left
gosub release spell
gosub release mana
gosub release symbi


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
        put #script abort all except qiz
        var scriptRunning 0
        var skipToNext 0
        math index add 1
        if (%index > %length) then var index 0
        gosub put my comp in my bag
        gosub put my telescope in my telescope case
        gosub stow right
        gosub stow left
        gosub release
        gosub release symbi
        pause 150
    }
    if (%scriptRunning = 0) then {
        if (%firstRun = 1) then {
            var firstRun 0
        } else {
            evalmath waitUntil (%t + 120)
            gosub waitItOut
        }
    }
    if ("%labels(%index)" = "First_Aid") then {
        if (%scriptRunning = 0) then {
            put .caracal
            var scriptRunning 1
        }
    } else if ("%labels(%index)" = "Utility") then {
       if (%scriptRunning = 0) then {
           put .qizhmur
           var scriptRunning 1
       }
    }
    pause 2
    goto selLoop

waitItOut:
    if (%t > %waitUntil) then return
    pause 10
    goto waitItOut
