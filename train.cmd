include libsel.cmd

var combatSkills Evasion|Crossbow|Targeted_Magic|Shield_Usage|Parry_Ability
eval combatLength count("%combatSkills", "|")
var magicSkills Warding|Augmentation|Utility
eval magicLength count("%magicSkills", "|")

gosub put my comp in my bag
gosub put my telescope in my telescope case
gosub stow right
gosub stow left
gosub release spell
gosub release mana
gosub release symbi


if ($SpellTimer.SeersSense.active = 0 || $SpellTimer.SeersSense.duration < 20) then {
    put .cast seer
    waitforre ^CAST DONE
}

if ($SpellTimer.ManifestForce.active = 0 || $SpellTimer.ManifestForce.duration < 20) then {
    put .cast maf
    waitforre ^CAST DONE
}

if ($SpellTimer.CageofLight.active = 0 || $SpellTimer.CageofLight.duration < 3) then {
    put .cast col
    waitforre ^CAST DONE
}

put .armor wear
waitforre ^ARMOR DONE

gosub stance shield

put .findSpot bull
waitforre ^FINDSPOT DONE

put .fight
put .idle
