#debuglevel 10
# Script to Travel for Genie3 #
# Written by Chris/Achilles with help from Shroom
# version 2.4
# Requires EXP Plugin by VTCifer #
# USAGE - .travel <city> <room>  (room is optional!)
# If you are calling this script via another, use ^YOU ARRIVED! to match the end of travelling!
##########################################
#                                        #
#       ADJUSTABLE VARIABLES             #
#                                        #
##########################################
##   ADJUST THE RANKS BELOW TO YOUR     ##
##       PARTICULAR CHARACTER           ##
##   THESE ARE CONSERVATIVE ESTIMATES   ##
##                                      ##
##  If you are joined in a group,       ##
##  You will take public transportation ##
##                                      ##
##########################################
##########################################
##    ARE YOU A CITIZEN OF SHARD?       ##
##        CHOOSE yes or no              ##
     var shardcitizen no
##########################################
##    RANKS TO USE THE ROSSMAN'S        ##
##          SHORTCUT                    ##
## NORTH
    var rossmannorth 200
## SOUTH
    var rossmansouth 125
##                                      ##
##########################################
##    RANKS TO USE THE FALDESU          ##
    var faldesu 200
##########################################
##    RANKS TO USE THE SEGOLTHA         ##
    #var segoltha 550
    var segoltha 540
##########################################
##    RANKS TO USE UNDER-GONDOLA        ##
    #var undergondola 550
    var undergondola 540
##########################################
##########################################
##    RANKS TO USE UNDER-SEGOLTHA(THIEF)##
    var undersegoltha 60
##########################################
## MULTIPLE CHARACTER SUPPORT FOR SHARD CITIZEN VARIABLE
## YOU MUST CREATE GENIE GLOBAL VARIABLES CHAR1, CHAR2 etc IN GENIE FOR THIS TO WORK
## type: #var char1 <charactername>
## in genie to create a global variable
if ("$charactername") = ("$char1") then var shardcitizen yes
if ("$charactername") = ("$char2") then var shardcitizen no
if ("$charactername") = ("$char3") then var shardcitizen no
if ("$charactername") = ("$char4") then var shardcitizen no
#### DONT TOUCH ANYTHING BELOW THIS LINE
###########################################
# CHANGELOG - Latest Update: 4/4/2020
# - Added Support for Starting inside the Gondola
# - Robustified all matches for towns and cleaned up a bunch of code
# - Added checking current coin you have on you and only going to bank if needed for ferries
# - Should now check for/withdraw double the amount needed for ferries (to account for return trips/thieves)
# - Added remove invisible checks when visiting the teller
# - Added support for Necros to check and keep up EOTB/ROC when using ferries
# - Fixed travel from Shard to Alfren
# - Merged all changes from recent updates
# - Added Khri Harrier for Thieves when climbing
# - Added travel to/from Boar Clan and Muspari via the wizard
# - Added option for %2 to move a roomid or name when arriving at the location
# - Added travel to and from Muspar'i via new Airship in Crossing area
# - Smashed bug involving travel between M'riss, Mer'Kresh, Hara'Jaal
# - Added travel to and from Islands! - Aesry, Ratha, M'riss, Mer'Kresh, Hara'Jaal, Fang Cove
# - Added Destination Wyvern Mountain
# - Fixed random hangups after withdrawing coins.  Other robustifications.
# - Added Destinations: Throne City, Beisswurms, Caravansary, Hvaral, Alfren's Ferry, Gondola
# - Added ASCII Art :)
# - Robustified undergondola check - Added buffs for thieves/rangers
# - Updated help log and updated labels for more matches
# - Fixed logic issue when starting from Map 50
# - Fixed issue travelling between Fornsted area and Theren
# - Changed all single movements to gosubs to avoid stalls
# - Added currency conversion before checking for coin
# - Will now attempt to exchange coin for ferry before withdrawing
# - Fixed problem traveling to P5
# - Fixed several bad nodes
# - Added multi-character support for shardcitizen variable
# - Added travel  to and from Muspari
# - Added Passport check / Sand Barge to Muspari
##########################################
goto INIT
NODESTINATION:
  Echo ---------------------------------------------------------------------------------------------------------
  Echo ## Either you did not enter a destination, or your destination is not recognized.  Please try again! ##
  Echo ##
  Echo ## SYNTAX IS: .travel CITY or .travel CITY roomnumber/label
  Echo ## e.g - .travel CROSS 144  - travel to crossing and move to room 144
  Echo ##
  Echo ## Valid Destinations are: ##
  Echo -------------------------------------------
  Echo ## Zoluren:
  Echo ## Crossing | Arthe Dale | Tiger Clan ##
  Echo ## Wolf Clan | Caravansary |Dirge     ##
  Echo ## Knife Clan | Acenemacra | Kaerna Village ##
  Echo ## Stone Clan | Ilaya Taipa | Misenseor ##
  Echo ## Sorrow's Reach | Beisswurms| Vipers/Leucros ##
  Echo ## Malodorous Buccas | Dokt |
  Echo ## Alfren's Ferry | Leth Deriel
  Echo -------------------------------------------
  Echo ## Therengia:
  Echo ## Riverhaven | Rossmans | Langenfirth ##
  Echo ## El'Bains | Zaulfun | Therenborough  ##
  Echo ## Fornsted | Zaulfung |  Throne City  ##
  Echo ## Muspar'i | Hvaral                   ##
  Echo -------------------------------------------
  Echo ## Ilithi:
  Echo ## Shard | Horse Clan | Fayrin's Rest ##
  Echo ## Steelclaw Clan | Spire |Corik's Wall ##
  Echo ## Ylono | Granite Gargoyles | Gondola ##
  Echo ## Bone Wolves | Germishdin | Fang Cove ##
  Echo ## Wyvern Mountain ##
  Echo -------------------------------------------
  Echo ## Forfedhdar:
  Echo ## Raven's Point | Ain Ghazal| Outer Hib ##
  Echo ## Inner Hib | Hibarnhvidar |Boar Clan ##
  Echo -------------------------------------------
  Echo ## Qi:
  Echo ## Aesy Surlaenis'a | Ratha | M'riss  ##
  Echo ## Mer'Kresh | Hara'jaal (TF only)    ##
  Echo -------------------------------------------
  exit
