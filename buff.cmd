include libmaster.cmd



var buffs $char.buffs.spells
var spellNames $char.buffs.spellNames

var index 0
eval numBuffs count("%buffs", "|")

buffs.loop:
	if ($SpellTimer.%spellNames(%index).active != 1 || $SpellTimer.%spellNames(%index).duration < 10) then {
	    if ($mana < 60) then {
            echo [buff] Waiting for mana (60)
            gosub waitForMana 60
        }
		gosub runScript cast %buffs(%index)
	}
	math index add 1
	if (%index > %numBuffs) then goto buffs.done
	goto buffs.loop

buffs.done:
	pause .2
	put #parse BUFF DONE
	exit