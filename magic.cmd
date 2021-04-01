include libsel.cmd

var spell.Warding maf
var prep.Warding 10
var charge.Warding 70

var spell.Augmentation cv
var prep.Augmentation 10
var charge.Augmentation 70

var spell.Utility sm
var prep.Utility 20
var charge.Utility 30

if (!($charge.Warding > 0)) then put #tvar charge.Warding %charge.Warding
if (!($charge.Augmentation > 0)) then put #tvar charge.Augmentation %charge.Augmentation
if (!($charge.Utility > 0)) then put #tvar charge.Utility %charge.Utility

var lastSpellBackfired 0
action var lastSpellBackfired 1 when ^Your spell.*backfire

var magic.skills Augmentation|Warding|Utility
eval magic.length count("%magic.skills", "|")

if (!($magic.index > -1)) then put #tvar magic.index 0

loop:
    gosub almanac.onTimer
    if ($Astrology.LearningRate < 33) then gosub observe.onTimer
    if ($Astrology.LearningRate < 25) then gosub runScript predict
    if ($Attunement.LearningRate < 33) then gosub perc.onTimer
    if ($Appraisal.LearningRate < 33) then gosub appraise.onTimer
    if ($Arcana.LearningRate < 33 && $concentration = 100) then gosub gaze my sanowret crystal

    var skill %magic.skills($magic.index)

    if ($%skill.LearningRate < 33) then {
        if ($preparedspell != None) then gosub release spell
        var lastSpellBackfired 0
        gosub prep symbiosis
        gosub prep %spell.%skill %prep.%skill
        gosub charge my calf $charge.%skill
        gosub invoke my calf $charge.%skill
        gosub waitForPrep
        gosub cast
        if (%lastSpellBackfired = 1) then {
            evalmath tmp ($charge.%skill - 1)
            put #tvar charge.%skill %tmp
        }
    }

    evalmath tmp ($magic.index + 1)
    put #tvar magic.index %tmp
    if ($magic.index > %magic.length) then put #tvar magic.index 0

    gosub waitForMana 80
    pause .5
    goto loop


done:
    gosub stow my %cambrinth
    pause .2
    put #parse MAGIC DONE
    exit
