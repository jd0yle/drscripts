include libsel.cmd

loop:
    gosub get book from my shadows
    if ("$lefthand" = "Empty") then exit
    gosub put my book in my white backpack
    goto loop