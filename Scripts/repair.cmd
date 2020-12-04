include libsel.cmd


if ("$zoneid" != "1") then {
    echo "***** NOT IN CROSSING *****"
    exit
}

gosub stow right
gosub stow left

put .armor wear
waitforre ^ARMOR DONE

gosub automove teller
put withdraw 20 plat
pause

gosub automove catrox
put ask catrox about repair all
pause
put ask catrox about repair all
pause
gosub stow ticket

gosub automove w gate
gosub automove repair

put ask randal about repair all
pause
put ask randal about repair all
pause
gosub stow ticket