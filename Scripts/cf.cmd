include libsel.cmd

if_1 then {
    var creature %1
} else {
    goto done
}

var parts skin|head|neck|chest|abdomen|back|tail|rightarm|leftarm|righthand|lefthand|rightleg|leftleg|righteye|lefteye
var partsIndex 0
eval partslength count("%parts", "|")

var didHeal 0

action var heal.skin 1 when difficulty controlling actions|(?:minor|severe) (?:twitching|twitches)|difficulty thinking|paralysis of the entire body
action var heal.$1 1 when (head|neck|chest|abdomen|back|tail)
action var heal.$1$2 1 when (right|left) (arm|hand|leg|eye)

action goto done when ^Lacking the skill and insight to draw more life essence out of this husk, your spell pattern fails\.$
action goto done when ^Lacking any ritually prepared corpses, the spell pattern fails entirely.$

var isFullyPrepped 0
action var isFullyPrepped 1 when ^You feel fully prepared to cast your spell.


goto mainLoop

mainLoop:
    gosub resetHealVars
    gosub health
    gosub healAllParts
    if (%didHeal = 1) then goto mainLoop
    goto done

healAllParts:
    var healIndex 0
    var didHeal 0
    healAllParts.loop:
    if (%heal.%parts(%healIndex) = 1) then {
        gosub heal %parts(%healIndex)
        var didHeal 1
    }
    math healIndex add 1
    if (%healIndex > %partslength) then return
    goto healAllParts.loop

heal:
    var part $0
    eval part replace("%part", "left", "left ")
    eval part replace("%part", "right", "right ")
    var isFullyPrepped 0
    gosub prep cf
    gosub perform preserve on %creature
    gosub perform consume on %creature
    gosub waitForPrep
    gosub cast %part
    return

waitForPrep:
    if (%isFullyPrepped = 1) then return
    pause
    goto waitForPrep

resetHealVars:
    var resetIndex 0
    resetHealVars.loop:
    var heal.%parts(%resetIndex) 0
    math resetIndex add 1
    if (%resetIndex > %partslength) then return
    goto resetHealVars.loop

done:
    put #parse CF DONE
    exit
