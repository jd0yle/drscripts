include libsel.cmd

action #send search when ^You notice a small rat scurrying around the area.

action goto goNextRoom when A small rat scurries
action goto goNextRoom when ^You search around
action goto goNextRoom when ^You can't go there
action goto goNextRoom when ^You've recently searched this area

var dirs north|northeast|east|southeast|south|southwest|west|northwest
var opps south|southwest|west|northwest|north|northeast|east|southeast

var moveDirection north
var backtrack 0

waiting:
    pause .5
    goto waiting


goNextRoom:
    # Get the character index in the string of the last move direction
    eval nextExitIndex indexof(%dirs, %moveDirection)

    # Take the substring from the beginning to the start of this direction (ex: north|northeast|e)
    eval nextExitIndex substring(%dirs, 0, %nextExitIndex)

    # The number of | in the substring is the index of the direction in the array
    eval nextExitIndex count("%nextExitIndex", "|")

    goNextRoomLoop:
        # Add 1 to go to the NEXT index
        math nextExitIndex add 1

        # Only 0-7 compass directions, so roll over
        if (%nextExitIndex > 7) then var nextExitIndex 0

        # If that direction is not a valid exit from this room...
        if ($%opps(%nextExitIndex) = 0) then {
            goto goNextRoomLoop
        }

    # This exit is the exit we came in through
    if (%dirs(%nextExitIndex) = %moveDirection) then {
        # There is only one exit; backtrack to a room with 3+ exits
        var backtrack 1
    }

    var moveDirection %opps(%nextExitIndex)
    gosub move %moveDirection

    goto waiting
