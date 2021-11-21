include libmaster.cmd

var stackerTypes folio|worn book

var index 0

loop:
	gosub get my %stackerTypes(%index) from my shadows
	if ("$righthand" = "Empty") then {
		math index add 1
		if (%index > count("%stackerTypes", "|")) then return
		goto loop
	}
	gosub open my %stackerTypes(%index)
	put flip my %stackerTypes(%index)
	gosub put my %stackerTypes(%index) in my portal
	goto loop