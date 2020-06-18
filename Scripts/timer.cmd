var interval %1
shift
var command %0

var lastActionAt 0

timer start

echo Doing <%command> every %interval seconds.

loop:
    evalmath tmp (%t - %lastActionAt)
    if ( %tmp > %interval) then {
        put %command
        var lastActionAt %t
    }
    pause
    goto loop
