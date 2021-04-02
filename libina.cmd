###################
# Inauri Library
###################
action clear
gosub clear
Counter Set 0
Timer clear

###################
# Sakhhtaw Library
###################

###################
# Khurnaarti Library
###################
action put #var observeOffCooldown true when ^You feel you have sufficiently pondered your latest observation\.$
action put #var observeOffCooldown true when ^Although you were nearly overwhelmed by some aspects of your observation
action put #var observeOffCooldown false when ^You learned something useful from your observation\.$
action put #var observeOffCooldown false when ^You have not pondered your last observation sufficiently\.$
action put #var observeOffCooldown false when ^You are unable to make use of this latest observation
action put #var observeOffCooldown false when ^While the sighting wasn't quite what you were hoping for, you still learned from your observation\.$

###################
# Friends and Enemies
###################
var friends (Selesthiel|Asherasa|Sorhhn|Xomfor|Yraggahh|Qihhth|Diapsid|Qizhmur|Khurnaarti)
var enemies (Meiline|Nideya|Psaero)
var super.enemies (Meiline|Nideya|Psaero)

###################
# General
###################
#action send dump junk when ^The room is too cluttered to find anything here\!
action send stand when ^You can't do that while lying down
action send stand when ^You had better stand up first
action send stand when ^You might want to stand up first
action send stand when ^You must stand first
action send stand when ^You'd have better luck standing up

###################
# Health
###################
action goto refreshRegen when eval $health < 50
#action goto exit.full when ^Your body will decay beyond its ability to hold your soul
#action goto exit.full when ^You feel like you're dying
#action goto exit.full when ^You are somewhat comforted that you have gained favor with your God and are in no danger of walking the Starry Road, never to return\.
#action goto exit.full when ^Your death cry echoes in your brain
#action goto exit.full when ^You feel yourself falling\.\.\.
#action goto exit.full when ^You are a ghost\!
#action goto exit.full when ^You are a ghost\!  You must wait until someone resurrects you, or you decay\.
#action goto exit.full when ^You feel like you're dying\!

####################
# HIDDEN
####################
action var Hidden 0 when ^You blend in with your surroundings|^You slip into a hiding|^You melt into the background|^Darkness falls over you like a cloak, and you involuntarily blend into the shadows\.|^Eh\?  But you're already hidden
action var Hidden 1 when ^You leap out of hiding|^You come out of hiding\.|^You burst from hiding and begin to dance about\!|^You slip out of hiding\.|notices your attempt to hide|discovers you, ruining your hiding place|reveals you, ruining your hiding attempt
var Hidden 1

###################
# Magic
###################


###################
# Looting
###################
action var loot 1 when ^The clay mage falls apart into a pile of worthless pottery shards
action var loot 1 when ^A rock guardian collapses into a pile of stone
action var loot 1 when ^The cadaverous yeehar collapses to the ground in a pile of bones and rotting flesh

###################
# Necromancer Ritual Needs
###################
#action #send prep qe when You sense your Quicken the Earth spell fade.
action put #var creature badger when ^The striped badger screams one last time and lies still|^The striped badger falls to the ground and lies still
action put #var creature pothanit when ^The croff pothanit falls to the ground and lies still
action put #var creature boar when ^The wild boar falls to the ground and lies still|^The wild boar screams one last time and lies still
action put #var creature bear when ^A silver-backed bear growls one last time and collapses
action put #var creature maiden when ^The fire maiden screams and collapses, her dance stilled at last
action put #var creature sprite when ^A fire sprite screams and collapses, her dance stilled at last
action put #var creature sprite when ^A fire sprite screams in anguish and lies still
action put #var creature firecat when firecat falls to the ground and lies still


####################
### ROOM OCCUPIED
####################
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

