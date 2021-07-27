###############################
###      Duskruin Heist 2021
###############################


###############################
###      ACTION VARIABLES
###############################
action goto heist.failure when ^Suddenly, a .* surrounds you! You attempt to escape, but are met with .*\.$
action goto heist.collectPrize when You begin making your way out of the bank\.|You glance around, but see no signs of any threats\.
action goto heist.encounter when You make your way deeper inside the bank\.
action goto heist.encounterLoop when eval $monstercount = 0
action #send cast when You feel fully prepared|Your formation of a targeting pattern around a
action var heist.doCutRope 1 when Perhaps you could cut that
action var heist.doGuard 1 when You should guard it before it is stolen\.
action var heist.doObserve 1 when You should watch or observe for clues in the bank\.
action var heist.doPace 1 when You should pace to make some extra footprints\.
action var heist.doSteal 1 when ^You should steal whatever is inside the .*\.
action var heist.doTrack 1 when ^You secure the contents|Some movement can be seen out of the corner of your eye\.|You should track|Perhaps you should look for clues\.|There is nothing else to face\!
action var heist.doWatch 1 when You see something entering the area\.|Perhaps you should try to WATCH your surroundings\.|You should watch or observe for clues in the bank\.|Perhaps you should look for clues\.
action var heist.doSneak 1 when You should sneak somewhere else\.
action var heist.prizes $1 when ^You rummage through.*and see (.*)\.$


###############################
###      VARIABLES
###############################
# Heist Type options:
# battlemaster - Perception, Outdoorsmanship
# brigand - Thievery, Stealth, Perception
# enforcer - Athletics, Stealth, Perception
var heist.heistType battlemaster

# Add weapon here or put null for Brawling.
var heist.weapon assassin blade

# Add debilitation spell and mana for prep here or put null for non-magic user.
var heist.spell nb
var heist.mana 15

# Heist Type Values
var heist.room.battlemaster 54
var heist.begin.battlemaster listen
var heist.doGuard 0
var heist.doListen 0
var heist.doTrack 0

var heist.room.brigand 56
var heist.begin.brigand observe
var heist.doPace 0
var heist.doObserve 0
var heist.doSteal 0

var heist.room.enforcer 55
var heist.begin.enforcer watch
var heist.doCutRope 0
var heist.doSneak 0
var heist.doWatch 0

var heist.toDoList %heist.doGuard|%heist.doListen|%heist.doTrack|%heist.doObserve|%heist.doPace|%heist.doSteal|%heist.doCutRope|%heist.doSneak|%heist.doWatch
var heist.toDoCommand guard|listen|track|observe|pace|steal|cut rope|sneak|watch
var heist.toDoIndex 0
var heist.command 0
var heist.length 0
eval heist.length count("%heist.toDoList", "|")


###############################
###      CHECKS
###############################
heist.checkLocation:
    if !contains("$roomname", "Duskruin") then {
        put #echo >Log [heist] You're not in Duskruin, exiting.
        goto heist.exit
    }
    if ($roomid = %heist.room.%heist.heistType) then {
        goto heist.checkWeapon
    } else {
        gosub automove %heist.room.%heist.heistType
    }
    goto heist.checkLocation


heist.checkWeapon:
    if ("$righthand" <> "Empty") then {
        gosub stow
    }
    if (%heist.weapon <> null) then {
        gosub get my %heist.weapon
        if ("$righthand" <> "%heist.weapon" || "$righthandnoun" <> "%heist.weapon") then {
            put #echo >Log [heist] Your weapon is missing.
            goto heist.exit
        }
    }
    goto heist.startEncounter


heist.checkDuelingSlips:
    if ("$lefthand" <> "Empty") then {
        gosub stow left
    }
    gosub get my dueling slip
    if ("$lefthandnoun" = "slip" || "$lefthandnoun" = "slips") then {
        goto heist.startEncounter
    } else {
        put #echo >Log [heist] You have no dueling slips remaining.
        goto heist.exit
    }


