include libsel.cmd



action goto putAway when eval $lefthand != Empty

waiting:
    pause 2
    goto waiting

putAway:
    gosub put my $lefthandnoun in my white back
    goto waiting
