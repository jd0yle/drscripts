include libmaster.cmd

var trash blanket|kaleidoscope|earring|harp|cowbell|cookbook|thumb ring|book|witch ball
eval numItems count("%trash", "|")
var index 0

loop:
	gosub get my %trash(%index) from my skull
	if ("$righthand" != "Empty") then {
		gosub put my %trash(%index) in bucket
		goto loop
	}
	gosub get my %trash(%index) from my shadows
	if ("$righthand" != "Empty") then {
		gosub put my %trash(%index) in bucket
		goto loop
	}
	math index add 1
	if (%index > %numItems) then goto done
	goto loop

done:
	pause .2
	put #parse TRASH DONE
	exit
