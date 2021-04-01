include libsel.cmd

var numMaterial 0

matchre doCount ^You rummage through.*?and see (.*)\.$
gosub rummage my satchel
matchwait 5
goto done


doCount:
    var contents $1

    eval itemArr replace("%contents", ",", "|")
    eval itemLength count("%itemArr", "|")
    var index 0

    doCountLoop:
        if (matchre("%itemArr(%index)", "material")) then math numMaterial add 1
        math index add 1
        if (%index > %itemLength) then goto done
        goto doCountLoop




done:
    pause .2
    put #var necroMaterialCount %numMaterial
    put #parse COUNTNECROMATERIAL DONE
    exit