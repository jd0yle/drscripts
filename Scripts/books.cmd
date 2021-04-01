include libsel.cmd

if ("%1" = "stow") then {
    var fromContainer steelsilk backpack
    var toContainer white backpack
}

loop:
    gosub get book from my %fromContainer
    if ("$lefthandnoun" != "book" && "$righthandnoun" != "book") then exit
    gosub put my book in my %toContainer
    goto loop