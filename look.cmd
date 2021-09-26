include libmaster.cmd
###############################
###    IDLE ACTION TRIGGERS
###############################
action var look.openDoor 1 when ^($friends)'s face appears in the
action var look.teach 1; var look.topic $2 ; var look.target $1 when ^($friends) whispers, \"teach (\S+)\"$


###############################
###    VARIABLES
###############################
if (!($lastLookGametime >0)) then put #var lastLookGametime 0

if !(matchre("$scriptlist", "reconnect")) then {
    put .reconnect
}


###############################
###    MAIN
###############################
look.loop:
    if ($standing = 0) then gosub stand
    if (%look.openDoor = 1) then gosub look.door
    pause 2
    gosub look.look
    goto look.loop


###############################
###    METHODS
###############################
look.door:
    if (%look.openDoor = 0) then goto look.loop
    gosub unlock door
    gosub open door
    var look.openDoor 0
    goto look.loop


look.houseMove:
    put .house
    waitforre ^HOUSE DONE
    goto look.loop


look.look:
  evalmath nextLookAt $lastLookGametime + 240
  if (%nextLookAt < $gametime) then {
    gosub tdp
    put #var lastLookGametime $gametime
  }
return


look.teach:
    if ($lib.class = 1) then {
        gosub assess teach
        if contains("$lib.classTopic", "%look.topic") then {
            put whisper %look.target I am already teaching you $class.
            var look.teach 0
            return
        }
        gosub stop teach
    }
    if ($lib.student = 1) then {
        gosub stop listen
    }
    gosub teach %look.topic to %look.target
    var look.teach 0
    return
