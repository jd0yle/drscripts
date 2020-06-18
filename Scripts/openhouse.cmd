action goto openDoor when ^Asherasa's face appears in the glass window
#action goto greet when ^(\S+) walks (through|in) the door.

var nextGreetAt 0
timer start

waiting:
    pause 2
    goto waiting


openDoor:
    send unlock door
    pause
    send open door
    pause
    goto waiting

greet:
    var name $1
    pause
    put say Welcome home, %name!
    goto waiting