###############################
###      MAIN
###############################
heist.startEncounter:
    if !matchre("$roomobjs", "%heist.heistType") {
        put #echo >Log [heist] Script is configured for %heist.heistType, but the NPC is missing.
        goto heist.exit
    }
    gosub join %heist.heistType
    goto heist.encounter


heist.encounter:
    # Do first verb.  Based on heist type.
    gosub %heist.begin.%heist.heistType

    if ("%heist.spell" <> null) then {
        gosub prep %heist.spell %heist.mana
    }

    heist.encounterLoop:
        if ($monstercount = 0) then {
            gosub heist.checkToDo
            goto heist.encounterLoop
        } else {
            gosub attack
        }



# Check to see if any commands got triggered and execute them.
heist.checkToDo:
    if matchre("%heist.toDoList", 1) then {
        var heist.index 0


        heist.checkToDoLoop:
            if ("%heist.toDoList(%heist.index)" = 1) then {
                var heist.command %heist.toDoList(%heist.index)
                gosub %heist.toDoCommand(%heist.index)

                # Reset variable and rebuild array.
                var heist.do%heist.command 0
                var heist.toDoList %heist.doGuard|%heist.doListen|%heist.doTrack|%heist.doObserve|%heist.doPace|%heist.doSteal|%heist.doCutRope|%heist.doSneak|%heist.doWatch
                return
            }
            math heist.index add 1
            if (%heist.index > %heist.length) then return
            goto heist.checkToDoLoop
    }


heist.collectPrize:
    if (%heist.weapon <> null) then {
        gosub stow right
    }
    if ("$lefthand" = "burlap pouch") then {
        gosub open my burlap pouch
        gosub get my bloodscrip
        gosub rummage my burlap pouch
        put #echo >Log [heist] Prizes: %heist.prizes
        gosub stow my burlap pouch
    } else {
        put #echo >Log [heist] Unable to locate prize pouch.  Did you fail?
    }
    if (%heist.doLoop = 1) then {
        goto heist.checkLocation
    }
    goto heist.done


heist.done:
    put #echo >log [heist] Complete.
    exit


heist.failure:
    put #echo >Log [heist] You FAILED the heist event!  Please check your settings before trying again.
    exit


###############################
###      COMMAND UTILITY
###############################
advance:
    var location advance1
    var todo $0
    advance1:
    matchre return ^What do you want to advance towards\?
    matchre return ^You are already advancing on
    matchre return ^You are already at melee with
    matchre return ^You begin to advance on
    matchre return ^You begin to stealthily advance on
    matchre return ^You spin around to face
    matchre return ^You will have to retreat from your current melee first\.
    put advance %todo
    goto retry


advance2:
    if $hidden = 1 then put shiver
    pause
    put engage
    pause 2
    goto Attack1


aim:
    var location aim1
    var todo $0
    aim1:
    matchre return ^At what are you trying to aim\?
    matchre return ^But the .+ in your right hand isn't a ranged weapon\!
    matchre return ^You are already targetting that\!
    matchre return ^You begin to target
    matchre return ^You don't have a ranged weapon to aim with\!
    matchre return ^You need both hands in order to aim\.
    matchre return ^You shift your target to
    matchre return ^Your .+ isn't loaded\!
    put aim %todo
    goto retry


