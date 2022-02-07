include libmaster.cmd
###############################
###    TRASH
###############################


###############################
###    VARIABLES
###############################
var fromContainer $char.inv.container.trash
var trash blanket|kaleidoscope|earring|harp|cowbell|cookbook|thumb ring|witch ball|mouse|recipe box|towel
eval numItems count("%trash", "|")
var index 0

if ("%fromContainer" = "0") then {
    put #echo >log [trash] char.inv.container.trash not set.
    goto trash-done
}



###############################
###    MAIN
###############################
trash-loop:
	gosub get my %trash(%index) from my %fromContainer
	if ("$righthand" != "Empty") then {
		gosub put my %trash(%index) in bucket
		goto trash-loop
	}
	gosub get my %trash(%index) from my %fromContainer
	if ("$righthand" != "Empty") then {
		gosub put my %trash(%index) in bucket
		goto trash-loop
	}
	math index add 1
	if (%index > %numItems) then goto done
	goto trash-loop


trash-done:
	pause .2
	put #parse TRASH DONE
	exit
