
var doMagic 1
var doChange 1

timer start

top:
    if (%t > 1800) then {
         if (%doMagic = 1) then {
             var doMagic 0
         } else {
             var doMagic 1
         }
         var doChange 1
         timer stop
         timer reset
         timer start
    }

    if (%doChange = 1) then {
        put #script abort discomagic
        put #script abort comp
        if (%doMagic = 1) then {
            var doMagic 1
            put .discomagic

        } else {
            put .comp
        }
        var doChange 0
    }

    if (%doMagic = 1) then {
        if ($Augmentation.LearningRate > 33 && $Utility.LearningRate > 33 && Warding.LearningRate > 33) then {
            var doChange 1
            var doMagic 0
        }
    } else {
        if ($First_Aid.LearningRate > 33) then {
            var doChange 1
            var doMagic 1
        }
    }
    pause 2
    goto top

