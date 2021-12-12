####################################################################################################
# libmaster.cmd
# Selesthiel - justin@jmdoyle.com
# Inauri - snmurphy95@gmail.com
#
# USAGE
# include libmaster.cmd
#
# gosub <verb> [options]
#
# gosub stow right
# gosub prep burn 20
#
# Has a label for each verb. invoking `gosub <verb>` will automatically retry in the case of RT, or stand
# (as appropriate), etc...
# stow, stow right, stow left will not try send any commands if your hand is Empty
# NOTE: This assumes you have you 15 sigil books with the colors in the `colors` array!
####################################################################################################
var libmasterLoaded 1

var retryAttempts 0
action var retryAttempts 0 when eval %todo


###############################
###    CHAR VARIABLES
###############################
put .var_$charactername.cmd
waitforre ^CHARVARS DONE$


###############################
###    INIT
###############################
action clear
gosub clear
Counter Set 0
Timer clear
var reconnects 0
var listen null

put #var powerwalk 0
put #var caravan 0
put #var drag 0

var todo


###############################
###    BURGLE
###############################
#put #trigger {^You should wait at least (\d+) roisaen for the heat to die down\.$} {#var lib.timers.nextBurgleAt #evalMath {($1 * 60) + $gametime + 120}} {timers}
#put #trigger {^The heat has died down from your last caper\.$} {#var lib.timers.nextBurgleAt $gametime} {timers}
#put #trigger {^A tingling on the back of your neck draws attention to itself by disappearing, making you believe the heat is off from your last break in\.$} {#var lib.timers.nextBurgleAt $gametime} {timers}


###############################
###    CROSSBOWS
###############################
var crossbowItems crossbow|stonebow|latchbow|pelletbow|lockbow


###############################
###    CYCLICS
###############################
put #class cyclicBarbarian off
put #class cyclicBard off
put #class cyclicCleric off
put #class cyclicEmpath off
put #class cyclicMoonMage off
put #class cyclicNecromancer off
put #class cyclicPaladin off
put #class cyclicRanger off
put #class cyclicThief off
put #class cyclicTrader off
put #class cyclicWarriorMage off

# NECROMANCER
put #trigger {^You weave a field of sublime corruption, concealing the scars in your aura under a layer of magical pretense\.$} {#tvar char.cast.cyclic.lastCastGametime.roc $gametime} {cyclicNecromancer}
put #trigger {^You project your self-image outward on a gust} {#tvar char.cast.cyclic.lastCastGametime.rog $gametime} {cyclicNecromancer}
if ("$guild" = "Necromancer") then {
    if (!($char.cast.cyclic.lastCastGametime.roc > 0)) then put #tvar char.cast.cyclic.lastCastGametime.roc 1
    if (!($char.cast.cyclic.lastCastGametime.rog > 0)) then put #tvar char.cast.cyclic.lastCastGametime.rog 1

    put #class cyclicNecromancer on
}

# MOON MAGE
put #trigger {^Several motes of light gather, briefly forming} {#tvar char.cast.cyclic.lastCastGametime.sls $gametime} {cyclicMoonMage}
if ("$guild" = "Moon Mage") then {
    if (!($char.cast.cyclic.lastCastGametime.sls > 0)) then put #tvar char.cast.cyclic.lastCastGametime.sls 1

    put #class cyclicMoonMage on
}


###############################
###    HE/2HE SWAPPING
###############################
action var weapon_hand The when ^With a quiet snarl, you move your hands to grip your sword as a two-handed edged weapon\.$
action var weapon_hand The when ^You deftly change your grip on your sword so it can be used as a two-handed edged weapon\.$
action var weapon_hand The when ^You draw out your .* sword from the .*, gripping it firmly in your right hand and balancing with your left\.$
action var weapon_hand The when ^You effortlessly switch to a grip for using your sword as a two-handed edged weapon\.$
action var weapon_hand The when ^Your eyes blaze as your hands move to a two-handed edged grip on your sword\.$
action var weapon_hand The when ^You fiercely switch your grip so that your sword can be used as a two-handed edged weapon\.$
action var weapon_hand The when ^You switch your sword so that you can use it as a two-handed edged weapon\.$
action var weapon_hand The when ^You turn your sword easily in your hands and end with it in position to be used as a two-handed edged weapon\.$
action var weapon_hand The when ^Silver light kisses the surface of your bastard sword as you shift it to a two-handed edged grip\.$
action var weapon_hand The when ^With one superbly balanced motion, you shift your bastard sword to a two-handed edged grip in front of your heart\.$
action var weapon_hand The when ^You shift your.*to a two-handed edged grip while quietly paying homage to the war gods\.$


action var weapon_hand he when ^With a quiet snarl, you move your hands to grip your.*as a heavy edged weapon\.$
action var weapon_hand he when ^You deftly change your grip on your sword so it can be used as a heavy edged weapon\.$
action var weapon_hand he when ^You draw out your .* sword from the .*, gripping it firmly in your right hand\.$
action var weapon_hand he when ^You effortlessly switch to a grip for using your sword as a heavy edged weapon\.$
action var weapon_hand he when ^Your eyes blaze as your hands move to a heavy edged grip on your sword\.$
action var weapon_hand he when ^You fiercely switch your grip so that your sword can be used as a heavy edged weapon\.$
action var weapon_hand he when ^You switch your sword so that you can use it as a heavy edged weapon\.$
action var weapon_hand he when ^You turn your sword easily in your hands and end with it in position to be used as a heavy edged weapon\.$
action var weapon_hand he when ^Silver light kisses the surface of your.*as you shift it to a heavy edged grip\.$
action var weapon_hand he when ^With one superbly balanced motion, you shift your bastard sword to a heavy edged grip in front of your heart\.$
action var weapon_hand he when ^You shift your.*to a heavy edged grip while quietly paying homage to the war gods\.$
var weapon_hand NONERIGHTNOW


###############################
###    DEAD
###############################
#action goto exit.full when ^You are a ghost\!
#action goto exit.full when ^You are a ghost\!  You must wait until someone resurrects you, or you decay\.
#action goto exit.full when ^You are somewhat comforted that you have gained favor with your God and are in no danger of walking the Starry Road, never to return\.
#action goto exit.full when ^Your body will decay beyond its ability to hold your soul
#action goto exit.full when ^Your death cry echoes in your brain
#action goto exit.full when ^You feel like you're dying\!
#action goto exit.full when ^You feel yourself falling\.\.\.


###############################
###    HIDDEN
###############################
action var Hidden 0 when ^You blend in with your surroundings|^You slip into a hiding|^You melt into the background|^Darkness falls over you like a cloak, and you involuntarily blend into the shadows\.|^Eh\?  But you're already hidden
action var Hidden 1 when ^You leap out of hiding|^You come out of hiding\.|^You burst from hiding and begin to dance about\!|^You slip out of hiding\.|notices your attempt to hide|discovers you, ruining your hiding place|reveals you, ruining your hiding attempt
var Hidden 1


###############################
###    FORAGEBLE
###############################
#action send dump junk when ^The room is too cluttered to find anything here\!
action var foragable 1 when ^The room is too cluttered to find anything her
action var foragable 0 when ^A scavenger troll strolls in, looks you squarely in the eye and says
action var foragable 0 when ^A low fog rolls in, then just as quickly rolls out
var foragable 0


###############################
###    JUSTICE
###############################
action put #var lib.justice 0 when You're fairly certain this area is lawless and unsafe\.$
action put #var lib.justice 1 when After assessing the area, you think local law enforcement keeps an eye on what's going on here\.$
action put #var lib.justice 2 when After assessing the area, you believe there is some kind of unusual law enforcement in this area\.$


###############################
##    MAGIC
###############################
if ("$charactername" = "Inauri") then {
    action goto refreshRegen when eval $health < 50
}
action put #var lib.magicInert 1 when ^The spell pattern resists the influx of unstable mana, overloading your arcane senses and rendering you magically inert\.
action put #var lib.magicInert 0 when ^Awareness enfolds you like the embrace of a loving parent as your attunement to (Life|Lunar|Arcane|Elemental|Holy) mana returns\.
action (checkForBacklashDebuff) var lib.debuffedSkills %lib.debuffedSkills|$1 when ^--.* (Lunar Magic|Augmentation|Debilitation|Utility|Warding|Sorcery)

###############################
###    ROOM OCCUPIED
###############################
#action var People.Room occupied when ^A howl echoes about you as a wolf calls to his kind\!$
#action var People.Room occupied when ^With a waver like a mirage, \w+ fades into view\.$
#action var People.Room occupied when ^You notice \w+ loading
#action var People.Room occupied when ^\w+ appears to be aiming at
#action var People.Room occupied when ^You notice \w+'s attempt to remain hidden
#action var People.Room occupied when Appearing to have lost sight of its target
#action var People.Room occupied when comes out of hiding\.$
#action var People.Room occupied when ^\w+ leaps from hiding
#action var People.Room occupied when slips out of the shadows
#action var People.Room occupied when Someone snipes
#action var People.Room occupied when attempt to fire from hiding\.$
#action var People.Room occupied when ^You hear
#action var People.Room occupied when You hear the spine-chilling hiss of a S'Kra Mur somewhere in the shadows\.$
#action var People.Room occupied when bursts from hiding and begins to dance about\!$
#action var People.Room occupied when ^You notice \w+ as \w+ stealthily closes to.(melee|missle) on a
#action var People.Room occupied when ^You notice \w+ attempting to stealthily advance upon a
#action var People.Room occupied when ^You hear someone cough\.$
#action var People.Room occupied when ^You hear the voice of \w+ say, "
#action var People.Room occupied when ^\w+ moves into a position to (parry|dodge)\.$
#action var People.Room occupied when ^\w+ coughs\.$
#action var People.Room occupied when ^\w+ says, "
#action var People.Room occupied when ^\w+ gestures at a \w+\.$
#var People.Room empty


###############################
###    SKINNING
###############################
#var pelts.keep (celpeze eye)
#var pelts.empty (rat pelt|goblin skin|goblin hide|hog hoof|eel skin|razorsharp claw|leucro pelt|white pelt|curved tusk|caracal pelt|plated claw)


###############################
###    SLEEP / AWAKE
###############################
#action put sleep when ^Overall state of mind: (very murky|thick|very thick|frozen|very frozen|dense|very dense)
#action put sleep when ^Overall state of mind: murky
#action put awake when ^Overall state of mind: clear

#action put #echo log1 *** sleeping *** when ^You relax and allow your mind to enter a state of rest\.
#action put #echo log1 *** awake *** when ^You awaken from your reverie and begin to take in the world around you|^Your mind cannot rest while you are doing

#action var sleep 0 when ^You relax and allow your mind to enter a state of r
#action var sleep 1 when ^You awaken from your reverie and begin to take in the world aro


###############################
###    STANCE
###############################
put #trigger {^You are now set to use your (\S+) stance} {#var lastStanceGametime $gametime;#var stance \$1} {stance}


###############################
###    STAND
###############################
#action put STAND when eval $standing = 0
action send stand when ^You can't do that while lying down
action send stand when ^You had better stand up first
action send stand when ^You might want to stand up first
action send stand when ^You must stand first
action send stand when ^You should stand up first\.
action send stand when ^You'd have better luck standing up
action send stand when ^You'll have to move off the sandpit first\.

action send climb track when ^You will have to climb that\.


###############################
###    TEACHING
###############################
action put #var lib.class 0 when ^All of your students have left, so you stop teaching\.$
action put #var lib.class 0 when ^Because you have no more students, your class ends\.$
action put #var lib.class 0 when ^But you aren't teaching anyone\.$
action put #var lib.class 0 when ^You stop teaching so as not to disturb the aura of quiet here\.$
action put #var lib.class 0 when ^You stop teaching\.$
action put #var lib.class 1 when ^\S+ begins to listen to you teach the .* skill\.$
action put #var lib.class 1 when ^You are teaching a class on .*$
action put #var lib.class 1 when ^You continue to instruct your students? on .*\.$
action put #var lib.student 1 when ^You begin to listen to \w+ teach.*$
action put #var lib.student 1 when ^.*You are (in|observing) this class\!$
action put #var lib.student 0 ; put #var lib.instructor $1 when ^(\S+) is teaching a class on .* which is still open to new students\.$
action put #var lib.student 0 when ^Being unconscious, you make a lousy student, so \w+ stops teaching you\.$
action put #var lib.student 0 when ^But you aren't listening to anyone\.$
action put #var lib.student 0 ; put #var lib.class 0 ; put #var lib.topic 0 when ^No one seems to be teaching\.$
action put #var lib.student 0 when ^You stop listening to \w+\.$`
action put #var lib.student 0 when ^Your teacher (has left|is not here), so you are no longer learning anything\.$
action put #var lib.student 0 ; put #var lib.class 0 when ^You're unconscious\!$
action put #var lib.topic $1 when ^You are teaching a class on (.+?) which.*$
action put #var lib.topic $1 when .* know\) (.*) which is .*\.  You are in this class\!
action put #var lib.topic 0 when No one seems to be teaching\.