###################
# Skinning
###################
action put #var skin 1 when ^The ship's rat screams one last time and lies still\.
action put #var skin 1 when ^The ship's rat falls to the ground and lies still\.
action put #var skin 1 when ^A granite gargoyle grumbles and falls over\.
action put #var skin 1 when ^A granite gargoyle grumbles and goes still\.
action put #var skin 1 when ^A quartz gargoyle grumbles and falls over with a
action put #var skin 1 when ^A quartz gargoyle grumbles and goes still\.
action put #var skin 1 when ^A silverfish lurches forward and collapses
action put #var skin 1 when ^A silverfish freezes a moment and falls into a heap
action put #var skin 1 when grows limp and seems to deflate slightly
action put #var skin 1 when slaps around a few times and then grows still
action put #var skin 1 when ^A giant thicket viper rises up threateningly one last time before collapsing
action put #var skin 1 when ^A seordhevor kartais flaps its wings to no avail as it falls to the ground and goes
action put #var skin 1 when ^A seordhevor kartais lets out a shriek and goes
action put #var skin 1 when ^The striped badger screams one last time and lies still\.
action put #var skin 1 when ^The striped badger falls to the ground and lies still\.
action put #var skin 1 when ^The croff pothanit falls to the ground and lies still\.
action put #var skin 1 when ^The wild boar falls to the ground and lies still\.
action put #var skin 1 when ^The wild boar screams one last time and lies still\.
action put #var skin 1 when ^The majestic deer collapses to the ground, its mouth panting in a last few desperate gulps of air before that too fails and it goes completely limp\.
action put #var skin 1 when ^A.*gryphon collapses into a lifeless mound of fur and feathers\.
action put #var skin 1 when ^A.*snow goblin stares at you stupidly for a moment, before its eyes roll backwards into its head\.
action put #var skin 1 when ^A snowbeast lets loose a blood-curdling howl and falls into a heap\.
action put #var skin 1 when ^A snowbeast lets loose a blood-curdling howl and goes still\.
action put #var skin 1 when ^The forest geni's body explodes into a gaseous cloud\.
action put #var skin 1 when ^The forest geni cries out to the forest for protection\.  Getting no response, it collapses to the ground\.
action put #var skin 1 when ^A giant black leucro collapses to the ground, yelping like a lost puppy calling for its mother until finally it ceases all movement\.
action put #var skin 1 when ^A giant black leucro suddenly yelps like a puppy and stops all movement\.
action put #var skin 1 when ^The silver leucro screams one last time and lies
action put #var skin 1 when ^The silver leucro falls to the ground and lies
action put #var skin 1 when ^A giant thicket viper slaps around a few times and then grows still\.
action put #var skin 1 when ^A giant thicket viper rises up threateningly one last time before collapsing\.
action put #var skin 1 when ^A grass eel coils and uncoils rapidly before expiring\.
action put #var skin 1 when ^A grass eel thrashes about wildly for a few seconds, then lies still\.
action put #var skin 1 when ^A grass eel coils and uncoils rapidly before expiring\.
action put #var skin 1 when ^A grass eel shudders then goes limp\.
action put #var skin 1 when ^A grass eel shudders, then goes limp\.
action put #var skin 1 when ^The beisswurm falls to the ground and lies still\.
action put #var skin 1 when ^A rock troll collapses with a heavy thud\.
action put #var skin 1 when ^The bucca drops dead at your feet\!
action put #var skin 1 when ^A copperhead viper rises up threateningly one last time before collapsing\.
action put #var skin 1 when ^A copperhead viper slaps around a few times and then grows still\.
action put #var skin 1 when ^An Endrus serpent jackknifes a few times, then grows still, its body rapidly settling until it is little more than a pile of wood and vine\.
action put #var skin 1 when ^A suw bizar loses its cohesion, oozing outwards as a murky puddle\.
action put #var skin 1 when ^A blood wolf whines briefly before closing its eyes forever\.
action put #var skin 1 when ^A silver-backed bear growls one last time and collapses\.
action put #var skin 1 when ^The fire maiden screams and collapses, her dance stilled at last\.
action put #var skin 1 when ^The immature firecat falls to the ground and lies still\.
action put #var skin 1 when ^The immature firecat screams one last time and lies still\.
action put #var skin 1 when ^The young firecat falls to the ground and lies still\.
action put #var skin 1 when ^A fire sprite screams and collapses, her dance stilled at last\.
action put #var skin 1 when ^A fire sprite screams in anguish and lies still\.
action put #var skin 1 when ^A blue-belly crocodile sinks into the water and turns belly up, clawing in vain at the air until it ceases all movement\.
action put #var skin 1 when ^A caracal tips over, limbs extended stiffly, and exp
action put #var skin 1 when ^A caracal trembles violently before finally exp
action put #var skin 1 when ^A peccary flops in a porky heap, squealing one last time before passing into obliv
action put #var skin 1 when ^A peccary kicks and spasms as the last vestiges of life flee this mortal c
action put #var skin 1 when ^A bristle-backed peccary flops in a porky heap, squealing one last time before passing into ob
action put #var skin 1 when ^A bristle-backed peccary kicks and spasms as the last vestiges of life flee this mortal
action put #var skin 1 when ^The asaren celpeze thrashes about for a moment, then lies s
action put #var skin 1 when ^The asaren celpeze's flared crest wobbles, then collapses as the celpeze falls over and lies s
action put #var skin 1 when ^The asaren celpeze slumps and goes limp\.  Its tail twitches once or twice, and the light fades from its baleful e
action put #var skin 1 when ^The asaren celpeze's chest heaves slowly and it emits a rasping hiss before finally lying st
action put #var skin 1 when ^An.*desert armadillo falls over and, after a couple of spasms, is still\.
action goto loot when ^Skin what\?
action goto loot when ^.* can't be skinned
put #var skin 0