attack:
    var todo $0
    var location attack1
    if $stamina < 85 then pause 3
    pause .1
    attack1:
    if $stamina < 85 then pause 4
    if $standing = 0 then put stand
    matchre attack.advance ^You must be closer
    matchre attack.advance ^It would help if you were closer
    matchre attack.advance ^You are already advancing
    matchre attack.advance ^You aren't close enough to attack\.
    matchre attack2 ^You should stand up first\.
    matchre return ^At what are you trying
    matchre return ^But you don't have a ranged weapon in your hand to fire with\!
    matchre return ^But your .* isn't loaded\!
    matchre return ^How can you snipe if you are not hidden\?
    matchre return ^I could not find what you were referring to\.
    matchre return is already quite dead\.
    matchre return ^\[Roundtime
    matchre return ^Roundtime:
    matchre return sphere
    matchre return ^The .* is already debilitated\!
    matchre return ^The khuj is too heavy for you to use like that\.
    matchre return ^There is nothing else to face
    matchre return ^What are you trying to
    matchre return ^Wouldn't it be better
    matchre return ^You can not slam with that
    matchre return ^You don't have a weapon to draw with\!
    matchre return ^You must have both hands free to use the
    matchre return ^You must be hidden or invisible to ambush\!
    matchre return ^You need two hands to wield this weapon\!
    put %todo
    goto retry


attack2:
    gosub stand
    var location attack1
    goto Attack1


attack.advance:
	gosub advance
	return


fire:
    var location fire1
    var todo $0
    fire1:
    matchre return Roundtime
    matchre return ^That weapon must be in your right hand to fire
    matchre return ^There is nothing else to face
    matchre return ^What are you trying to attack
    matchre return ^You turn to face
    put fire %todo
    goto retry


get:
    var location get1
    var todo $0
    get1:
    matchre return ^But that is already in your inventory\.
    matchre return ^Please rephrase that command\.$
    matchre return ^That is far too dangerous
    matchre return ^What were you referring to\?
    matchre return ^You are a bit too busy
    matchre return ^You are already holding that\.
    matchre return ^You are not strong enough to pick that up\!
    matchre return ^You carefully pull
    matchre return ^You deftly remove
    matchre return ^You fade in for a moment
    matchre return ^You get
    matchre return ^You must unload the
    matchre return ^You need a free hand
    matchre return ^You pick up
    matchre return ^You pull
    put get %todo
    goto retry


hide:
    var location hide
    matchre return discovers you, ruining your hiding place\!
    matchre return ^Eh\?  But you're already hidden
    matchre return notices your attempt to hide\!
    matchre return reveals you, ruining your hiding attempt
    matchre return ^Roundtime
    matchre return ^You blend in with your surroundings
    matchre return ^You can't hide in all this armor\!
    matchre return ^You melt into the background
    matchre return ^You slip into a hiding
    put hide
    goto retry


join:
    var location join1
    var todo $0
    join1:
    matchre return ^You hold out your dueling slip
    put join %todo
    goto retry


load:
    var location load1
    var todo $0
    load1:
    matchre return ^Roundtime
    matchre return ^What weapon are you trying to load\?
    matchre return ^You can't load .+, silly\!
    matchre return ^You don't have the proper ammunition readily available for your
    matchre return ^You need to hold the
    matchre return ^Your .+ is already loaded
    put load %todo
    goto retry


listen:
    var location listen1
    var todo $0
    listen1:
    matchre return ^Roundtime
    matchre return You hear something nearby\.
    matchre return You're all set here, time to move on\.
    matchre return ^You've already listened to your surroundings\.
    matchre return ^You pause a moment to listen
    put listen %todo
    goto retry


observe:
    var location observe1
    var todo $0
    observe1:
    matchre return ^Roundtime
    matchre return ^You observe your surroundings
    put observe %todo
    goto retry


sneak:
    var location sneak1
    var todo $0
    sneak1:
    matchre return ^Roundtime
    matchre return ^You attempt to sneak off deeper into the bank
    matchre return You prepare yourself to sneak
    put sneak %todo
    goto retry


steal:
    var location steal1
    var todo $0
    steal1:
    matchre return ^Roundtime
    matchre return ^You cautiously attempt to lift
    matchre return ^You consider it, but
    matchre return ^You couldn't get close enough to steal anything in time\.
    matchre return ^You glance around but your mark seems to be missing\.
    matchre return ^You haven't picked something to steal\!
    matchre return ^You need at least one hand free to steal\.
    matchre return ^You start to steal from
    put steal %todo
    goto retry


stow:
    var location stow1
    var todo $0
    stow1:
    if ("%todo" = "" && "$righthand" = "Empty") then return
    if ("%todo" = "right" && "$righthand" = "Empty") then return
    if ("%todo" = "left" && "$lefthand" = "Empty") then return
    matchre return ^But that is already in your inventory\.
    matchre return ^I can't find your container
    matchre return ^Stow what\?
    matchre return ^You can't pick that up with your hands that damaged\.$
    matchre return ^You carefully
    matchre return ^You hang your
    matchre return ^You need a free hand to pick that up\.
    matchre return ^You open your pouch
    matchre return ^You pick up
    matchre return ^You put your
    matchre return ^You stop as you realize
    matchre return ^You think the .* pouch is too full to fit another gem into\.
    matchre return ^You try to
    matchre location.unload ^You need to unload the
    matchre location.unload ^You should unload the
    put stow %todo
    goto retry


track:
    var location track1
    var todo $0
    track1:
    matchre return ^You attempt to track any threats within the bank
    matchre return ^It's not safe enough to track anything\.
    matchre return ^Perhaps you should look for clues\.
    matchre return You spot some footprints nearby\.
    put track %todo
    goto retry


watch:
    var location watch1
    var todo $0
    watch1:
    matchre return ^Roundtime
    matchre return ^You are not currently watching anything\.
    matchre return ^You begin watching for the presence
    matchre return ^You feel too distracted to be on the lookout for somebody again right now\.
    matchre return You see something entering the area\.
    put watch %todo
    goto retry


###############################
###      RETRY UTILITY
###############################
location:
    goto %location


location.p:
    pause 1


location.tooFast:
    random 1 2
    pause %r

location.unload:
    var unloadTodo %todo
    gosub unload
    gosub stow left
    gosub stow %unloadTodo
    return


retry:
    matchre return ^Roundtime
    matchre return ^Please rephrase that command\.$
    matchre location ^\.\.\.wait
    matchre location ^Sorry, system is slow
    matchre location.tooFast ^Sorry, you may
    matchre location.p ^It's all a blur
    matchre location.p There is no need for violence here\.
    matchre location.p ^You are still stunned
    matchre location.p ^You attempt that, but end up getting caught in an invisible box\.
    matchre location.p ^You can't do that while entangled in a web\.
    matchre location.p ^You don't seem to be able to move to do that
    matchre location.p ^You struggle against the shadowy webs to no avail\.
    matchre location.p ^You're unconscious\!
    matchwait 30
    math retryAttempts add 1
    echo [ heist -> retry ] No match found, %retryAttempts retries
    var heist.retryAttempts %retryAttempts
    if (%retryAttempts > 10) then {
         put #echo #FF0000 [heist] RETRIED 10 TIMES, NO MATCHES! FORCING RETURN!
         put var heist.responseNotFound 1
         return
    }
    goto location


return:
    return

-----------
getBlade:
  matchre getBlade ...wait|Sorry
  match getSlip You deftly remove
  put wield my %weapon
  matchwait

getSlip:
  matchre getSlip ...wait|Sorry
  match join You get a dueling slip 
  put get my slip
  matchwait

join:
  matchre join ...wait|Sorry
  match listen You hold out your dueling slip and a Chrematistic Investor battlemaster takes it, escorting you to the bank.
  put join battlemaster
  matchwait

listen:
  matchre listen  ...wait|Sorry
  matchre return You're all set here, time to move on\.
  matchre attackWait  Roundtime|You've already listened to your surroundings.
  put listen
  matchwait

attackWait:
  waitforre assassin|bandit|asp|eagle
  put prep %tmSpell %mana
  goto attack

cast:
  matchre cast ...wait|Sorry
  match attack Roundtime
  put cast
  matchwait

attack:
  matchre attack ...wait|Sorry
  matchre track There is nothing else to face
  match attack Roundtime
  put attack
  matchwait

track:
  match attack It's not safe enough to track anything.
  matchre track ...wait|Sorry
  match listen Roundtime
  put track
  matchwait

sheath:
  matchre sheath ...wait|Sorry
  match openPouch You hang 
  put sheath
  matchwait

openPouch:
  matchre getBS You open your burlap pouch.
  match openPouch ...wait|Sorry
  put open my pouch
  matchwait

getBS:
  matchre getBS ...wait|Sorry
  match rummagePouch You pick up
  put get my bloo
  matchwait

rummagePouch:
  match exit You rummage through
  matchre rummagePouch ...wait|Sorry
  put rummage my pouch
  matchwait

exit:
  exit