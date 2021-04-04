


send sort auto headtotoe

#if ("$charactername" = "Selesthiel") then {
#    var titleList Shadow Mage|Monk|Ascetic|Precursor|Dissident|Divine Soldier|Arcane Researcher|Student|Scholar|Researcher|Judge|Diplomat|Professor|Sibilant
#    eval len count("%titleList", "|")
#    random 0 %len
#    #put title pre choose moon %titleList(%r)
#}

if ($standing != 1) then send stand

send befriend list

if (!($lastLoginTime > -1) then put #tvar lastLoginTime $gametime