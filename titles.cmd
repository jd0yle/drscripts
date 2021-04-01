####
# Dumps out a list of all titles in Genie Client 3/Logs/titles.txt
####

var categories guild|Blunt|Ranged|Brawling|GenEdged|SpecEdged|Thrown|Pole|Shield|Slings|Weapons|WeaponMaster|Performer|PrimaryMagic|Magic|Money|Ownership|Survival1|Survival2|Survival3|Lore|Criminal|Generic|Racial|Premium|Order|Religion|Arcane|Novice|Practitioner|Dilettante|Aficionado|Adept|Expert|Professional|Authority|Genius|Savant|Master|GrandMaster|Guru|Legend|Custom
eval len count("%categories", "|")
eval index 0

var titles
action var titles $1 when ^(.+?, .+?,.*)$

loop:
    var titles None
    put #log >titles.txt ----------------------------------------------------------------
    put #log >titles.txt ******** %categories(%index) ********
    put title pre list %categories(%index)
    pause 1
    put #log >titles.txt %titles
    math index add 1
    if (%index > %len) then exit
    goto loop
