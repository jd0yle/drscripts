include libsel.cmd

var lootables throwing blade|arrow|bolt|quadrello|brazier
var toLoot null
action (invFeet) var toLoot %toLoot|$1 when (%lootables)
action (invFeet) off


gosub pickupLootAtFeet
put #parse LOOT DONE
exit


pickupLootAtFeet:
    action (invFeet) on
    var toLoot null
    pause .2
    gosub inv atfeet
    action (invFeet) off
    eval invLength count("%toLoot", "|")
    var invIndex 0

    pickupLootAtFeetLoop:
        if ("%toLoot(%invIndex)" != "null") then gosub stow %toLoot(%invIndex)
        math invIndex add 1
        if (%invIndex > %invLength) then return
        goto pickupLootAtFeetLoop
