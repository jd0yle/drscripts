include libmaster.cmd
include args.cmd

var rezz.target %args.target

var rezz.memoryState null
action rezz.memoryState $1 when thin (\S+) nimbus


gosub stow right
gosub stow left

#gosub rezz.rejuv

if ($SpellTimer.Resurrection.active != 1) then {
	gosub prep rezz 8
	gosub waitForPrep
	gosub cast
}

rezz.loop:
    gosub rezz.waitForMana
    gosub harness 8
    gosub infuse rezz 8
    goto rezz.loop


rezz.rejuv:
    if ("%rezz.memoryState" = "null") then gosub perc %rezz.target
    if ("%rezz.memoryState" != "silver") then {
        gosub runScript cast rejuv %rezz.target
        goto rezz.rejuv
    }
    return


rezz.waitForMana:
	if ($mana > 50) then return
	pause 1
	goto rezz.waitForMana