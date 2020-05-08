include libsel.cmd

####### CONFIG #######

var cambrinth yoakena globe

######################

var combatSpells seer|maf|col|shadows|cv|psy
var names SeersSense|ManifestForce|CageofLight|Shadows
var index 0
eval len count("%combatSpells", "|")

action var isFullyPrepped 1 when ^You feel fully prepared to cast your spell.

loop:
    if (%index > %len) then goto done
    if ($SpellTimer.%names(%index).active = 0) then {
        if (%mana < 80) then gosub waitMana
        gosub buff %combatSpells(%index)
    }
    math index add 1
    goto loop

 buff:
    var spell $1
    var target $charactername
    var isFullyPrepped 0

    if ("$preparedspell" != "None") then gosub release spell

    if ("%combatSpells(%index)" = "col") then {
        if ($Time.isYavashUp = 1) then var target yavash
        if ($Time.isXibarUp = 1) then var target xibar
        if ($Time.isKatambaUp = 1) then var target katamba
        if ("%target" = "$charactername") then return
    }
    gosub prep %spell 20
    gosub get %cambrinth
    gosub charge my %cambrinth 20
    gosub charge my %cambrinth 20
    gosub charge my %cambrinth 20
    gosub charge my %cambrinth 20
    gosub focus my %cambrinth
    gosub invoke my %cambrinth
    if (%isFullyPrepped != 1) then gosub waitForPrep
    gosub cast %target
    return

waitForPrep:
    pause 1
    if (%isFullyPrepped = 1) then return
    goto waitForPrep

waitMana:
    pause 1
    if ($mana > 80) then return
    goto waitMana


 done:
     gosub stow my %cambrinth
     exit
