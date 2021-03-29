include libsel.cmd



var spell.warding maf
var prep.warding 10
var charge.warding 70

var spell.augmentation cv
var prep.augmentation 10
var charge.augmentation 70

var spell.utility sm
var prep.utility 20
var charge.utility 30

if (!($charge.warding > 0)) then put #tvar charge.warding %charge.warding
if (!($charge.augmentation > 0)) then put #tvar charge.augmentation %charge.augmentation
if (!($charge.utility > 0)) then put #tvar charge.utility %charge.utility

var lastSpellBackfired 0
action var lastSpellBackfired 1 when ^Your spell.*backfire

loop:
    gosub almanac.onTimer

    if ($Astrology.LearningRate < 33) then gosub observe.onTimer

    if ($Astrology.LearningRate < 22) then gosub runScript predict

    if ($Attunement.LearningRate < 33) then gosub perc.onTimer

    if ($Appraisal.LearningRate < 33) then gosub appraise.onTimer

    if ($Arcana.LearningRate < 33 && $concentration = 100) then {
        if ($SpellTimer.RefactiveField.active = 1) then gosub release rf
        gosub gaze my sanowret crystal
    }

    if ($Warding.LearningRate < 33) then {
        if ($preparedspell != None) then gosub release spell
        var lastSpellBackfired 0
        gosub prep symbiosis
        gosub prep maf %prep.warding
        gosub charge my calf $charge.warding
        gosub invoke my calf $charge.warding
        gosub waitForPrep
        gosub cast
        if (%lastSpellBackfired = 1) then {
            evalmath tmp ($charge.warding - 1)
            put #tvar charge.warding %tmp
        }
        #gosub release shear
    }

    if ($Utility.LearningRate < 33) then {
        if ($preparedspell != None) then gosub release spell
        var lastSpellBackfired 0
        gosub prep symbiosis
        gosub prep %spell.utility %prep.utility
        gosub charge my calf $charge.utility
        gosub invoke my calf $charge.utility
        gosub waitForPrep
        gosub cast
        if (%lastSpellBackfired = 1) then {
            evalmath tmp ($charge.utility - 1)
            put #tvar charge.utility %tmp
        }
    }

    if ($Augmentation.LearningRate < 33) then {
        if ($preparedspell != None) then gosub release spell
        var lastSpellBackfired 0
        gosub prep symbiosis
        gosub prep %spell.augmentation %prep.augmentation
        gosub charge my calf $charge.augmentation
        gosub invoke my calf $charge.augmentation
        gosub waitForPrep
        gosub cast
        if (%lastSpellBackfired = 1) then {
            evalmath tmp ($charge.augmentation - 1)
            put #tvar charge.augmentation %tmp
        }
    }
   
    gosub waitForMana 80
    pause .5

goto loop



done:
    gosub stow my %cambrinth
    exit
