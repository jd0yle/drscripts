#Updated on May 27th
#############################################################################################################################################
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
#############################################################################################################################################
#dico

#var friends (Timothy|Kai|Copernicus|Macross|Arai|Xajzhi|Skurvy|Aydrian|Yachy|Sristal|Kristen|Ferra|Cez|Warneck|Dagat|Colporteur|Dagwood|Cookie|Jon|Mems|Jake|Alydenorek|Mofo|Ubo|Zonkar|Beastofburden|Illithi|Rathan|Aesrian|Thex|Raegath|Elbainian|Musparian|Gimpmule|Scheisse|Methadone|Sawbones|Zaul|Maoramachi|Solos|Seethe|Bobbybooshay|Kastr|Killr|Gator|Par|Zao|Vye|Rishlu|Gazer|Dasffion|Lotsamoney|Grubber|Jobag|Jettro|Tseng|Ameshi|And)
var friends (Inauri|Asherasa)
var enemies (nonerightnow)
var super.enemies (Nonerightnow)

#Log only if person is an enemy:



########################################################################################################################################
#################################################################################################################################
action var weapon_hand The when ^You draw out your .* sword from the .*, gripping it firmly in your right hand and balancing with your left\.$
action var weapon_hand The when ^You deftly change your grip on your sword so it can be used as a two-handed edged weapon\.$
action var weapon_hand The when ^You fiercely switch your grip so that your sword can be used as a two-handed edged weapon\.$
action var weapon_hand The when ^You effortlessly switch to a grip for using your sword as a two-handed edged weapon\.$
action var weapon_hand The when ^You turn your sword easily in your hands and end with it in position to be used as a two-handed edged weapon\.$
action var weapon_hand The when ^You switch your sword so that you can use it as a two-handed edged weapon\.$
action var weapon_hand The when ^Your eyes blaze as your hands move to a two-handed edged grip on your sword\.$
action var weapon_hand The when ^With a quiet snarl, you move your hands to grip your sword as a two-handed edged weapon\.$
action var weapon_hand he when ^You draw out your .* sword from the .*, gripping it firmly in your right hand\.$
action var weapon_hand he when ^You deftly change your grip on your sword so it can be used as a heavy edged weapon\.$
action var weapon_hand he when ^You fiercely switch your grip so that your sword can be used as a heavy edged weapon\.$
action var weapon_hand he when ^You effortlessly switch to a grip for using your sword as a heavy edged weapon\.$
action var weapon_hand he when ^You turn your sword easily in your hands and end with it in position to be used as a heavy edged weapon\.$
action var weapon_hand he when ^You switch your sword so that you can use it as a heavy edged weapon\.$
action var weapon_hand he when ^Your eyes blaze as your hands move to a heavy edged grip on your sword\.$
action var weapon_hand he when ^With a quiet snarl, you move your hands to grip your sword as a heavy edged weapon\.$
var weapon_hand NONERIGHTNOW
#################################################################################################################################
#########################################################################################################################
# DEAD
#action goto exit.full when ^Your body will decay beyond its ability to hold your soul
#action goto exit.full when ^You feel like you're dying
#action goto exit.full when ^You are somewhat comforted that you have gained favor with your God and are in no danger of walking the Starry Road, never to return\.
#action goto exit.full when ^Your death cry echoes in your brain
#action goto exit.full when ^You feel yourself falling\.\.\.
#action goto exit.full when ^You are a ghost\!
#action goto exit.full when ^You are a ghost\!  You must wait until someone resurrects you, or you decay\.
#action goto exit.full when ^You feel like you're dying\!
#########################################################################################################################


#action var People.Room occupied when ^A howl echoes about you as a wolf calls to his kind\!$
#action var People.Room occupied when ^With a waver like a mirage, \w+ fades into view\.$
#action var People.Room occupied when ^You notice \w+ loading
#action var People.Room occupied when ^\w+ appears to be aiming at
#action var People.Room occupied when ^You notice \w+'s attempt to remain hidden
#action var People.Room occupied when Appearing to have lost sight of its target
#action var People.Room occupied when comes out of hiding\.$
#ction var People.Room occupied when ^\w+ leaps from hiding
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

########################################################################################################################################

#action put sleep when ^Overall state of mind: (very murky|thick|very thick|frozen|very frozen|dense|very dense)
#action put sleep when ^Overall state of mind: murky
#action put awake when ^Overall state of mind: clear

#action put #echo log1 *** sleeping *** when ^You relax and allow your mind to enter a state of rest\.
#action put #echo log1 *** awake *** when ^You awaken from your reverie and begin to take in the world around you|^Your mind cannot rest while you are doing

#action var sleep 0 when ^You relax and allow your mind to enter a state of r
#action var sleep 1 when ^You awaken from your reverie and begin to take in the world aro



#########################################################################################################################


action var Hidden 0 when ^You blend in with your surroundings|^You slip into a hiding|^You melt into the background|^Darkness falls over you like a cloak, and you involuntarily blend into the shadows\.|^Eh\?  But you're already hidden
action var Hidden 1 when ^You leap out of hiding|^You come out of hiding\.|^You burst from hiding and begin to dance about\!|^You slip out of hiding\.|notices your attempt to hide|discovers you, ruining your hiding place|reveals you, ruining your hiding attempt
var Hidden 1

action var foragable 1 when ^The room is too cluttered to find anything her
action var foragable 0 when ^A scavenger troll strolls in, looks you squarely in the eye and says
action var foragable 0 when ^A low fog rolls in, then just as quickly rolls out
var foragable 0

#########################################################################################################################




action var skin 1 when ^A.*gryphon collapses into a lifeless mound of fur and feathers\.
action var skin 1 when ^A.*snow goblin stares at you stupidly for a moment, before its eyes roll backwards into its head\.
action var skin 1 when ^A snowbeast lets loose a blood-curdling howl and falls into a heap\.
action var skin 1 when ^A snowbeast lets loose a blood-curdling howl and goes still\.
action var skin 1 when ^The forest geni's body explodes into a gaseous cloud\.
action var skin 1 when ^The forest geni cries out to the forest for protection\.  Getting no response, it collapses to the ground\.
action var skin 1 when ^A giant black leucro collapses to the ground, yelping like a lost puppy calling for its mother until finally it ceases all movement\.
action var skin 1 when ^A giant black leucro suddenly yelps like a puppy and stops all movement\.
action var skin 1 when ^The silver leucro screams one last time and lies
action var skin 1 when ^The silver leucro falls to the ground and lies
action var skin 1 when ^A giant thicket viper slaps around a few times and then grows still\.
action var skin 1 when ^A giant thicket viper rises up threateningly one last time before collapsing\.
action var skin 1 when ^A grass eel coils and uncoils rapidly before expiring\.
action var skin 1 when ^A grass eel thrashes about wildly for a few seconds, then lies still\.
action var skin 1 when ^A grass eel coils and uncoils rapidly before expiring\.
action var skin 1 when ^A grass eel shudders then goes limp\.
action var skin 1 when ^The beisswurm falls to the ground and lies still\.
action var skin 1 when ^A caracal tips over, limbs extended stiffly, and exp
action var skin 1 when ^A caracal trembles violently before finally exp
action var skin 1 when ^A peccary flops in a porky heap, squealing one last time before passing into obliv
action var skin 1 when ^A peccary kicks and spasms as the last vestiges of life flee this mortal c
action var skin 1 when ^A bristle-backed peccary flops in a porky heap, squealing one last time before passing into ob
action var skin 1 when ^A bristle-backed peccary kicks and spasms as the last vestiges of life flee this mortal
action var skin 1 when ^The asaren celpeze thrashes about for a moment, then lies s
action var skin 1 when ^The asaren celpeze's flared crest wobbles, then collapses as the celpeze falls over and lies s
action var skin 1 when ^The asaren celpeze slumps and goes limp\.  Its tail twitches once or twice, and the light fades from its baleful e
action var skin 1 when ^The asaren celpeze's chest heaves slowly and it emits a rasping hiss before finally lying st
action var skin 1 when ^An.*desert armadillo falls over and, after a couple of spasms, is still\.


action var skin 0 when ^Skin what\?
action var skin 0 when ^.* can't be skinned
var skin 0

#var pelts.keep (celpeze eye)
#var pelts.empty (rat pelt|goblin skin|goblin hide|hog hoof|eel skin|razorsharp claw|leucro pelt|white pelt|curved tusk|caracal pelt|plated claw)
#######################################################################################################################################

action var listen $2 when ^To learn from (him|her), you must LISTEN TO (\w+)

#action send dump junk when ^The room is too cluttered to find anything here\!

#action put STAND when eval $standing = 0

   action send stand when ^You must stand first
   action send stand when ^You might want to stand up first
   action send stand when ^You had better stand up first
   action send stand when ^You can't do that while lying down
   action send stand when ^You'd have better luck standing up

#Skip to the end of the file, don't execute this because we're including
goto end.of.file


stow:
var location stow1
var todo $0
stow1:
matchre return ^Stow what\?
matchre return ^You put your
matchre return ^You stop as you realize
matchre return ^You pick up
matchre return ^But that is already in your inventory\.
matchre location.unload ^You should unload the
matchre location.unload ^You need to unload the
matchre stowing too long to fit
put stow %todo
goto retry


wear:
var location wear1
var todo $0
wear1:
matchre return ^You sling
matchre return ^You attach
matchre return ^You put
matchre return ^You strap
matchre return ^You work your way into
matchre return ^You slide your left arm through
matchre return ^You hang
matchre return ^You slip
matchre return ^You drape
matchre return ^You slide
matchre return ^You are already wearing that\.
matchre return ^Wear what\?
matchre return ^The contours of the
matchre return ^You can't wear any more items like that\.
matchre location.unload1 ^You should unload the
matchre location.unload1 ^You need to unload the
put wear %todo
goto retry

rem:
remove:
var location remove1
var todo $0
remove1:
matchre return ^You take
matchre return ^You slide
matchre return ^You sling
matchre return ^Roundtime
matchre return ^You remove
matchre return ^You pull off
matchre return ^You pull your
matchre return ^Remove what\?
matchre return ^You count out
matchre return ^You work your way out of
matchre return ^You aren't wearing that\.
matchre return ^What were you referring to\?
matchre return ^You loosen the straps securing
put remove %todo
goto retry


combine:
var location combine1
var todo $0
combine1:
matchre return ^You combine
matchre return ^Roundtime
matchre return ^Combine some
matchre return ^Perhaps you should be holding that first\.
put combine %todo
goto retry


get:
var location get1
var todo $0
get1:
matchre return ^You get
matchre return ^You pull
matchre return ^You pick up
matchre return ^What were you referring to\?
matchre return ^You are already holding that\.
matchre return ^You need a free hand to pick that up\.
matchre return ^But that is already in your inventory\.
matchre return ^You fade in for a moment as you pick up
matchre return ^You are not strong enough to pick that up\!
put get %todo
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


wield:
var location wield1
var todo $0
wield1:
matchre return ^You can only wield a weapon or a shield\!
matchre return ^You need to have your
matchre return ^You draw out your
matchre return ^You're already holding
put wield %todo
goto retry


juggle:
var location juggle1
var todo $0
juggle1:
matchre return ^Don't be silly\!
matchre return ^What were you referring to\?
matchre return ^But you're not holding
matchre return ^It's easier to juggle if you start
matchre return ^Roundtime
matchre return ^Your injuries make juggling impossible\.
put juggle %todo
goto retry


predict:
var location predict1
var todo $0
predict1:
matchre return ^You focus inwardly searching for insight into your future\.
matchre return ^After a few moments, the mists of time begin to part\.
matchre return ^You see nothing else\.
matchre return ^The future, however, remains a dark mystery to you\.
matchre return ^You must be a real expert to predict the weather indoors\.
matchre return ^You are a bit too distracted to be making predictions\.
matchre return ^Roundtime
put predict %todo
goto retry


observe:
var location observe1
var todo $0
observe1:
matchre return ^You scan the skies for a few moments\.
matchre return ^Your search for the constellation
matchre return ^Roundtime
put observe %todo
goto retry


read:
var location read1
var todo $0
read1:
matchre return ^I could not find what you were referring to\.
matchre return ^The writing is too small\.  You'll have to hold the scroll to read it\.
matchre return ^Roundtime
put read %todo
goto retry


prep_spell:
if $Harness_Ability.LearningRate > 30 then goto return
prep_spell1:
if $mana < 80 then goto return
prep:
var location prep1
var todo $0
prep1:
matchre return ^You begin chanting a prayer
matchre return ^You close your eyes and breathe deeply,
matchre return ^You trace an arcane sigil in the air,
matchre return ^Heatless orange flames blaze between your fingertips
matchre return ^Your eyes darken to black as a starless night
matchre return ^You raise your arms skyward, chanting
matchre return ^You are already preparing
matchre return ^Icy blue frost crackles up your arms
matchre return ^You make a careless gesture as you chant the words
matchre return ^Tiny tendrils of lightning jolt between your hands
matchre return ^The wailing of lost souls accompanies your preparations
matchre return ^Your skin briefly withers and tightens, becoming gaunt
matchre return ^Images of streaking stars falling from the heavens flash across your vision
matchre return ^A nagging sense of desperation guides your hands through the motions
matchre return ^You hastily shout the arcane phrasings needed to prepare
matchre return ^You deftly waggle your fingers in the precise motions needed to prepare
matchre return ^With great force, you slap your hands together before you and slowly pull them apart,
matchre return ^With no small amount of effort, you slowly recall the teachings
matchre return ^You struggle against your bindings to prepare
matchre return ^You raise one hand before you and concentrate
matchre return ^As you begin to focus on preparing
put prepare %todo
goto retry

harn:
harness:
#if $preparedspell = None then goto return
var location harness1
var todo $0
harness1:
matchre return ^Roundtime
matchre return ^You tap into the mana
matchre return ^Usage:
matchre return ^Attunement:
matchre return ^You strain, but cannot harness that much power\.
matchre return ^You can't harness that much mana\!
put harness %todo
goto retry


infuse:
var location infuse1
var todo $0
infuse1:
matchre return ^Roundtime
matchre return ^You don't have enough harnessed to infuse that much\.
put infuse %todo
goto retry


cast:
var location cast1
var todo $0
cast1:
matchre return ^You gesture
matchre return ^You don't have a spell prepared\!
matchre return ^Your spell pattern collapses
matchre return ^With a wave of your hand,
matchre return ^You wave your hand\.
matchre return ^With a flick of your wrist,
matchre return You draw your
matchre return ^Your secondary spell pattern dissipates
matchre return ^You can't cast .+ on yourself\!
matchre return ^You make a holy gesture
matchre return ^You raise your palms and face to the heavens
matchre return ^I could not find what you were referring to\.
matchre return ^You have difficulty manipulating the mana streams, causing the spell pattern to collapse at the last moment\.
put cast %todo
goto retry


charge:
var location charge1
var todo $0
charge1:
matchre return ^Roundtime
matchre return ^I could not find
put charge %todo
goto retry

foc:
focus:
var location focus1
var todo $0
focus1:
matchre return ^Roundtime
matchre return ^You reach out into the seemingly infinite strands of Lunar mana
matchre return ^You move into the chaotic tides
matchre return ^Your link to the .+ is intact\.
matchre return ^You are in no condition to do that\.
matchre return ^I could not find
put focus %todo
goto retry


release:
var location release
matchre return ^Type RELEASE HELP for more options\.
put release
goto retry


rel.shadow:
var location rel.shadow
matchre return ^You gesture, completing the pattern to unravel the mystical bonds binding the shadowling to this plane\.
matchre return ^You gesture, attempting to unravel the pattern binding the shadowling to this plane\.
matchre return ^That would be a neat trick.  Try finding a shadowling first\.
put release shadowling
goto retry


