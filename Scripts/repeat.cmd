include libsel.cmd

var command %0

mainLoop:
    gosub %command
    goto mainLoop