###################
# Teaching
###################
#action var listen $2 when ^To learn from (him|her), you must LISTEN TO (\w+)
action put #var student 1 when ^You begin to listen to (\S+) teach
action put #var class 0 when ^All of your students have left, so you stop teaching\.
action put #var class 0 when ^Because you have no more students, your class ends\.


###################
# Common Methods
###################
#Skip to the end of the file, don't execute this because this is just an include
goto end.of.file

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
  matchre return ^You fail to find any holes
  matchre return ^You must be closer
  put analyze %todo
  goto retry
  
app:
appraise:
  var location appraise1
  var todo $0
appraise1:
  matchre return ^Appraise what\?
  matchre return ^I could not find what you were referring to\.
  matchre return ^It's dead
  matchre return ^Taking stock of its
  matchre return ^You cannot appraise that when you are in combat\!
  matchre return ^You can't
  matchre return ^You don't seem to be able to move to do that\.
  matchre return ^Roundtime
  matchre return Roundtime:

  put appraise %todo
  goto retry

arr:
arrange:
  var todo $0
  var location arrange1
arrange1:
  matchre arrange1 ...wait
  matchre arrange1 Sorry
  matchre arrange1 ^You continue
  matchre arrange1 ^You begin
  matchre return has already been arranged as much as you can manage\.
  matchre return ^Arrange what\?
  matchre return ^That creature cannot produce a skinnable part\.
  matchre return ^Try killing the
  matchre return The .+ cannot be skinned, so you can't arrange it either.
  matchre return Roundtime
  put arrange %todo
  goto retry

ass:
assess:
  var todo $0
  var location assess1