###############################
###    WAIT FOR PREP
###############################
action var isFullyPrepped 1 when ^Your concentration lapses for a moment, and your spell is lost.$
action var isFullyPrepped 1 when ^Your concentration slips for a moment, and your spell is lost.$
action var isFullyPrepped 1 when ^You feel fully prepared to cast your spell.
action var isFullyPrepped 1 when ^Your formation of a targeting pattern
action var isFullyPrepped 0 when eval $preparedspell = None

action var observeOffCooldown true when ^Although you were nearly overwhelmed by some aspects of your observation
action var observeOffCooldown true when ^You feel you have sufficiently pondered your latest observation\.$
action var observeOffCooldown false when ^While the sighting wasn't quite what you were hoping for, you still learned from your observation\.$
action var observeOffCooldown false when ^You are unable to make use of this latest observation
action var observeOffCooldown false when ^You have not pondered your last observation sufficiently\.$
action var observeOffCooldown false when ^You learned something useful from your observation\.$

#######################################################################################################################################

action send 2 #parse MOVE FAILED;echo [libmaster] parsed for failed move when DESTINATION NOT FOUND

#######################################################################################################################################

#Skip to the end of the file, don't execute this because this is just an include
goto end.of.file

accept:
    var location accept1
    var todo $0
    accept1:
    matchre return ^Both of your hands are full\.
    matchre return ^You accept (.*)'s offer and are now holding
    matchre return ^You accept (.*)'s tip and slip it away\.
    matchre return ^You have no offers to accept\.
    put accept %todo
    goto retry


adjust:
    var location adjust1
    var todo $0
    adjust1:
    matchre return You adjust
    matchre return ^You cannot adjust
    put adjust %todo
    goto retry


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


affix:
    var location affix1
    var todo $0
    affix1:
    matchre return ^Roundtime
    matchre return ^You carefully attach
    put affix %todo
    goto retry


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


align:
    var location align1
    var todo $0
    align1:
    matchre return ^You focus internally
    matchre return ^Roundtime
    put align %todo
    goto retry


ana:
analyze:
    var location analyze1
    var todo $0
    analyze1:
    matchre return ^Analyze what
    matchre return ^Roundtime
    matchre return ^You can't
    matchre return ^You fail to find any holes
    matchre analyze.advance ^You must be closer
    put analyze %todo
    goto retry

analyze.advance:
    gosub advance
    return


app:
appraise:
    var location appraise1
    var todo $0
    appraise1:
    matchre return ^Appraise what\?
    matchre return ^I could not find what you were referring to\.
    matchre return ^It's dead
    matchre return ^It's hard to appraise
    matchre return ^Taking stock of its
    matchre return ^You cannot appraise that when you are in combat\!
    matchre return ^You can't
    matchre return ^Roundtime
    matchre return Roundtime:
    put appraise %todo
    goto retry


apply:
    var location apply1
    var todo $0
    apply1:
    matchre return ^Now the flights are ready to be trimmed with a carving knife\.$
    matchre return ^You apply some glue to your bolts and affix each bolthead in place\.$
    matchre return ^You dab the surface of your bolts with glue and attach the boltheads to them\.$
    put apply %todo
    goto retry


arr:
arrange:
    var todo $0
    var location arrange1
arrange1:
    matchre return ^Arrange what\?
    matchre return has already been arranged as much as you can manage\.
    matchre return Roundtime
    matchre return ^That creature cannot produce a skinnable part\.
    matchre return The .+ cannot be skinned, so you can't arrange it either.
    matchre return ^Try killing the
    matchre return currently being arranged
    matchre arrange ...wait
    matchre arrange Sorry
    put arrange %todo
    goto retry


ask:
    var location ask1
    var todo $0
    ask1:
    matchre return ^A pure white alfar avenger peers at you
    matchre return hands it to you\.$
    matchre return Osmandikar|Lakyan|Granzer|Randal|repairman
    matchre return ^The Shadow Servant stares at you in confusion.
    matchre return ^To whom are you speaking\?
    matchre return ^With a sad look
    matchre return ^You hand
    matchre ask.retreat ^You cannot do that while focusing on combat!
    put ask %todo
    goto retry


ask.retreat:
    gosub retreat
    goto %location


assemble:
    var location assemble1
    var todo $0
    assemble1:
    matchre return ^You place your .+ with your .+ bolts and carefully mark where it will attach when you continue crafting\.$
    put assemble %todo
    goto retry


assess:
    var location assess1
    var todo $0
    assess1:
    matchre return ^Members of your group\:$
    matchre return ^No one appears to be protected by a Paladin\.$
    matchre return ^Roundtime
    matchre return ^This isn't the place for that\.$
    matchre return ^You assess the teaching environment\.\.\.$
    matchre return ^You assess your combat situation\.\.\.$
    matchre return ^You study the area\.\.\.$
    put assess %todo
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
    matchre return ^You must be hidden or invisible to ambush\!
    matchre return ^You must have both hands free to use the
    matchre return ^You must hold
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


awake:
libAwake:
    var location awake1
    var todo $0
    awake1:
    matchre return ^But you are not sleeping!
    matchre return ^You awaken from
    put awake %todo
    goto retry
    put awake
    goto %location


avoid:
    var location avoid1
    var todo $0
    avoid1:
    matchre return ^You're now (?:allowing|avoiding) attempts to dance with you\.$
    matchre return ^You're now (?:allowing|avoiding) attempts to (?:drag|hold|join)\.$
    matchre return ^You're now (?:allowing|avoiding) attempts to hand you coins\.$
    matchre return ^You're now (?:allowing|avoiding) attempts to lead you into crime\.$
    matchre return ^You're now (?:allowing|avoiding) attempts to (?:teach|touch) you\.$
    matchre return ^You're now (?:allowing|avoiding) attempts to whisper to you\.$
    put avoid %todo
    goto retry


