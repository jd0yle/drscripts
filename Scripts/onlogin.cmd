include libsel.cmd

if ("$charactername" = "Selesthiel") then {
    send sort my boots
    pause .2
    send sort my pants
    pause .2
    send sort my trousers
    pause .2
    send sort my baldric
    pause .2
    send sort my sash
    pause .2
    send sort my band
    pause .2
    send sort my robe

    var titleList Shadow Mage|Monk|Ascetic|Precursor|Dissident|Divine Soldier|Arcane Researcher|Student|Scholar|Researcher|Judge|Diplomat|Professor|Sibilant
    eval len count("%titleList", "|")
    random 0 %len
    #put title pre choose moon %titleList(%r)
} else {
    send sort auto headtotoe
}

if ($standing != 1) then gosub stand
