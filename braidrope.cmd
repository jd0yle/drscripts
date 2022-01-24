include libmaster.cmd
###############################
###      BRAID ROPE
###############################


###############################
###      IDLE ACTION TRIGGERS
###############################
action var readyToPull false when ^You are certain that the braided grass isn't usable for anything yet.
action var readyToPull true when piece of bundling rope\.$
action goto braidrope-forage when ^You need to have more material in your other hand to continue braiding.
action goto braidrope-clearHands when ^You really need to have at least one hand free to forage properly\.
action goto braidrope-done when ^I'm afraid that you can't pull that\.


###############################
###      VARIABLES
###############################
var skinType null
var skins bone|eye|fang|hide|horn|pelt|sac|skin|teeth|toe|tooth|tusk
var readyToPull false

if (matchre ("$righthandnoun", "(%skins)")) then {
    var skinType $1
}

if (matchre ("$lefthandnoun", "(%skins)")) then {
    var skinType $1
}

###############################
###      MAIN
###############################
braidrope-main:
    gosub braidrope-clearHands
    gosub braidrope-forage
    gosub braidrope-braid
    gosub braidrope-pull
    if (%skinType <> null) then {
        gosub get my %skinType
    }
    goto braidrope-done



###############################
###      UTILITY
###############################
braidrope-clearHands:
    if !(matchre("$righthand", "grass")) then {
        gosub stow
    }

    if !(matchre("$lefthand", "grass")) then {
        gosub stow left
    }
    return


braidrope-forage:
    if ($monstercount != 0) then {
        gosub retreat
        gosub retreat
    }

    gosub forage grass
    if !(matchre("$righthandnoun|$lefthandnoun", "grass")) then {
        gosub braidrope-forage
    }
    return


braidrope-braid:
    if (%getMoreGrass = true) then {
        gosub braidrope-forage
    }

    if (%readyToPull = true) then return

    if ($monstercount != 0) then {
        gosub retreat
        gosub retreat
    }
    gosub braid my grass
    goto braidrope-braid


braidrope-pull:
    if (matchre("$righthandnoun|$lefthandnoun", "rope")) then return
    if ($monstercount != 0) then {
        gosub retreat
        gosub retreat
    }
    gosub pull my grass
    goto braidrope-pull


braidrope-done:
    pause
    put #parse BRAIDROPE DONE
    exit