assess1:
  matchre assess1 ^Are you sure you want to do that
  matchre return Roundtime
  matchre assess ...wait
  matchre assess Sorry
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
    matchre advance2 ^It would help if you were closer
    matchre advance2 ^You are already advancing
    matchre advance2 ^You aren't close enough to attack\.
    matchre attack2 ^You should stand up first\.
    matchre return ^At what are you trying
    matchre return ^But you don't have a ranged weapon in your hand to fire with\!
    matchre return ^But your .* isn't loaded\!
    matchre return ^How can you snipe if you are not hidden\?
    matchre return ^I could not find what you were referring to\.
    matchre return is already quite dead\.
    matchre return ^\[Roundtime
    matchre return ^Roundtime:
    matchre return ^The .* is already debilitated\!
    matchre return ^The khuj is too heavy for you to use like that\.
    matchre return ^There is nothing else to face
    matchre return ^What are you trying to throw?
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

bundle:
  var location bundle
  matchre return ^That's not going to work\.
  matchre return ^You bundle up your
  matchre return ^You stuff your
  matchre return ^You try to stuff your.*into the bundle but can't seem to find a good spot\.
  put bundle $lefthand
  goto retry

bundle2:
  if "$lefthand" != "Empty" then put stow left
  gosub get bundling rope
  goto bundle

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
  matchre return ^You can't cast .+ on yourself\!
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
  matchre return ^You raise your palms and face to the heavens
  matchre return ^You wave your hand\.
  matchre return ^You whisper the final word of your spell
  matchre return ^Your secondary spell pattern dissipates
  matchre return ^Your spell backfires
  matchre return ^Your spell pattern collapses
  matchre return ^Your target pattern dissipates
  put cast %todo
  goto retry

center:
  var todo $0
  var location center1
center1:
  matchre openTelescope ^You'll need to open
  matchre return ^You put your eye to the
  matchre return ^Center what
  matchre return ^What did you want
  matchre return ^The pain is too much
  matchre return ^You are unable to hold
  put center %todo
  goto retry
  
charge:
  var location charge1
  var todo $0
charge1:
  matchre return ^I could not find

  matchre return ^Roundtime
  matchre return ^You are in no condition to do that
  matchre return ^You harness
  put charge %todo
  goto retry

close:
  var location close1
  var todo $0
close1:
  matchre return ^That is already
  matchre return ^The door
  matchre return ^You close
  matchre return ^You collapse your telescope\.
  matchre return ^You need to be holding the telescope first\.
  matchre return ^You quickly
  matchre return ^You try, but the telescope won't collapse any further\.
  matchre return ^Your dreamweave fan is already
  matchre return ^What were
  matchre return ^With a practiced flick of your wrist
  put close %todo
  goto retry

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
  put combine %todo
  goto retry

dump.junk:
  var location dump.junk
  matchre return ^\[You have marked this room to be cleaned by the janitor\.  It should arrive shortly.\]
  matchre return ^The janitor was recently summoned to this room\.  Please wait \d+ seconds\.
  matchre return ^You should just kick yourself in the shin\.  There is no junk here\.
  put dump junk
  goto retry

dodge:
  var location dodge
  matchre return ^But you are already dodging\!
  matchre return ^Roundtime
  matchre return ^You are already in a position
  matchre return ^You move into a position
  matchre return ^You need two hands to wield this weapon\!
  put dodge
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

ejectFromHouse:
  if ($roomname <> "Inauri's Home") then goto end.of.file
  eval names replacere("$roomplayers", "Also here: ", "")
  eval names replacere("%names", "(,| and)", "|")
  eval names replacere("%names", "\.", "")
  var index 0
  eval namesLength count("%names", "|")

ejectloop:
  if ("%names(%index)" != "Selesthiel") then {
     put show %names(%index) to door
     pause .5
     put show %names(%index) to door
     pause .5
  }
  math index add 1
  if (%index > %namesLength) then goto ejectdone
  goto ejectloop

ejectdone:
  goto end.of.file

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
  matchre return ^Your attempt to flee has failed
  matchre return ^Your fate is sealed
  matchre return ^You manage to free yourself from engagement
  matchre return ^You melt into the background, convinced that your misdirect was successful
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
  matchre return ^You move into the chaotic tides
  matchre return ^You reach out into the seemingly infinite strands of Lunar mana
  matchre return ^Your link to the .+ is intact\.
  put focus %todo
  goto retry

forage:
  var location forage1
  var todo $0
forage1:
  matchre return ^Roundtime
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

get:
  var location get1
  var todo $0
get1:
  matchre return ^But that is already in your inventory\.
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

give:
  var location give1
  var todo $0
give1:
  matchre give1 ^A clerk looks over the
  matchre give1 ^Catrox says, "It will cost
  matchre return ^Catrox mutters
  matchre return ^Catrox shrugs
  matchre return ^You offer
  matchre return ^You give
  matchre return ^You hand
  put give %todo
  goto retry

harn:
harness:
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
  
healPoisonSelf:
  gosub prep fp 10    
  pause 2
  gosub charge my $cambItem 10
  pause 2
  gosub invoke my $cambItem spell
  waitforre ^You feel fully prepared
  gosub cast
  return

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

idleLook:
  evalmath nextLookAt $lastLookGametime + 240
  if (%nextLookAt < $gametime) then {        
    gosub look
    put #var lastLookGametime $gametime        
  }
return

invoke:
  var location invoke1
  var todo $0
invoke1:
  matchre return ^A finely balanced tago suddenly leaps
  matchre return ^Invoke what?
  matchre return ^Roundtime
  matchre return ^The cambrinth
  matchre return ^You are in no condition
  matchre return ^You don't have any
  matchre return ^You gesture, adjusting the pattern that binds the shadowling to this plane.$
  matchre return You reach for its center and forge a magical link
  matchre return ^You're not sure what would happen
  matchre invoke ^You reach for its center, attempting
  put invoke %todo
  goto retry

kick:
  var location kick1
  var todo $0
kick1:
  if ($standing = 0) then put stand
  matchre return ^Bringing your foot
  matchre return ^I could not find what you were referring to\.
  matchre return ^Loosing your footing at the last moment
  matchre return ^You can't quite manage
  matchre return ^You kick
  matchre return ^You take a step back and run up to the
  matchre kick1 ^You can't do that from your position\.
  matchre kick1 ^You throw a glorious temper tantrum\!
  put kick %todo
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
  matchre return ^You are already listening to someone\.
  matchre return ^You begin to listen
  matchre return ^You cannot teach a skill and be a student at the same time\!
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

lob:
  var location lob1
  var todo $0
lob1:
  matchre return Roundtime
  matchre return ^There is nothing
  put lob %todo
  goto retry

lock:
  var location lock1
  var todo $0
lock1:
  matchre return is already locked
  matchre return ^That is
  matchre return ^You don't
  matchre return ^You do not
  matchre return ^You lock
  matchre return ^You quickly lock
  matchre return ^You rattle
  put lock %todo
  goto retry

look:
  var location look1
  var todo $0
look1:
  matchre return ^\[
  matchre return ^(He|She) is
  matchre return ^I could not find what you were referring to\.
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
  put loot %todo
  goto retry

observe:
  var location observe1
  var todo $0
observe1:
  matchre return ^Roundtime
  matchre return ^You are a bit too distracted
  matchre return ^You scan the skies for a few moments\.
  matchre return ^Your search for the constellation
  put observe %todo
  goto retry

observe.onTimer:
  var todo $0
  var location observe.onTimer1
observe.onTimer1:
  if (!($lastObserveAt > -1)) then put #var lastObserveAt 0
  evalmath nextObserveGametime ($lastObserveAt + 240)
  if ($gametime > %nextObserveGametime || $isObsOnCd != true) then {
    put .observation %todo
  }
  return

open:
  var location open1
  var todo $0
open1:
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
  put open %todo
  goto retry

openTelescope:
  put open my telescope
  goto location

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
  var location peer1
peer1:
  matchre return ^That's a bit tough to do when you can't see the sky\.
  matchre return ^You focus
  matchre return ^You peer aimlessly
  matchre return ^Roundtime
  matchre return ^Clouds obscure the sky
  put peer %todo
  goto retry

perc:
perceive:
  var location perceive1
  var todo $0
perceive1:
  matchre return ^I could not find who you were referring to\.
  matchre return ^Roundtime
  matchre return ^Something in the area is interfering
  matchre return ^Strangely, you can sense absolutely nothing.
  matchre return ^You are already
  matchre return ^You are too distracted
  matchre return ^You lost track of your surroundings
  matchre return ^You stop for a moment
  matchre return ^Your focus expires
  matchre return ^Your resolve collapses
  put perceive %todo
  goto retry

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
  matchre return ^The blood on your palm bubbles slightly
  matchre return ^The harvesting ritual performed
  matchre return ^This corpse has already
  matchre return ^This ritual may only be performed
  matchre return too injured to be a good specimen\.$
  matchre return ^You bend over the
  matchre return ^You cannot harvest useful material from the corpse unless it is preserved first\.
  matchre return ^You've already performed
  put perform %todo
  goto retry

pick:
  var location pick1
  var todo $0
pick1:
  matchre return isn't locked
  matchre return ^The lock looks weak
  matchre return ^With a faint
  put pick %todo
  goto retry

play:
  var location play1
  var todo $0
play1:
  matchre return with only the slightest hint
  matchre return ^You begin
  matchre return ^You effortlessly
  matchre return ^You fumble
  matchre return ^You play
  matchre return ^You struggle
  put play %todo
  goto retry

pre.skin:
  if (%skin = 0) then goto return
  if (%current.stance <> custom) then gosub stance custom
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

prep:
  var location prep1
  var todo $0
prep1:
  matchre prep1 ^Are you sure you want to do that\?  You'll interrupt your research\!
  matchre return ^A nagging sense of desperation guides your hands through the motions
  matchre return ^As quickly as you form the spell pattern in your mind it slips away from you again.$
  matchre return ^As you begin to focus on preparing
  matchre return ^But you've already
  matchre return ^Heatless orange flames blaze between your fingertips
  matchre return ^Icy blue frost crackles up your arms
  matchre return ^Images of streaking stars falling from the heavens flash across your vision
  matchre return ^Something in the area interferes with your spell preparations
  matchre return ^The wailing of lost souls accompanies your preparations
  matchre return ^Tiny tendrils of lightning jolt between your hands
  matchre return ^With great force, you slap your hands together before you and slowly pull them apart,
  matchre return ^With no small amount of effort, you slowly recall the teachings
  matchre return ^With rigid movements you prepare your body
  matchre return ^You are already
  matchre return ^You begin chanting a prayer
  matchre return ^You close your eyes and breathe deeply,
  matchre return ^You deftly waggle your fingers in the precise motions needed to prepare
  matchre return ^You don't seem to be able to move to do that\.
  matchre return ^You have already
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
  put prep %todo
  goto retry

pull:
    var location pull1
    var todo $0
    pull1:
    matchre return ^Roundtime
    matchre return ^With a muttered curse
    matchre return ^You are a little too busy with combat to worry about that right now\.
    matchre return ^You throw away the ruined portion
    matchre return ^You tug
    put pull %todo
    goto retry

read:
    var location read1
    var todo $0
    read1:
    matchre return contains a
    matchre return ^I could not find what you were referring to\.
    matchre return ^On this page
    matchre return ^Roundtime
    matchre return ^The writing is too small\.  You'll have to hold the scroll to read it\.
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

refreshRegen:
  pause 3
  put #var refreshRegen 0
  if ($SpellTimer.Regenerate.duration > 1) then {
    return
  }
  gosub prep regen 8
  waitforre ^You feel fully prepared to cast your spell
  gosub cast
  return

rel:
release:
    var location release1
    var todo $0
    release1:
    if ( ("%todo" = "" || "%todo" = "spell") && "$preparedspell" = "none") then return
    matchre return ^A faint groan echoes
    matchre return ^A faint growl echoes from the depths
    matchre return ^A.*Shadow Servant.*disappears\.$
    matchre return ^But you haven't prepared
    matchre return disappears\.$
    matchre return ^Release what
    matchre return sphere suddenly flares with a cold light and vaporizes\!$
    matchre return ^That would be a neat trick.  Try finding a shadowling first\.$
    matchre return ^The greenish hues
    matchre return ^Release\?  You can't even sense mana right now.$
    matchre return ^The Rite of Contrition
    matchre return ^The Rite of Grace matrix loses
    matchre return ^The shimmering globe of blue fire
    matchre return ^The tingling across your body diminishes as you feel the motes of energy fade away
    matchre return ^Type RELEASE HELP for more options\.
    matchre return ^You aren't harnessing any mana.
    matchre return ^You aren't holding any mana\.
    matchre return ^You aren't preparing
    matchre return ^You cease your shadow weaving\.$
    matchre return ^You don't have a Shadow Servant
    matchre return ^You gesture, attempting to unravel the pattern binding the shadowling to this plane\.
    matchre return ^You gesture, completing the pattern to unravel the mystical bonds binding the shadowling to this plane\.
    matchre return ^You have no cyclic spell active to release\.
    matchre return ^You let your concentration lapse and feel the spell's energies dissipate\.
    matchre return ^The refractive field surrounding you
    matchre return ^You release
    matchre return ^Your corruption fades
    put release %todo
    goto retry

rem:
remove:
    var location remove1
    var todo $0
    remove1:
    matchre return ^Remove what\?
    matchre return ^Roundtime
    matchre return ^What were you referring to\?
    matchre return ^You aren't wearing that\.
    matchre return ^You count out
    matchre return ^You loosen the straps securing
    matchre return ^You pull off
    matchre return ^You pull your
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
    matchre return ^Roundtime
    matchre return SKIN
    matchre return ^The leather looks frayed
    matchre return ^With some needle and thread
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
    if ($monstercount > 0) then {
      put retreat;retreat
      pause .2
    }
    return

roll:
    var location roll1
    var todo $0
    roll1:
    matchre return ^Roundtime
    matchre return ^You realize you have not yet properly aligned
    matchre return ^You're too
    put roll %todo
    goto retry


rub:
    var location rub1
    var todo $0
    rub1:
    matchre rub1 ^You rub Mythos gently, trying to massage any sore muscles\.
    matchre return ^As you rub the orb, it glows slightly more intensely and you feel a strange tugging, as if something has been moved from you to the orb\.
    matchre return The strange tugging sensation is gone, leading you to believe that your sacrifice is properly prepared\.
    matchre return ^You rub the orb and feel a strange tugging, but nothing really seems to happen\.
    matchre return ^You run your fingers over the bones\.
    matchre return ^Rub what\?
    put rub %todo
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
    matchre return ^Sell what\?
    matchre return ^Scupper separates the bundle and sorts through it carefully
    matchre return ^There is no merchant
    matchre return ^You ask
    matchre return ^You ask Scupper to buy a lumpy bundle\.
    put sell %todo
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
    matchre trainerDone ^The leather looks frayed
    put skin %todo
    goto retry

sleep:
  var expSleep 0
  put #queue clear
  matchre sleep1 ^But you are not|^You awaken from your reverie
  matchwait
sleep1:
  matchre sleep2 ^You relax and allow your mind
  put sleep
  matchwait
sleep2:
  matchre return You draw deeper into rest
  put sleep
  matchwait

stance:
    var location stance1
    var todo $0
    var current.stance $0
    if ("$righthandnoun" = "crossbow" && "%todo" != "shield") then {
        var todo shield
        var current.stance shield
    }
    stance1:
    matchre return ^You are now set to use your
    matchre return ^Your (attack|evasion|parry|shield) ability is now set at
    matchre return (Attack|Evade|Parry|Block)
    put stance %todo
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
    put stand %todo
    goto retry

stop:
    var location stop1
    var todo $0
    stop1:
    matchre return ^But you aren't listening to anyone\.
    matchre return ^But you aren't teaching anyone\.
    matchre return ^You stop listening to
    matchre return ^You stop practicing your climbing skills\.
    matchre return ^You stop teaching\.
    matchre return ^You stop trying to teach
    matchre return ^You weren't practicing your climbing skills anyway\.
    put stop %todo
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
    matchre return ^There doesn't seem to be anything left in the pile\.$
    matchre return ^You carefully
    matchre return ^You hang your
    matchre return ^You need a free hand to pick that up.
    matchre return ^You open your pouch
    matchre return ^You pick up
    matchre return ^You put your
    matchre return ^You stop as you realize
    matchre return ^You think the gem pouch is too full to fit another gem into\.
    matchre return ^You try to
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
    if $lefthand != Empty then gosub wear left
    if $righthand != Empty then gosub wear right
    return


study:
    var location study1
    var todo $0
    study1:
    matchre study1 ^Are you sure you want to do that
    matchre return ^But you aren't holding
    matchre return ^Roundtime
    matchre return ^Why do you need to study this chart again\?
    matchre return ^You are unable to sense additional information\.
    matchre return ^You attempt
    matchre return ^You feel it is too soon to grasp anything new in the skies above\.
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
    matchre return ^With a quiet
    matchre return ^You deftly change
    matchre return ^You effortlessly switch
    matchre return ^You fiercely switch
    matchre return ^You have nothing to swap\!
    matchre return ^You move
    matchre return ^You switch your
    matchre return ^You turn
    matchre return ^Your eyes blaze
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

take:
  var location take1
  var todo $0
take1:
  matchre return ^You rest your hand
  matchre return ^You brush
  matchre return ^You touch
  put take %todo
  goto retry

tar:
target:
    var location target1
    var todo $0
    target1:
    matchre return ^But you're already preparing
    matchre return ^You begin to weave
    matchre return ^You deftly remove
    matchre return ^You don't need to target the spell you're preparing\.
    matchre return ^You must be preparing a spell in order to target it\!
    matchre return ^This spell cannot be targeted\.$
    matchre return ^Your target pattern is already formed
    matchre target2 ^There is no need to target
    matchre target2 ^You are not engaged to anything, so you must specify a target to focus on\!
    put target %todo
    goto retry
target2:
    put face next
    goto target1

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

throw:
    var location throw1
    var todo $0
    throw1:
    matchre return Roundtime
    matchre return ^There is nothing
    put throw %todo
    goto retry

tie:
    var location tie1
    var todo $0
    tie1:
    matchre return ^What were you
    matchre return ^You are already
    matchre return ^You attach
    matchre return ^You tie
    put tie %todo
    goto retry

touch:
    var location touch1
    var todo $0
    touch1:
    matchre return ^You lay your hand on
    matchre return ^You lightly touch
    matchre return ^You reluctantly touch
    matchre return ^You rest your hand
    matchre return ^You touch
    put touch %todo
    goto retry

trainerDone: 
  put #var lastTrainerGametime $gametime
  return

turn:
    var location turn1
    var todo $0
    turn1:
    matchre return already at the contents
    matchre return ^But you're not
    matchre return ^I could not
    matchre return ^Roundtime
    matchre return ^The book is already
    matchre return ^Turn what\?
    matchre return ^You attempt
    matchre return ^You carefully
    matchre return ^You turn to the section
    matchre return ^You turn
    put turn %todo
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
    put unlock %todo
    goto retry

untie:
    var location untie1
    var todo $0
    untie1:
    matchre return ^What were you
    matchre return ^You are already
    matchre return ^You untie
    put untie %todo
    goto retry

wear:
    var location wear1
    var todo $0
    wear1:
    matchre return ^Wear what\?
    matchre return ^The contours of the
    matchre return ^You are already wearing that\.
    matchre return ^You attach
    matchre return ^You can't wear that!
    matchre return ^You can't wear any more items like that\.
    matchre return ^You drape
    matchre return ^You hang
    matchre return ^You put
    matchre return ^You slide
    matchre return ^You sling
    matchre return ^You slip
    matchre return ^You strap
    matchre return ^You work your way into
    matchre location.unload1 ^You need to unload the
    matchre location.unload1 ^You should unload the
    put wear %todo
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


########################################################################
#                            MOVE
########################################################################
automove:
  var toroom $0
  var moveAttemptsRemaining 5
automovecont:
  match return YOU HAVE ARRIVED
  match automovecont1 YOU HAVE FAILED
  match automovecont1 AUTOMAPPER MOVEMENT FAILED!
  match automovecont1 MOVE FAILED
  matchre automovecont1 DESTINATION NOT FOUND
  put #walk %toroom
  matchwait 120

automovecont1:
  math moveAttemptsRemaining subtract 1
  if (%moveAttemptsRemaining < 1) then {
      echo [libina automove]: No more attempts, it's dead, Jim.
      return
  } else {
      echo [libina automove]: Automove failed, retrying (%moveAttemptsRemaining)
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
    #Running heedlessly over the rough terrain|A bony hand reaches up out of the bog and clamps its cold skeletal fingers|can't seem to make much headway
    matchre dig.then.move ^Like a blind, lame duck, you wallow in the mud
    matchre dig.then.move ^The mud holds you tightly
    matchre dig.then.move ^You find yourself stuck in the mud
    matchre dig.then.move ^You struggle forward
    matchre move.portal ^What were you referring to?
    matchre move.error ^You can't go there\.
    matchre move.error ^You can't swim in that direction\.
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
    matchre return ^You look around in vain for the
    matchre return ^You see no dock.
    matchre stand.then.move ^You can't do that while kneeling.
    matchre stand.then.move ^You can't do that while lying down\.
    matchre stand.then.move ^You must be standing to do that\.
    matchre stow.then.move ^Free up your hands first
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

pause.then.move:
    pause .2
    goto moving

retreat.then.move:
    gosub retreat
    goto moving

stand.then.move:
    gosub stand
    goto move1

stow.then.move:
    var todo.saved %todo
    gosub stowing
    var todo %todo.saved
    goto moving


moveRandom:
    pause .2
    var People.Room empty
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

########################################################################
#                            UTIL
########################################################################

retry:
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
    goto location

location.unload:
    gosub unload
    var location stow1
    gosub stow1
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

runScript:
    var todo $0
    var scriptName $1
    var location runScript1
    runScript1:
    #echo [runScript] .%todo
	put .%todo
	eval doneString toupper(%scriptName)
    waitforre ^%doneString DONE$
    return

waitForConcentration:
    var waitConcentrationAmount $1
    if (!(%waitConcentrationAmount) > 0) then var waitConcentrationAmount 30

    waitForConcentration1:
    if ($concentration >= %waitConcentrationAmount) then return
    pause .5
    goto waitForConcentration1

waitForPrep:
    var isFullyPrepped 0
    waitForPrep1:
    pause .5
    if (%isFullyPrepped = 1 || $preparedspell = None) then return
    goto waitForPrep1

waitForMana:
    var waitManaForAmount $1
    if (!(%waitManaForAmount > 0)) then var waitManaForAmount 80

    waitForMana1:
    pause .5
    if ($mana > %waitManaForAmount) then return
    goto waitForMana1

end.of.file: