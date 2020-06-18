include libsel.cmd

var labels First_Aid|Warding|Astrology
eval length count("%labels", "|")
var index 0

var highestRateIndex 0

put #script abort all except sel
put .idle
put .logafter

gosub put my comp in my bag
gosub put my telescope in my telescope case
gosub stow right
gosub stow left
gosub release
gosub release symbi


initloop:
    if ($%labels(%index).LearningRate > $%labels(%highestRateIndex).LearningRate) then var highestRateIndex index
    math index add 1
    if (%index > length) then goto initDone
    goto initloop

initDone:
    var index %highestRateIndex
    timer start
    var nextCheckAt
    var scriptRunning 0

selLoop:
    if ($%labels(%index).LearningRate > 32) then {
        put #script abort all except sel
        put .logafter
        put .idle
        var scriptRunning 0
        math index add 1
        if (%index > %length) then var index 0
        gosub put my comp in my bag
        gosub put my telescope in my telescope case
        gosub stow right
        gosub stow left
        gosub release
        gosub release symbi
    }
    if ("%labels(%index)" = "First_Aid") then {
        if (%scriptRunning = 0) then {
            put .comp
            var scriptRunning 1
        }
    } else if ("%labels(%index)" = "Warding") then {
       if (%scriptRunning = 0) then {
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