bank:
    var location bank1
    var todo $0
    bank1:
    matchre return \[
    matchre return ^You don't
    matchre return ^But you don't have any
    put bank %todo
    goto retry


block.stop:
    var location block.stop
    matchre return ^In the name of love
    matchre return ^Okay\.
    matchre return ^You stop
    matchre return ^You aren't trying to defend against a second foe\!
    put block stop
    goto retry


braid:
    var location braid1
    var todo $0
    braid1:
    matchre return ^Braid what
    matchre return ^Roundtime
    matchre return ^You are a little too busy
    matchre return ^You begin to carefully braid
    matchre return ^You need to have
    put braid %todo
    goto retry


break:
    var location break1
    var todo $0
    break1:
    matchre return ^You thrust your
    put break %todo
    goto retry


build:
	var location build1
	var todo $0
	build1:
	matchre return ^You slowly
	put build %todo
	goto retry


bundle:
    var location bundle
    var todo $0
    bundle1:
    matchre return ^Only completed items can be bundled with the work order\.
    matchre return ^That's not going to work\.
    matchre return ^The work order requires items of a higher quality
    matchre return ^You bundle up your
    matchre return ^You have already bundled enough
    matchre return ^You notate
    matchre return ^You realize you have items bundled with the logbook
    matchre return ^You stuff your
    matchre return ^You try to stuff your.*into the bundle but can't seem to find a good spot\.
    put bundle %todo
    goto retry


bundle2:
    if "$lefthand" != "Empty" then put stow left
    gosub get bundling rope
    goto bundle


burgle:
    var location burgle
    var todo $0
    burgle1:
    matchre return ^The BURGLE command
    matchre return ^You don't see any
    matchre return ^You should wait
    matchre return ^You take a moment to think
    put burgle %todo
    goto retry


card:
    var location card1
    var todo $0
    card1:
    matchre return ^You don't have room
    matchre return ^You must have a
    matchre return ^You slide
    put card %todo
    goto retry


carve:
    var location carve1:
    var todo $0
    carve1:
    matchre return ^Using slow strokes
    matchre return ^You carve
    matchre return ^You use your knife to carve detail into .* surface
    matchre return ^You whittle
    put carve %todo
    goto retry


cast:
    var location cast1
    var todo $0
    cast1:
    if ("$preparedspell" = "None") then return
    matchre return aids your spell\.$
    matchre return aid your spell\.$
    matchre return ^Currently lacking the skill to complete the pattern
    matchre return ^Disregarding the pain
    matchre return ^I could not find what you were referring to\.
    matchre return ^It would be better if you just stayed focused on your journey\.
    matchre return ^Lacking properly ritualized blood
    matchre return ^Return
    matchre return ^Rutilant sparks of light encircle
    matchre return ^The blood on your palm bubbles slightly
    matchre return ^The mental strain of this pattern
    matchre return ^With a flick of your wrist,
    matchre return ^With a wave of your hand,
    matchre return ^You attempt to quiet your mind
    matchre return ^You can't cast
    matchre return ^You clench your hands into fists
    matchre return ^You cup your hand before
    matchre return ^You don't have a spell prepared\!
    matchre return You draw your
    matchre return ^You gesture
    matchre return ^You have already fully prepared
    matchre return ^You have difficulty manipulating the mana streams, causing the spell pattern to collapse at the last moment\.
    matchre return ^You hold out your arms to either side
    matchre return ^You make a holy gesture
    matchre return ^You mutter incoherently to yourself
    matchre return ^You place your hands
    matchre return ^You project
    matchre return ^You raise your palms and face to the heavens
    matchre return ^You wave your hand\.
    matchre return ^You whisper the final word of your spell
    matchre return ^Your secondary spell pattern dissipates
    matchre return ^Your spell backfires
    matchre return ^Your spell pattern collapses
    matchre return ^Your target pattern dissipates
    matchre return ^You weave
    put cast %todo
    goto retry


center:
    var todo $0
    center1:
    var location center1
    matchre openTelescope ^You'll need to open
    matchre return ^Center what
    matchre return ^That's a bit tough to do when you can't see the sky\.
    matchre return ^The pain is too much
    matchre return ^What did you want
    matchre return ^You are unable to hold
    matchre return ^You put your eye to the
    matchre return ^You would probably need a periscope to do that.
    put center %todo
    goto retry


charge:
    var location charge1
    var todo $0
    charge1:
    matchre return ^Roundtime
    matchre return ^I could not find
    matchre return ^You are in no condition to do that
    matchre return ^You strain, but lack the mental stamina to charge
    put charge %todo
    goto retry


clean:
    var todo $0
    var location clean1
    clean1:
    matchre return ^You gently buff
    matchre return ^Clean
    matchre return  not in need of cleaning\.$
    matchre return ^You need
    matchre return ^That
    matchre return ^I think that's a personal thing
    matchre return sopping wet
    put clean %todo
    goto retry


climb:
    var todo $0
    climb1:
    var location climb1
    if $stamina < 60 then pause 3
    if $standing = 0 then put stand
    matchre climb1 ^Roundtime
    matchre climb2 ^You are engaged
    matchre climb3 ^Stand up first\.
    matchre return ^  CLIMB
    matchre return ^CLIMB
    matchre return ^Obvious
    matchre return ^You begin to practice your climbing skills\.
    matchre return ^You should stop practicing your climbing skill before you do that\.
    matchre location.p ^All this climbing back and forth is getting a bit tiresome
    matchre location.p ^You are too tired to climb that\.
    put climb %todo
    goto retry
climb2:
    gosub ret
    goto climb1
climb3:
    gosub stand
    goto climb1


close:
    var todo $0
    close1:
    var location close1
    matchre return ^That is already
    matchre return ^The door
    matchre return ^The door is open\.  You'll need to shut it first\.
    matchre return ^You close
    matchre return ^You collapse your telescope\.
    matchre return ^You need to be holding the telescope first\.
    matchre return ^You quickly
    matchre return ^You try, but the telescope won't collapse any further\.
    matchre return ^Your .* fan is already
    matchre return ^What were
    matchre return ^With a practiced flick of your wrist
    matchre return ^You try to close
    put close %todo
    goto retry


closeTelescope:
  put close my telescope
  goto %location


coll:
collect:
    var location collect1
    var todo $0
    collect1:
    matchre return ^Searching and searching
    matchre return ^The room is too cluttered
    matchre return ^You are certain
    matchre return ^You are sure
    matchre return ^You begin to forage
    matchre return ^You cannot collect anything while in combat\!
    matchre return ^You find something
    matchre return ^You forage
    matchre return ^You manage
    matchre return ^You really need to have at least one hand free to forage properly\.
    matchre return ^You wander
    put collect %todo
    goto retry


combine:
    var location combine1
    var todo $0
    combine1:
    matchre return ^Combine some
    matchre return ^Perhaps you should be holding that first\.
    matchre return ^Roundtime
    matchre return ^You combine
    matchre return ^You must be holding both substances to combine them
    put combine %todo
    goto retry


commune:
    var location commune1
    var todo $0
    commune1:
    matchre return ^As you commune
    matchre return ^Nothing happens
    matchre return ^You stop
    matchre return ^You struggle to commune
    put commune %todo
    goto retry


count:
    var location count1
    var todo $0
    count1:
    matchre return ^I could not find what
    matchre return ^That doesn't tell you much of anything.
    matchre return ^There are
    matchre return ^There is
    matchre return ^You count out
    matchre return ^You count some
    matchre return ^You count up the items in your
    matchre return ^You take a quick count of potential threats in the area\.\.\.
    put count %todo
    goto retry


cut:
    var location cut1
    var todo $0
    matchre return You carefully cut
    cut1:
    put cut %todo
    goto retry


dance:
    var location dance1
    var todo $0
    dance1:
    matchre return ^Roundtime
    matchre return ^Stop what\?
    matchre return ^You are off center, and have trouble focusing\.
    matchre return ^You push out your chest as you feel your eyes taking on a new and distant focus\.
    matchre return ^You slowly center yourself
    matchre return ^You slowly relax, letting the power of the dance fade from your core\.
    matchre return ^Your mind and body are focused on a Dance\.
    put dance %todo
    goto retry


decline:
    var location decline1
    var todo $0
    decline1:
    matchre return ^You decline (.*)'s offer\.
    matchre return ^You have no outstanding offers to decline\.
    matchre return ^Offer declined\.
    put decline %todo
    goto retry


dip:
    var location dip1
    var todo $0
    dip1:
    matchre return ^Roundtime
    matchre return ^You dip the
    put dip %todo
    goto retry


disarm:
    var location disarm1
    var todo $0
    disarm1:
    matchre return An aged grandmother could defeat this trap in her sleep\.
    matchre return A pitiful snowball encased in the Flames of Ushnish would fare better than you\.
    matchre return fails to reveal to you what type of trap protects it\.
    matchre return Prayer would be a good start for any attempt of yours at disarming the
    matchre return should not take long with your skills\.
    matchre return Somebody has already located and identified the current
    matchre return The odds are against you, but with persistence you believe you could disarm the
    matchre return The trap has the edge on you, but you've got a good shot at disarming the
    matchre return This trap is a laughable matter, you could do it blindfolded\!
    matchre return trap is a trivially constructed gadget which you can take down any time\.
    matchre return will be a simple matter for you to disarm\.
    matchre return with only minor troubles\.
    matchre return would be a longshot\.
    matchre return ^You attempt to disarm the trap
    matchre return You can disarm the .* with only minor troubles\.
    matchre return You could just jump off a cliff and save yourself the frustration of attempting this
    matchre return You get the distinct feeling your careless examination caused something to shift inside the trap mechanism\.  This is not likely to be a good thing\.
    matchre return You guess it is already disarmed\.|indicating the trap is no longer a danger\.
    matchre return You have an amazingly minimal chance at disarming the
    matchre return You have some chance of being able to disarm the
    matchre return You probably have the same shot as a snowball does crossing the desert.
    matchre return You really don't have any chance at disarming this
    matchre return You think this trap is precisely at your skill level\.
    matchre return You work with the trap for a while but are unable to make any progress\.
    put disarm %todo
    goto retry


dismantle:
    var location dismantle1
    var todo $0
    dismantle1:
    matchre return ^Aren't those generally found outdoors\?$
    matchre return Count yourself fortunate that the only thing truly injured is your pride\.$
    matchre return ^Dismantle what\?$
    matchre return ^While bunnies are useful for a great many things, they do not as a general rule serve well as janitors\.$
    matchre return ^You must be holding the object you wish to dismantle\.$
    matchre dismantle1 ^You can not dismantle the
    matchre dismantle1 ^You cannot dismantle the
    put dismantle %todo
    goto retry


dissect:
    var location dissect1
    var todo $0
    dissect1:
    matchre return ^What exactly are
    matchre return ^While likely a fascinating study
    matchre return ^You believe the
    matchre return ^You'll learn nothing
    put dissect %todo
    goto retry


dodge:
    var location Dodge
    matchre return ^But you are already dodging\!
    matchre return ^You are already in a position
    matchre return ^You move into a position
    matchre return ^You need two hands to wield this weapon\!
    matchre return ^Roundtime
    put Dodge
    goto retry


drag:
    var location drag1
    var todo $0
    drag1:
    matchre return ^Don't be silly\!
    matchre return ^I could not find what you were referring to\.
    matchre return ^Roundtime
    put drag %todo
    goto retry


drop:
    var location drop1
    var todo $0
    drop1:
    matchre return ^But you aren't holding that\.
    matchre return ^Having no further use
    matchre return ^What were you referring to\?
    matchre return ^Whoah!
    matchre return ^You discard
    matchre return ^You drop
    matchre return ^You spread
    put drop %todo
    goto retry


dump.junk:
    var location dump.junk
    matchre return ^\[You have marked this room to be cleaned by the janitor\.  It should arrive shortly.\]
    matchre return ^The janitor was recently summoned to this room\.  Please wait \d+ seconds\.
    matchre return ^You should just kick yourself in the shin\.  There is no junk here\.
    put dump junk
    goto retry


eat:
    var location eat1
    var todo $0
    eat1:
    matchre return ^What were you referring to\?
    matchre return ^You can't drink a
    matchre return ^You drink
    matchre return ^You eat
    matchre return ^You'd be better off trying to drink
    put %todo
    goto retry


empty:
    if "$lefthand" != "Empty" then gosub drop $lefthand
    if "$righthand" != "Empty" then gosub drop $righthand
    return


exchange:
    var location exchange1
    var todo $0
    exchange1:
    matchre return EXCHANGE
    matchre return money-changer
    matchre return ^But you don't
    matchre return ^You count out
    matchre return Lirums|Dokoras|Kronars
    put exchange %todo
    goto retry


exhale:
    var location exhale1
    var todo $0
    exhale1:
    matchre return ^Roundtime
    matchre return ^You sound a series of bursts
    matchre return ^Your lungs are tired from having sounded a warhorn so recently\.
    put exhale %todo
    goto retry


EXP:
    var location EXP1
    var todo $0
    EXP1:
    matchre return ^EXP HELP for more information
    matchre return ^Overall state of mind:
    matchre return ^The bonus
    matchre return ^The following skills
    matchre return ^You do not have
    put EXP %todo
    goto retry


face:
    var location face1
    var todo $0
    face1:
    matchre return Face what\?
    matchre return There is nothing else to face\!
    matchre return You turn to face
    put face %todo
    goto retry


fill:
    var todo $0
    fill1:
    var location fill1
    matchre return Roundtime
    matchre return There aren't
    matchre return You
    put fill %todo
    goto retry


fire:
    var todo $0
    fire1:
    var location fire1
    matchre return Roundtime
    matchre return ^That weapon must be in your right hand to fire
    matchre return ^There is nothing else to face
    matchre return ^What are you trying to attack
    matchre return ^You turn to face
    put fire %todo
    goto retry


flee:
    var todo $0
    flee1:
    var location flee1
    matchre return ^How do you expect to flee with your
    matchre return ^You assess your combat situation and realize you don't see anything engaged with you
    matchre return ^You manage to free yourself from engagement
    matchre return ^You melt into the background, convinced that your misdirect was successful
    matchre return ^Your attempt to flee has failed
    matchre return ^Your fate is sealed
    matchre flee2 ^You should stand up first\.
    put flee %todo
    goto retry
flee2:
    gosub stand
    goto flee1


foc:
focus:
    var location focus1
    var todo $0
    focus1:
    matchre return ^I could not find
    matchre return ^Roundtime
    matchre return ^You are in no condition to do that\.
    matchre return ^You focus your magical senses
    matchre return ^You move into the chaotic tides
    matchre return ^You need
    matchre return ^You reach out into the seemingly infinite strands of Lunar mana
    matchre return ^Your link to the .+ is intact\.
    put focus %todo
    goto retry


forage:
    if $Foraging.LearningRate > 33 then return
    forage1:
    var location forage2
    var todo $0
forage2:
    matchre return ^Roundtime
    matchre return ^You forage
    matchre return ^The room is too cluttered to find anything here\!
    matchre return ^You cannot forage while in combat\!
    matchre return ^You really need to have at least one hand free to forage properly\.
    put forage %todo
    goto retry


gaze:
    var location gaze1
    var todo $0
    gaze1:
    matchre return ^Doing that would give away your hiding place
    matchre return ^I could not find
    matchre return ^You gaze intently
    put gaze %todo
    goto retry


gesture:
    var location gesture1
    var todo $0
    gesture1:
    matchre return ^you gesture\.
    matchre return ^Roundtime:
    matchre return ^As you intone a quiet prayer to Meraud, your hands begin to glow with a faint silvery nimbus\.
    put gesture %todo
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


get.remove:
    gosub remove %todo
    goto location


give:
    var location give1
    var todo $0
    give1:
    matchre return ^A clerk
    matchre return ignores your offer
    matchre return Osmandikar|Lakyan|Granzer|Randal
    matchre return ^The apprentice repairman
    matchre return ^The Servant accepts
    matchre return ^There's nothing
    matchre return ^What is it
    matchre return ^You hand
    matchre return ^You may only
    matchre return ^You offer
    put give %todo
    goto retry


harn:
harness:
    #if $preparedspell = None then goto return
    var location harness1
    var todo $0
    harness1:
    matchre return ^Attunement:
    matchre return ^Roundtime
    matchre return ^Usage:
    matchre return ^You can't harness that much mana\!
    matchre return ^You strain, but cannot harness that much power\.
    matchre return ^You tap into the mana
    put harness %todo
    goto retry


health:
    var location health
    matchre return ^Your body feels
    matchre return ^Your spirit feels
    put health
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


hunt:
    var todo $0
    hunt1:
    var location hunt1
    matchre return ^Roundtime
    matchre return ^You don't have that target currently available\.
    matchre return ^You find yourself unable to hunt
    matchre return ^You move to hunt down your prey\.
    matchre return ^You take note
    matchre hunt3 ^You'll need to be standing up, first\.
    matchre hunt2 ^You'll need to disengage first\.
    matchre return ^Your prey seems to have completely vanished\.
    put hunt %todo
    goto retry
hunt2:
    gosub ret
    goto hunt1
hunt3:
    gosub stand
    goto hunt1


info:
    var location info
    matchre return ^Wealth:
    matchre return ^Concentration :
    matchre return ^Debt:
    put info
    goto retry


infuse:
    var location infuse1
    var todo $0
    infuse1:
    matchre return ^You don't have enough harnessed to infuse that much\.
    matchre return ^Roundtime
    put infuse %todo
    goto retry


inv:
inven:
inventory:
    var location inventory1
    var todo $0
    inventory1:
    matchre return ^\[Use INVENTORY HELP for more options\.\]$
    put inventory %todo
    goto retry


invoke:
    var location invoke1
    var todo $0
    invoke1:
    matchre return ^A finely balanced tago suddenly leaps
    matchre return By directing your focus, you ensure that energy drawn only when spells are cast\.
    matchre return ^Closing your eyes
    matchre return ^Invoke what?
    matchre return ^Magical rituals are exceedingly obvious.  You cannot do it while remaining hidden\.$
    matchre return ^Roundtime
    matchre return ^The cambrinth
    matchre return ^You are in no condition
    matchre return ^You don't have any
    matchre return ^You focus
    matchre return ^You gesture, adjusting the pattern that binds the shadowling to this plane\.
    matchre return ^You hold
    matchre return ^You must begin preparing a ritual spell before you can focus it
    matchre return You reach for its center and forge a magical link
    matchre return ^You're not sure what would happen
    matchre return ^You must be able to handle your (.*) with both hands to use it for a ritual.
    matchre invoke ^You reach for its center, attempting
    put invoke %todo
    goto retry


join:
    var location join1
    var todo $0
    join1:
    matchre return glances at you briefly and then steps away
    matchre return ^You hold out your dueling slip
    matchre return ^You join
    put join %todo
    goto retry


juggle:
    var location juggle1
    var todo $0
    juggle1:
    matchre return ^But you're not holding
    matchre return ^Don't be silly\!
    matchre return ^It's easier to juggle if you start
    matchre return ^Roundtime
    matchre return ^What were you referring to\?
    matchre return ^Your injuries make juggling impossible\.
    put juggle %todo
    goto retry


justice:
    var location justice
    justice1:
    matchre return You're fairly certain this area is lawless and unsafe\.$
    matchre return After assessing the area, you believe there is some kind of unusual law enforcement in this area\.$
    matchre return After assessing the area, you think local law enforcement keeps an eye on what's going on here\.$
    put justice
    goto retry


khri:
    var location khri1
    var todo $0
    khri1:
    matchre return not recognizable as a valid khri\.
    matchre return ^Roundtime
    matchre return ^Tapping into the well of mental power within
    matchre return ^You have not recovered from your previous
    matchre return ^You strain, but cannot focus your mind enough to manage that\.
    matchre return ^You're already using the
    put khri start %todo
    goto retry


khri.stop:
    var location khri.stop1
    var todo $0
    khri.stop1:
    matchre return ^Nothing happens, as you are not using any stoppable meditations\.
    matchre return ^You are unable to maintain the complex thought processes any longer and your mental faculties return to normal\.
    matchre return ^You are no longer able to keep your thoughts free from distraction, and your heightened ability to notice and avoid incoming dangers fails\.
    matchre return ^You attempt to relax your mind from all of its meditative states\.
    matchre return ^You feel mentally fatigued as your heightened paranoia ceases to enhance your knowledge of nearby escape routes\.
    matchre return ^Your augmented reaction times slow as one of your mental pillars supporting it ceases\.
    matchre return ^Your cool composure fades, and with it your heightened knowledge of enemies' weak points\.
    matchre return ^Your concentration fails, and you feel your body perceptibly slow\.
    matchre return ^Your concentration runs out, and your rapid analysis of incoming threats ceases\.
    matchre return ^Your extreme cunning vanishes as one of your mental pillars supporting it ceases\.
    matchre return ^Your focused mind falters, and you feel slightly less competent overall\.
    matchre return ^Your inward calm vanishes, the troubles of the world once more washing over you\.
    matchre return ^Your silence ends, placing you back into the normal field of perception\.
    matchre return ^Your mind's prowess wavers, and so too does the extra combat strength it granted you vanish\.
    put khri stop
    goto retry


kick:
    var location kick
    if ($standing = 0) then put stand
    matchre kick ^Loosing your footing at the last moment
    matchre kick ^You can't do that from your position\.
    matchre kick ^You can't quite manage
    matchre kick ^You throw a glorious temper tantrum\!
    matchre return Bringing your foot
    matchre return ^I could not find what you were referring to\.
    matchre return ^You take a step back and run up to the
    put kick pile
    goto retry


kiss:
    var location kiss1
    var todo $0
    kiss1:
    matchre return kiss
    matchre return ^You bend
    matchre return ^I don't
    put kiss %todo
    goto retry


kneel:
    var location kneel1
    var todo $0
    kneel1:
    matchre return ^Subservient type
    matchre return ^You humbly
    matchre return ^You kneel
    matchre return kneel
    put kneel %todo
    goto retry


lean:
    var location lean1
    var todo $0
    lean1:
    matchre return ^I could not find what you were referring to\.
    matchre return ^You lean
    matchre return ^You shift your weight\.
    put lean %todo
    goto retry


light:
    var location light1
    var todo $0
    light1:
    matchre return ^You strike
    matchre return ^Light
    matchre return ^But the
    matchre return ^Please rephrase
    matchre return ^What
    matchre return ^You can't
    put light %todo
    goto retry


link:
    var location link1
    var todo $0
    link1:
    matchre return ^Any deep empathic link or offers to form have been cancelled\.$
    matchre return ^You are maintaining a manifestation of the Hand of Hodierna link with (\S+)\.$
    matchre return ^You extend additional tendrils of life energy towards (\S+)
    matchre return ^You have a diagnostic link with (\S+)\.$
    matchre return ^You have a persistent diagnostic link with (\S+)\.$
    matchre return ^You gently allow the persistent link between you and (\S+) to dissipate\.$
    matchre return ^You reach out to (\S+) with your empathic senses
    put link %todo
    goto retry


listen:
    var location listen1
    var todo $0
    listen1:
    matchre return has closed the class to new students\.
    matchre return ^I could not find who you were referring to\.
    matchre return isn't teaching a class\.
    matchre return isn't teaching you anymore\.
    matchre return ^Who do you want to listen to
    matchre return ^You've already listened to your surroundings\.
    matchre return ^You are already listening to someone\.
    matchre return ^You are already offering someone else a class
    matchre return ^You begin to listen
    matchre return ^You cannot teach a skill and be a student at the same time\!
    matchre return ^You can't really learn anything when your instructor can't see you.
    matchre return ^You don't have the appropriate training to learn that skill.
    matchre return ^You pause a moment to listen
    matchre return ^Your teacher appears to have left\.
    put listen %todo
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


lock:
    var location lock1
    var todo $0
    lock1:
    matchre return is already locked
    matchre return ^Maybe you should close
    matchre return ^That is
    matchre return ^The door is open\.  You'll need to shut it first\.
    matchre return ^You don't
    matchre return ^You do not
    matchre return ^You lock
    matchre return ^You need
    matchre return ^You quickly lock
    matchre return ^You rattle
    matchre return ^What were you referring to
    put lock %todo
    goto retry


look:
    var location look1
    var todo $0
    look1:
    matchre return ^\[
    matchre return ^(He|She) is
    matchre return ^I could not find what you were referring to\.
    matchre return ^In the
    matchre return ^Looking
    matchre return ^There is nothing
    matchre return ^On the
    matchre return ^You also see
    matchre return ^You are
    matchre return ^You have
    matchre return ^You see
    put look %todo
    goto retry


loot:
    var location loot1
    var todo $0
    loot1:
    matchre return ^I could not
    matchre return ^You search
    matchre return already been searched
    matchre return ^You should
    put loot %todo
    goto retry


lower:
    var location lower1
    var todo $0
    lower1:
    matchre return ^There is no point in lowering
    matchre return ^You lower
    put lower %todo
    goto retry


mark:
    var location mark1
    var todo $0
    mark1:
    matchre return ^As you consider
    matchre return ^It's dead
    matchre return ^Mark what\?
    matchre return ^Roundtime
    matchre return ^The stamp is too badly damaged to be used for that\.$
    matchre return ^There is not enough
    matchre return ^You carefully size up
    matchre return ^You begin to
    matchre return ^You hold
    matchre return ^You mark
    matchre return ^You count
    put mark %todo
    goto retry


meditate:
    var location meditate1
    var todo $0
    meditate1:
    matchre libAwake ^You attempt to meditate, but have trouble concentrating.
    matchre return ^You lean in close
    matchre return ^Return
    put meditate %todo
    goto retry


mind:
    var location mind1
    mind1:
    matchre return ^EXP HELP for more information
    matchre return ^Overall state of mind:
    put mind
    goto retry


observe:
    var location observe1
    var todo $0
    observe1:
    matchre return ^Roundtime
    matchre return ^That's a bit hard to do here, since you cannot see the sky\.
    matchre return ^You are a bit too distracted
    matchre return ^You observe your surroundings
    matchre return ^You scan the skies for a few moments\.
    matchre return ^Your search for the constellation
    put observe %todo
    goto retry


ooc:
    var location ooc1
    var todo $0
    ooc1:
    matchre return ^Whisper what
    matchre return ^Who are
    matchre return ^You whisper
    put OOC %todo
    goto retry


open:
    var todo $0
    open1:
    var location open1
    matchre return already open.$
    matchre return ^That is already
    matchre return ^What were
    matchre return ^With a practiced flick of your wrist
    matchre return ^You open
    matchre return ^You extend your telescope\.
    matchre return ^You need to be holding the telescope first.
    matchre return ^You rattle
    matchre return ^You try, but the telescope seems as extended as it will ever be\.
    matchre return ^Your dreamweave fan is already
    matchre return ^is already open
    matchre return seems to be closed.$
    put open %todo
    goto retry


openTelescope:
    put open my telescope
    goto location


order:
    var todo $0
    var location order1
    order1:
    matchre return enough coins
    matchre return ^The attendant takes some coins from you and hands you
    matchre return says, "You can purchase
    matchre return Just order it again
    put order %todo
    goto retry


pace:
    var location pace1
    var todo %todo
    pace1:
    matchre return ^You pace
    matchre return ^You weave back
    put pace %todo
    goto retry


parry:
    var location parry
    matchre return ^Roundtime:
    matchre return ^You are already in a position to parry\.
    matchre return ^You need two hands to wield this weapon\!
    matchre return ^You move into a position
    put parry
    goto retry


peer:
    var todo $0
    peer1:
    var location peer1
    matchre return ^That's a bit tough to do when you can't see the sky\.
    matchre return ^You focus
    matchre return ^You peer aimlessly
    matchre return ^You peer in the window and see
    matchre return ^Roundtime
    matchre return ^Clouds obscure the sky
    matchre return ^You peer in the window
    matchre openTelescope ^You'll need to open it to make any use of it\.
    matchre return Usage
    put peer %todo
    goto retry


perc:
perceive:
pow:
power:
    var location power1
    var todo $0
    power1:
    matchre return ^I could not find who you were referring to\.
    matchre return ^Roundtime
    matchre return ^Something in the area is interfering
    matchre return ^Strangely, you can sense absolutely nothing.
    matchre return ^You are already
    matchre return ^You are too distracted
    matchre return ^You lost track of your surroundings
    matchre return ^You stop for a moment
    matchre return ^You're not ready to do that again, yet\.
    matchre return ^Your focus expires
    matchre return ^Your resolve collapses
    put PERCEIVE %todo
    goto retry


perf:
perform:
    var location perform1
    var todo $0
    perform1:
    matchre return ^A failed or completed ritual
    matchre return ^A skinned creature is worthless
    matchre return ^Both
    matchre return is too injured
    matchre return much too battered
    matchre return prevents a meaningful dissection.
    matchre return ^Rituals do not work upon constructs\.$
    matchre return ^Roundtime
    matchre return ^That's not
    matchre return ^The blood on your palm bubbles slightly
    matchre return ^The harvesting ritual performed
    matchre return ^This corpse has already
    matchre return ^This ritual may only be performed
    matchre return too injured to be a good specimen\.$
    matchre return ^You bend over the
    matchre return ^You cannot harvest useful material from the corpse unless it is preserved first\.
    matchre return ^You've already performed
    matchre return ^You draw
    matchre return ^Roundtime
    put perform %todo
    goto retry


pick:
    var location pick1
    var todo $0
    pick1:
    matchre return Somebody has already inspected the current lock
    matchre return isn't locked
    matchre return It's not even locked, why bother\?
    matchre return The lock looks weak
    matchre return You set about picking
    matchre return A pitiful snowball encased in the Flames of Ushnish would fare better than you\.
    matchre return Prayer would be a good start for any attempt of yours at picking open the
    matchre return should not take long with your skills\.
    matchre return Somebody has already inspected the current lock on this
    matchre return The lock has the edge on you, but you've got a good shot at picking open the
    matchre return The odds are against you, but with persistence you believe you could pick open the
    matchre return with only minor troubles\.
    matchre return would be a longshot\.
    matchre return You could just jump off a cliff and save yourself the frustration of attempting this
    matchre return You have an amazingly minimal chance at picking open the
    matchre return You have some chance of being able to pick open the
    matchre return You probably have the same shot as a snowball does crossing the desert\.
    matchre return You really don't have any chance at picking open this
    matchre return You think this lock is precisely at your skill level\.
    matchre return fails to teach you anything about the lock guarding it\.
    matchre return You are unable to make any progress towards opening the lock\.
    matchre return You discover another lock protecting the
    matchre return An aged grandmother could open this in her sleep\.
    matchre return should not take long with your skills\.
    matchre return The lock is a trivially constructed piece of junk barely worth your time\.
    matchre return This lock is a laughable matter, you could do it blindfolded\!
    matchre return will be a simple matter for you to unlock\.
    put pick %todo
    goto retry


play:
    var location play1
    var todo $0
    play1:
    matchre return with only the slightest hint
    matchre return ^You begin
    matchre return ^You cannot
    matchre return ^You effortlessly
    matchre return ^You fumble
    matchre return ^You notice that moisture
    matchre return ^You play
    matchre return ^You struggle
    matchre return ^You're already playing a song
    matchre return ^What type
    put play %todo
    goto retry


poke:
    var location poke1
    var todo $0
    poke1:
    matchre return ^Going around poking things isn't going to get you far\.
    matchre return ^What were you referring to\?
    matchre return ^You can't tear up the envelope while there's still paper inside\.
    matchre return ^You must be either wearing or holding a plain paper envelope before you can do that\!
    matchre return ^You poke a hole in your
    matchre return ^You poke a piece of
    matchre return ^You tear up the empty envelope and toss it away\.
    matchre return ^You toss a piece of
    matchre return ^You track down
    put poke %todo
    goto retry


pour:
    var location pour1
    var todo $0
    pour1:
    matchre return ^You can't
    matchre return ^I don't
    matchre return ^Maybe you should kneel.
    matchre return ^Pour what
    matchre return ^You quietly
    put pour %todo
    goto retry


pray:
    var location pray1
    var todo $0
    pray1:
    matchre return ^As you utter your prayer
    matchre return ^Quietly touching
    matchre return ^The soft sound of your prayers wraps itself around you and brings you a sense of tranquility\.
    matchre return ^You begin to pray
    matchre return ^You begin to pray, kneeling before the altar\.
    matchre return ^You beseech your God for mercy\.
    matchre return ^You bow your head
    matchre return ^You continue praying for guidance\.
    matchre return ^You glance
    matchre return ^You kneel down and begin to pray\.
    matchre return ^You narrow your eyes
    matchre return ^You pray fervently\.
    matchre return ^You should be holding your
    matchre return ^You want to pray here\?
    matchre return ^Your fervent prayers are met with a sense of peace and security\.
    put pray %todo
    goto retry


pre.skin:
    if %skin = 0 then goto Return
    if %current.stance != custom then gosub stance custom
    gosub stowing
    gosub get my skinning knife
    return


pred:
predict:
    var location predict1
    var todo $0
    predict1:
    matchre return ^Roundtime
    matchre return ^After a few moments, the mists of time begin to part\.
    matchre return ^As you reach out toward the future
    matchre return ^You are a bit too distracted to be making predictions\.
    matchre return ^You are far too occupied
    matchre return ^You consider your recent observations
    matchre return ^You focus inwardly searching for insight into your future\.
    matchre return ^The future, however, remains a dark mystery to you\.
    matchre return ^You must be a real expert to predict the weather indoors\.
    matchre return ^You see nothing else\.
    put predict %todo
    goto retry


prep_spell:
    if $Harness_Ability.LearningRate > 30 then goto return
    prep_spell1:
    if $mana < 80 then goto return
prep:
prepare:
    var location prep1
    var todo $0
    prep1:
    if ($char.research.interrupt.cast = 1) then {
        matchre prep1 ^Are you sure you want to do that\?  You'll interrupt your research\!
    }
    matchre return ^Are you sure you want to do that\?  You'll interrupt your research\!
    matchre return ^A nagging sense of desperation guides your hands through the motions
    matchre return ^As quickly as you form the spell pattern in your mind it slips away from you again.$
    matchre return ^As you begin to focus on preparing
    matchre return ^But you've already
    matchre return ^Heatless orange flames blaze between your fingertips
    matchre return ^Icy blue frost crackles up your arms
    matchre return ^Images of streaking stars falling from the heavens flash across your vision
    matchre return ^Light withdraws from around you as you speak arcane words
    matchre return ^Shadow and light collide wildly around you
    matchre return ^Something in the area interferes with your spell preparations
    matchre return ^The wailing of lost souls accompanies your preparations
    matchre return ^Tiny tendrils of lightning jolt between your hands
    matchre return ^With great force, you slap your hands together before you and slowly pull them apart,
    matchre return ^With no small amount of effort, you slowly recall the teachings
    matchre return ^With rigid movements you prepare your body
    matchre return ^You are already
    matchre return ^You begin chanting a prayer
    matchre return ^You can't seem to form the spell pattern
    matchre return ^You close your eyes and breathe deeply,
    matchre return ^You deftly waggle your fingers in the precise motions needed to prepare
    matchre return ^You don't seem to be able to move to do that\.
    matchre return ^You have already fully prepared
    matchre return ^You have no idea how
    matchre return ^You hastily shout the arcane phrasings needed to prepare
    matchre return ^You make a careless gesture as you chant the words
    matchre return ^You mutter incoherently to yourself
    matchre return ^You raise one hand before you and concentrate
    matchre return ^You raise your arms skyward, chanting
    matchre return ^You raise your head skyward
    matchre return ^You recall the exact details of the Chaos
    matchre return ^Your skin briefly withers and tightens, becoming gaunt
    matchre return ^You struggle against your bindings to prepare
    matchre return ^You trace a hasty sigil in the air
    matchre return ^You trace an angular sigil
    matchre return ^You trace an arcane sigil in the air,
    matchre return ^Your eyes darken to black as a starless night
    matchre return ^You recall the exact details of the
    matchre prepare.ritualFix ^Magical rituals are exceedingly obvious.  You cannot do it while remaining hidden.
    put prepare %todo
    goto retry


prepare.ritualFix:
    gosub release rf
    gosub shiver
    goto %location


pull:
    var location pull1
    var todo $0
    pull1:
    matchre return ^Roundtime
    matchre return ^With a muttered curse
    matchre return ^You are a little too busy with combat to worry about that right now\.
    matchre return ^You throw away the ruined portion
    matchre return ^You must
    matchre return ^You tug
    matchre return ^You remove
    put pull %todo
    goto retry


push:
    var location push1
    var todo $0
    push1:
    matchre return ^Not finding a matching section
    matchre return ^Flipping through
    matchre return ^You wave the loop near
    matchre return ^Roundtime
    matchre return ^You push
    matchre return ^What are you
    put push %todo
    goto retry


put:
    var location put1
    var todo $0
    put1:
    matchre closeTelescope telescope is too long
    matchre return ^No winners have been selected
    matchre return ^Raffle Attendant Tizzeg examines your ticket but shakes her head, "I'm sorry this isn't a winning ticket.  Better luck next time!"
    matchre return ^You add
    matchre return ^You rearrange
    matchre return ^You drop
    matchre return ^You put
    matchre return  looks completely full\.$
    matchre return ^You reverently place
    matchre return ^As you start to place
    matchre return ^What were you referring to\?
    matchre return ^You briefly twist the top
    matchre return ^As you put the wax label
    matchre return ^You glance down
    matchre return ^With a flick
    matchre return ^Roundtime
    matchre return ^That's too heavy to go in there\!$
    matchre return ^There isn't any more room
    matchre return too long to fit
    matchre return ^Perhaps you should be holding that first.$
    matchre return ^You carefully fit
    put put %todo
    goto retry


read:
    var location read1
    var todo $0
    read1:
    matchre return contains a
    matchre return ^I could not find what you were referring to\.
    matchre return ^On this page
    matchre return Page
    matchre return ^Roundtime
    matchre return ^The writing is too small\.  You'll have to hold the scroll to read it\.
    matchre return ^You open your logbook
    matchre return ^You page through
    put read %todo
    goto retry


redirect:
    var location redirect1
    var todo $0
    redirect1:
    matchre return ^You are now redirecting all wounds and scars to your
    put redirect %todo
    goto retry


rel:
release:
    var location release1
    var todo $0
    release1:
    if ( ("%todo" = "" || "%todo" = "spell") && "$preparedspell" = "none") then return
    matchre return ^A faint groan echoes
    matchre return ^A faint growl echoes from the depths
    matchre return ^A.*Shadow Servant.*disappears\.$
    matchre return ^Are you sure you'd lke to remove the Discern symbiosis from your memory
    matchre return ^But you haven't prepared
    matchre return disappears\.$
    matchre return ^Release\?  You can't even sense mana right now\.$
    matchre return ^Release what
    matchre return sphere suddenly flares with a cold light and vaporizes\!$
    matchre return ^That would be a neat trick.  Try finding a shadowling first\.$
    matchre return ^That's probably not a good idea\.
    matchre return ^The deadening murk around you subsides\.$
    matchre return ^The greenish hues
    matchre return ^The heightened sense of spiritual awareness leaves you\.$
    matchre return ^The Refractive Field pattern fades from you\.
    matchre return ^The refractive field surrounding you
    matchre return ^The Rite of Contrition
    matchre return ^The Rite of Grace matrix loses
    matchre return ^The shimmering globe of blue fire
    matchre return ^The swirling fog dissipates from around you\.$
    matchre return ^The tingling across your body diminishes as you feel the motes of energy fade away
    matchre return ^Type RELEASE HELP for more options\.
    matchre return ^You aren't harnessing any mana\.
    matchre return ^You aren't preparing
    matchre return ^You cease your shadow weaving\.
    matchre return ^You don't have a Shadow Servant
    matchre return ^You feel the feverish heat in your flesh gradually subside\.$
    matchre return ^You gesture, attempting to unravel the pattern binding the shadowling to this plane\.
    matchre return ^You gesture, completing the pattern to unravel the mystical bonds binding the shadowling to this plane\.
    matchre return ^You have no
    matchre return ^You have no cyclic spell active to release\.
    matchre return ^You let your concentration lapse and feel the spell's energies dissipate\.
    matchre return ^You release
    matchre return ^You release the mana you were holding\.
    matchre return ^Your corruption fades
    put release %todo
    goto retry


roll:
    var location roll1
    var todo $0
    roll1:
    matchre return ^Roundtime
    matchre return ^You can't
    matchre return ^It is
    matchre return ^You carefully
    matchre return ^You're having too much trouble focusing
    matchre return ^You realize you have not yet properly aligned
    matchre return ^You're too
    put roll %todo
    goto retry


rem:
remove:
    var location remove1
    var todo $0
    remove1:
    matchre return ^Remove what\?
    matchre return ^Roundtime
    matchre return ^What were you referring to\?
    matchre return ^Wiggling your fingers
    matchre return ^You aren't wearing that\.
    matchre return ^You count out
    matchre return ^You loosen the straps securing
    matchre return ^You pull
    matchre return ^You remove
    matchre return ^You slide
    matchre return ^You sling
    matchre return ^You take
    matchre return ^You work your way out of
    put remove %todo
    goto retry


repair:
    var todo $0
    var location repair1
    repair1:
    matchre return isn't in need of repair
    matchre return not in need of repair\.$
    matchre return ^As you finish your task
    matchre return ^Roundtime
    matchre return SKIN
    matchre return ^The leather looks frayed
    matchre return ^With some needle and thread
    matchre return ^You can't fix
    matchre return ^You lack the proper
    matchre return ^You'll have to hold it
    put repair %todo
    goto retry


research:
    var location research1
    var todo $0
    research1:
    matchre return ^Abandoning
    matchre return ^With a mixture
    matchre return ^You are already busy at research
    matchre return ^You confidently
    matchre return ^You focus your
    matchre return ^You require some special means
    matchre return ^You tentatively
    put research %todo
    goto retry


ret:
retreat:
    var location retreat
    matchre retreat ^You must stand first\.
    matchre retreat ^You retreat back to pole range\.
    matchre retreat ^You retreat from combat\.
    matchre retreat ^You sneak back out
    matchre retreat ^You stop advancing
    matchre retreat ^You try to back out
    matchre retreat ^You try to sneak
    matchre return ^You are already as far away as you can get\!
    matchre return ^You try to back away from
    matchre return revealing your hiding place\!
    put retreat
    goto retry


2retreat:
    var location 2retreat
    matchre return revealing your hiding place\!
    matchre return ^You are already as far away as you can get\!
    matchre return ^You retreat from combat\.
    matchre return ^You retreat back to pole range\.
    matchre return ^You sneak back out
    matchre return ^You stop advancing
    matchre return ^You try to
    put retreat
    goto retry


ret2:
    if $monstercount > 0 then
    {
      put retreat;retreat
      pause .2
    }
    return


rub:
    var location rub1
    var todo $0
    rub1:
    matchre rub1 ^You rub Mythos gently, trying to massage any sore muscles\.
    matchre return ^But you currently
    matchre return ^As you rub the orb, it glows slightly more intensely and you feel a strange tugging, as if something has been moved from you to the orb\.
    matchre return ^The spider comes alive
    matchre return The strange tugging sensation is gone, leading you to believe that your sacrifice is properly prepared\.
    matchre return ^You reach out and rub
    matchre return ^You rub the orb and feel a strange tugging, but nothing really seems to happen\.
    matchre return ^You run your fingers over the bones\.
    matchre return ^You try
    matchre return ^Rub what\?
    put rub %todo
    goto retry


rummage:
    var location rummage1
    var todo $0
    rummage1:
    matchre return ^You rummage
    matchre return ^I don't
    put rummage %todo
    goto retry


scrape:
    var location scrape1
    var todo $0
    scrape1:
    matchre return ^You delicately shape fine detail into .* with your rasp\.
    matchre return ^You set the lumber
    put scrape %todo
    goto retry


scream:
    var location scream1
    var todo $0
    scream1:
	matchre return ^You lift your head
	put scream %todo
	goto retry

scribe:
    var location scribe1
    var todo $0
    scribe1:
    matchre return ^You lean in towards
    matchre return ^You need another
    matchre return ^That tool does not seem
    matchre return ^The burin doesn't
    matchre return ^Roundtime
    put scribe %todo
    goto retry


search:
    var location search
    matchre return ^Roundtime
    matchre return ^You search around for a moment
    put search
    goto retry


sell:
    var location sell1
    var todo $0
    sell1:
    matchre return Aelik
    matchre return ^Cormyn looks around
    matchre return ^Cormyn looks puzzled
    matchre return ^Cormyn shakes his head and says
    matchre return ^Cormyn takes your
    matchre return ^Cormyn whistles and says
    matchre return Dokora|Kronar|Lirum
    matchre return ^"Hmm\?" says Scupper, "What are you talking about\?"
    matchre return ^I could not find what you were referring to\.
    matchre return Oweede
    matchre return Relf rocks back
    matchre return Relf takes your
    matchre return ^Sell what\?
    matchre return ^Scupper separates the bundle and sorts through it carefully
    matchre return ^There is no merchant
    matchre return ^You ask
    matchre return ^You ask Scupper to buy a lumpy bundle\.
    put sell %todo
    goto retry


shape:
    var location shape1
    var todo $0
    shape1:
    matchre return ^Quickly you rub your shaper across the surface of .*\.
    matchre return ^The bolts are ready for an application of glue to affix each bolthead\.$
    matchre return ^You flip (a|an|some) unfinished .* over and begin to shape it with your shaper\.
    matchre return ^Using abrupt motions you shape a series of grooves into your bolt shafts\.$
    matchre return ^With short strokes you shape .* with your shaper\.
    put shape %todo
    goto retry


sheath:
    var location sheath1
    var todo $0
    sheath1:
    matchre return ^You sheath
    matchre return ^You hang
    put sheath %todo
    goto retry


shiver:
    var location shiver
    matchre return ^A shiver runs up your spine\.
    put shiver
    goto retry


shop:
    var location shop
    var todo $0
    matchre return ^On the .*, you see\:
    matchre return ^The following items contain goods for sale
    matchre return ^There is nothing to buy here\.
    matchre return ^\[Type SHOP \[GOOD\] or click an item to see some details about it\.\]
    put shop $0
    goto retry


skin:
skinning:
    var location skin1
    var todo $0
    skin1:
    matchre return ^.*can't be skinned
    matchre return ^Despite your best efforts,
    matchre return ^Living creatures often object to being flayed alive\.
    matchre return Maybe you should REPAIR it\.$
    matchre return ^Roundtime
    matchre return ^Skin what\?
    matchre return ^Some days it just doesn't pay to wake up\.
    matchre return ^Somehow managing to do EVERYTHING wrong
    matchre return ^The .+ cannot be skinned.
    matchre return ^The leather looks frayed
    matchre return ^There isn't another
    matchre return ^With preternatural poise
    matchre return ^Working deftly
    matchre return ^You bumble the attempt
    matchre return ^You claw
    matchre return ^You hideously bungle the attempt
    matchre return ^You fumble and make an improper cut
    matchre return ^You skillfully peel back the leather from the frame underneath\.
    matchre return ^You struggle with the
    matchre return ^Your .* moves as a fluid extension
    matchre return ^Your .* twists and slips in your grip
    matchre pre.skin ^You must have one hand free to skin\.
    matchre pre.skin ^You will need a more appropriate tool for skinning
    matchre pre.skin ^You'll need to have a bladed instrument to skin with\.
    matchre skinning ^You approach \w+'s kill
    put skin %todo
    goto retry


sleep:
  var location sleep
  matchre return ^You relax and allow your mind
  matchre return ^You draw deeper into rest
  put sleep
  goto retry


smell:
    var location smell1
    var todo $0
    smell1:
    matchre return ^You sniff the air
    put smell %todo
    goto retry


sneak:
    var location sneak1
    var todo $0
    sneak1:
    matchre return ^Roundtime
    matchre return You prepare yourself to sneak
    put sneak %todo
    goto retry


sort:
    var location sort1
    var todo $0
    sort1:
    matchre return has been moved (down|up) in your inventory\.
    matchre return ^Usage
    matchre return ^Your inventory has been reversed\.
    matchre return ^Your inventory is now arranged in head-to-toe order\.
    put sort %todo
    goto retry



sprinkle:
    var location sprinkle1
    var todo $0
    sprinkle1:
    matchre return ^You sprinkle
    matchre return ^Sprinkle
    put sprinkle %todo
    goto retry


stance:
    var location stance1
    var todo $0
    var current.stance $0
    if ("%todo" != "shield" && contains("$righthandnoun", "%crossbowItems")) then var todo shield
    if ("$stance" = "%todo") then return
    stance1:
    matchre return ^You are now set to use your
    matchre return ^Your (attack|evasion|parry|shield) ability is now set at
    matchre return (Attack|Evade|Parry|Block)
    put stance %todo
    goto retry


stance.set:
    var location stance.set1
    var todo $0
    stance.set1:
    matchre return ^Setting your
    matchre return ^Please specify
    matchre return ^You have specified a total number
    put stance set %todo
    goto retry


stand:
    if $standing = 1 then return
    var location stand1
    var todo $0
    stand1:
    matchre stand1 ^The weight of all your possessions prevents you from standing\.
    matchre stand1 ^You are overburdened and cannot manage to stand\.
    matchre stand1 ^You are so unbalanced you cannot manage to stand\.
    matchre stand1 ^Roundtime
    matchre return ^You are already standing\.
    matchre return ^You climb off
    matchre return ^You stand back up\.
    matchre return ^You swim back up
    matchre return ^You stand
    put stand %todo
    goto retry


start.humming:
    if $Vocals.LearningRate > 30 then return
    if %humming = 0 then return
    var location start.humming1
    start.humming1:
    matchre return ^You begin to hum
    matchre return ^You fumble slightly as you begin to hum
    matchre return ^You struggle to begin to hum
    matchre return ^You continue to hum
    matchre return ^You are already performing something\.
    matchre start.humming1 ^You can't focus your attention enough to perform\.
    put hum %hum
    goto retry


stop.humming:
    var location stop.humming
    stop.humming1:
    matchre return ^You stop playing your song\.
    matchre return ^In the name of love\?
    put stop hum
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


stop:
    var location stop1
    var todo $0
    stop1:
    matchre return ^But you aren't listening to anyone\.
    matchre return ^But you aren't teaching anyone\.
    matchre return ^In the name of love
    matchre return ^You stop
    matchre return ^You stop practicing your climbing skills\.
    matchre return ^You stop teaching\.
    matchre return ^You stop trying to teach
    matchre return ^You weren't practicing your climbing skills anyway\.
    put stop %todo
    goto retry


store:
    var location store1
    var todo $0
    store1:
    matchre return ^To use the STORE verb
    matchre return ^You will now
    put store %todo
    goto retry


stow:
    var location stow1
    var todo $0
    stow1:
    if ("%todo" = "" && "$righthand" = "Empty") then return
    if ("%todo" = "right" && "$righthand" = "Empty") then return
    if ("%todo" = "left" && "$lefthand" = "Empty") then return
    if ("$charactername" = "Selesthiel") then {
        if (contains("%todo", "ka'hurst hauberk") || ("%todo" = "right" && "$righthand" = "ka'hurst hauberk") || ("%todo" = "left" && "$lefthand" = "ka'hurst hauberk")) then {
			gosub put my hauberk in my water bag
			return
        }
        if (contains("%todo", "tele") || ("%todo" = "right" && "$righthand" = "clockwork telescope") || ("%todo" = "left" && "$lefthand" = "clockwork telescope")) then {
            gosub put my telescope in my telescope case
            return
        }
        if (contains("%todo", "bones") || ("%todo" = "right" && "$righthand" = "divination bones") || ("%todo" = "left" && "$lefthand" = "divination bones")) then {
            gosub put my divination bones in my telescope case
            return
        }
        if (contains("%todo", "compendium") || ("%todo" = "right" && "$righthandnoun" = "compendium")) then {
            gosub put my compendium in my thigh bag
            return
        }
    }
    if ("$charactername" = "Qizhmur") then {
        if (contains("%todo", "material") || ("%todo" = "right" && "$righthandnoun" = "material") || ("%todo" = "left" && "$lefthandnoun" = "material")) then {
            gosub put my material in my satchel
            return
        }
        if (contains("%todo", "greatsword") || ("%todo" = "right" && "$righthand" = "iron greatsword") || ("%todo" = "left" && "$lefthand" = "iron greatsword")) then {
            gosub put my iron greatsword in my hip pouch
            return
        }
        if (contains("%todo", "halberd") || ("%todo" = "right" && "$righthand" = "glaes halberd") || ("%todo" = "left" && "$lefthand" = "glaes halberd")) then {
            gosub put my glaes halberd in my hip pouch
            return
        }
    }
    if ("$charactername" = "Izqhhrzu") then {
        if ( ("%todo" = "right" && "$righthand" = "blood-red scythe") || ("%todo" = "" && "$righthand" = "blood-red scythe") || contains("%todo", "scythe") || ("%todo" = "left" && "$lefthand" = "blood-red scythe") ) then {
            gosub put my scythe in my hip pouch
            return
        }
        if ( ("%todo" = "right" && "$righthand" = "holy water") || ("%todo" = "" && "$righthand" = "holy water") || contains("%todo", "holy water") || ("%todo" = "left" && "$lefthand" = "holy water") ) then {
            gosub put my holy water in my witch jar
            return
        }
    }
    matchre return ^But that is already in your inventory\.
    matchre return ^I can't find your container
    matchre return ^Stow what\?
    matchre return ^There doesn't seem to be anything left in the pile\.$
    matchre return ^You can't pick that up with your hands that damaged\.$
    matchre return ^You carefully
    matchre return ^You hang your
    matchre return ^You need a free hand to pick that up.
    matchre return ^You open your pouch
    matchre return ^You pick up
    matchre return ^You put your
    matchre return ^You stop as you realize
    matchre return ^You think the gem pouch is too full to fit another gem into\.
    matchre return ^You try to
    matchre closeTelescope telescope is too long
    matchre location.unload ^You need to unload the
    matchre location.unload ^You should unload the
    matchre stowing too long to fit
    matchre stowing too wide to fit
    matchre stow.tieGemPouch ^You've already got a wealth of gems in there\!
    put stow %todo
    goto retry


stow.tieGemPouch:
    var stowTodo %todo
    gosub tie my gem pouch
    gosub stow %stowTodo
    return


stowing:
    if matchre("$lefthand","(partisan|lumpy bundle|staff|copperwood longbow|slender khuj|longbow)") then gosub wear my $1
    if matchre("$righthand","(partisan|lumpy bundle|staff|copperwood longbow|slender khuj|longbow)") then gosub wear my $1

    if matchre("$lefthand","(%pelts.keep)") then gosub bundle
    if matchre("$righthand","(%pelts.keep)") then gosub bundle
    if matchre("$lefthand","(%pelts.empty)") then gosub drop $lefthand
    if matchre("$righthand","(%pelts.empty)") then gosub drop $righthand

    if matchre("$lefthand","(partisan|lumpy bundle|quarter staff|copperwood longbow|slender khuj|longbow)") then gosub wear my $1
    if matchre("$righthand","(partisan|lumpy bundle|quarter staff|copperwood longbow|slender khuj|longbow)") then gosub wear my $1

    if $lefthand != Empty then gosub wear left
    if $righthand != Empty then gosub wear right

    if $lefthand != Empty then gosub stow left
    if $righthand != Empty then gosub stow right
    return


study:
    var location study1
    var todo $0
    study1:
    if ($char.research.interrupt.study = 1) then {
        matchre study1 ^Are you sure you want to do that
    }
    matchre return ^Are you sure you want to do that
    matchre return ^But you aren't holding
    matchre return ^Roundtime
    matchre return ^Why do you need to study this chart again\?
    matchre return ^You are unable to sense additional information\.
    matchre return ^You attempt
    matchre return ^You believe
    matchre return ^You feel it is too soon to grasp anything new in the skies above\.
    matchre return ^You need to be holding
    matchre return ^You review
    matchre return ^You scan
    matchre return ^You set about
    matchre return ^You should try that where you can see the sky\.
    matchre return ^You study your
    matchre return ^You take on a studious look\.
    matchre return ^You've already started to make something
    matchre return ^You've gleaned all the insight you can
    put study %todo
    goto retry


swap:
    var location swap1
    var todo $0
    swap1:
    matchre return too injured to do that.$
    matchre return ^Silver light kisses
    matchre return ^With a quiet
    matchre return ^You deftly change
    matchre return ^You effortlessly switch
    matchre return ^You fiercely switch
    matchre return ^You have nothing to swap\!
    matchre return ^You move
    matchre return ^You shift
    matchre return ^You switch your
    matchre return ^You turn
    matchre return ^Your eyes blaze
    matchre return ^With one superbly balanced motion
    put swap %todo
    goto retry


swap_right:
    var location swap_right
    matchre return to your right hand
    matchre return ^You have nothing
    matchre swap_right to your left hand
    put swap
    matchwait


swap_Left:
    var location swap_Left
    matchre return to your left hand
    matchre return ^You have nothing
    matchre swap_Left to your right hand
    put swap
    matchwait


stalk:
    var location stalk
    matchre return alerts others of your attempt to slip behind
    matchre return Roundtime:
    matchre return ^Stalk what\?
    matchre return ^Stalking is an inherently stealthy endeavor, try being out of sight\.
    matchre return ^You are already stalking
    put stalk
    goto retry


stop.stalk:
    var location stop.stalk
    matchre return ^You stop stalking\.
    matchre return ^You're not stalking anything though\.
    put stop stalk
    goto retry

take:
    var location take1
    var todo $0
    take1:
    matchre return ^You lay your hand on
    matchre return ^You lightly touch
    matchre return ^You reluctantly touch
    matchre return ^You rest your hand
    matchre return ^You touch
    put take %todo
    goto retry


tap:
    var location tap1
    var todo $0
    tap1:
    matchre return ^You drum
    matchre return ^You tap
    matchre stand1 ^Roundtime
    put tap %todo
    goto retry


tar:
target:
    var location target1
    var todo $0
    target1:
    matchre return ^But you're already preparing
    matchre return ^There is nothing else to face\!$
    matchre return ^This spell cannot be targeted\.$
    matchre return ^You begin to weave
    matchre return ^You deftly remove
    matchre return ^You don't need to target the spell you're preparing\.
    matchre return ^You must be preparing a spell in order to target it\!
    matchre return ^Your target pattern is already formed
    matchre target2 ^There is no need to target
    matchre target2 ^You are not engaged to anything, so you must specify a target to focus on\!
    put target %todo
    goto retry
target2:
    put face next
    goto target1


task:
    var location task
    matchre return You recall
    put task
    goto retry

tdps:
    var location tdps1
    var todo $0
    tdps1:
    matchre return ^An attendant
    matchre return ^You have
    put tdps %todo
    goto retry

tdp:
    var location tdp
    matchre return ^An attendant quietly informs you
    matchre return ^An attendant steps over to you
    matchre return ^You have
    put tdp
    goto retry


teach:
    var location teach1
    var todo $0
    teach1:
    matchre return already trying to teach someone else
    matchre return ^I could not find who you were referring to\.
    matchre return ^I don't understand which skill you wish to teach\.
    matchre return is already listening to you\.
    matchre return is already trying to teach you something
    matchre return is listening to someone else\.
    matchre return is not paying attention to you\.
    matchre return isn't teaching you anymore\.
    matchre return ^That person is too busy teaching their own students to listen to your lesson\.
    matchre return ^The TEACH verb
    matchre return ^You begin to lecture
    matchre return ^You cannot listen to a teacher and teach at the same time
    matchre return ^You have already offered to
    put teach %todo
    goto retry


tend:
    var location tend1
    var todo $0
    tend1:
    matchre return ^Doing your best
    matchre return ^Roundtime:
    matchre return ^That area has already been tended to\.
    matchre return ^That area is not bleeding\.
    matchre return too injured for you to do that\.
    matchre return ^You realize you cannot handle so severe an injury while in combat\!
    matchre return ^You work carefully at tending your wound\.
    matchre return ^Your task is made more difficult by being in combat\.
    put tend %todo
    goto retry


tie:
    var location tie1
    var todo $0
    tie1:
    matchre return ^But this bundle
    matchre return Once you've tied off your bundle
    matchre return ^Tie it off
    matchre return ^Tie what
    matchre return ^The gem pouch has already
    matchre return ^What were you
    matchre return ^Using the length
    matchre return ^You are already
    matchre return ^You attach
    matchre return ^You tie
    put tie %todo
    goto retry


throw:
    var location throw1
    var todo $0
    throw1:
    matchre return Roundtime
    matchre return ^There is nothing
    matchre return ^You must hold
    put throw %todo
    goto retry


touch:
    var location touch1
    var todo $0
    touch1:
    if ("$charactername" = "Inauri") then put #echo >Log #FF0000 Psssst! I love you! -Justin
    matchre return ^You lay your hand on
    matchre return ^You lightly touch
    matchre return ^You reluctantly touch
    matchre return ^You rest your hand
    matchre return ^You rush around
    matchre return ^You touch
    put touch %todo
    goto retry


track:
    var location track1
    var todo $0
    track1:
    matchre return ^It's not safe enough to track anything\.
    put track %todo
    goto retry


turn:
    var location turn1
    var todo $0
    turn1:
    matchre return already at the contents
    matchre return ^But you're not
    matchre return ^I could not
    matchre return ^Roundtime
    matchre return ^The (book|codex) is already
    matchre return ^Turn what\?
    matchre return ^You attempt
    matchre return ^You carefully
    matchre return ^You fiddle with
    matchre return ^You turn to the section
    matchre return ^You turn
    matchre return ^What skill
    put turn %todo
    goto retry


trace:
    var location trace1
    var todo $0
    trace1:
    matchre return ^Recalling the intricacies of the sigil
    matchre return ^Roundtime
    put trace %todo
    goto retry


unload:
    var location unload
    matchre return ^But your
    matchre return ^Roundtime:
    matchre return ^You can't unload such a weapon\.
    matchre return ^You don't have a
    matchre return ^You remain concealed by your surroundings, convinced that your unloading
    matchre return ^You unload the
    matchre return ^Your
    put unload
    goto retry


unlock:
    var location unlock1
    var todo $0
    unlock1:
    matchre return already open.$
    matchre return ^The door is open.
    matchre return ^What were you referring to
    matchre return ^You don't have a key
    matchre return ^You rattle
    matchre return ^You unlock
    matchre unlock.invisible ^That would reveal your hiding place.
    put unlock %todo
    goto retry

unlock.invisible:
    var unlockTodo %todo
    if ($SpellTimer.RefractiveField.active = 1 || $SpellTimer.RefractiveField.duration > 0) then gosub release rf
    if ($SpellTimer.EyesoftheBlind.active = 1 || $SpellTimer.EyesoftheBlind.duration > 0) then gosub release eotb
    var todo %unlockTodo
    unvar unlockTodo
    goto unlock1


untie:
    var location untie1
    var todo $0
    untie1:
    matchre return ^What were you
    matchre return ^You are already
    matchre return ^You untie
    put untie %todo
    goto retry


unroll:
    var location unroll1
    var todo $0
    unroll1:
    matchre return ^You reverently
    matchre return ^You must
    matchre return ^You need
    matchre return ^You can't
    put unroll %todo
    goto retry


unwrap:
    var location unwrap1
    var todo $0
    unwrap1:
    matchre return ^\[Roundtime:
    matchre return ^That area is not tended\.
    matchre return ^The bandages binding your
    matchre return ^You may undo the affects of TENDing to an injured area by using the UNWRAP command to remove the bandages\.
    matchre return ^You unwrap your bandages\.
    put unwrap my %todo
    goto retry


watch:
    var location watch1
    var todo $0
    watch1:
    matchre return ^You are not currently watching anything\.
    matchre return ^You begin watching for the presence
    matchre return ^You feel too distracted to be on the lookout for somebody again right now\.
    matchre return You see something entering the area\.
    put watch %todo
    goto retry


wave:
    var location wave1
    var todo $0
    wave1:
    matchre return ^I do not understand
    matchre return ^You slowly wave the
    matchre return ^You wave
    put wave %todo
    goto retry


wealth:
    var location wealth
    matchre return Wealth\:
    put wealth
    goto retry


wear:
    var location wear1
    var todo $0
    wear1:
    matchre return can't fit over
    matchre return ^Please rephrase that command\.$
    matchre return ^Wear what\?
    matchre return ^The contours of the
    matchre return ^You are already wearing that\.
    matchre return ^You attach
    matchre return ^You can't wear that!
    matchre return ^You can't wear any more items like that\.
    matchre return ^You drape
    matchre return ^You hang
    matchre return ^You place
    matchre return ^You put
    matchre return ^You slide
    matchre return ^You sling
    matchre return ^You slip
    matchre return ^You strap
    matchre return ^You tug
    matchre return ^You work your way into
    matchre location.unload1 ^You need to unload the
    matchre location.unload1 ^You should unload the
    put wear %todo
    goto retry


whisper:
    var location whisper1
    var todo $0
    whisper1:
    matchre return ^Whisper what
    matchre return ^Who are
    matchre return ^You whisper
    put whisper %todo
    goto retry


wield:
    var location wield1
    var todo $0
    wield1:
    matchre return ^You can only wield a weapon or a shield\!
    matchre return ^You draw out your
    matchre return ^You need to have your
    matchre return ^You're already holding
    put wield %todo
    goto retry


wipe:
	var location wipe1
	var todo $0
	wipe1:
	matchre return not in need of drying\.$
	matchre return ^Wipe
	put wipe %todo
	goto retry


withdraw:
    var location withdraw1
    var todo $0
    withdraw1:
    matchre return clerk
    matchre return copper|silver|bronze|gold|platinum|Kronar|Dokora|Lirum
    put withdraw %todo
    goto retry


wring:
	var location wring1
	var todo $0
	wring1:
	matchre return ^You can't wring
	matchre return ^You wring
	put wring %todo
	goto retry



########################################################################
#                            Timer Verbs
########################################################################
almanac.onTimer:
    var todo $0
    var location almanac.onTimer1

    almanac.onTimer1:
	if (!($lastAlmanacGametime > 0)) then put #var lastAlmanacGametime 1
	evalmath nextStudyAt $lastAlmanacGametime + 600
	if (%nextStudyAt < $gametime) then gosub runScript almanac noloop
	unvar nextStudyAt
	return


burgle.setNextBurgleAt:
    if (!($lib.timers.nextBurgleAt > -1)) then gosub burgle recall

    if ($lib.timers.nextBurgleAt < $gametime) then {
        if ($Stealth.LearningRate > 2 && $Thievery.LearningRate > 2 && $Athletics.LearningRate > 2 && $Locksmithing.LearningRate > 2) then {
            var lowestLearningRateNumber $Stealth.LearningRate
            if (%lowestLearningRateNumber > $Thievery.LearningRate) then var lowestLearningRateNumber $Thievery.LearningRate
            if (%lowestLearningRateNumber > $Athletics.LearningRate) then var lowestLearningRateNumber $Athletics.LearningRate
            if (%lowestLearningRateNumber > $Locksmithing.LearningRate) then var lowestLearningRateNumber $Locksmithing.LearningRate
            evalmath tmpNextBurgleGametime %lowestLearningRateNumber * 200 + 60 + $gametime
            put #var lib.timers.nextBurgleAt %tmpNextBurgleGametime
        }
    }
    return


appraise.onTimer:
    var todo $0
    var location appraise.onTimer1

    appraise.onTimer1:
    if (!($lastAppGametime > 0)) then put #var lastAppGametime 1
    evalmath nextAppGametime $lastAppGametime + 61

    if ($gametime > %nextAppGametime) then gosub runScript appraise %todo
    unvar nextAppGametime
    return


hunt.onTimer:
    var todo $0
    var location hunt.onTimer1

    hunt.onTimer1:
    if (!($lastHuntGametime > 0)) then put #var lastHuntGametime 1
    evalmath nextHuntGametime $lastHuntGametime + 120
    if ($gametime > %nextHuntGametime) then {
        gosub hunt
        put #var lastHuntGametime $gametime
    }
    unvar nextHuntGametime
    return


observe.onTimer:
    var todo $0
    var location observe.onTimer1

    observe.onTimer1:
	if (!($lastObserveAt > -1)) then put #var lastObserveAt 0
	evalmath nextObserveGametime ($lastObserveAt + 240)
	if ($gametime > %nextObserveGametime || $isObsOnCd != true) then gosub runScript observe %todo
	unvar nextObserveGametime
	return


perc.onTimer:
    var todo $0
    var location perc.onTimer1

    perc.onTimer1:
	if (!($lastPercGametime > 0)) then put #var lastPercGametime 1

	evalmath nextPercGametime $lastPercGametime + 61

	if ($gametime > %nextPercGametime) then {
	    if ("$guild" = "Moon Mage") then {
	        gosub perc mana
        } else {
            gosub perc
        }
	    put #var lastPercGametime $gametime
	}
	unvar nextPercGametime
    return


percHealth.onTimer:
    var todo $0
    var location percHealth.onTimer1

    percHealth.onTimer1:
    if ($roomplayers <> null) then {
        var cooldown 30
        if ($roomid = $lastPercHealthRoomid) then var cooldown 270
        evalmath nextPercHealthGametime ($lastPercHealthGametime + %cooldown)
        if (%nextPercHealthGametime < $gametime) then {
            gosub perc health
            put #tvar lastPercHealthRoomid $roomid
            put #var lastPercHealthGametime $gametime
        }
    }
	return


pray.onTimer:
    var todo $0
    var location pray.onTimer1
    
    pray.onTimer1:
    if (!($lastPrayGametime > 0)) then put #var lastPrayGametime 1
	
	evalmath nextPrayGametime $lastPrayGametime + 601

	if ($gametime > %nextPrayGametime) then {
        gosub pray %todo
	    put #var lastPrayGametime $gametime
	}
    return


refreshRegen:
  pause 3
  put #var refreshRegen 0
  if ($SpellTimer.Regenerate.duration > 1) then {
    return
  }
  gosub prep regen 8
  waitforre ^You feel fully prepared to cast your spell\.
  gosub cast
  return

########################################################################
#                            MOVE
########################################################################

automove:
    var toroom $0
    var location automove1
    var moveAttemptsRemaining 5
	automove1:

    if ("$roomname" = "Private Home Interior") then return
    if ($hidden = 1) then gosub shiver

    if ("$roomid" = "0") then {
        gosub moveRandom
        goto automove1
    }

    if (!($north && $northeast && east && $southeast && $south && $southwest && $west && $northwest && $out)) then {
        var cardinalDirections north|northeast|east|southeast|south|southwest|west|northwest
        #random 1 8
        #put %cardinalDirections(%r)
        #pause .5
        #goto automove1
    }

    automovecont:
    match return YOU HAVE ARRIVED
    matchre return SHOP IS CLOSED
    match automovecont1 YOU HAVE FAILED
    match automovecont1 AUTOMAPPER MOVEMENT FAILED!
    match automovecont1 MOVE FAILED
    matchre automovecont1 DESTINATION NOT FOUND
    put #walk %toroom
    matchwait 120
    automovecont1:
    math moveAttemptsRemaining subtract 1
    if (%moveAttemptsRemaining < 1) then {
        echo [libmaster automove]: No more attempts, it's dead, Jim
        return
    } else {
        echo [libmaster automove]: Automove failed, Destination = %toroom, retrying (%moveAttemptsRemaining)
        #gosub moveRandom
        var cardinalDirections north|northeast|east|southeast|south|southwest|west|northwest
        random 1 8
        put %cardinalDirections(%r)
        pause
    }
    pause
    put look
    pause
    goto automovecont


move:
    var alsohere no
    var People.Room empty
    var critter no
    var todo $0
    move1:
    var location moving
    moving:
    if ($standing != 1) then {
        var moveTodo %todo
        gosub stand
        var todo %moveTodo
        goto move1
    }
    #Running heedlessly over the rough terrain|A bony hand reaches up out of the bog and clamps its cold skeletal fingers|can't seem to make much headway
    matchre dig.then.move ^Like a blind, lame duck, you wallow in the mud
    matchre dig.then.move ^The mud holds you tightly
    matchre dig.then.move ^You find yourself stuck in the mud
    matchre dig.then.move ^You struggle forward
    matchre move.portal ^What were you referring to?
    matchre move.error ^You can't go there\.
    matchre move.error ^You can't swim in that direction\.
    matchre move.releaseInvis ^But no one can see you
    matchre pause.then.move ^All this climbing back and forth is getting a bit tiresome
    matchre pause.then.move ^You are too tired
    matchre pause.then.move ^You work against the current
    matchre pause.then.move ^Your excessive speed causes you to lose your footing
    matchre retreat.then.move While in combat
    matchre retreat.then.move ^You are engaged to
    matchre retreat.then.move ^You'll have better luck if you first retreat
    matchre return ^\[
    matchre return It's pitch dark and you can't see a thing
    matchre return ^Obvious
    matchre return You don't have a key\.
    matchre return ^You look around in vain for the
    matchre return ^You see no dock.
    matchre return ^You stumble through the darkness
    matchre return seems to be closed\.$
    matchre stand.then.move ^You can't do that while kneeling.
    matchre stand.then.move ^You can't do that while lying down\.
    matchre stand.then.move ^You must be standing to do that\.
    matchre stand.then.move ^Perhaps you should stand up first.
    matchre stow.then.move ^Free up your hands first
    #matchre move1 ^As you start towards
    put %todo
    goto retry


dig.then.move:
    pause .1
    put dig %move.direction
    pause .5
    pause .5
    goto moving


move.error:
    echo * Bad move direction, will try next command in 1 second. *
    pause
    goto moving


move.portal:
    if ($SpellTimer.RefractiveField.active = 1 || $SpellTimer.RefractiveField.duration > 0) then gosub release rf
    if ($SpellTimer.EyesoftheBlind.active = 1 || $SpellTimer.EyesoftheBlind.duration > 0) then gosub release eotb
    gosub move go portal
    return


move.releaseInvis:
    if ($SpellTimer.RefractiveField.active = 1 || $SpellTimer.RefractiveField.duration > 0) then gosub release rf
    if ($SpellTimer.EyesoftheBlind.active = 1 || $SpellTimer.EyesoftheBlind.duration > 0) then gosub release eotb
    goto move1
    

pause.then.move:
    pause .2
    goto moving


retreat.then.move:
    gosub retreat
    goto moving


stand.then.move:
    var moveTodo %todo
    gosub stand
    gosub move %moveTodo
    return


stow.then.move:
    var todo.saved %todo
    gosub stowing
    var todo %todo.saved
    goto moving


moveRandom:
    pause .2
	if ("$roomname" = "Private Home Interior") then gosub runScript house
    var People.Room empty
    var direction north
    random 1 8
    if %r = 1 and $north = 0 then goto moverandom
    if %r = 2 and $northeast = 0 then goto moverandom
    if %r = 3 and $east = 0 then goto moverandom
    if %r = 4 and $southeast = 0 then goto moverandom
    if %r = 5 and $south = 0 then goto moverandom
    if %r = 6 and $southwest = 0 then goto moverandom
    if %r = 7 and $west = 0 then goto moverandom
    if %r = 8 and $northwest = 0 then goto moverandom
    if %r = 1 then var direction north
    if %r = 2 then var direction northeast
    if %r = 3 then var direction east
    if %r = 4 then var direction southeast
    if %r = 5 then var direction south
    if %r = 6 then var direction southwest
    if %r = 7 then var direction west
    if %r = 8 then var direction northwest
    gosub move %direction
    return


libmastertest:
    echo [ libmaster -> libmastertest] Called from script: %scriptname
    var todo $0
    var location test1
    test1:
    matchre return ^FORCERETURN
    put look %todo
    goto retry

########################################################################
#                            UTIL
########################################################################

checkForBacklashDebuff:
    var lib.debuffedSkills null
    put #tvar lib.backlashDebuff 0

    gosub exp mods
    eval lib.debuffedSkills replace("%lib.debuffedSkills", "null|", "")
    var numDebuffedMagicSkills 0
    if (contains("%lib.debuffedSkills", "Augmentation")) then math numDebuffedMagicSkills add 1

	if (contains("%lib.debuffedSkills", "Utility")) then math numDebuffedMagicSkills add 1
	if (contains("%lib.debuffedSkills", "Warding")) then math numDebuffedMagicSkills add 1
	if (%numDebuffedMagicSkills >= 2) then put #tvar lib.backlashDebuff 1
	put #tvar lib.timers.lastCheckForBacklashDebuff $gametime
	unvar lib.debuffedSkills
	unvar numDebuffedMagicSkills
    return

checkMoons:
    put #var moon null
    if ($Time.isYavashUp = 1) then {
        put #var moon yavash
    }
    if ($Time.isXibarUp = 1) then {
        put #var moon xibar
    }
    if ($Time.isKatambaUp = 1) then {
        put #var moon katamba
    }
    return


debug:
	put #echo [%scriptname] $0
	return


retry:
    matchre return ^\[Roundtime
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
    matchre location1 ^You are concentrating too much upon your performance to do that\.
    matchre location1 ^You are a bit too busy performing to do that\.
    matchre location1 ^You should stop playing before you do that\.
    matchwait 30
    math retryAttempts add 1
    echo [ libmaster -> retry ] No match found, %retryAttempts retries
    put #tvar libmaster.retryAttempts %retryAttempts
    if (%retryAttempts > 5) then {
         put #echo #FF0000 RETRIED 5 TIMES, NO MATCHES! FORCING RETURN!
         put #tvar libmaster.responseNotFound 1
         return
     }
    goto location


location.unload:
    var unloadTodo %todo
    gosub unload
    gosub stow left
    gosub stow %unloadTodo
    return


location.unload1:
    gosub unload
    var location wear1
    gosub wear1
    return


location1:
    gosub stop.humming1
    goto %location


location.p:
    pause 1


location:
    goto %location


location.tooFast:
    random 1 2
    pause %r


return.p:
   pause .1


return:
    return


isDef:
    if (!matchre(“%var”, “\%var”)) then var localDef 1
    return


restartScript:
    put #echo >FF9900 [ libmaster -> restartScript ] RESTARTING SCRIPT: %scriptname
    pause .2
    put .%scriptname
    exit


runScript:
    var todo $0
    var scriptName $1
    var location runScript1

    runScript1:
        #put #echo >Debug #FF9900 runScript start %todo
	    eval doneString toupper("%scriptName")
		matchre runScriptDone ^%doneString DONE$
		put .%todo

	runScriptLoop:
		matchre runScriptDone ^%doneString DONE$
		matchwait 15
        eval lowerScriptName tolower("%scriptName")
        var lowerScriptName %lowerScriptName.cmd
		if (!contains("$scriptlist", "%lowerScriptName")) then {
		    put #echo #FF9900 [runScript] *%lowerScriptName* NOT IN SCRIPTLIST ($scriptlist), RETURNING
		    put #echo >Log #FF9900 [runScript] %lowerScriptName exited without #parse
		    goto runScriptDone
		}
		delay .2
	    goto runScriptLoop

    runScriptDone:
        #put #echo >Debug #FF9900 runScript end %todo
        return


waitForConcentration:
    var waitConcentrationAmount $1
    if (!(%waitConcentrationAmount) > 0) then var waitConcentrationAmount 30

    waitForConcentration1:
    if ($concentration >= %waitConcentrationAmount) then return
    pause .5
    goto waitForConcentration1


waitForPrep:
	var waitForPrep.minSpellTime $1
	if (!(%waitForPrep.minSpellTime > -1)) then var waitForPrep.minSpellTime 40
    var isFullyPrepped 0
    echo waitForPrep: Waiting for minspell time: %waitForPrep.minSpellTime
    waitForPrep1:
    gosub waitForMana 30
    pause .1
    if (%isFullyPrepped = 1 || "$preparedspell" = "None" || $spelltime > %waitForPrep.minSpellTime) then return
    goto waitForPrep1


waitForMana:
    var waitManaForAmount $1
    if (!(%waitManaForAmount > 0)) then var waitManaForAmount 80

    waitForMana1:
    pause .5
    #if ($mana > %waitManaForAmount || "$preparedspell" = "None") then return
    if ($mana >= %waitManaForAmount) then return
    goto waitForMana1


end.of.file: