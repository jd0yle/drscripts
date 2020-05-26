include libsel.cmd

collLoop:
    gosub collect rock
    gosub kick pile
    goto collLoop