release.spell:
if $preparedspell = None then return
var location release.spell
matchre return ^You let your concentration lapse and feel the spell's energies dissipate\.
matchre return ^You aren't preparing a spell\.
put release spell
goto retry


release.mana:
var location release.mana
matchre return ^You release the mana you were holding\.
matchre return ^You aren't holding any mana\.
put release mana
goto retry


rel:
var location rel
matchre return ^You release a
matchre return ^You release the mana you were holding\.
matchre return ^You aren't holding any mana\.
put release
goto retry

perc:
perceive:
pow:
power:
var location power1
var todo $0
power1:
matchre return ^Roundtime
matchre return ^Something in the area is interfering
matchre return ^I could not find who you were referring to\.
put PERCEIVE %todo
goto retry


tend:
var location tend1
var todo $0
tend1:
matchre return ^That area has already been tended to\.
matchre return ^You work carefully at tending your wound\.
matchre return ^Doing your best
matchre return too injured for you to do that\.
matchre return ^That area is not bleeding\.
matchre return ^Roundtime:
matchre return ^You realize you cannot handle so severe an injury while in combat\!
matchre return ^Your task is made more difficult by being in combat\.
put tend %todo
goto retry


unwrap:
var location unwrap1
var todo $0
unwrap1:
matchre return ^You may undo the affects of TENDing to an injured area by using the UNWRAP command to remove the bandages\.
matchre return ^That area is not tended\.
matchre return ^The bandages binding your
matchre return ^You unwrap your bandages\.
matchre return ^\[Roundtime:
put unwrap my %todo
goto retry


look:
var location look1
var todo $0
look1:
matchre return ^You are
matchre return ^You have
matchre return ^You see
matchre return ^(He|She) is
matchre return ^I could not find what you were referring to\.
put look %todo
goto retry


search:
var location search
matchre return ^Roundtime
matchre return ^You search around for a moment
put search
goto retry


teach:
var location teach1
var todo $0
teach1:
matchre return ^You begin to lecture
matchre return is already listening to you\.
matchre return is listening to someone else\.
matchre return is not paying attention to you\.
matchre return ^You have already offered to
matchre return already trying to teach someone else
matchre return is already trying to teach you something
matchre return ^That person is too busy teaching their own students to listen to your lesson\.
matchre return ^You cannot listen to a teacher and teach at the same time
matchre return ^I could not find who you were referring to\.
matchre return isn't teaching you anymore\.
put Teach %todo
goto retry


listen:
var location listen1
var todo $0
listen1:
matchre return ^You begin to listen
matchre return ^Your teacher appears to have left\.
matchre return ^You are already listening to someone\.
matchre return ^Who do you want to listen to
matchre return ^I could not find who you were referring to\.
matchre return isn't teaching a class\.
matchre return isn't teaching you anymore\.
matchre return has closed the class to new students\.
matchre return ^You cannot teach a skill and be a student at the same time\!
put listen %todo
goto retry


stop:
var location stop1
var todo $0
stop1:
matchre return ^You stop teaching\.
matchre return ^But you aren't teaching anyone\.
matchre return ^You stop listening to
matchre return ^But you aren't listening to anyone\.
matchre return ^You stop trying to teach
matchre return ^You stop practicing your climbing skills\.
matchre return ^You weren't practicing your climbing skills anyway\.
put stop %todo
goto retry


dance:
var location dance1
var todo $0
dance1:
matchre return ^You slowly center yourself
matchre return ^Roundtime
matchre return ^Your mind and body are focused on a Dance\.
matchre return ^You push out your chest as you feel your eyes taking on a new and distant focus\.
matchre return ^You are off center, and have trouble focusing\.
matchre return ^You slowly relax, letting the power of the dance fade from your core\.
matchre return ^Stop what\?
put dance %todo
goto retry


khri:
var location khri1
var todo $0
khri1:
matchre return not recognizable as a valid khri\.
matchre return ^Roundtime
matchre return ^You're already using the
matchre return ^You strain, but cannot focus your mind enough to manage that\.
matchre return ^You have not recovered from your previous
matchre return ^Tapping into the well of mental power within
put khri start %todo
goto retry


khri.stop:
var location khri.stop1
var todo $0
khri.stop1:
matchre return ^Nothing happens, as you are not using any stoppable meditations\.
matchre return ^Your focused mind falters, and you feel slightly less competent overall\.
matchre return ^Your extreme cunning vanishes as one of your mental pillars supporting it ceases\.
matchre return ^Your inward calm vanishes, the troubles of the world once more washing over you\.
matchre return ^You are unable to maintain the complex thought processes any longer and your mental faculties return to normal\.
matchre return ^You attempt to relax your mind from all of its meditative states\.
matchre return ^Your cool composure fades, and with it your heightened knowledge of enemies' weak points\.
matchre return ^Your concentration fails, and you feel your body perceptibly slow\.
matchre return ^Your silence ends, placing you back into the normal field of perception\.
matchre return ^You attempt to relax your mind from all of its meditative states\.
matchre return ^Your mind's prowess wavers, and so too does the extra combat strength it granted you vanish\.
matchre return ^Your augmented reaction times slow as one of your mental pillars supporting it ceases\.
matchre return ^You feel mentally fatigued as your heightened paranoia ceases to enhance your knowledge of nearby escape routes\.
matchre return ^You are no longer able to keep your thoughts free from distraction, and your heightened ability to notice and avoid incoming dangers fails\.
matchre return ^Your concentration runs out, and your rapid analysis of incoming threats ceases\.
put khri stop
goto retry


ask:
var location ask1
var todo $0
ask1:
matchre return ^To whom are you speaking\?
matchre return ^With a sad look
matchre return ^A pure white alfar avenger peers at you
put ask %todo
goto retry


stance:
var location stance1
var todo $0
var current.stance $0
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


count:
var location Count1
var todo $0
count1:
matchre return ^You take a quick count of potential threats in the area\.\.\.
matchre return ^You count up the items in your
matchre return ^That doesn't tell you much of anything.
put count %todo
goto retry


forage:
if $Foraging.LearningRate > 33 then return
forage1:
var location forage2
var todo $0
forage2:
matchre return ^Roundtime
matchre return ^You really need to have at least one hand free to forage properly\.
matchre return ^You cannot forage while in combat\!
matchre return ^The room is too cluttered to find anything here\!
put forage %todo
goto retry

coll:
collect:
var location collect1
var todo $0
collect1:
matchre return ^Roundtime
matchre return ^You really need to have at least one hand free to forage properly\.
matchre return ^You cannot collect anything while in combat\!
matchre return ^The room is too cluttered to find anything here\!
put collect %todo
goto retry


kick:
var location kick
matchre kick ^You take a step back and run up to the
matchre kick1 ^You can't do that from your position\.
matchre kick1 ^You throw a glorious temper tantrum\!
matchre return ^I could not find what you were referring to\.
put kick pile
goto retry
kick1:
gosub stand
var location kick
goto kick

turn:
var location turn1
var todo $0
turn1:
matchre return ^Turn what\?
matchre return ^You turn to the section
put turn %todo
goto retry


study:
var location study1
var todo $0
study1:
matchre return ^You study your
matchre return ^You've already started to make something
matchre return ^You are unable to sense additional information\.
matchre return ^You take on a studious look\.
matchre return ^You should try that where you can see the sky\.
matchre return ^You feel it is too soon to grasp anything new in the skies above\.
matchre return ^Roundtime
matchre return ^Why do you need to study this chart again\?
put study %todo
goto retry


poke:
var location poke1
var todo $0
poke1:
matchre return ^You poke a hole in your
matchre return ^You toss a piece of
matchre return ^You poke a piece of
matchre return ^You tear up the empty envelope and toss it away\.
matchre return ^What were you referring to\?
matchre return ^Going around poking things isn't going to get you far\.
matchre return ^You can't tear up the envelope while there's still paper inside\.
matchre return ^You must be either wearing or holding a plain paper envelope before you can do that\!
put poke %todo
goto retry

invoke:
var location invoke1
var todo $0
invoke1:
matchre return ^You don't have any
matchre return ^A finely balanced tago suddenly leaps
put invoke %todo
goto retry


drop:
var location drop1
var todo $0
drop1:
matchre return ^You drop
matchre return ^What were you referring to\?
matchre return ^But you aren't holding that\.
put drop %todo
goto retry


aim:
var location aim1
var todo $0
aim1:
matchre return ^You begin to target
matchre return ^You shift your target to
matchre return ^You are already targetting that\!
matchre return ^You need both hands in order to aim\.
matchre return ^At what are you trying to aim\?
matchre return ^Your .+ isn't loaded\!
matchre return ^But the .+ in your right hand isn't a ranged weapon\!
matchre return ^You don't have a ranged weapon to aim with\!
matchre return ^You are already targetting that!
put aim %todo
goto retry

tar:
target:
var location target1
var todo $0
target1:
matchre return ^You begin to weave
matchre return ^Your target pattern is already formed
matchre return ^You must be preparing a spell in order to target it\!
matchre return ^You don't need to target the spell you're preparing\.
matchre target2 ^You are not engaged to anything, so you must specify a target to focus on\!
matchre target2 ^There is no need to target
put target %todo
goto retry
target2:
put face next
goto target1

load:
var location load1
var todo $0
load1:
matchre return ^Roundtime
matchre return ^Your .+ is already loaded
matchre return ^What weapon are you trying to load\?
matchre return ^You don't have the proper ammunition readily available for your
matchre return ^You can't load .+, silly\!
put load %todo
goto retry


unload:
var location unload
matchre return ^You unload the
matchre return ^You remain concealed by your surroundings, convinced that your unloading
matchre return ^Roundtime:
matchre return ^But your
matchre return ^You don't have a
matchre return ^You can't unload such a weapon\.
matchre return ^Your
put unload
goto retry


pray:
var location pray1
var todo $0
pray1:
matchre return ^You begin to pray
matchre return ^You bow your head
matchre return ^You pray fervently\.
matchre return ^You want to pray here\?
matchre return ^As you utter your prayer
matchre return ^You kneel down and begin to pray\.
matchre return ^You continue praying for guidance\.
matchre return ^You beseech your God for mercy\.
matchre return ^You begin to pray, kneeling before the altar\.
matchre return ^Your fervent prayers are met with a sense of peace and security\.
matchre return ^The soft sound of your prayers wraps itself around you and brings you a sense of tranquility\.
put pray %todo
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


tap:
var location tap1
var todo $0
tap1:
matchre return ^You tap
matchre stand1 ^Roundtime
put tap %todo
goto retry


stand:
if standing then return
var location stand1
stand1:
matchre return ^You stand back up\.
matchre return ^You swim back up
matchre return ^You are already standing\.
matchre stand1 ^You are so unbalanced you cannot manage to stand\.
matchre stand1 ^You are overburdened and cannot manage to stand\.
matchre stand1 ^The weight of all your possessions prevents you from standing\.
matchre stand1 ^Roundtime
put stand
goto retry


hunt:
var todo $0
hunt1:
var location hunt1
matchre return ^Roundtime
matchre return ^You take note
matchre return ^You move to hunt down your prey\.
matchre return ^Your prey seems to have completely vanished\.
matchre return ^You don't have that target currently available\.
matchre hunt2 ^You'll need to disengage first\.
matchre hunt3 ^You'll need to be standing up, first\.
put hunt %todo
goto retry
hunt2:
gosub ret
goto hunt1
hunt3:
gosub stand
goto hunt1


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
matchre return ^You start to steal from
matchre return ^You cautiously attempt to lift
matchre return ^You haven't picked something to steal\!
matchre return ^You glance around but your mark seems to be missing\.
matchre return ^You couldn't get close enough to steal anything in time\.
matchre return ^You need at least one hand free to steal\.
matchre return ^You consider it, but
put steal %todo
goto retry


put:
var location put1
var todo $0
put1:
matchre return ^You drop
matchre return ^You put
matchre return ^You reverently place
matchre return ^As you start to place
matchre return ^What were you referring to\?
matchre return ^You briefly twist the top
matchre return ^As you put the wax label
put put %todo
goto retry


lean:
var location lean1
var todo $0
lean1:
matchre return ^You lean
matchre return ^You shift your weight\.
matchre return ^I could not find what you were referring to\.
put lean %todo
goto retry


eat:
var location eat1
var todo $0
eat1:
matchre return ^You'd be better off trying to drink
matchre return ^What were you referring to\?
matchre return ^You eat
matchre return ^You can't drink a
matchre return ^You drink
put %todo
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

ret:
retreat:
var location retreat
matchre retreat ^You retreat from combat\.
matchre retreat ^You retreat back to pole range\.
matchre retreat ^You stop advancing
matchre retreat ^You sneak back out
matchre retreat ^You must stand first\.
matchre retreat ^You try to back out
matchre return ^You are already as far away as you can get\!
matchre return revealing your hiding place\!
put retreat
goto retry


2retreat:
var location 2retreat
matchre return ^You stop advancing
matchre return ^You retreat from combat\.
matchre return ^You retreat back to pole range\.
matchre return ^You sneak back out
matchre return ^You are already as far away as you can get\!
matchre return ^You try to
matchre return revealing your hiding place\!
put retreat
goto retry

ret2:
if $monstercount > 0 then
{
  put retreat;retreat
  pause .2
}
return


advance:
var location advance1
var todo $0
advance1:
matchre return ^What do you want to advance towards\?
matchre return ^You begin to advance on
matchre return ^You are already advancing on
matchre return ^You are already at melee with
matchre return ^You begin to stealthily advance on
matchre return ^You spin around to face
matchre return ^You will have to retreat from your current melee first\.
put advance %todo
goto retry


swap:
var location swap1
var todo $0
swap1:
matchre return ^You have nothing to swap\!
matchre return ^You move
matchre return ^You turn
matchre return ^You deftly change
matchre return ^You effortlessly switch
matchre return ^You fiercely switch
matchre return ^You switch your
matchre return ^Your eyes blaze
matchre return ^With a quiet
put swap %todo
goto retry


swap_right:
var location swap_right
matchre return ^You have nothing
matchre return to your righT hand
matchre swap_right to your left hand
put swap
matchwait


swap_Left:
var location swap_Left
matchre return ^You have nothing
matchre swap_Left to your righT hand
matchre return to your left hand
put swap
matchwait


block.stop:
var location block.stop
matchre return ^Okay\.
matchre return ^You stop trying to defend against
matchre return ^You aren't trying to defend against a second foe\!
put block stop
goto retry


dump.junk:
var location dump.junk
matchre return ^\[You have marked this room to be cleaned by the janitor\.  It should arrive shortly.\]
matchre return ^The janitor was recently summoned to this room\.  Please wait \d+ seconds\.
matchre return ^You should just kick yourself in the shin\.  There is no junk here\.
put dump junk
goto retry


flee:
var todo $0
flee1:
var location flee1
matchre return ^You assess your combat situation and realize you don't see anything engaged with you
matchre return ^Your attempt to flee has failed
matchre return ^Your fate is sealed
matchre return ^You melt into the background, convinced that your misdirect was successful
matchre return ^You manage to free yourself from engagement
matchre return ^How do you expect to flee with your
matchre flee2 ^You should stand up first\.
put flee %todo
goto retry
flee2:
gosub stand
goto flee1

app:
appraise:
var location appraise1
var todo $0
appraise1:
matchre return ^Taking stock of its
matchre return ^It's dead
matchre return ^Appraise what\?
matchre return ^Roundtime
matchre return ^You cannot appraise that when you are in combat\!
matchre return ^I could not find what you were referring to\.
matchre return Roundtime:
put appraise %todo
goto retry


mark:
var location mark1
var todo $0
mark1:
matchre return ^You carefully size up
matchre return ^It's dead
matchre return ^As you consider
matchre return ^Roundtime
matchre return ^Mark what\?
matchre return ^You begin to
put mark all %todo
goto retry


Attack:
var todo $0
var location attack1
if $stamina < 85 then pause 3
pause .1
Attack1:
if $stamina < 85 then pause 4
if $standing = 0 then put stand
matchre advance2 ^It would help if you were closer
matchre advance2 ^You aren't close enough to attack\.
matchre advance2 ^You are already advancing
matchre return ^You don't have a weapon to draw with\!
matchre return ^But you don't have a ranged weapon in your hand to fire with\!
matchre return ^You must have both hands free to use the
matchre return ^But your .* isn't loaded\!
matchre return ^You need two hands to wield this weapon\!
matchre return ^I could not find what you were referring to\.
matchre return ^At what are you trying
matchre return ^There is nothing else to face
matchre return ^How can you snipe if you are not hidden\?
matchre return ^What are you trying to throw?
matchre return ^\[Roundtime
matchre return ^Roundtime:
matchre return is already quite dead\.
matchre return ^The .* is already debilitated\!
matchre return ^You must be hidden or invisible to ambush\!
matchre return ^The khuj is too heavy for you to use like that\.
matchre attack2 ^You should stand up first\.
put %todo
goto retry

advance2:
if $hidden = 1 then put shiver
pause
put engage
pause 2
goto Attack1

attack2:
gosub stand
var location attack1
goto Attack1

arr:
arrange:
Skinning.Arrangep:
pause .3
Skinning.Arrange:
var location Skinning.Arrange
matchre Skinning.Arrangep ^You properly arrange
matchre Skinning.Arrangep ^Roundtime
matchre return has already been arranged as much as you can manage\.
matchre return ^Arrange what\?
matchre return ^Try killing the
matchre return The .+ cannot be skinned, so you can't arrange it either.
put arrange
goto retry


pre.skin:
if %skin = 0 then goto Return
if %current.stance != custom then gosub stance custom
gosub stowing
gosub get my skinning knife
return


Skinning:
var location Skinning
matchre return ^.*can't be skinned
matchre return ^Skin what\?
matchre return ^Living creatures often object to being flayed alive\.
matchre return ^There isn't another
matchre return ^You hideously bungle the attempt
matchre return ^Somehow managing to do EVERYTHING wrong
matchre return ^Some days it just doesn't pay to wake up\.
matchre return ^Despite your best efforts,
matchre return ^You bumble the attempt
matchre return ^You claw
matchre return ^You fumble and make an improper cut
matchre return ^Your .* twists and slips in your grip
matchre return ^The .+ cannot be skinned.
matchre pre.skin ^You will need a more appropriate tool for skinning
matchre pre.skin ^You must have one hand free to skin\.
matchre pre.skin ^You'll need to have a bladed instrument to skin with\.
matchre Skinning ^You approach \w+'s kill
matchre Skinning.Empty ^You struggle with the
matchre Skinning.Empty ^Roundtime
matchre Skinning.Empty ^A heartbreaking slip
matchre Skinning.Empty ^You skillfully peel
matchre Skinning.Empty ^You skin
matchre Skinning.Empty ^You work diligently at skinning
matchre Skinning.Empty ^You work hard at peeling
matchre Skinning.Empty ^You skillfully peel
matchre Skinning.Empty ^You slice away a bloody trophy
matchre Skinning.Empty ^Some greater force guides your hand
matchre Skinning.Empty ^Moving with impressive skill and grace
matchre Skinning.Empty ^Working deftly
put skin
goto retry
Skinning.Empty:
gosub stowing
return


bundle:
var location bundle
matchre return ^You try to stuff your eye into the bundle but can't seem to find a good spot\.
matchre return ^You stuff your
matchre return ^You bundle up your
matchre bundle2 ^That's not going to work\.
put bundle eye
goto retry

bundle2:
if "$lefthand" != "Empty" then put stow left
gosub get bundling rope
goto bundle


sell:
var location sell1
var todo $0
sell1:
matchre return ^"Hmm\?" says Scupper, "What are you talking about\?"
matchre return ^You ask Scupper to buy a lumpy bundle\.
matchre return ^Scupper separates the bundle and sorts through it carefully
matchre return ^Sell what\?
matchre return ^I could not find what you were referring to\.
put sell %todo
goto retry

Dodge:
var location Dodge
matchre return ^You are already in a position
matchre return ^But you are already dodging\!
matchre return ^You move into a position
matchre return ^You need two hands to wield this weapon\!
matchre return ^Roundtime
put Dodge
goto retry


Parry:
var location Parry
matchre return ^You are already in a position
matchre return ^Roundtime:
matchre return ^You are already in a position to parry\.
matchre return ^You need two hands to wield this weapon\!
matchre return ^You move into a position
put Parry
goto retry


EXP:
var location EXP1
var todo $0
EXP1:
matchre return ^EXP HELP for more information
matchre return ^Overall state of mind:
put EXP %todo
goto retry


INFO:
var location INFO
matchre return ^Wealth:
matchre return ^Concentration :
matchre return ^Debt:
put INFO
goto retry


health:
var location health
   matchre return.p ^Your body feels
   matchre return.p ^Your spirit feels
   put health
goto retry


mind:
var location mind1
mind1:
matchre return ^EXP HELP for more information
matchre return ^Overall state of mind:
put mind
goto retry


shiver:
var location shiver
matchre return ^A shiver runs up your spine\.
put shiver
goto retry


HIDE:
var location HIDE
matchre return reveals you, ruining your hiding attempt
matchre return discovers you, ruining your hiding place\!
matchre return notices your attempt to hide\!
matchre return ^Eh\?  But you're already hidden
matchre return ^You melt into the background
matchre return ^You slip into a hiding
matchre return ^You blend in with your surroundings
matchre return ^You can't hide in all this armor\!
matchre return ^Roundtime
put HIDE
goto retry


stalk:
var location stalk
matchre return ^Stalk what\?
matchre return ^Stalking is an inherently stealthy endeavor, try being out of sight\.
matchre return ^You are already stalking
matchre return alerts others of your attempt to slip behind
matchre return Roundtime:
put stalk
goto retry


stop.stalk:
var location stop.stalk
matchre return ^You stop stalking\.
matchre return ^You're not stalking anything though\.
put stop stalk
goto retry


drag:
var location drag1
var todo $0
drag1:
matchre return ^I could not find what you were referring to\.
matchre return ^Don't be silly\!
matchre return ^Roundtime
put drag %todo
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
matchre return ^Obvious
matchre return ^  CLIMB
matchre return ^CLIMB
matchre return ^You begin to practice your climbing skills\.
matchre return ^You should stop practicing your climbing skill before you do that\.
matchre location.p ^You are too tired to climb that\.
matchre location.p ^All this climbing back and forth is getting a bit tiresome
put climb %todo
goto retry
climb2:
gosub ret
goto climb1
climb3:
gosub stand
goto climb1

########################
# MOVE #
########

automove:
var toroom $1
automovecont:
match return YOU HAVE ARRIVED
match automovecont1 YOU HAVE FAILED
put #goto %toroom
matchwait

automovecont1:
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
matchre stand.then.move ^You must be standing to do that\.
matchre stand.then.move ^You can't do that while lying down\.
matchre stand.then.move ^You can't do that while kneeling.
matchre pause.then.move ^You are too tired
matchre pause.then.move ^All this climbing back and forth is getting a bit tiresome
matchre pause.then.move ^Your excessive speed causes you to lose your footing
matchre pause.then.move ^You work against the current
matchre retreat.then.move ^You are engaged to
matchre retreat.then.move ^You'll have better luck if you first retreat
matchre retreat.then.move While in combat
matchre Dig.then.move ^You struggle forward
matchre Dig.then.move ^Like a blind, lame duck, you wallow in the mud
matchre Dig.then.move ^The mud holds you tightly
matchre Dig.then.move ^You find yourself stuck in the mud
matchre stow.then.move ^Free up your hands first
matchre return ^Obvious
matchre return It's pitch dark and you can't see a thing
matchre move.error ^You can't go there\.
matchre move.error ^You can't swim in that direction\.
put %todo
goto retry
stand.then.move:
gosub stand
goto move1
pause.then.move:
pause .2
goto moving
retreat.then.move:
gosub retreat
goto moving
move.error:
echo * Bad move direction, will try next command in 1 second. *
pause
goto moving
Dig.then.move:
pause .1
put dig %move.direction
pause .5
pause .5
goto moving
stow.then.move:
var todo.saved %todo
gosub stowing
var todo %todo.saved
goto moving


moverandom:
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



stowing:
if matchre("$lefthand","(partisan|lumpy bundle|quarter staff|copperwood longbow|slender khuj|longbow)") then gosub wear my $1
if matchre("$righthand","(partisan|lumpy bundle|quarter staff|copperwood longbow|slender khuj|longbow)") then gosub wear my $1

if matchre("$lefthand","(%pelts.keep)") then gosub bundle
if matchre("$righthand","(%pelts.keep)") then gosub bundle
if matchre("$lefthand","(%pelts.empty)") then gosub drop $lefthand
if matchre("$righthand","(%pelts.empty)") then gosub drop $righthand

if matchre("$lefthand","(partisan|lumpy bundle|quarter staff|copperwood longbow|slender khuj|longbow)") then gosub wear my $1
if matchre("$righthand","(partisan|lumpy bundle|quarter staff|copperwood longbow|slender khuj|longbow)") then gosub wear my $1

if $lefthand != Empty then gosub stow left
if $righthand != Empty then gosub stow Right
return


empty:
if "$lefthand" != "Empty" then gosub drop $lefthand
if "$righthand" != "Empty" then gosub drop $righthand
return



retry:
matchre location ^\.\.\.wait
matchre location ^Sorry, you may
matchre location ^Sorry, system is slow
matchre location.p ^You don't seem to be able to move to do that
matchre location.p ^It's all a blur
matchre location.p ^You're unconscious\!
matchre location.p ^You are still stunned
matchre location.p There is no need for violence here\.
matchre location.p ^You can't do that while entangled in a web\.
matchre location.p ^You struggle against the shadowy webs to no avail\.
matchre location.p ^You attempt that, but end up getting caught in an invisible box\.
matchre location1 ^You should stop playing before you do that\.
matchre location1 ^You are a bit too busy performing to do that\.
matchre location1 ^You are concentrating too much upon your performance to do that\.
matchwait

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
pause

location:
goto %location

return.p:
   pause .1

return:
return

end.of.file:
