if_1 then {
    var destination %1
} else {
    echo [astral] Must specify a destination
    echo .astral destination
    exit
}



if (matchre("%destination", "rolagi|crossing|cross")) then {
    var pillar Nightmares
    var destShardName Rolagi
} else if (matchre("%destination", "besoge|kresh|merkresh|mriss") then {
   var pillar Nightmares
   var destShardName Besoge
} else if (matchre("%destination", "tabelrem|muspari") then {
   var pillar Nightmares
   var destShardName Tabelrem
} else if (matchre("%destination", "auilusi|aesry") then {
   var pillar Tradition
   var destShardName Auilusi
}

echo %destShardName %pillar

