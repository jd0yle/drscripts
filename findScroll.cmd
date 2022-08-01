include libmaster.cmd

var spellName %args.spell

var stackerTypes folio|worn book

var spellNames
action var spellNames %spellNames|$1 $2 when ^The (.*) section has (\d+) cop

#var spellName Shatter
var foundSpell 0
action echo FOUND IT!;var foundSpell 1 when ^The %spellName section

var index 0

loop:
	gosub get my %stackerTypes(%index) from my shadows
	if ("$righthand" = "Empty") then {
		math index add 1
		if (%index > count("%stackerTypes", "|")) then {
		    echo %spellNames
		    put #log >findScrolls.txt %spellNames
		    gosub findScroll.storeStackers
		    exit
		}
		goto loop
	}
	gosub open my %stackerTypes(%index)
	put flip my %stackerTypes(%index)
	pause 1
	#if (matchre("%spellNames", "%spellName")) then {
	if (%foundSpell = 1) then {
	    echo FOUND THE SPELL
	    exit
	}
	gosub put my %stackerTypes(%index) in my portal
	goto loop


findScroll.storeStackers:
    var index 0

    findScroll.storeStackers.loop:
        gosub get my %stackerTypes(%index) from my portal
        if ("$righthand" = "Empty") then {
            math index add 1
            if (%index > count("%stackerTypes", "|")) then exit
            goto findScroll.storeStackers.loop
        }
        gosub put my %stackerTypes(%index) in my shadows
        goto findScroll.storeStackers.loop