INIT:
# action goto START when ^Just when it seems you will never reach the end of the road
action goto NOPASSPORT when No one proceeds through this checkpoint without a passport
action goto NOCOIN when You haven't got enough (.+) to pay for your trip\. Come back|You reach your funds\, but realize you\'re short\.|^\"Hey\,\" he says\, \"You haven\'t got enough lirums to pay for your trip\.
action var offtransport platform when a barge platform
action var offtransport pier when the Riverhaven pier
action var offtransport wharf when the Langenfirth wharf
action var offtransport dock when \[\"Her Opulence\"\]|\[\"Hodierna\'s Grace\"\]|\[\"Kertigen\'s Honor\"\]|\[\"His Daring Exploit\"\]|\[The Evening Star\]|\[The Damaris\' Kiss\]|\[A Birch Skiff\]|\[A Highly Polished Skiff\]|\[\"Imperial Glory\"\]|\[\"The Riverhawk\"\]|Baso Docks|a dry dock|the salt yard dock|covered stone dock|\[The Galley Sanegazat\]|\[The Galley Cercorim\]
action put fatigue when ^You can see a ferry approaching on the left side.|^The ferry|^A kingfisher|^A burst of|^The Elven|^The skiff|^The polemen|^Small waves|^The sturdy stone|^You are about a fourth of the way across\.|^The ferry moves away\, nearly out of view\.|ferry passing you on the left\.|^You are nearing the docks\.|^A swarm of eels passes beneath the keel\, probably on their way to the river\'s fresh water to spawn\.|followed by the clatter of wood on wood\.|^A family of dolphins leaps from the water beside the galley\.|^Some geese in a perfect V fly north high overhead\.|^Some small blue sharks slide past through the water\.|^A sailor walks by with a coil of rope\.|^A green turtle as large as a tower shield swims past\,|^You are nearing the docks\.|A drumbeat sounds through the ship\.|^You are about a fourth of the way across\.|^A galley comes into sight\, its oars beating rhythmically\.|^The galley moves away\, the beat of its drum slowly fading\.|^For a few minutes\, the drumbeat from below is echoed across the water by the beat from the galley passing on the left\.|The door swings shut of its own accord, and the gondola pushes off\.|The platform vanishes against the ridgeline\.|The gondola arrives at the center of the chasm\, and keeps heading (north|south)\.|The cab trundles on along as the ropes overhead creak and moan\.|The ropes creak as the gondola continues (north|south)\.|^The gondola creaks as a wind pushes it back and forth\.|^You hear a bell ring out three times|^The barge|^Several oars pull|^All that is visible|^The opposite bank|^A few of the other passengers|^The shore disappears
action put fatigue when ^A desert oasis|^The oasis|The endless expanse of the desert|The dock disappears from view quickly|sand-bearing winds buffet|Several skilled yeehar-handlers|^The Sand Elf|^The harsh winds|^The Gemfire Mountains|^The extreme heat causes|^The sand barge|^The large yeehars|^The murderous shriek|dark-skinned elf|Dark-skinned Elves|^As the barge is pulled|^As the dirigible continues|^The thick canopy of|^The dirigible|^The sinuous Southern Trade Route|^The Reshal Sea|^The peculiar sight|^A long moment of breathless suspense|^A Gnomish mechanic|^As the dirigible|^A breathtaking panorama|^The Gnomish operators|^The river quickly gives|^A massive peak|^A large flock|^Far below\, you see|^The Greater Fist|^A clangorous commotion|^Passing over land|^A human who had been|^A cowled passenger peers|^The balloon|^A few scattered islands|^The mammoth\'s fur|^The sea mammoth|^The air cools|^Scarcely visible in|^Another sea mammoth|^Steadily climbing\,|^As the airship leaves the mountain range|^With a swift turn of the|^With another yank on the|^The pilot adjusts his controls|^Turning his wheel\, the pilot points the airship|^With a confident spin of the|^Coming down from the mountain|^A whoosh of steam escapes
action put look when ^Your destination
action put #tvar spellEOTB 0 when ^Your corruptive mutation fades\, revealing you to the world once more\.
action put #tvar spellEOTB 1 when ^You feel a rippling sensation throughout your body as your corruptive mutation alters you and your equipment into blind spots invisible to the world\.
action put #tvar spellEOTB 1 when ^Your spell subtly alters the corruptive mutation upon you\, creating a blind spot once more\.
action put #tvar spellEOTB 1 when ^You sense the Eyes of the Blind spell upon you\, which will last .*\.
action put #tvar spellROC 0 when ^The Rite of Contrition matrix loses cohesion\, leaving your aura naked\.
action put #tvar spellROC 0 when eval ($SpellTimer.RiteofContrition.active = 0)
action put #tvar spellROC 1 when ^You weave a field of sublime corruption\, concealing the scars in your aura under a layer of magical pretense\.
action put #tvar spellROC 1 when ^You sense the Rite of Contrition spell upon you\, which will last .*\.
action put #tvar spellROG 1 when ^You project your self-image outward on a gust of psychic miasma
action put #tvar spellROG 1 when eval ($SpellTimer.RiteofGrace.active = 1)
action put #tvar spellROG 0 when eval ($SpellTimer.RiteofGrace.active = 0)
put #tvar spellROG 0
put #tvar spellROC 0
put #tvar spellEOTB 0
if !def(guild) then action put #var guild $1 when Guild\: (\S+)
action put #var circle $1 when Circle\: (\d+)
action var kronars 0 when No Kronars\.
action var kronars $1 when \((\d*) copper Kronars\)\.
action var lirums 0 when No Lirums\.
action var lirums $1 when \((\d*) copper Lirums\)\.
action var dokoras 0 when No Dokoras\.
action var dokoras $1 when \((\d*) copper Dokoras\)\.
var kronars 0
var dokoras 0
var lirums 0
var destination %1
eval destination tolower("%destination")
var detour nil
var therencoin 300
var boarneeded 300
TOP:
pause 0.001
send info;encumbrance
waitforre ^\s*Encumbrance\s*\:
action remove Guild\: (\S+)
action remove Circle\: (\d+)
pause 0.1
pause 0.1
send exp 0
waitforre EXP HELP
pause 0.2
pause 0.2
action remove Circle\: (\d+)
action remove Guild\: (\S+)
put #var save
put #mapper reset
if matchre("$guild", "(Ranger|Thief)") then var undergondola 520
if matchre("$guild", "Necromancer") then
     {
          put perceive
          pause
          pause 0.2
     }
put #echo >Log Travel script departure from: $zonename (map $zoneid: room $roomid)
if $hidden then send unhide
pause 0.001
pause 0.001
timer clear
timer start
eval destination tolower("%destination")
if ($joined = 1) then
     {
          var rossmannorth 2000
          var rossmansouth 2000
          var faldesu 2000
          var segoltha 2000
          var undergondola 2000
          var undersegoltha 2000
          var shardcitizen no
          echo ### You are in a group!  You will NOT be taking the gravy short cuts today! ###
     }
START:
if ("%destination" = "") then goto NODESTINATION
if (("$zoneid" = "0") || ("$roomid" = "0")) then
     {
          echo ### Unknown map or room id - Attempting to move in random direction to recover
          gosub MOVE_RANDOM
     }
pause 0.001
if (("$zoneid" = "0") || ("$roomid" = "0")) then gosub MOVE_RANDOM
pause 0.001
if ("$zoneid" = "0") then
     {
          ECHO ### You are in a spot not recognized by Genie, please start somewhere else! ###
          exit
     }
echo ** TRAVEL DRAGON
echo
echo                 \||/
echo                 |  @___oo ------------ Pew Pew Pew
echo       /\  /\   / (__,,,,|
echo      ) /^\) ^\/ _)
echo      )   /^\/   _)
echo      )   _ /  / _)
echo  /\  )/\/ ||  | )_)
echo <  >      |(,,) )__)
echo  ||      /    \)___)\
echo  | \____(      )___) )___
echo   \______(_______;;; __;;;
echo
echo LET'S GO!
pause 0.3
#DESTINATION
if matchre("$roomname", "Gondola") then gosub FERRYLOGIC
if matchre("Aesry","$zonename") then gosub AESRYBACK
if (("$zoneid" = "90") && !matchre("%destination", "(rat?h?a?|aesr?y?|hara)")) then
    {
        var toratha 0
        gosub MOVE 834
        gosub JOINLOGIC
        pause
        gosub JOINLOGIC
        gosub MOVE 2
    }
if (("$zoneid" = "150") && !matchre("%destination", "(rat?h?a?|acen?e?m?a?c?r?a?)")) then
     {
         gosub move 85
         pause 0.3
         send go exit portal
         pause 0.5
         pause 0.2
     }
cheatstart:
if matchre("%destination", "\b(cros?s?i?n?g?s?|xing?)") then goto CROSSING
if matchre("%destination", "\b(wolfc?l?a?n?)") then
     {
          var detour wolf
          goto CROSSING
     }
if matchre("%destination", "\b(knif?e?c?l?a?n?)") then
     {
          var detour knife
          goto CROSSING
     }
if matchre("%destination", "\b(tige?r?c?l?a?n?)") then
     {
          var detour tiger
          goto CROSSING
     }
if matchre("%destination", "\b(dirg?e?)") then
     {
          var detour dirge
          goto CROSSING
     }
if matchre("%destination", "\b(arth?e?d?a?l?e?)") then
     {
          var detour arthe
          goto CROSSING
     }
if matchre("%destination", "\b(kaer?n?a?)") then
     {
          var detour kaerna
          goto CROSSING
     }
if matchre("%destination", "\b(ilay?a?t?a?i?p?|illa?y?a?t?a?i?p?a?|taipa)") then
     {
          var detour taipa
          goto CROSSING
     }
if matchre("%destination", "\b(leth?d?e?r?i?e?l?)") then
     {
          var detour leth
          goto CROSSING
     }
if matchre("%destination", "\b(acen?a?m?a?c?r?a?)") then
     {
          var detour acen
          goto CROSSING
     }
if matchre("%destination", "\b(vipe?r?s?|guar?d?i?a?n?s?|leuc?r?o?s?)") then
     {
          var detour viper
          goto CROSSING
     }
if matchre("%destination", "\b(malod?o?r?o?u?s?|bucc?a?)") then
     {
          var detour bucca
          goto CROSSING
     }
if matchre("%destination", "\b(dokt?)") then
     {
          var detour dokt
          goto CROSSING
     }
if matchre("%destination", "\bsorr?o?w?s?") then
     {
          var detour sorrow
          goto CROSSING
     }
if matchre("%destination", "\bmisens?e?o?r?") then
     {
          var detour misen
          goto CROSSING
     }
if matchre("%destination", "\bbeis?s?w?u?r?m?s?") then
     {
          var detour beisswurms
          goto CROSSING
     }
if matchre("%destination", "\bston?e?c?l?a?n?") then
     {
          var detour stone
          goto CROSSING
     }
if matchre("%destination", "\bshar?d?") then goto ILITHI
if matchre("%destination", "\b(bone?w?o?l?f?|germ?i?s?h?d?i?n?)") then
     {
          var detour bone
          goto ILITHI
     }
if matchre("%destination", "\balfr?e?n?s?") then
     {
          var detour alfren
          goto ILITHI
     }
if matchre("%destination", "\b(gond?o?l?a?)") then
     {
          var detour gondola
          goto ILITHI
     }
if matchre("%destination", "\b(grani?t?e?|garg?o?y?l?e?)") then
     {
          var detour garg
          goto ILITHI
     }
if matchre("%destination", "\b(spir?e?)") then
     {
          var detour spire
          goto ILITHI
     }
if matchre("%destination", "\b(horse?c?l?a?n?)") then
     {
          var detour horse
          goto ILITHI
     }
if matchre("%destination", "\b(fayr?i?n?s?)") then
     {
          var detour fayrin
          goto ILITHI
     }
if matchre("%destination", "\b(steel?c?l?a?w?)") then
     {
          var detour steel
          goto ILITHI
     }
if matchre("%destination", "\b(cori?k?s?)") then
     {
          var detour corik
          goto ILITHI
     }
if matchre("%destination", "\b(ada?n?f?)") then
     {
          var detour adan'f
          goto ILITHI
     }
if matchre("%destination", "\b(ylo?n?o?)") then
     {
          var detour ylono
          goto ILITHI
     }
if matchre("%destination", "\b(wyve?r?n?)") then
     {
          var detour wyvern
          goto ILITHI
     }

if matchre("%destination", "\b(cara?v?a?n?s?a?r?y?)") then
     {
          var detour caravansary
          goto THERENGIA
     }
if matchre("%destination", "\b(rive?r?h?a?v?e?n?|have?n?)") then
     {
          var detour haven
          goto THERENGIA
     }
if matchre("%destination", "\b(ross?m?a?n?s?)") then
     {
          var detour rossman
          goto THERENGIA
     }
if matchre("%destination", "\b(ther?e?n?b?o?r?o?u?g?h?)") then
     {
          var detour theren
          goto THERENGIA
     }
if matchre("%destination", "\b(lang?e?n?f?i?r?t?h?)") then
     {
          var detour lang
          goto THERENGIA
     }
if matchre("%destination", "\b(el'?b?a?i?n?s?|elb?a?i?n?s?)") then
     {
	      var detour el'bain
		  goto THERENGIA
	 }
if matchre("%destination", "\b(raka?s?h?)") then
     {
          var detour rakash
          goto THERENGIA
     }
if matchre("%destination", "\bthro?n?e?") then
     {
          var detour throne
          goto THERENGIA
     }
if matchre("%destination", "\b(musp?a?r?i?)") then
     {
          var detour muspari
          goto THERENGIA
     }
if matchre("%destination", "\b(forn?s?t?e?d?)") then
     {
          var detour fornsted
          goto THERENGIA
     }
if matchre("%destination", "\b(hvar?a?l?)") then
     {
          var detour hvaral
          goto ILITHI
     }
if matchre("%destination", "\b(zaul?f?u?n?g?)") then
     {
          var detour zaulfung
          goto THERENGIA
     }
if matchre("%destination", "\b(aing?h?a?z?a?l?)") then
     {
          var detour ain
          goto FORD
     }
if matchre("%destination", "\b(rave?n?s?)") then
     {
          var detour raven
          goto FORD
     }
if matchre("%destination", "\b(hib?a?r?n?h?v?i?d?a?r?|out?e?r?)") then
     {
          var detour outer
          goto FORD
     }
if matchre("%destination", "\b(inne?r?)") then
     {
          var detour inner
          goto FORD
     }
if matchre("%destination", "\b(boar?c?l?a?n?)") then goto FORD
if matchre("%destination", "\b(aes?r?y?|sur?l?a?e?n?i?s?)") then
    {
            var detour aesry
            goto ILITHI
    }
if matchre("%destination", "\b(mri?s?s?)") then
    {
            var detour mriss
            goto THERENGIA
    }
if matchre("%destination", "\b(merk?r?e?s?h?|kre?s?h?)") then
    {
            var detour merk
            goto THERENGIA
    }
if matchre("%destination", "\b(har?a?j?a?a?l?)") then
    {
            var detour hara
            goto THERENGIA
    }
if matchre("%destination", "\b(rat?h?a?)") then
    {
            var detour ratha
            if ("$zoneid" = "150") then
                {
                    gosub MOVE 2
                    var toratha 1
                    gosub JOINLOGIC
                    gosub MOVE 252
                    goto ARRIVED
                }
            goto CROSSING
    }
if "$zoneid" = "150" && "$game" != "DRF" && "%detour" != "ratha" then
    {
            gosub MOVE 2
            var toratha 0
            gosub JOINLOGIC
            gosub MOVE 2
            goto cheatstart
    }
if matchre("%destination", "\b(fan?g?|cov?e?)") then
    {
            var detour fang
            if "$game" = "DRF" then
                {
                    pause
                    echo
                    echo
                    echo YOU ARE IN THE FALLEN, GO FIND A FUCKING MEETING PORTAL YOU LAZY FUCK
                    exit
                }
            goto CROSSING
    }
goto NODESTINATION

AESRY_LONG:
echo
echo ** NO SHORTCUT TO AESRY IN TF - TAKING LONG ROUTE
echo
if ("$zoneid" = "90") then goto AESRY_LONG_2
var detour aesry
if %lirums < 300 then goto NOCOIN
if ("$zoneid" = "67") then gosub MOVE east
gosub MOVE portal
pause 0.2
put go meeting portal
pause 0.5
pause 0.3
gosub MOVE 2
var toratha 1
gosub JOINLOGIC
AESRY_LONG_2:
pause 0.2
gosub MOVE 234
gosub JOINLOGIC
goto ARRIVED

# TRAVEL
CROSSING:
var label CROSSING
if matchre("$zonename", "(Hara'jaal|Mer'Kresh|M'Riss)") then
     {
          var backuplabel CROSSING
          var backupdetour %detour
          var detour mriss
          var tomainland 1
          goto QITRAVEL
     }
if ("$zoneid" = "35") then
     {
          if %lirums < 240 then goto NOCOIN
          gosub MOVE 166
          gosub FERRYLOGIC
          pause
     }
if ("$zoneid" = "1a") then gosub MOVE cross
if ("$zoneid" = "2a") then gosub MOVE cross
if ("$zoneid" = "47") then
     {
          gosub MOVE 117
          gosub FERRYLOGIC
          pause
     }
if ("$zoneid" = "41") then
     {
          gosub MOVE 53
          waitforre ^Just when it seems
          pause
          # put #mapper reset
     }
if ("$zoneid" = "42") then gosub MOVE 2
if ("$zoneid" = "59") then gosub MOVE 12
if ("$zoneid" = "114") then
     {
          put wealth
          pause 0.7
          if %dokoras < 120 then goto NOCOIN
          gosub MOVE 1
          gosub FERRYLOGIC
          send go oak doors
          pause
     }
if (("$zoneid" = "113") && ("$roomid" = "1")) then gosub MOVE 5
if ("$zoneid" = "40a") then gosub MOVE 125
if (("$zoneid" = "40") && ($Athletics.Ranks >= %rossmansouth)) then gosub MOVE 213
if (("$zoneid" = "40") && ($Athletics.Ranks < %rossmansouth)) then
     {
          if %lirums < 140 then goto NOCOIN
          gosub MOVE 36
          gosub FERRYLOGIC
     }
if ("$zoneid" = "34a") then gosub MOVE 134
if ("$zoneid" = "34") then gosub MOVE 15
if ("$zoneid" = "33a") then gosub MOVE 46
if ("$zoneid" = "33") then gosub MOVE 1
if ("$zoneid" = "32") then gosub MOVE 1
if ("$zoneid" = "31") then gosub MOVE 1
if (("$zoneid" = "30") && ($Athletics.Ranks < %faldesu)) then
     {
          put wealth
          pause 0.7
          if %lirums < 140 then goto NOCOIN
          gosub MOVE 103
          pause
          gosub FERRYLOGIC
     }
if (("$zoneid" = "30") && ($Athletics.Ranks >= %faldesu)) then
     {
          gosub MOVE 203
          gosub MOVE 79
     }
if ("$zoneid" = "14c") then gosub MOVE 21
if ("$zoneid" = "14c") then gosub MOVE 21
if ("$zoneid" = "14c") then gosub MOVE 21
if ("$zoneid" = "127") then gosub MOVE 510
if ("$zoneid" = "126") then gosub MOVE 49
if ("$zoneid" = "116") then gosub MOVE 3
if ("$zoneid" = "123") then gosub MOVE 175
if ("$zoneid" = "67a") then gosub MOVE shard
if ("$zoneid" = "69") then gosub MOVE 1
if ("$zoneid" = "68a") then gosub MOVE 29
if ("$zoneid" = "68b") then gosub MOVE 44
if (("$zoneid" = "68") && ("$guild" = "Thief")) then gosub MOVE 15
if (("$zoneid" = "68") && (%shardcitizen = "yes")) then
     {
          gosub MOVE 1
          gosub MOVE 135
     }
if (("$zoneid" = "68") && (%shardcitizen = "no")) then gosub MOVE 15
if (("$zoneid" = "67") && ("$guild" = "Thief")) then
     {
          gosub MOVE 566
          gosub MOVE 23
     }
if ("$zoneid" = "67") then gosub MOVE 132
if (("$zoneid" = "66") && ("$guild" = "Thief" && $Athletics.Ranks >= %undergondola)) then
     {
          put khri flight harrier
          pause
     }
if (("$zoneid" = "66") && ("$guild" = "Ranger" && $Athletics.Ranks >= %undergondola)) then
     {
          put prep athletic 12
          pause 8
          put cast
          pause 0.2
     }
if (("$zoneid" = "66") && ($Athletics.Ranks >= %undergondola)) then gosub MOVE 317
if (("$zoneid" = "66") && ($Athletics.Ranks < %undergondola)) then
     {
          gosub MOVE 156
          pause
          gosub FERRYLOGIC
     }
if ("$zoneid" = "1a") then gosub MOVE cross
if ("$zoneid" = "63") then gosub MOVE 112
if ("$zoneid" = "65") then gosub MOVE 44
if ("$zoneid" = "62") then gosub MOVE 100
if ("$zoneid" = "112") then gosub MOVE 112
if ("$zoneid" = "58") then gosub MOVE leth
if (("$zoneid" = "60") && matchre("%detour", "(leth|acen|taipa|LETH|ACEN|ratha|fang)")) then gosub MOVE 57
if (("$zoneid" = "61") && matchre("%detour", "(leth|acen|taipa|LETH|ACEN|ratha|fang)")) then
     {
          if "%detour" = "acen" then
               {
                    gosub MOVE 178
                    gosub MOVE 47
               }
          if "%detour" = "taipa" then
               {
                    gosub MOVE 126
                    gosub MOVE 27
               }
          if "%detour" = "ratha" then
               {
                    gosub MOVE 178
                    gosub MOVE 47
                    var toratha 1
                    gosub JOINLOGIC
                    pause
                    gosub JOINLOGIC
                    gosub MOVE 252
                    goto ARRIVED
               }
          if "%detour" = "leth" then gosub MOVE 18
          goto ARRIVED
     }
if ("$zoneid" = "61") then gosub MOVE 115
if ("$zoneid" = "50") && matchre("%destination", "(knife?|wolf?|tige?r?|dirg?e?|arth?e?|kaer?n?a?|rive?r?|have?n?|ther?e?n?|lang?|raka?s?h?|musp?a?r?i?|zaul?f?u?n?g?|cross?i?n?g?)") && ($Athletics.Ranks > %segoltha) then gosub MOVE 8
if ("$zoneid" = "50") then gosub MOVE 30
if (("$zoneid" = "60") && ("%detour" = "alfren")) then
          {
          gosub MOVE 42
          goto ARRIVED
          }
if (("$zoneid" = "60") && matchre("%detour", "(leth|acen|taipa|LETH|ACEN|ratha|fang|ain|raven|outer|inner|adan'f|corik|steel|ylono|fayrin|horse|spire)")) then gosub MOVE leth
if (("$zoneid" = "60") && ("$guild" = "Thief")) then
          {
              if $Athletics.Ranks >= %undersegoltha then
                  {
                      gosub MOVE 107
                      if ("$zoneid" = "120") then gosub MOVE 107
                      gosub MOVE cross
                      pause 0.1
                      if ("$zoneid" = "1a") then gosub MOVE cross
                  }
          }
if (("$zoneid" = "60") && ($Athletics.Ranks >= %segoltha)) then gosub MOVE 108
pause 0.01
if ("$zoneid" = "50") && matchre("%destination", "(knife|wolf|tiger|dirge|arthe|kaerna|haven|theren|lang|rakash|muspari|zaulfung|cross|crossing)") && ($Athletics.Ranks > %segoltha) then gosub MOVE 8
if ("$zoneid" = "50") then gosub MOVE 30
if (("$zoneid" = "60") && ($Athletics.Ranks < %segoltha)) then
          {
              put wealth
              pause 0.7
              if %kronars < 40 then goto NOCOIN
              gosub MOVE 42
              if ("$roomid" != "42") then gosub MOVE 42
              if ("$roomid" != "42") then gosub MOVE 42
              pause
              gosub FERRYLOGIC
          }
if "$zoneid" = "6"  then gosub MOVE cross
if ("$zoneid" = "4a") then gosub MOVE 15
if ("$zoneid" = "4b") then gosub MOVE 1
if (("$zoneid" = "4") && (("%detour" = "dokt"))) then
          {
              gosub MOVE dok
              goto ARRIVED
          }
if "$zoneid" = "4"  then gosub MOVE 14
if ("$zoneid" = "13") then gosub MOVE 71
if ("$zoneid" = "12a") then gosub MOVE 60
if ("$zoneid" = "10") then gosub MOVE 116
if ("$zoneid" = "9b") then gosub MOVE 9
if ("$zoneid" = "14b") then gosub MOVE 217
if ("$zoneid" = "11") then gosub MOVE 2
if (("$zoneid" = "1") && matchre("%detour", "(arthe|dirge|kaerna|stone|misen|sorrow|fist|beisswurms|bucca|viper)")) then gosub MOVE 171
if (("$zoneid" = "7") && matchre("%detour", "(arthe|dirge|kaerna|stone|misen|sorrow|fist|beisswurms|bucca|viper)")) then
     {
         if "%detour" = "dirge" then
             {
                 gosub MOVE 147
                 gosub MOVE 38
             }
         if "%detour" = "arthe" then gosub MOVE 535
         if "%detour" = "kaerna" then gosub MOVE 352
         if "%detour" = "stone" then gosub MOVE 396
         if "%detour" = "stone" && "$zoneid" = "7" then gosub MOVE 396
         if "%detour" = "stone" && "$zoneid" = "7" then gosub MOVE 396
         if "%detour" = "beisswurms" then gosub MOVE 396
         if "%detour" = "beisswurms" && "$zoneid" = "7" then gosub MOVE 396
         if "%detour" = "fist" then gosub MOVE 253
         if "%detour" = "misen" then gosub MOVE 437
         if "%detour" = "viper" then
             {
                 gosub MOVE 394
                 if $Perception.Ranks > 150 then gosub MOVE 5
             }
         if matchre("(sorrow|bucca)","%detour") then
             {
                 gosub MOVE 397
                 if "%detour" = "sorrow" then
                       {
                            gosub MOVE 77
                            goto ARRIVED
                       }
                 if "%detour" = "bucca" then
                       {
                            gosub MOVE 124
                            goto ARRIVED
                       }
             }
        if "%detour" = "beisswurms" then gosub MOVE 31
         goto ARRIVED
     }
if ("$zoneid" = "7") then gosub MOVE 349
if ("$zoneid" = "7") then gosub MOVE 349
if ("$zoneid" = "8") then gosub MOVE 43
if (("$zoneid" = "1") && matchre("%detour", "(wolf|knife|tiger)")) then
     {
         gosub MOVE 172
         if "%detour" = "wolf" then gosub MOVE 126
         if "%detour" = "knife" then gosub MOVE 459
         if "%detour" = "tiger" then gosub MOVE 87
         goto ARRIVED
     }
if (("$zoneid" = "1") && matchre("%detour", "(leth|acen|taipa|ratha)")) then
     {
         if "$guild" = "Thief" then
             {
                 if $Athletics.Ranks >= %undersegoltha then
                     {
                         gosub MOVE 650
                         gosub MOVE 23
                     }
             }
         if $Athletics.Ranks >= %segoltha && "$zoneid" = "1" then
             {
                 gosub MOVE 476
                 gosub MOVE 30
             }
         if ("$zoneid" = "1") then
             {
                 if %kronars < 100 then goto NOCOIN
                 gosub MOVE 236
                 gosub FERRYLOGIC
             }
         pause
         put south
         wait
         put #mapper reset
         gosub MOVE 57
         if "%detour" = "acen" then
             {
                 gosub MOVE 178
                 gosub MOVE 47
             }
         if "%detour" = "taipa" then
             {
                 gosub MOVE 126
                 gosub MOVE 27
             }
         if "%detour" = "ratha" then
             {
                 gosub MOVE 178
                 gosub MOVE 47
                 var toratha 1
                 gosub JOINLOGIC
                 pause
                 gosub JOINLOGIC
                 send go beach
                 pause 0.5
                 gosub MOVE 252
                 goto ARRIVED
             }
         if "%detour" = "leth" then gosub MOVE 18
     }
if ("$zoneid" = "1") then gosub MOVE 42
goto ARRIVED

ILITHI:
var label ILITHI
if ("$zoneid" = "127") then gosub MOVE south
if "$zoneid" = "6"  then gosub MOVE cross
if ("$zoneid" = "2a") then gosub MOVE cross
if ("$zoneid" = "67a") then gosub MOVE shard
if matchre("$zonename", "(Hara'jaal|Mer'Kresh|M'Riss)") then
     {
         var backuplabel ILITHI
         var backupdetour %detour
         var detour mriss
         var tomainland 1
         goto QITRAVEL
     }
if ("$zoneid" = "35") then
     {
         if %lirums < 120 then goto NOCOIN
         gosub MOVE 166
         gosub FERRYLOGIC
     }
 if ("$zoneid" = "47") then
     {
         gosub MOVE 117
         gosub FERRYLOGIC
         pause 0.5
     }
if ("$zoneid" = "41") then
     {
         gosub MOVE 53
         waitforre ^Just when it seems
         pause
         put #mapper reset
     }
if ("$zoneid" = "127") then gosub MOVE south
if ("$zoneid" = "40a") then gosub MOVE 125
if (("$zoneid" = "40") && ($Athletics.Ranks >= %rossmansouth)) then gosub MOVE 213
if (("$zoneid" = "40") && ($Athletics.Ranks < %rossmansouth)) then
     {
        evalmath boarneeded $circle * 20
        if %lirums < %boarneeded then goto NOCOIN
        gosub MOVE 263
     }
if ("$zoneid" = "40a") then
	{
	evalmath boarneeded $circle * 20
	if %lirums < %boarneeded then
		{
		gosub move 125
		goto NOCOIN
		}
	gosub MOVE 68
	gosub JOINLOGIC
	}
if ("$zoneid" = "126") then gosub MOVE 49
if ("$zoneid" = "127") then gosub MOVE south
if ("$zoneid" = "126") then gosub MOVE 49
if ("$zoneid" = "116") then gosub MOVE 3
if ("$zoneid" = "114") then
          {
              if %dokoras < 120 then goto NOCOIN
              gosub MOVE 4
              gosub FERRYLOGIC
              send west
              wait
          }
if ("$zoneid" = "112") then gosub MOVE 112
if ("$zoneid" = "123") then gosub MOVE 175
if ("$zoneid" = "42") then gosub MOVE 2
if ("$zoneid" = "59") then gosub MOVE 12
if ("$zoneid" = "114") then
          {
              if %dokoras < 120 then goto NOCOIN
              gosub MOVE 1
              gosub FERRYLOGIC
              send go oak doors
          }
if ("$zoneid" = "40a") then gosub MOVE 125
if (("$zoneid" = "40") && ($Athletics.Ranks >= %rossmansouth)) then gosub MOVE 213
if (("$zoneid" = "40") && ($Athletics.Ranks < %rossmansouth)) then
          {
              if %lirums < 140 then goto NOCOIN
              gosub MOVE 36
              gosub FERRYLOGIC
          }
if ("$zoneid" = "34a") then gosub MOVE 134
if ("$zoneid" = "34") then gosub MOVE 15
if ("$zoneid" = "33a") then gosub MOVE 46
if ("$zoneid" = "33") then gosub MOVE 1
if ("$zoneid" = "32") then gosub MOVE 1
if ("$zoneid" = "31") then gosub MOVE 1
if (("$zoneid" = "30") && ($Athletics.Ranks < %faldesu)) then
          {
              if %lirums < 140 then goto NOCOIN
              gosub MOVE 103
              pause
              gosub FERRYLOGIC
          }
if (("$zoneid" = "30") && ($Athletics.Ranks >= %faldesu)) then
          {
              gosub MOVE 203
              gosub MOVE 79
          }
if ("$zoneid" = "14c") then gosub MOVE 21
if ("$zoneid" = "14c") then gosub MOVE 21
if ("$zoneid" = "14c") then gosub MOVE 21
if ("$zoneid" = "13") then gosub MOVE 71
if ("$zoneid" = "12a") then gosub MOVE 60
if ("$zoneid" = "4a") then gosub MOVE 15
if ("$zoneid" = "4") then gosub MOVE 14
if ("$zoneid" = "8") then gosub MOVE 43
if ("$zoneid" = "10") then gosub MOVE 116
if ("$zoneid" = "9b") then gosub MOVE 9
if ("$zoneid" = "14b") then gosub MOVE 217
if ("$zoneid" = "11") then gosub MOVE 2
if ("$zoneid" = "7") then gosub MOVE 349
if ("$zoneid" = "7") then gosub MOVE 349
if ("$zoneid" = "7") then gosub MOVE 349
if ("$zoneid" = "112") then gosub MOVE 112
if ("$zoneid" = "1") then
          {
              if "$guild" = "Thief" then
                  {
                      if $Athletics.Ranks >= %undersegoltha then
                          {
                              gosub MOVE 650
                              gosub MOVE 23
                          }
                  }
              if $Athletics.Ranks >= %segoltha && "$zoneid" = "1" then
                  {
                      gosub MOVE 476
                      gosub MOVE 30
                  }
              if ("$zoneid" = "1") then
                  {
                      if %kronars < 100 then goto NOCOIN
                      gosub MOVE 236
                      gosub FERRYLOGIC
                  }
              pause
              put south
              wait
              put #mapper reset
          }
if ("$zoneid" = "50") && matchre("(knife|wolf|tiger|dirge|arthe|kaerna|haven|theren|lang|rakash|muspari|zaulfung|cross|crossing)","%destination") && ($Athletics.Ranks > %segoltha) then gosub MOVE 8
if ("$zoneid" = "50") then gosub MOVE 30
if ("$zoneid" = "1a") then gosub MOVE 23
if (("$zoneid" = "67") && matchre("alfren","%detour")) then
          {
              goto CROSSING
          }
if (("$zoneid" = "62") && matchre("alfren","%detour")) then
          {
              gosub MOVE leth
          }
if (("$zoneid" = "61") && matchre("alfren","%detour")) then
          {
              gosub MOVE cross
              pause 0.2
          }
if (("$zoneid" = "60") && matchre("alfren","%detour")) then
          {
              gosub MOVE 42
              goto ARRIVED
          }
if ("$zoneid" = "60") then gosub MOVE 57
if ("$zoneid" = "112") then gosub MOVE 112
if ("$zoneid" = "59") then gosub MOVE 12
if ("$zoneid" = "58") then gosub MOVE 2
if ("$zoneid" = "61") then gosub MOVE 130
if ("$zoneid" = "63") then gosub MOVE 112
if (("$zoneid" = "62") && matchre("gondola","%detour")) then
          {
              gosub MOVE 2
              goto ARRIVED
          }
if (("$zoneid" = "62") && matchre("(bone|germ)","%detour")) then
          {
              gosub MOVE 101
              goto ARRIVED
          }
if (("$zoneid" = "62") && ("$guild" = "Thief") && ($Athletics.Ranks >= %undergondola)) then
          {
               put khri flight harrier
               pause
          }
if (("$zoneid" = "62") && ("$guild" = "Ranger") && ($Athletics.Ranks >= %undergondola)) then
          {
               put prep athlet 10
               pause 8
               put cast
          }
if (("$zoneid" = "62") && ($Athletics.Ranks >= %undergondola)) then
          {
             gosub MOVE 41
             pause
             if (toupper("$game") = "DRF") then
                   {
                        gosub MOVEIT sw
                        gosub MOVEIT sw
                        gosub MOVEIT s
                        gosub MOVE 153
                        goto ILITHI_2
                   }
             if (toupper("$game") = "DR") then
                   {
                        gosub MOVEIT sw
                        gosub MOVEIT sw
                        pause 0.2
                        put go blockade
                        pause 0.8
                        pause 0.1
                        gosub MOVE 153
                   }
          }
if ("$zoneid" = "62") && (toupper("$game") = "DRF") then
          {
              gosub MOVE 41
              gosub MOVEIT sw
              gosub MOVEIT sw
              gosub MOVEIT s
              pause 0.5
              gosub MOVE 2
              gosub FERRYLOGIC
          }
if ("$zoneid" = "62") && (toupper("$game") = "DR") then
          {
              gosub MOVE 41
              gosub MOVEIT sw
              gosub MOVEIT sw
              pause 0.1
              put go blockade
              pause 0.8
              pause 0.1
              gosub MOVE 2
              gosub FERRYLOGIC
          }
ILITHI_2:
if (("$zoneid" = "69") && matchre("(horse|spire|wyvern)","%detour")) then
          {
              if "%detour" = "horse" then gosub MOVE 199
              if "%detour" = "spire" then gosub MOVE 334
              if "%detour" = "wyvern" then gosub MOVE 15
              goto ARRIVED
          }
if ("$zoneid" = "65") then gosub MOVE 1
if (("$zoneid" = "66") && ("%detour" = "garg")) then
          {
              gosub MOVE 167
              goto ARRIVED
          }
#if (("$zoneid" = "69") && ("%shardcitizen" = "yes")) then gosub MOVE 31
if ("$zoneid" = "69") then gosub MOVE 1
if ("$zoneid" = "68a") then gosub MOVE 29
if (("$zoneid" = "68") && matchre("(adan'f|corik)","%detour")) then
          {
              if "%detour" = "corik" then gosub MOVE 114
              if "%detour" = "adan'f" then gosub MOVE 29
              goto ARRIVED
          }
if (("$zoneid" = "68") && ("$guild" = "Thief")) then gosub MOVE 225
if ("$zoneid" = "67a") then gosub MOVE shard
if (("$zoneid" = "68") && (%shardcitizen = "yes")) then gosub MOVE 1
if (("$zoneid" = "68") && (%shardcitizen = "no")) then gosub MOVE 15
if (("$zoneid" = "67") && matchre("alfren","%detour")) then
          {
              goto CROSSING
          }
if (("$zoneid" = "67") && ("$guild" = "Thief") && matchre("(steel|ylono|fayrin|horse|spire|wyvern)","%detour")) then
          {
              gosub MOVE 566
              gosub MOVE 23
          }
if (("$zoneid" = "67") && ("$guild" = "Thief") && matchre("(adan'f|corik)","%detour")) then
          {
              gosub MOVE 228
              pause
              send climb embrasure
              wait
              if "%detour" = "adan'f" then gosub MOVE 29
              if "%detour" = "corik" then gosub MOVE 114
          }
if (("$zoneid" = "67") && matchre("(steel|ylono|fayrin|horse|spire|wyvern|corik|adan'f)","%detour")) then gosub MOVE 132
if (("$zoneid" = "66") && matchre("(steel|fayrin|ylono|corik|adan'f)","%detour")) then
          {
              if "%detour" = "steel" then gosub MOVE 99
              if "%detour" = "fayrin" then gosub MOVE 127
              if "%detour" = "ylono" then gosub MOVE 495
              if matchre("(corik|adan'f)","%detour") then
                  {
                      if "$guild" = "Thief" then
                          {
                              gosub MOVE 66
                              put go trail
                              pause 0.5
                              gosub MOVEIT south
                              gosub MOVEIT south
                              pause 0.2
                              gosub MOVE shard
                              gosub MOVE 228
                              pause
                              send climb embrasure
                              wait
                          }
                      if "%shardcitizen" = "yes" && "$zoneid" = 66 then
                          {
                              gosub MOVE 216
                              gosub MOVE 230
                          }
                      if ("$zoneid" = "66") then gosub MOVE 3
                      if "%detour" = "adan'f" then gosub MOVE 29
                      if "%detour" = "corik" then gosub MOVE 114
                  }
              goto ARRIVED
          }
if (("$zoneid" = "66") && matchre("(horse|spire|wyvern)","%detour")) then
          {
              gosub MOVE 217
              if "%detour" = "horse" then gosub MOVE 199
              if "%detour" = "spire" then gosub MOVE 334
              if "%detour" = "wyvern" then gosub MOVE 15
          }
if (("$zoneid" = "66") && ("$guild" = "Thief")) then
          {
               gosub MOVE 66
               gosub MOVEIT go trail
               pause 0.2
               gosub MOVEIT south
               gosub MOVEIT south
               pause 0.2
               gosub MOVE shard
          }
if ("$zoneid" = "66a") then gosub MOVE shard
if ("$zoneid" = "66") then gosub MOVE 216
if ("$zoneid" = "67") then gosub MOVE 81
if (("$zoneid" = "67") && matchre("gondola","%detour")) then
          {
              gosub MOVE north
              gosub MOVE platform
              goto ARRIVED
          }
if matchre("aesry","%detour") then
          {
              if matchre("$game", "DRF") then goto AESRY_LONG
              gosub MOVE 734
              gosub JOINLOGIC
              gosub MOVE 113
          }
goto ARRIVED
THERENGIA:
var label THERENGIA
if (("$zoneid" = "42") && ("%detour" = "rakash")) then gosub MOVE lang
if ("$zoneid" = "2a") then gosub MOVE cross
if "$zoneid" = "6"  then gosub MOVE cross
if ("$zoneid" = "67a") then gosub MOVE shard
if matchre("$zonename", "(Hara'jaal|Mer'Kresh|M'Riss)") then
          {
              var backuplabel THERENGIA
              var backupdetour %detour
              var detour mriss
              var tomainland 1
              goto QITRAVEL
          }
if matchre("$zoneid", "106|107|108") then goto QITRAVEL
#debug 10
if ("$zoneid" = "150") && ("$game" = "DRF") && ("%detour" = "hara") then
          {
              gosub MOVE 3
              gosub FERRYLOGIC
              pause
          }
if "$zoneid" = "35" && "%detour" != "throne" then
          {
              if %lirums < 240 then goto NOCOIN
              gosub MOVE 166
              gosub FERRYLOGIC
              pause
          }
if ("$zoneid" = "127") then gosub MOVE 510
if ("$zoneid" = "126") then gosub MOVE 49
if ("$zoneid" = "116") then gosub MOVE 3
if ("$zoneid" = "114") then
          {
              if %dokoras < 140 then goto NOCOIN
              gosub MOVE 1
              gosub FERRYLOGIC
              put go oak doors
              waitforre ^Obvious
          }
if (("$zoneid" = "113") && ("$roomid" = "1")) then gosub MOVE 5
if ("$zoneid" = "123") then gosub MOVE 175
if ("$zoneid" = "69") then gosub MOVE 1
if ("$zoneid" = "68a") then gosub MOVE 29
if ("$zoneid" = "68b") then gosub MOVE 44
if (("$zoneid" = "68") && ("$guild" = "Thief")) then gosub MOVE 15
if (("$zoneid" = "68") && (%shardcitizen = "yes")) then
          {
              gosub MOVE 1
              gosub MOVE 135
          }
if (("$zoneid" = "68") && (%shardcitizen = "no")) then gosub MOVE 15
if (("$zoneid" = "67") && ("$guild" = "Thief")) then
          {
              gosub MOVE 566
              pause 0.5
              gosub MOVE 23
          }
if ("$zoneid" = "67a") then gosub MOVE STR
if ("$zoneid" = "67") then gosub MOVE 132
if (("$zoneid" = "66") && matchre("gondola","%detour")) then
          {
              gosub MOVE platform
              goto ARRIVED
          }
if (("$zoneid" = "66") && ("$guild" = "Thief") && ($Athletics.Ranks >= %undergondola)) then
          {
               put khri flight harrier
               pause
          }
if (("$zoneid" = "66") && ("$guild" = "Ranger") && ($Athletics.Ranks >= %undergondola)) then
          {
               put prep athlet 10
               pause 8
               put cast
          }
if (("$zoneid" = "66") && ($Athletics.Ranks >= %undergondola)) then gosub MOVE 317
if (("$zoneid" = "66") && ($Athletics.Ranks < %undergondola)) then
          {
              gosub MOVE 156
              pause
              gosub FERRYLOGIC
          }
if ("$zoneid" = "65") then gosub MOVE 44
pause 0.1
if ("$zoneid" = "63") then gosub MOVE 112
if ("$zoneid" = "62") then gosub MOVE 100
if ("$zoneid" = "112") then gosub MOVE 112
if ("$zoneid" = "59") then gosub MOVE 12
if ("$zoneid" = "58") then gosub MOVE 2
if (("$zoneid" = "50") && ($Athletics.Ranks > %segoltha)) then gosub MOVE 8
if ("$zoneid" = "50") then gosub MOVE 30
if ("$zoneid" = "61") then gosub MOVE 115
if (("$zoneid" = "50") && ($Athletics.Ranks < %segoltha)) then gosub MOVE STR
if (("$zoneid" = "60") && ("$guild" = "Thief")) then
          {
              if $Athletics.Ranks >= %undersegoltha then
                  {
                      gosub MOVE 107
                      gosub MOVE 6
                  }
          }
if (("$zoneid" = "60") && ($Athletics.Ranks >= %segoltha)) then gosub MOVE 108
if (("$zoneid" = "60") && ($Athletics.Ranks < %segoltha)) then
          {
              if %kronars < 100 then goto NOCOIN
              gosub MOVE 42
              pause
              gosub FERRYLOGIC
          }
if ("$zoneid" = "13") then gosub MOVE 71
if ("$zoneid" = "4a") then gosub MOVE 15
if ("$zoneid" = "32") then gosub MOVE 1
if ("$zoneid" = "4") then gosub MOVE 14
if ("$zoneid" = "8") then gosub MOVE 43
if ("$zoneid" = "10") then gosub MOVE NTR
if ("$zoneid" = "9b") then gosub MOVE 9
if ("$zoneid" = "14b") then gosub MOVE 217
if ("$zoneid" = "11") then gosub MOVE 2
if ("$zoneid" = "1") then gosub MOVE 171
if (("$zoneid" = "7") && ("%detour" = "muspari")) then
          {
              gosub move 271
              gosub JOINLOGIC
              gosub move
          }
if (("$zoneid" = "7") && ("%detour" = "caravansary")) then
          {
              gosub MOVE caravan
              goto ARRIVED
          }
if (("$zoneid" = "7") && ($Athletics.Ranks >= %faldesu)) then gosub MOVE 197
if (("$zoneid" = "7") && ($Athletics.Ranks < %faldesu)) then
          {
              if %lirums < 140 then goto NOCOIN
              gosub MOVE 81
              gosub FERRYLOGIC
          }
if ("$zoneid" = "14c") then gosub MOVE 22
if ("$zoneid" = "33a") then gosub MOVE 46
if ("$zoneid" = "33") then gosub MOVE 1
if (("$zoneid" = "31") && ("%detour" = "zaulfung")) then gosub MOVE 100
if ("$zoneid" = "31") then gosub MOVE 1
if "$zoneid" = "34a" && "%detour" != "rossman" then gosub MOVE forest
if (("$zoneid" = "34") && ("%detour" = "rossman")) then
          {
              if %lirums < 70 then goto NOCOIN
              gosub MOVE 22
              goto ARRIVED
          }
if (("$zoneid" = "34") && matchre("%detour", "(lang|theren|rakash|muspari|fornsted|el'bain)")) then gosub MOVE 137
if (("$zoneid" = "34") && matchre("%detour", "(haven|zaulfung)")) then
          {
              if $Athletics.Ranks < %rossmansouth then gosub MOVE 137
              if $Athletics.Ranks >= %rossmansouth then
                  {
                      gosub MOVE 15
                      gosub MOVE 46
                      gosub MOVE 1
                  }
          }
if ("$zoneid" = "47") then
          {
              gosub MOVE 117
              gosub FERRYLOGIC
          }
if ("$zoneid" = "41") then if matchre("%detour", "(muspari|fornsted)") then
          {
              if matchre("fornsted","%detour") then
                  {
                      gosub MOVE 91
                      goto ARRIVED
                  }
              if matchre("muspari","%detour") then
                  {
                      gosub MOVE 91
                      gosub PASSPORT
                      gosub MOVE 160
                      gosub FERRYLOGIC
                  }
          }
if (("$zoneid" = "41") && matchre("%detour", "(rossman|lang|theren|rakash|el'bain|haven|zaulfung)")) then
          {
              gosub MOVE 53
              waitforre ^Just when it seems
              pause 0.5
              put #mapper reset
          }
if (("$zoneid" = "47") && matchre("muspari","%detour")) then
          {
              gosub MOVE 235
              goto ARRIVED
          }
if ("$zoneid" = "47") then
          {
              gosub MOVE 117
              gosub FERRYLOGIC
          }
if (("$zoneid" = "30") && matchre("%detour", "(rossman|lang|theren|rakash|muspari|fornsted|el'bain|mriss|merk|hara)")) then
          {
              if $Athletics.Ranks < %rossmannorth then
                  {
                      if %lirums < 140 then goto NOCOIN
                      gosub MOVE 99
                      gosub FERRYLOGIC
                  }
              if $Athletics.Ranks >= %rossmannorth then
                  {
                      gosub MOVE 174
                      gosub MOVE 29
                      gosub MOVE 48
                      if "%detour" = "rossman" then
                          {
                              gosub MOVE 22
                              goto ARRIVED
                          }
                      gosub MOVE 137
                  }
          }
if ("$zoneid" = "116") then
			{
			evalmath therencoin $circle*20
			if %dokoras < %therencoin then goto NOCOIN
			gosub MOVE 217
			}
if ("$zoneid" = "126") then
			{
			evalmath therencoin $circle*20
			if %dokoras < %therencoin then
				{
				gosub MOVE 49
				goto NOCOIN
				}
			gosub MOVE 103
			}
if ("$zoneid" = "127") then
			{
			evalmath therencoin $circle*20
			if %dokoras < %therencoin then
				{
				gosub MOVE 510
				gosub MOVE 49
				goto NOCOIN
				}
			gosub MOVE 363
			gosub JOINLOGIC
			}
# if matchre("rakash", "(?i)%detour" then goto ARRIVED
if ("$zoneid" = "40a") then gosub MOVE 125
if "$zoneid" = "42" && "%detour" != "theren" then gosub MOVE 2
if (("$zoneid" = "40") && ("%detour" = "rossman")) then
          {
              gosub MOVE 213
              gosub MOVE 22
              goto ARRIVED
          }
if (("$zoneid" = "40") && matchre("%detour", "(?i)(lang|rakash|el'bain|mriss|merk|hara)")) then
          {
              if ("%detour" = "el'bain") then
                  {
                      gosub MOVE 142
                      goto ARRIVED
                  }
              if ("%detour" = "lang") then
                  {
                      gosub MOVE 1
                      goto ARRIVED
                  }
              if ("%detour" = "rakash") then
                  {
                      gosub MOVE 263
                      gosub MOVE 96
                      goto ARRIVED
                  }
              if matchre("%detour", "(mriss|merk|hara)") then
                  {
                      gosub MOVE 305
                      gosub JOINLOGIC
                      goto QITRAVEL
                  }
          }
if (("$zoneid" = "40") && matchre("(haven|zaulfung|throne)","%detour")) then
          {
              if $Athletics.Ranks >= %rossmansouth then
                  {
                      gosub MOVE 213
                      gosub MOVE 15
                      gosub MOVE 46
                      gosub MOVE 1
                  }
              if $Athletics.Ranks < %rossmansouth then
                  {
                      if %lirums < 140 then goto NOCOIN
                      gosub MOVE 36
                      gosub FERRYLOGIC
                  }
          }
if (("$zoneid" = "40") && ("%detour" = "theren")) then gosub MOVE 211
if (("$zoneid" = "42") && ("%detour" = "theren")) then
          {
              gosub MOVE 56
              goto ARRIVED
          }
if (("$zoneid" = "40") && matchre("%detour", "(muspari|fornsted|hvaral)")) then
          {
              gosub MOVE 376
              waitforre ^Just when it seems
              pause
              put #mapper reset
          }
if ("$zoneid" = "41") && ("%detour" = "fornsted") then
          {
              gosub MOVE 91
              goto ARRIVED
          }
if ("$zoneid" = "41") && ("%detour" = "hvaral") then
          {
              gosub MOVE 91
              gosub PASSPORT
              gosub MOVE 145
              goto ARRIVED
          }
if ("$zoneid" = "41") && ("%detour" = "muspari") then
          {
              gosub MOVE 91
              gosub PASSPORT
              gosub MOVE 160
              gosub FERRYLOGIC
          }
if (("$zoneid" = "41") && matchre("%detour", "(rossman|lang|theren|rakash|el'bain|haven|zaulfung)")) then
          {
              gosub MOVE 53
              waitforre ^Just when
              pause
              put #mapper reset
          }
if (("$zoneid" = "30") && ("%detour" = "throne")) then
          {
              gosub MOVE throne city barge
              gosub FERRYLOGIC
              goto ARRIVED
          }
if (("$zoneid" = "30") && ("%detour" = "zaulfung")) then
          {
              gosub MOVE 203
              gosub MOVE 100
          }
if ("$zoneid" = "30") then
          {
              gosub MOVE 8
              goto ARRIVED
          }
goto ARRIVED
FORD:
var label FORD
if matchre("$zoneid", "(Hara'jaal|Mer'Kresh|M'Riss)") then
          {
              var backuplabel FORD
              var backupdetour %detour
              var detour mriss
              var tomainland 1
              goto QITRAVEL
          }
if "$zoneid" = "35" && "%detour" != "throne" then
          {
              if %lirums < 240 then goto NOCOIN
              gosub MOVE 166
              gosub FERRYLOGIC
              pause
          }
if ("$zoneid" = "47") then
          {
              gosub MOVE 117
              gosub FERRYLOGIC
          }
if ("$zoneid" = "41") then
          {
              gosub MOVE 53
              waitforre ^Just when it seems
              pause
              put #mapper reset
          }
if ("$zoneid" = "40a") then gosub MOVE 125
if ("$zoneid" = "42") then gosub MOVE 2
if (("$zoneid" = "40") && ($Athletics.Ranks >= %rossmansouth)) then gosub MOVE 213
if (("$zoneid" = "40") && ($Athletics.Ranks < %rossmansouth)) then
          {
		    evalmath boarneeded $circle*20
              if %lirums < %boarneeded then goto NOCOIN
              gosub MOVE 263
          }
if ("$zoneid" = "40a") then
			{
				evalmath boarneeded $circle*20
				if %lirums < %boarneeded then
					{
					gosub move 125
					goto NOCOIN
					}
				gosub MOVE 68
				gosub JOINLOGIC
				goto FORD_3
			}
if ("$zoneid" = "34a") then gosub MOVE 134
if ("$zoneid" = "34") then gosub MOVE 15
if ("$zoneid" = "33a") then gosub MOVE 46
if ("$zoneid" = "33") then gosub MOVE 1
if ("$zoneid" = "32") then gosub MOVE 1
if ("$zoneid" = "31") then gosub MOVE 1
if (("$zoneid" = "30") && ($Athletics.Ranks < %faldesu)) then
          {
              if %lirums < 140 then goto NOCOIN
              gosub MOVE 103
              pause
              gosub FERRYLOGIC
          }
if (("$zoneid" = "30") && ($Athletics.Ranks >= %faldesu)) then
          {
              gosub MOVE 203
              gosub MOVE 79
          }
if ("$zoneid" = "14c") then gosub MOVE 21
if ("$zoneid" = "13") then gosub MOVE 71
if ("$zoneid" = "4a") then gosub MOVE 15
if ("$zoneid" = "4") then gosub MOVE 14
if ("$zoneid" = "8") then gosub MOVE 43
if ("$zoneid" = "10") then gosub MOVE NTR
if ("$zoneid" = "9b") then gosub MOVE 9
if ("$zoneid" = "14b") then gosub MOVE 217
if ("$zoneid" = "11") then gosub MOVE 2
if ("$zoneid" = "7") then gosub MOVE 349
if ("$zoneid" = "1") then
          {
              if "$guild" = "Thief" then
                  {
                      if $Athletics.Ranks >= %undersegoltha then
                          {
                              gosub MOVE 650
                              gosub MOVE 23
                          }
                  }
              if $Athletics.Ranks >= %segoltha && "$zoneid" = "1" then
                  {
                      gosub MOVE 476
                      gosub MOVE 30
                  }
              if ("$zoneid" = "1") then
                  {
                      if %kronars < 100 then goto NOCOIN
                      gosub MOVE 236
                      gosub FERRYLOGIC
                  }
              pause
              put south
              wait
              put #mapper reset
          }
if ("$zoneid" = "50") then gosub MOVE 30
if ("$zoneid" = "60") then gosub MOVE 57
if ("$zoneid" = "58") then gosub MOVE 2
if (("$zoneid" = "61") && ("%detour" = "ain")) then gosub MOVE 126
if (("$zoneid" = "114") && ("%detour" != "ain")) then
          {
              if %dokoras < 120 then goto NOCOIN
              gosub MOVE 4
              gosub FERRYLOGIC
              gosub MOVEIT west
          }
if (("$zoneid" = "63") && ($Athletics.Ranks < %undergondola)) then
          {
              gosub MOVE 112
              gosub MOVE 100
              gosub MOVE 126
          }
if (("$zoneid" = "112") && ("$guild" = "Ranger") && ($Athletics.Ranks >= %undergondola)) then
          {
               put prep athlet 10
               pause 8
               put cast
          }
if (("$zoneid" = "112") && ("$guild" = "Thief") && ($Athletics.Ranks >= %undergondola)) then
          {
               put khri flight harrier
               pause
          }
if (("$zoneid" = "112") && ("%detour" = "ain")) then
          {
              if $Athletics.Ranks >= %undergondola then
                  {
                      gosub MOVE 112
                      gosub MOVE 130
                  }
              if $Athletics.Ranks < %undergondola then
                  {
                      if %dokoras < 120 then goto NOCOIN
                      gosub MOVE 98
                      gosub FERRYLOGIC
                  }
          }
if ("$zoneid" = "112") then gosub MOVE 112
if ("$zoneid" = "58") then gosub MOVE 2
if ("$zoneid" = "61") then gosub MOVE 130
if ("$zoneid" = "63") then gosub MOVE 112
if (("$zoneid" = "62") && ($Athletics.Ranks >= %undergondola)) then
          {
             gosub MOVE 41
             pause
             if (toupper("$game") = "DRF") then
                   {
                        put sw
                        pause 0.5
                        put sw
                        pause 0.7
                        put s
                        pause 0.5
                        gosub MOVE 153
                        goto FORD_2
                   }
             if (toupper("$game") = "DR") then
                   {
                        put sw
                        pause 0.5
                        put sw
                        pause 0.7
                        put go blockade
                        pause 0.8
                        pause 0.1
                        gosub MOVE 153
                        goto FORD_2
                   }
          }
if (toupper("$game") = "DR") && ("$zoneid" = "62") then
          {
              gosub MOVE 41
              put sw
              pause 0.5
              put sw
              pause 0.5
              put go blockade
              pause 0.8
              pause 0.1
              gosub MOVE 2
              gosub FERRYLOGIC
          }
if (toupper("$game") = "DRF") && ("$zoneid" = "62") then
          {
              gosub MOVE 41
              put sw
              pause 0.5
              pause
              put sw
              pause 0.5
              put s
              pause 0.5
              gosub MOVE 2
              gosub FERRYLOGIC
          }
FORD_2:
if ("$zoneid" = "65") then gosub MOVE 1
if ("$zoneid" = "68b") then gosub MOVE 44
if ("$zoneid" = "68a") then gosub MOVE 29
if (("$zoneid" = "68") && ("$guild" = "Thief")) then gosub MOVE 15
if (("$zoneid" = "68") && (%shardcitizen = "yes")) then
          {
              gosub MOVE 1
              gosub MOVE 129
          }
if (("$zoneid" = "68") && (%shardcitizen = "no")) then gosub MOVE 15
if (("$zoneid" = "67") && ("$guild" = "Thief")) then
          {
              gosub MOVE 566
              gosub MOVE 23
          }
if ("$zoneid" = "67a") then gosub MOVE STR
if ("$zoneid" = "67") then gosub MOVE 132
if ("$zoneid" = "66") then gosub MOVE 217
if ("$zoneid" = "69") then gosub MOVE 283
FORD_3:
if (("$zoneid" = "127") && matchre("%detour", "(raven|outer|inner|ain)")) then gosub MOVE 510
if (("$zoneid" = "126") && matchre("%detour", "(raven|outer|inner|ain)")) then gosub MOVE 49
if (("$zoneid" = "116") && matchre("%detour", "(raven|ain)")) then gosub MOVE 3
if (("$zoneid" = "123") && ("%detour" = "ain")) then
          {
              if %dokoras < 120 then goto NOCOIN
              gosub MOVE 174
              gosub FERRYLOGIC
          }
if (("$zoneid" = "123") && ("%detour" = "raven")) then
          {
              gosub MOVE 133
              goto ARRIVED
          }
if ("$zoneid" = "123") then gosub MOVE 169
if (("$zoneid" = "116") && ("%detour" = "outer")) then
          {
              gosub MOVE 225
              goto ARRIVED
          }
if (("$zoneid" = "116") && ("%detour" = "inner")) then
          {
              gosub MOVE 96
              goto ARRIVED
          }
if (("$zoneid" = "113") && ("$roomid" = "4")) then
          {
              gosub MOVEIT west
              waitforre ^Obvious
          }
if (("$zoneid" = "113") && ("$roomid" = "8")) then
          {
              gosub MOVEIT north
          }
if (("$zoneid" = "114") && ("%detour" = "ain")) then gosub MOVE 34
if ("$zoneid" = "116") then gosub MOVE 217
if ("$zoneid" = "126") then gosub MOVE 103
if ("$zoneid" = "127") then gosub MOVE 24
goto ARRIVED

AESRYBACK:
  pause 0.1
  pause 0.1
  var label AESRYBACK
  if ("$zoneid" = "98") then gosub MOVE 86
  gosub MOVE 427
  gosub JOINLOGIC
  return

QITRAVEL:
  pause 0.1
  pause 0.1
  var label QITRAVEL
  if !matchre("106|107|108","$zoneid") then goto therengia
  if (("$zoneid" = "108") && matchre("%detour", "(merk|hara)")) then
            {
                gosub MOVE 151
                if ("$roomid" != "151") then gosub MOVE 151
                gosub FERRYLOGIC
            }
  if (("$zoneid" = "107") && ("%detour" = "hara")) then
            {
                gosub MOVE 78
                gosub FERRYLOGIC
                gosub MOVE 173
            }
  if (("$zoneid" = "106") && matchre("%detour", "(merk|mriss)")) then
            {
                gosub MOVE 101
                gosub FERRYLOGIC
            }
  if (("$zoneid" = "107") && ("%detour" = "merk")) then
            {
                gosub MOVE 194
                goto ARRIVED
            }
  if (("$zoneid" = "107") && ("%detour" = "mriss")) then
            {
                gosub MOVE 113
                gosub FERRYLOGIC
            }
  if %tomainland then
            {
                gosub move 222
                var tomainland 0
                var label %backuplabel
                var detour %backupdetour
                gosub JOINLOGIC
                pause
                put #mapper reset
                goto %label
            }
  if (("$zoneid" = "108") && ("%detour" = "mriss")) then
            {
                gosub MOVE 150
                goto ARRIVED
            }

#####################################################################################
## ENGINE
ARRIVED:
     if_2 then gosub move %2 %3 %4
     echo
     echo      |\          .(' *) ' .
     echo      | \        ' .*) .'*
     echo      |(*\      .*(// .*) .
     echo      |___\       // (. '*
     echo      ((("'\     // '  * .
     echo      ((c'7')   /\)
     echo      ((((^))  /  \
     echo    .-')))(((-'   /
     echo       (((()) __/'
     echo        )))( |
     echo         (()
     echo          ))
     echo
  put #parse YOU ARRIVED!
  put #parse REACHED YOUR DESTINATION
  # put #play Just Arrived.wav
  echo ## WOW! YOU ARRIVED AT YOUR DESTINATION: %destination in %t seconds!  That's FAST! ##
  put #echo >Log Travel script arrival at: $zonename (map $zoneid: room $roomid)
  put #class arrive off
  exit
######################################################################################
PASSPORTCHECK:
  pause 0.2
  put get my passport
  pause 2
  if !matchre("$righthand $lefthand", "passport") then var passport 0
  if matchre("$righthand $lefthand", "passport") then var passport 1
  put stow passport
  pause 0.4
  return
FERRYLOGIC:
  if contains("(1|7|30|35|60|40|41|47|113|106|107|108|150)","$zoneid" then goto FERRY
  if matchre("$roomname", "Gondola") then
     {
         if matchre("%destination", "\b(acen?e?m?a?c?r?a?|cros?s?i?n?g?s?|xing?|knif?e?c?l?a?n?|tige?r?c?l?a?n?|dirg?e?|arth?e?d?a?l?e?|kaer?n?a?|ilay?a?t?a?i?p?|illa?y?a?t?a?i?p?a?|taipa|leth?d?e?r?i?e?l?|acen?a?m?a?c?r?a?|vipe?r?s?|guar?d?i?a?n?s?|leuc?r?o?s?|malod?o?r?o?u?s?|bucc?a?|dokt?|sorr?o?w?s?|misens?e?o?r?|beis?s?w?u?r?m?s?|ston?e?c?l?a?n?|bone?w?o?l?f?|germ?i?s?h?d?i?n?|alfr?e?n?s?|cara?v?a?n?s?a?r?y?|rive?r?h?a?v?e?n?|have?n?|ross?m?a?n?s?|ther?e?n?b?o?r?o?u?g?h?|lang?e?n?f?i?r?t?h?|el\'?b?a?i?n?s?|elb?a?i?n?s?|raka?s?h?|thro?n?e?|musp?a?r?i?|forn?s?t?e?d?|hvar?a?l?|zaul?f?u?n?g?|mri?s?s?|merk?r?e?s?h?|kre?s?h?|har?a?j?a?a?l?|rat?h?a?)\b") then
          {
               echo *** ON GONDOLA! - HEADING NORTH
               var direction north
               goto ONGONDOLA
          }
         if matchre("%destination", "\b(shar?d?|grani?t?e?|garg?o?y?l?e?|spir?e?|horse?c?l?a?n?|fayr?i?n?s?|steel?c?l?a?w?|cori?k?s?|ada?n?f?|ylo?n?o?|wyve?r?n?|aing?h?a?z?a?l?|rave?n?s?|hib?a?r?n?h?v?i?d?a?r?|out?e?r?|inne?r?|boar?c?l?a?n?|aes?r?y?|sur?l?a?e?n?i?s?|fan?g?|cov?e?)\b") then
          {
               echo *** ON GONDOLA! - HEADING SOUTH
               var direction south
               goto ONGONDOLA
          }
        if matchre("%destination", "\bgondola?\b") then goto ARRIVED
     }
  if ("$zoneid" = "66") then
        {
            var direction north
            goto GONDOLA
        }
  if ("$zoneid" = "62") then
        {
            var direction south
            goto GONDOLA
        }
  else goto NODESTINATION
GONDOLA:
  pause 0.1
  pause 0.1
  send look
  pause 2
  matchre ONGONDOLA \[Gondola\,
  if matchre ("$roomobjs","gondola") then send go gondola
  matchwait 2
  pause 7
  goto GONDOLA
ONGONDOLA:
  pause
  pause
  if ("%direction" = "north") && ($north = 1) then gosub MOVEIT north
  if ("%direction" = "south") && ($south = 1) then gosub MOVEIT south
GONDOLAWAIT:
  pause
  if ($out) then goto GONDOLAOUT
  waitforre ^With a soft
  if ($standing = 0) then gosub STAND
GONDOLAOUT:
  put look
  pause 0.8
  if ($out = 0) then goto GONDOLAWAIT
  gosub MOVEIT out
  pause
  put #mapper reset
  return
STOP_INVIS:
     delay 0.001
     if ("$guild" = "Necromancer") then
          {
               put release eotb
               pause 0.3
          }
     if ("$guild" = "Thief") then
          {
               put khri stop silence vanish
               pause 0.3
          }
     if ("$guild" = "Moon Mage") then
          {
               put release rf
               pause 0.3
          }
     pause 0.3
FERRY:
  pause 0.1
  if ($invisible) then goto STOP_INVIS
  pause 0.1
  matchre ONFERRY \[\"Her Opulence\"\]|\[\"Hodierna\'s Grace\"\]|\[\"Kertigen\'s Honor\"\]|\[\"His Daring Exploit\"\]|\[\"Northern Pride\"\, Main Deck\]|\[\"Theren\'s Star\"\, Deck\]|\[The Evening Star\]|\[The Damaris\' Kiss\]|\[A Birch Skiff\]|\[A Highly Polished Skiff\]|\[\"The Desert Wind\"\]|\[\"The Suncatcher\"\]|\[\"The Riverhawk\"\]|\[\"Imperial Glory\"\]\"Hodierna\'s Grace\"|\"Her Opulence\"\]|\[The Galley Cercorim\]|\[The Jolas\, Fore Deck\]|\[Aboard the Warship\, Gondola\]|\[The Halasa Selhin\, Main Deck\]
  matchre ONFERRY Long\, wide and low\, this vessel is built for utility\, but the hand of luxury can be discerned in the ornately carved walnut railings\, down-cushioned benches and the well polished deck
  matchre ONFERRY ^A few weary travelers lean against a railing at the bow of this ferry\, anxiously waiting to reach the opposite bank\.
  matchre ONFERRY ^The ferry rocks gently as you step aboard\. Surrounded by the cool\, briny air of the Segoltha\, you take your place on the deserted deck and gaze up into the night sky\.
  matchre ONFERRY ^Most of the passengers on this low riding barge have descended into quiet conversation\, not wishing to stir the night\. A single lantern, swinging from the fore rail\, pushes its dull gold rays across the dark water\.
  matchre ONFERRY ^This is the only barge of its type to ply the waters of Lake Gwenalion|^A white-washed wood railing surrounds the entire upper deck of the barge
  matchre ONFERRY ^The first of the massive barges to traverse Lake Gwenalion\, \"Theren\'s Star\" still maintains a quiet elegance despite its apparent age\.
  matchre ONFERRY ^Long and low\, the sleek lines of the ferry are designed so that it slips through the water with a minimum of disturbance\.
  matchre ONFERRY ^This particular skiff is roomy and solid with benches only slightly worn from use
  matchre ONFERRY ^The newly crafted skiff smells of fresh wood and paint\.
  matchre ONFERRY ^The warship (continues|rumbles)|^The din of battle abates as the Gnomish crew|^Sputtering loudly\, the cast\-iron stove
  matchre ONFERRY ^The resounding boom of a nearby cannon|^A flaming arrow narrowly misses the balloon|^Your ears are left ringing as the crew begins to fire the cannons|^Fang's Peak sinks below the southern horizon
  matchre ONFERRY ^The Desert Wind barge is made up of a wooden flatboat mounted atop steel rails
  matchre ONFERRY ^The deck of the wooden barge is mostly covered with tightly packed crates and barrels\, all tied down so as not to tumble about or fall overboard during the sometimes turbulent river journeys\.
  matchre ONFERRY ^A row of water-stained benches occupies the deck of the Imperial Glory\, where wealthy passengers can sit at ease and view the beautiful landscape\, rolling forests and a few sandy beaches\, of southern Therengia\.
  matchre ONFERRY ^The light bowl-shaped boat has a blue leather hide stretched tightly over its birch sapling frame
  matchre ONFERRY ^Flecks of foam spray through the air when the Jolas cuts through the waves\.
  matchre ONFERRY ^The deck is split down the middle by an open pit\, bracketed on each end by the two masts\.
  matchre ONFERRY ^Walking in this tiny area is difficult due to the litter of ropes\, some coiled and some stretching from the railings and belaying pins up into the maze of wood and canvas above\.
  matchre ONFERRY ^In anticipation of the sudden influx of passengers\, makeshift benches have been hastily constructed from kegs\, driftwood\, and nets stretched tight between boards\, then have been cleverly placed so that they are as out of the way as possible\.
  matchre ONFERRY ^Passengers and cargo crowd the deck of the sleek\, black galley\.
  matchre ONFERRY ^The light bowl-shaped boat has a new leathery hide stretched tightly over its birch sapling frame\.
  matchre ONFERRY ^The galley\, like its twin\, carries passengers and cargo\, but it can easily become a war galley\.
  matchre ONFERRY ^The bowsprit attached to the jib boom on the bow is rigged to hold three triangular foresails in front of the foremast\.
  matchre ONFERRY ^The length of this ferry is filled to capacity with travelers making their way to the opposite bank of the Segoltha
  matchre ONFERRY ^A few weary travelers lean against a railing at the bow of this ferry
  matchre ONFERRY ^Passengers and cargo crowd the deck of the sleek\, black galley\.|^The galley\, like its twin\, carries passengers and cargo\,|^Grease spewed from the galley
  matchre ONFERRY ^The Selhin ties off to the Uaro Dock\!
  matchre STOP_INVIS ^How do you expect the barge crew to let you onboard if they can't see you\?
  send look
  pause 0.5
  if matchre ("$roomobjs","Riverhawk") then send go riverhawk
  if matchre ("$roomobjs","Imperial") then send go imperial glory
  if matchre ("$roomobjs","Star") then send go ferry
  if matchre ("$roomobjs","skiff") then send go skiff
  if matchre ("$roomobjs","Kiss") then send go ferry
  if matchre ("$roomobjs","ferry") then send go ferry
  if matchre ("$roomobjs","barge") then send go barge
  if matchre ("$roomobjs","galley") then send go galley
  if matchre ("$roomobjs","Jolas") then send go jolas
  if matchre ("$roomobjs","Selhin") then send go selhin
  if matchre ("$roomobjs","warship") then send join warship
  matchwait 4
  if ($hidden = 0) then put hide
  pause 10
  echo ### Waiting for a transport..
  goto FERRY
ONFERRY:
  pause 0.1
  pause 0.1
  echo
  echo ### Riding on public transport. Final Destination: %destination
  echo
  send hide
  pause
  if ("$guild" = "Necromancer") then
     {
          if (($spellROC = 0) || ($spellEOTB = 0)) then gosub NECRO_PREP
     }
  if matchre ("$roomname","(Jolas|Selhin)") then goto shiploop
  matchre OFFTHERIDE dock and its crew ties the (ferry|barge) off\.|^You come to a very soft stop|^The skiff lightly taps|^The sand barge pulls into dock|^The barge pulls into dock|The crew ties it off and runs out the gangplank\.
  matchre OFFTHERIDE ^The warship lands with a creaky lurch|^The captain barks the order to tie off .+ to the docks\.
  matchwait

SHIPLOOP:
  pause 0.1
  pause 0.1
  matchre OFFTHERIDE ^The captain barks the order to tie off the Selhin to the docks\.
  matchre OFFTHERIDE ^The captain barks the order to tie off the Jolas to the docks\.
  matchwait 180
  put fatigue
  goto SHIPLOOP

OFFTHERIDE:
  put look
  pause 0.5
  if ($hidden = 1) then
     {
          put unhide
          pause 0.4
     }
  if ("$guild" = "Necromancer") then
     {
          if (($spellROC = 0) || ($spellEOTB = 0)) then gosub NECRO_PREP
     }
  pause 0.1
  pause 0.1
  if matchre ("$roomname","Jolas") then
    {
        pause 0.1
        if matchre ("$roomobjs","Sumilo") then put go dock
        if matchre ("$roomobjs","Wharf") then put go end
        pause
        put #mapper reset
        return
    }
  if ($standing = 0) then gosub STAND
  put go %offtransport
  pause
  put #mapper reset
  return

JOINLOGIC:
  pause 0.1
  pause 0.1
  matchre ONJOINED ^\[Aboard the Dirigible\, Gondola\]|^\[Alongside a Wizened Ranger\]|^An intricate network of silken rope|^\[Aboard the Balloon\, Gondola\]|^A veritable spiderweb of ropes secures|^Thick\, barnacle\-encrusted ropes secure the platform to the|\[Aboard the Mammoth\, Platform\]|\[The Bardess\' Fete\, Deck\]|^Silken rigging suspends the sweeping teak|\[Aboard the Warship\, Gondola\]
  put look
  wait
  pause
  if matchre("$roomobjs","airship") then put join airship
  if matchre("$roomobjs","dirigible") then put join dirigible;join dirigible
  if matchre("$roomobjs","balloon") then put join balloon;join balloon
  if matchre("$roomobjs","wizened ranger") then put join wizened ranger;join wizened ranger
  if (("$zoneid" = "58") && matchre("$roomobjs","tall sea mammoth")) then put join tall mammoth
  if (("$zoneid" = "90") && matchre("$roomobjs","massive sea mammoth")) then put join sea mammoth
  if ("$zoneid" = "150") then
        {
            if "%detour" = "fang" then goto ARRIVED
            if %toratha = 1 && matchre ("$roomobjs","massive sea mammoth") then put join sea mammoth
            if %toratha = 0 && matchre ("$roomobjs","tall sea mammoth") then put join tall mammoth
            if "%detour" = "hara" && matchre ("$roomobjs","warship") then put join warship
        }
  matchwait 5
  echo ### Waiting for a transport..
  pause 20
  goto joinlogic

ONJOINED:
  pause 0.1
  pause 0.1
  matchre OFFJOINED ^The grasses of this wide clearing|^From its northwest\-facing position|^A deep firepit has been hacked into the frozen earth|^The distance between the surrounding hills is narrower|^The ironwood platform has withstood|^A rickety platform in the top of this huge\,|^Beyond the harbor\, spray is thrown|^Giant boulders are scattered|^Crudely assembled yet sturdy just the|\[Fang Cove\, Dock\]|\[Smuggler\'s Wharf\]|\[Outside Muspar\'i\]|\[Northeast Wilds\, Grimsage Way\]|^The once pristine tower of the Warrior Mages
  matchwait
OFFJOINED:
  put look
  wait
  if matchre("$roomname", "Rocky Path") then put go beach
  pause
  put #mapper reset
  return

PASSPORT:
  gosub STOWING
  pause 0.3
  matchre RETURN ^You get|^You are already
  matchre NOPASSPORT ^What were you|^I could not
  send get my passport
  matchwait 5

NOPASSPORT:
  echo ### You don't have a Muspari Passport! Go back to Therenborough to get one.
  goto ARRIVED

NOCOIN:
  put #parse NO COINS!
  Echo ### You don't have enough coins to travel, you vagrant!  Trying to get coins from the nearest bank!!!
  pause 0.5
  put wealth
  pause
  if ("$zoneid" = "1") then
        {
            var currencyneeded kro
            gosub MOVE exchange
            gosub KRONARS
            if %kronars >= 120 then goto COIN.CONTINUE
            gosub MOVE teller
            if ($invisible = 1) then gosub stopinvis
            put withdraw 120 copper
            wait
        }
  if ("$zoneid" = "60") then gosub MOVE leth
  if ("$zoneid" = "61") then
        {
            var currencyneeded kro
            gosub MOVE 57
            gosub MOVE exchange
            gosub KRONARS
            if %kronars >= 120 then goto COIN.CONTINUE
            gosub MOVE teller
            if ($invisible = 1) then gosub stopinvis
            put withdraw 120 copper
            wait
        }
   if ("$zoneid" = "30") then
        {
            var currencyneeded lir
            gosub MOVE exchange
            gosub LIRUMS
            if %lirums >= 140 then goto COIN.CONTINUE
            gosub MOVE teller
            if ($invisible = 1) then gosub stopinvis
            put withdraw 140 copper
            wait
        }
   if ("$zoneid" = "7") then
        {
            var currencyneeded lir
            gosub MOVE 349
            gosub MOVE exchange
            gosub LIRUMS
            if %lirums >= 200 then goto COIN.CONTINUE
            gosub MOVE teller
            if ($invisible = 1) then gosub stopinvis
            put withdraw 200 copper
            wait
            pause 0.2
            gosub MOVE exchange
            pause 0.2
            put exchange 200 copper kronar for lirum
            wait
            pause 0.2
        }
    if ("$zoneid" = "40") then
        {
            var currencyneeded lirtoboar
            gosub MOVE 211
            gosub MOVE exchange
            gosub LIRUMS
            gosub MOVE teller
            if %lirums >= %boarneeded then goto COIN.CONTINUE
            if ($invisible = 1) then gosub stopinvis
            if matchre ("%detour", "(mriss|merk|hara)") then
                {
                    var currencyneeded qi
                    put withdraw 10 gold
                }
            else put withdraw %boarneeded copper
            wait
        }
    if (("$zoneid" = "113") && ("$roomid" = "4")) then gosub MOVE 10
    if (("$zoneid" = "113") && ("$roomid" = "9")) then gosub MOVE 8
    if ("$zoneid" = "114") then
        {
            var currencyneeded dok
            gosub MOVE exchange
            gosub DOKORAS
            if %dokoras > 120 then goto COIN.CONTINUE
            gosub MOVE teller
            if ($invisible = 1) then gosub stopinvis
            put withdraw 120 copper
            wait
        }
    if (("$zoneid" = "113") && ("$roomid" = "6")) then gosub MOVE 7
    if ("$zoneid" = "123") then gosub MOVE hibar
    if (("$zoneid" = "116") && matchre("%detour", "(rossman|lang|theren|rakash|muspari|fornsted|el'bain|mriss|merk|hara)")) then
        {
            var currencyneeded doktotheren
            gosub MOVE exchange
            gosub DOKORAS
            if  %dokoras > %therencoin then goto COIN.CONTINUE
            gosub MOVE teller
            if ($invisible = 1) then gosub stopinvis
		  put withdraw %therencoin copper
            wait
        }
	if (("$zoneid" = "116") && !matchre("%detour", "(rossman|lang|theren|rakash|muspari|fornsted|el'bain|mriss|merk|hara)")) then
        {
            var currencyneeded dok
            gosub MOVE exchange
            gosub DOKORAS
            if %dokoras > 120 then goto COIN.CONTINUE
            gosub MOVE teller
            if ($invisible = 1) then gosub stopinvis
            put withdraw 120 copper
            wait
        }
     if (("$zoneid" = "113") && ("$roomid" = "1")) then gosub MOVE 5
     if ("$zoneid" = "112") then
        {
            var currencyneeded dok
            gosub MOVE exchange
            gosub DOKORAS
            if %dokoras > 120 then goto COIN.CONTINUE
            gosub MOVE teller
            if ($invisible = 1) then gosub stopinvis
            put withdraw 120 copper
            wait
        }
    if (("$zoneid" = "67") && ("%detour" = "aesry")) then
        {
            var currencyneeded aesry
            gosub MOVE teller
            if ($invisible = 1) then gosub stopinvis
            if ("$game" = "DR") then put withdraw 10 gold
            if ("$game" = "DRF") then
               {
                    var currencyneeded lir
                    put withdraw 5 silver
                    wait
                    gosub MOVE exchange
                    put exchange all dok to lirum
               }
            pause
        }
	if (("$zoneid" = "67") && !matchre("(rossman|lang|theren|rakash|muspari|fornsted|el'bain|mriss|merk|hara|cross|river|haven|arthe|kaerna|stone|sorrow|throne|hvaral)","%detour")) then
        {
            var currencyneeded kro
            gosub MOVE exchange
            gosub DOKORAS
            gosub MOVE teller
            if ($invisible = 1) then gosub stopinvis
            put withdraw 300 copper
            wait
            gosub MOVE exchange
            pause 0.3
            put exchang 50 copper dok to kro
            wait
            pause 0.5
            if matchre("(rossman|lang|theren|rakash|muspari|fornsted|el'bain|mriss|merk|hara|river|haven|arthe|kaerna|stone|sorrow|throne|hvaral)","%detour") then put exchang 250 copper dok to lir
            pause 0.5
        }
    if ("$zoneid" = "99") then
        {
            var currencyneeded aesryback
            gosub MOVE teller
            if ($invisible = 1) then gosub stopinvis
            put withdraw 10 gold
        }
    if ("$zoneid" = "107") then
        {
            var currencyneeded lir
            gosub MOVE teller
            if ($invisible = 1) then gosub stopinvis
            put withdraw 140 copper
        }
    if ("$zoneid" = "108") then
        {
            ECHO ## YOU ARE ON MRISS WITH NO COINS!  YOU NEED TO FIND A FRIEND, OR KILL STUFF TO SELL HIDES OR GEMS!
            exit
        }
    put wealth
    waitforre Dokoras
    pause 0.5
    if "%currencyneeded" = "kro" && %kronars < 50 then goto COINQUIT
    if "%currencyneeded" = "lirtoboar" && %lirums < %boarneeded then goto COINQUIT
    if "%currencyneeded" = "lir" && %lirums < 70 then goto COINQUIT
    if "%currencyneeded" = "dok" && %dokoras < 60 then goto COINQUIT
    if "%currencyneeded" = "doktotheren" && %dokoras < %therencoin then goto COINQUIT
    if "%currencyneeded" = "aesry" && %dokoras < 10000 then goto COINQUIT
    if "%currencyneeded" = "aesryback" && %lirums < 10000 then goto COINQUIT
    if "%currencyneeded" = "qi" && %lirums < 10000 then goto COINQUIT
    put #echo >Log Green You withdrew some money to ride the ferry from Zone $zonename!
    ECHO YOU HAD MONEY IN THE BANK, LET'S TRY THIS AGAIN!
    pause
    goto %label
COIN.CONTINUE:
    put #echo >Log Green You exchanged some money to ride the ferry from Zone $zonename!
    ECHO YOU EXCHANGED SOME MONIES, LET'S TRY THIS AGAIN!
    pause
    goto %label
COINQUIT:
    echo YOU DIDN'T HAVE ENOUGH MONEY IN THE BANK TO RIDE PUBLIC TRANSPORT.
    echo EITHER GET MORE ATHLETICS, OR MORE MONEY, FKING NOOB!
    put #echo >Log Red Travel Script Aborted! No money in bank to ride ferry in $zonename!
    put #parse OUT OF MONEY!
    exit
LIRUMS:
     var Target.Currency LIRUMS
     if ("%kronars" != "0") then gosub EXCHANGE KRONARS
     if ("%dokoras" != "0") then gosub EXCHANGE DOKORAS
     goto EXCHANGE.FINISH
KRONARS:
     var Target.Currency KRONARS
     if ("%lirums" != "0" then gosub EXCHANGE LIRUMS
     if ("%dokoras" != "0" then gosub EXCHANGE DOKORAS
     goto EXCHANGE.FINISH
DOKORAS:
     var Target.Currency DOKORAS
     if ("%kronars" != "0" then gosub EXCHANGE KRONARS
     if ("%lirums" != "0" then gosub EXCHANGE LIRUMS
     goto EXCHANGE.FINISH
EXCHANGE:
     var Coin $0
EXCHANGE.CONTINUE:
     pause 0.1
     matchre EXCHANGE.CONTINUE ^\.\.\.wait\s+\d+\s+sec(?:onds?|s)?\.?|^Sorry\,
     matchre EXCHANGE.FINISH ^You hand your money to the money-changer\.\s*After collecting a.* fee, .* hands you .*\.
     matchre EXCHANGE.FINISH Enjoy the holiday, friend\!
     matchre EXCHANGE.FINISH ^The money-changer says crossly, \"A transaction that small isn't worth my time\.\s*The minimum is one bronze or ten coppers\.\"
     matchre EXCHANGE.FINISH ^You count out all of your .* and drop them in the proper jar\.\s*After figuring a .* fee in the ledger beside the jar\, you reach into the one filled with .* and withdraw .*\.
     matchre EXCHANGE.FINISH ^One of the guards mutters\, \"None of that\, $charactername\.\s*You'd be lucky to get anything at all with an exchange that small\.\"
     matchre EXCHANGE.FINISH ^But you don't have any .*\.
     matchre EXCH.INVIS ^How can you exchange money when you can't be seen\?
     matchre EXCHANGE.SMALLER transactions larger than a thousand
     matchre EXCHANGE.FINISH ^There is no money-changer here\.
     put EXCHANGE ALL %Coin FOR %Target.Currency
     matchwait
EXCHANGE.SMALLER:
     pause 0.1
     pause 0.1
     matchre EXCHANGE.SMALLER ^\.\.\.wait\s+\d+\s+sec(?:onds?|s)?\.?|^Sorry\,
     matchre EXCHANGE.SMALLER ^You hand your .* to the money-changer\.\s*After collecting a.* fee, .* hands you .*\.
     matchre RETURN ^The money-changer says crossly, \"A transaction that small isn't worth my time\.\s*The minimum is one bronze or ten coppers\.\"
     matchre RETURN ^One of the guards mutters\, \"None of that\, $charactername\.\s*You'd be lucky to get anything at all with an exchange that small\.\"
     matchre EXCH.INVIS ^How can you exchange money when you can't be seen\?
     matchre EXCHANGE.CONTINUE Enjoy the holiday, friend\!
     matchre EXCHANGE.CONTINUE ^You count out all of your .* and drop them in the proper jar\.\s*After figuring a .* fee in the ledger beside the jar\, you reach into the one filled with .* and withdraw .*\.
     matchre EXCHANGE.CONTINUE ^But you don't have any .*\.
     matchre EXCHANGE.CONTINUE ^You don't have that many
     matchre EXCHANGE.FINISH ^There is no money-changer here\.
     put EXCHANGE 1000 plat %Coin FOR %Target.Currency
     matchwait
EXCHANGE.FINISH:
     pause 0.001
     put wealth
     pause 0.5
     RETURN
EXCH.INVIS:
     pause 0.1
     send hum scale
     pause 0.5
     send stop hum
     pause 0.1
     goto EXCHANGE.CONTINUE

## Stow
STOWING:
     delay 0.0001
     var LOCATION STOWING
     if "$righthand" = "vine" then put drop vine
     if "$lefthand" = "vine" then put drop vine
     if "$righthandnoun" = "rope" then put coil my rope
     if "$righthand" = "bundle" || "$lefthand" = "bundle" then put wear bund;drop bun
     #if matchre("$righthandnoun","(crossbow|bow|short bow)") then gosub unload
     if matchre("$righthandnoun","(block|granite block)") then put drop block
     if matchre("$lefthandnoun","(block|granite block)") then put drop block
     if matchre("$righthand","(partisan|shield|buckler|lumpy bundle|halberd|staff|longbow|khuj)") then gosub wear my $1
     if matchre("$lefthand","(partisan|shield|buckler|lumpy bundle|halberd|staff|longbow|khuj)") then gosub wear my $1
     if matchre("$lefthand","(longbow|khuj)") then gosub stow my $1 in my %SHEATH
     if "$righthand" != "Empty" then GOSUB STOW right
     if "$lefthand" != "Empty" then GOSUB STOW left
     RETURN
STOW:
     var todo $0
STOW1:
     delay 0.0001
     var LOCATION STOW1
     if "$righthand" = "vine" then put drop vine
     if "$lefthand" = "vine" then put drop vine
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre WEBBED ^You can't do that while entangled in a web
     matchre STUNNED ^You are still stunned
     matchre STOW2 not designed to carry anything|any more room|no matter how you arrange|^That's too heavy|too thick|too long|too wide|^But that's closed|I can't find your container|^You can't
     matchre RETURN ^Wear what\?|^Stow what\?  Type 'STOW HELP' for details\.
     matchre RETURN ^You put
     matchre RETURN ^You open
     matchre RETURN needs to be
     matchre RETURN ^You stop as you realize
     matchre RETURN ^But that is already in your inventory\.
     matchre RETURN ^That can't be picked up
     matchre LOCATION.unload ^You should unload the
     matchre LOCATION.unload ^You need to unload the
     put stow %todo
     matchwait 15
     put #echo >$Log Crimson $datetime *** MISSING MATCH IN STOW! ***
     put #echo >$Log Crimson $datetime Stow = %todo
     put #log $datetime MISSING MATCH IN STOW (base.inc)
STOW2:
     delay 0.0001
     var LOCATION STOW2
     matchre RETURN ^Wear what\?|^Stow what\?
     matchre RETURN ^You put
     matchre RETURN ^But that is already in your inventory\.
     matchre stow3 any more room|no matter how you arrange|^That's too heavy|too thick|too long|too wide|not designed to carry anything|^But that's closed
     matchre LOCATION.unload ^You should unload the
     matchre LOCATION.unload ^You need to unload the
     put stow %todo in my pack
     matchwait 15
     put #echo >$Log Crimson $datetime *** MISSING MATCH IN STOW2! ***
     put #echo >$Log Crimson $datetime Stow = %todo
     put #log $datetime MISSING MATCH IN STOW2 (base.inc)
STOW3:
     delay 0.0001
     var LOCATION STOW3
     if "$lefthandnoun" = "bundle" then put drop bun
     if "$righthandnoun" = "bundle" then put drop bun
     matchre open.thing ^But that's closed
     matchre RETURN ^Wear what\?|^Stow what\?
     matchre RETURN ^You put
     matchre RETURN ^But that is already in your inventory\.
     matchre STOW4 any more room|no matter how you arrange|^That's too heavy|too thick|too long|too wide|not designed to carry anything|^But that's closed
     matchre LOCATION.unload ^You should unload the
     matchre LOCATION.unload ^You need to unload the
     put stow %todo in my backpack
     matchwait 15
     put #echo >$Log Crimson $datetime *** MISSING MATCH IN STOW3! ***
     put #echo >$Log Crimson $datetime Stow = %todo
     put #log $datetime MISSING MATCH IN STOW3 (base.inc)
STOW4:
     delay 0.0001
     var LOCATION STOW4
     if "$lefthandnoun" = "bundle" then put drop bun
     if "$righthandnoun" = "bundle" then put drop bun
     matchre open.thing ^But that's closed
     matchre RETURN ^Wear what\?|^Stow what\?
     matchre RETURN ^You put your
     matchre RETURN ^But that is already in your inventory\.
     matchre REM.WEAR any more room|no matter how you arrange|^That's too heavy|too thick|too long|too wide
     matchre LOCATION.unload ^You should unload the
     matchre LOCATION.unload ^You need to unload the
     put stow %todo in my haversack
     matchwait 15
     put #echo >$Log Crimson $datetime *** MISSING MATCH IN STOW4! (base.inc) ***
     put #echo >$Log Crimson $datetime Stow = %todo
     put #log $datetime MISSING MATCH IN STOW4 (base.inc)
OPEN.THING:
     put open back
     put open hav
     pause 0.2
     goto STOWING
REM.WEAR:
     put rem bund
     put drop bund
     wait
     pause 0.5
     goto WEAR1

## Movement
MOVE.RETRY:
  math move.retry add 1
  if %move.retry > 3 then goto move.fail
  pause 0.2
  pause 0.1
  echo *** Move Failed...
  echo *** Retrying move to $1 $2 in %move.retry second(s).
  echo ***
  pause %move.retry
  goto MOVE.GOTO
MOVE:
  delay 0.0001
  var move.skip 0
  var move.retry 0
  var move.fail 0
  var move.room $0
MOVE.GOTO:
  #gosub retreat
  matchre MOVE.GOTO ^\.\.\.wait|^Sorry\,
  matchre MOVE.RETURN ^You are already traveling
  matchre MOVE.RETURN ^YOU HAVE ARRIVED
  matchre MOVE.RETURN ^Darkness settles like a thick cloak
  matchre MOVE.SKIP ^SHOP CLOSED
  matchre MOVE.RETRY ^MOVE FAILED
  matchre MOVE.FAIL ^DESTINATION NOT FOUND
  matchre MOVE.RETRY ^You will have to climb that\.
  matchre MOVE.RETRY ^You can't go
  matchre MOVE.RETRY ^You're still recovering from your recent attack\.
  matchre MOVE.RETREAT ^You are engaged
  matchre MOVE.RETREAT ^You can't do that while engaged\!
  put #goto %move.room
  matchwait
MOVE.FAIL:
  var move.fail 1
  pause 0.1
  pause 0.1
  goto MOVE.RETURN
MOVE.RETREAT:
  pause 0.1
  gosub RETREAT
  pause 0.1
  goto MOVE.RETRY
MOVE.SKIP:
  var move.skip 1
RETREAT:
  pause 0.1
  pause 0.1
  send retreat;retreat
  pause 0.1
  pause 0.1
  RETURN
MOVE.RETURN:
  pause 0.001
  pause 0.1
  pause 0.1
  #put #mapper reset
  RETURN
RETURN:
  delay 0.001
  pause 0.001
  RETURN

MOVE_RANDOM:
     delay 0.0001
     random 1 13
     if (%r = 1) && (!$north) then goto MOVE_RANDOM
     if (%r = 2) && (!$northeast) then goto MOVE_RANDOM
     if (%r = 3) && (!$east) then goto MOVE_RANDOM
     if (%r = 4) && (!$southeast) then goto MOVE_RANDOM
     if (%r = 5) && (!$south) then goto MOVE_RANDOM
     if (%r = 6) && (!$southwest) then goto MOVE_RANDOM
     if (%r = 7) && (!$west) then goto MOVE_RANDOM
     if (%r = 8) && (!$northwest) then goto MOVE_RANDOM
     if (%r = 9) && (!$out) then goto MOVE_RANDOM
     if (%r = 10) && (!$up) then goto MOVE_RANDOM
     if (%r = 11) && (!$down) then goto MOVE_RANDOM
     if (%r = 12) && !matchre("$roomobjs","doorway|door") then goto MOVE_RANDOM
     if (%r = 13) && !matchre("$roomobjs","archway|arch") then goto MOVE_RANDOM
     #
     if (%r = 1) then var Direction north
     if (%r = 2) then var Direction northeast
     if (%r = 3) then var Direction east
     if (%r = 4) then var Direction southeast
     if (%r = 5) then var Direction south
     if (%r = 6) then var Direction southwest
     if (%r = 7) then var Direction west
     if (%r = 8) then var Direction northwest
     if (%r = 9) then var Direction out
     if (%r = 10) then var Direction up
     if (%r = 11) then var Direction down
     if (%r = 12) then var Direction go door
     if (%r = 13) then var Direction go arch
     #
     if (%r = 1) then var Reverse.Direction south
     if (%r = 2) then var Reverse.Direction southwest
     if (%r = 3) then var Reverse.Direction west
     if (%r = 4) then var Reverse.Direction northwest
     if (%r = 5) then var Reverse.Direction north
     if (%r = 6) then var Reverse.Direction northeast
     if (%r = 7) then var Reverse.Direction east
     if (%r = 8) then var Reverse.Direction southeast
     if (%r = 9) then var Reverse.Direction out
     if (%r = 10) then var Reverse.Direction down
     if (%r = 11) then var Reverse.Direction up
     if (%r = 12) then var Reverse.Direction go door
     if (%r = 13) then var Reverse.Direction go arch
     #
     var Exits 0
     if ($north) then math Exits add 1
     if ($northeast) then math Exits add 1
     if ($east) then math Exits add 1
     if ($southeast) then math Exits add 1
     if ($south) then math Exits add 1
     if ($southwest) then math Exits add 1
     if ($west) then math Exits add 1
     if ($out) then math Exits add 1
     if ($up) then math Exits add 1
     if ($down) then math Exits add 1
     if matchre("$roomobjs","doorway|door") then math Exits add 1
     if matchre("$roomobjs","archway|arch") then math Exits add 1
     #
     # don't move "back" on a path unless we'we hit a dead end
     if (%Exits > 1) && ("%Last.Direction" = "%Reverse.Direction") then goto MOVE_RANDOM
     #
     var Last.Direction %Direction
     gosub MOVE_RESUME
     RETURN

MOVEIT:
     delay 0.0001
     var Direction $0
     var movefailCounter 0
MOVE_RESUME:
     matchre MOVE_RESUME ^\.\.\.wait|^Sorry\,
     matchre MOVE_RESUME ^You make your way up the .*\.\s*Partway up\, you make the mistake of looking down\.\s*Struck by vertigo\, you cling to the .* for a few moments\, then slowly climb back down\.
     matchre MOVE_RESUME ^You pick your way up the .*\, but reach a point where your footing is questionable\.\s*Reluctantly\, you climb back down\.
     matchre MOVE_RESUME ^You approach the .*\, but the steepness is intimidating\.
     matchre MOVE_RESUME ^You struggle
     matchre MOVE_RESUME ^You blunder
     matchre MOVE_RESUME ^You wander
     matchre MOVE_RESUME ^You turn
     matchre MOVE_RESUME ^You are already
     matchre MOVE_RESUME ^You slap
     matchre MOVE_RESUME ^You work
     matchre MOVE_RESUME make much headway
     matchre MOVE_RESUME ^You flounder around in the water\.
     matchre MOVE_RETREAT ^You are engaged to .*\!|^You cannot do that while engaged
     matchre MOVE_STAND ^You start up the .*\, but slip after a few feet and fall to the ground\!\s*You are unharmed but feel foolish\.
     matchre MOVE_STAND ^Running heedlessly over the rough terrain\, you trip over an exposed root and land face first in the dirt\.
     matchre MOVE_STAND ^You can't do that while lying down\.
     matchre MOVE_STAND ^You can't do that while sitting\!
     matchre MOVE_STAND ^You must be standing to do that\.
     matchre MOVE_STAND ^You must stand first\.
     matchre MOVE_STAND ^Stand up first.
     matchre MOVE_DIG ^You make no progress in the mud \-\- mostly just shifting of your weight from one side to the other\.
     matchre MOVE_DIG ^You find yourself stuck in the mud\, unable to move much at all after your pathetic attempts\.
     matchre MOVE_DIG ^You struggle forward\, managing a few steps before ultimately falling short of your goal\.
     matchre MOVE_DIG ^Like a blind\, lame duck\, you wallow in the mud in a feeble attempt at forward motion\.
     matchre MOVE_DIG ^The mud holds you tightly\, preventing you from making much headway\.
     matchre MOVE_DIG ^You fall into the mud with a loud \*SPLUT\*\.
     matchre MOVE_FAILED ^You can't go there
     matchre MOVE_FAILED ^I could not find what you were referring to\.
     matchre MOVE_FAILED ^What were you referring to\?
     matchre MOVE_END ^It's pitch dark
     matchre MOVE_END ^Obvious
     send %Direction
     matchwait
MOVE_STAND:
     pause 0.1
     matchre MOVE_STAND ^\.\.\.wait|^Sorry\,
     matchre MOVE_STAND ^You are overburdened and cannot manage to stand\.
     matchre MOVE_STAND ^The weight
     matchre MOVE_STAND ^You try
     matchre MOVE_RETREAT ^You are already standing\.
     matchre MOVE_RETREAT ^You stand(?:\s*back)? up\.
     matchre MOVE_RETREAT ^You stand up\.
     matchre MOVE_RETREAT ^You stand up in the water
     send stand
     matchwait
MOVE_RETREAT:
     pause 0.1
     matchre MOVE_RETREAT ^\.\.\.wait|^Sorry\,
     matchre MOVE_RETREAT ^You retreat back to pole range\.
     matchre MOVE_RETREAT ^You try to back away
     matchre MOVE_STAND ^You must stand first\.
     matchre MOVE_RESUME ^You retreat from combat\.
     matchre MOVE_RESUME ^You are already as far away as you can get\!
     send retreat
     matchwait
MOVE_DIG:
     pause 0.1
     matchre MOVE_DIG ^\.\.\.wait|^Sorry\,
     matchre MOVE_DIG ^You struggle to dig off the thick mud caked around your legs\.
     matchre MOVE_STAND ^You manage to dig enough mud away from your legs to assist your movements\.
     matchre MOVE_DIG_STAND ^Maybe you can reach better that way\, but you'll need to stand up for that to really do you any good\.
     matchre MOVE_RESUME ^You will have to kneel
     send dig
     matchwait
MOVE_DIG_STAND:
     pause 0.1
     matchre MOVE_DIG_STAND ^\.\.\.wait|^Sorry\,
     matchre MOVE_DIG_STAND ^The weight
     matchre MOVE_DIG_STAND ^You try
     matchre MOVE_DIG_STAND ^You are overburdened and cannot manage to stand\.
     matchre MOVE_DIG ^You stand(?:\s*back)? up\.
     matchre MOVE_DIG ^You are already standing\.
     matchre MOVE_DIG ^You stand up in the water
     send stand
     matchwait
MOVE_FAILED:
     evalmath movefailCounter (movefailCounter + 1)
     if (%movefailCounter > 3) then goto MOVE_FAIL_BAIL
     pause 0.5
     goto MOVE_RESUME
MOVE_FAIL_BAIL:
     put #echo
     put #echo >$Log Crimson *** MOVE FAILED. ***
     put #echo Crimson *** MOVE FAILED.  ***
     put #echo
     put #parse MOVE FAILED
     RETURN
MOVE_END:
     pause 0.0001
     RETURN
STAND:
     delay 0.0001
     var LOCATION STAND_1
     STAND_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre WAIT ^Roundtime\:?|^\[Roundtime\:?|^\(Roundtime\:?
     matchre WAIT ^The weight of all your possessions prevents you from standing\.
     matchre WAIT ^You are overburdened and cannot manage to stand\.
     matchre STUNNED ^You are still stunned
     matchre WEBBED ^You can't do that while entangled in a web
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre STAND_RETURN ^You stand (?:back )?up\.
     matchre STAND_RETURN ^You stand up in the water
     matchre STAND_RETURN ^You are already standing\.
     send stand
     matchwait
     STAND_RETURN:
     pause 0.1
     pause 0.1
     if (!$standing) then goto STAND
     return
NECRO_PREP:
     if ("$guild" != "Necromancer") then return
     var donotcastlist The Crossing, Western Gate|Northeast Wilds, Outside Northeast Gate
     pause 0.1
     if ($spellEOTB = 0) then gosub EOTB
     if ($SpellTimer.EyesoftheBlind.active = 0) then gosub EOTB
     if ($SpellTimer.RiteofContrition.active = 0) then gosub ROC
     return
JUSTICE_CHECK:
     pause 0.001
     matchre NECRO_KNOWN sorcerer|monster|necromancer
     matchre NECRO_UNKNOWN You|You\'re
     send justice
     matchwait 8
     goto NECRO_KNOWN
NECRO_KNOWN:
     var Necro.Known 1
     echo * KNOWN AS A NECRO!
     return
NECRO_UNKNOWN:
     var Necro.Known 0
     echo * NOT KNOWN AS A NECRO
     return
ROC:
     var ROCLoop 0
     var NecroPrep ROC
ROC_1:
     math ROCLoop add 1
     # if matchre("%spelltimer", "Liturgy") && ($Utility.Ranks >= 800) then var NecroPrep ROG
     if (%ROCLoop > 1) then var NecroPrep ROC
     if (($spellROC = 1) && ("%NecroPrep" = "ROC")) then goto NECRO.DONE
     # if (($spellROG = 1) && ("%NecroPrep" = "ROG")) then goto NECRO.DONE
     echo **** Prepping %NecroPrep ****
     pause 0.1
     if ("$preparedspell" != "None") then send release spell
     pause 0.3
     if (((matchre("$roomobjs", "exchange board")) || (matchre("$roomname", "([T|t]eller|[E|e]xchange|[B|b]ank)")) || (matchre("$roomname", "(%donotcastlist)"))) then
          {
               echo *** BAD ROOM
               return
          }
     # gosub NECRO.CHECKROOM
     if ($Utility.Ranks < 40) then var NecroMana 2
     if ($Utility.Ranks >= 40) && ($Utility.Ranks < 120) then var NecroMana 5
     if ($Utility.Ranks >= 120) && ($Utility.Ranks < 240) then var NecroMana 7
     if ($Utility.Ranks >= 240) && ($Utility.Ranks < 400) then var NecroMana 8
     if ($Utility.Ranks >= 400) && ($Utility.Ranks < 550) then var NecroMana 10
     if ($Utility.Ranks >= 550) && ($Utility.Ranks < 800) then var NecroMana 15
     if ($Utility.Ranks >= 800) then var NecroMana 20
     pause 0.2
     put prep %NecroPrep %NecroMana
     pause 17
     if ((!("$roomplayers" = "")) && (matchre("$preparedspell", "(Rite of Contrition|Eyes of the Blind)")) then gosub moveRandomDirection
     put cast
     pause 0.6
     pause 0.3
     matchre ROC_1 ivory mask|bone structure beneath is subtly altered|gleaming with arcane power|mutative nervous system|whitened ridges|black mist|sheath of spell\-disrupting miasma|sensitive eye\-cysts
     matchre ROC_RETURN You are
     put look $charactername
     matchwait 2
ROC_RETURN:
     if (($spellROC = 0) && ($spellROG = 0) && (ROCLoop < 3)) then goto ROC_1
     var ROCLoop 0
     return
EOTB:
     var EOTBLoop 0
EOTB_1:
     if (($spellEOTB = 1) && ($invisible = 1)) then goto NECRO.DONE
     pause 0.1
     echo  **** Prepping EOTB ****
     if ("$preparedspell" != "None") then send release spell
     pause 0.3
     ## ** Waits for invis pulse or casts the spell if invisible is off..
     pause 0.1
     if (($spellEOTB = 1) && ($invisible = 0)) then
          {
               ## ** This return is slightly different, it will not wait for pulse inside the exchange.
               ## ** It will also not wait for a pulse if destination = exchange, account or any teller trips to the exchange when moving areas.
               ## ** It should wait for a pulse inside the teller if going anywhere else.
               if (((matchre("$roomobjs", "exchange rate board")) || (matchre("$roomname", "([T|t]eller|[E|e]xchange|[B|b]ank)")) || (matchre("$roomname", "(%donotcastlist)"))) && ((matchre("$roomname", "([T|t]eller|[E|e]xchange|[B|b]ank)")) && (matchre("%Destination", "(teller|exchange)")))) then return
               matchre EOTB_1 ^Your spell subtly|^Your corruptive mutation fades
               matchwait 30
               put #echo >log Red *** Error with EOTB not pulsing invis. Attempting to recast.
          }
     if ($invisible = 1) then return
     ## ** If script made it to this section then EOTB must be recast.
     ## ** This will not cast while inside the bank or any other unapproved rooms.
     if (((matchre("$roomobjs", "exchange rate board")) || (matchre("$roomname", "([T|t]eller|[E|e]xchange|[B|b]ank)")) || (matchre("$roomname", "(%donotcastlist)"))) then return
     if ($stamina < 30) then return
     # gosub NECRO.CHECKROOM
     if ($Utility.Ranks < 40) then var NecroMana 2
     if ($Utility.Ranks >= 40) && ($Utility.Ranks < 120) then var NecroMana 5
     if ($Utility.Ranks >= 120) && ($Utility.Ranks < 240) then var NecroMana 7
     if ($Utility.Ranks >= 240) && ($Utility.Ranks < 400) then var NecroMana 8
     if ($Utility.Ranks >= 400) && ($Utility.Ranks < 500) then var NecroMana 10
     if ($Utility.Ranks >= 500) && ($Utility.Ranks < 700) then var NecroMana 12
     if ($Utility.Ranks >= 700) then var NecroMana 20
     pause 0.4
     put prep EOTB %NecroMana
     pause 16
     put cast
     pause 0.5
     if (($spellEOTB = 0) && (EOTBLoop < 3)) then goto EOTB_1
     var EOTBLoop 0
     return
NECRO.DONE:
     delay 0.0001
     return
NECRO.CHECKROOM:
     pause 0.01
     pause 0.01
     pause 0.01
     if !("$roomplayers" = "") then gosub moveRandomDirection
     send search
     pause $roundtime
     pause 0.5
     if !("$roomplayers" = "") then gosub moveRandomDirection
     echo **** FOUND EMPTY ROOM! ***
     return
moveRandomDirection:
     var moveloop 0
     moveRandomDirection_2:
     math moveloop add 1
     if (matchre("$roomobjs","thick fog") || matchre("$roomexits","thick fog")) then gosub TRUE_RANDOM
     if (matchre("$roomobjs","thick fog") || matchre("$roomexits","thick fog")) then gosub TRUE_RANDOM
     if $north then
          {
               gosub MOVEIT north
               return
          }
     if $northwest then
          {
               gosub MOVEIT northwest
               return
          }
     if $northeast then
          {
               gosub MOVEIT northeast
               return
          }
     if $southeast then
          {
               gosub MOVEIT southeast
               return
          }
     if $south then
          {
               gosub MOVEIT south
               return
          }
     if $west then
          {
               gosub MOVEIT west
               return
          }
     if $east then
          {
               gosub MOVEIT east
               return
          }
     if $southwest then
          {
               gosub MOVEIT southwest
               return
          }
     if $out then
          {
               gosub MOVEIT out
               return
          }
     if $up then
          {
               gosub MOVEIT up
               return
          }
     if $down then
          {
               gosub MOVEIT down
               return
          }
     if matchre("$roomname","Temple Hill Manor, Grounds") then
          {
               gosub MOVEIT go gate
               return
          }
     if matchre("$roomname","Darkling Wood, Ironwood Tree") then
          {
               gosub MOVEIT climb pine branches
               return
          }
     if matchre("$roomname","Darkling Wood, Pine Tree") then
          {
               gosub MOVEIT climb white pine
               return
          }
     if matchre("$roomobjs","strong creeper") then
          {
               gosub MOVEIT climb ladder
               return
          }
     if matchre("$roomobjs","\b(stairs|staircase|stairway)\b") then
          {
               gosub MOVEIT climb stair
               return
          }
     if matchre("$roomobjs","\bsteps\b") then
          {
               gosub MOVEIT climb step
               return
          }
     if matchre("$roomobjs","\b(arch|door|gate|hole|hatch|trapdoor|path|animal trail|tunnel|portal)\b") then
          {
               gosub MOVEIT go $1
               return
          }
     echo *** No random direction possible?? Looking to attempt to reset room exit vars
     #might need a counter here to prevent infinite loops
     put look
     pause 0.5
     pause 0.2
     if (%moveloop > 2) then return
     if (%moveloop > 4) then
          {
               echo *** Cannot find a room exit!! Stupid fog!
               echo *** ATTEMPTING RANDOM DIRECTIONS...
               pause 0.2
               gosub TRUE_RANDOM
               return
          }
     goto moveRandomDirection_2
TRUE_RANDOM:
     pause 0.001
     var moved 0
     math randomloop add 1
     if (%randomloop > 12) then
          {
               var lastmoved null
               var randomloop 0
          }
     random 1 16
     if (%r = 1) then gosub MOVEIT n
     if (%r = 2) then gosub MOVEIT ne
     if (%r = 3) then gosub MOVEIT e
     if (%r = 4) then gosub MOVEIT nw
     if (%r = 5) then gosub MOVEIT se
     if (%r = 6) then gosub MOVEIT s
     if (%r = 7) then gosub MOVEIT sw
     if (%r = 8) then gosub MOVEIT w
     if (%r = 9) then gosub MOVEIT out
     if (%r = 10) then gosub MOVEIT go open
     if (%r = 11) then gosub MOVEIT go door
     if (%r = 12) then gosub MOVEIT go path
     if (%r = 13) then gosub MOVEIT climb stair
     if (%r = 14) then gosub MOVEIT climb step
     if (%r = 15) then gosub MOVEIT go panel
     if (%r = 16) then gosub MOVEIT go arch
     return
#### CATCH AND RETRY SUBS
WAIT:
     delay 0.0001
     pause 0.1
     if (!$standing) then gosub STAND
     goto %LOCATION
WEBBED:
     delay 0.0001
     if ($webbed) then waiteval (!$webbed)
     if (!$standing) then gosub STAND
     goto %LOCATION
IMMOBILE:
     delay 0.0001
     if contains("$prompt" , "I") then pause 20
     if (!$standing) then gosub STAND
     goto %LOCATION
STUNNED:
     delay 0.0001
     if ($stunned) then waiteval (!$stunned)
     if (!$standing) then gosub STAND
     goto %LOCATION
CALMED:
     delay 5
     if ($stunned) then waiteval (!$stunned)
     if (!$standing) then gosub STAND
     goto %LOCATION
STOPINVIS:
     if ("$guild" = "Necromancer") then
          {
               put release eotb
               pause 0.3
          }
     if ("$guild" = "Thief") then
          {
               put khri stop silence vanish
               pause 0.3
          }
     if ("$guild" = "Moon Mage") then
          {
               put release rf
               pause 0.3
          }
     pause 0.3
     return
