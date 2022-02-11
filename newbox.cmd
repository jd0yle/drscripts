include libmaster.cmd
###############################
###    Box Opening Script
###############################


###############################
###    IDLE ACTIONS
###############################
# - - Armor Handling
action var boxArmorCheck 1 when All of your armor\:
action var boxWeaponCheck 1 when All of your weapons\:
action goto box-removeArmor when Your .* hinders your attempt\.

# - - Box Opening
action var boxDisarmed 0 ; goto box-disarmId  when However, (.*) is not fully disarmed, making any chance of picking it unlikely\.
action var boxDisarmed 0 ; goto box-disarmId  when Careful probing of the (.*) fails to reveal to you what type of trap protects it\.
action var boxDisarmed 0 ; goto box-disarmId  when You believe that the (.*) is not yet fully disarmed\.
action var boxDisarmed 0 ; goto box-disarmId  when You realize that despite this mishap, the (.*) still has more to torment you with\.
action var boxLocked 0 ; goto box-pickId when You discover another lock protecting the (.*)s contents as soon as you remove this one\.
action var boxLocked 0 ; goto box-pickId when You are unable to make any progress towards opening the lock\.
action var boxDisarmed 1 when After carefully pushing at the sharp blade for a while, you manage to bend it well away from the mesh bag\.
action var boxDisarmed 1 when After studying the design of the trap carefully, you begin to nudge the tip of the dart sideways in an effort to jam the mechanism\.
action var boxDisarmed 1 when After wiggling the milky-white tube back and forth for a few moments, you manage to bend it away from the tiny hammer set to break it\.  Just for fun, you flick the tube a couple of times with the tip of your finger, which seems to annoy the heck out of the little black dots inside\.
action var boxDisarmed 1 when By focusing on its tiny legs, you are able to pry the crusty scarab off one small piece at a time\.  Finally, the body of the faux insect falls away and crumbles, surprisingly, into sand\.
action var boxDisarmed 1 when Careful not to jostle the (.*), you reach down and scoop a pinchful of dirt from the ground, then pack it into the pinholes, blocking them\.  It's not exactly an original solution, but it still works\.
action var boxDisarmed 1 when Carefully, you pry the bronze face away from the (.*), then moving even more cautiously, pierce the bladder and allow its unsavory contents to spray harmlessly upon the ground\.
action var boxDisarmed 1 when Following a few moments of effort, you feel satisfied that the trap is no longer a threat\.
action var boxDisarmed 1 when Grabbing up a pinch of dust from the ground, you carefully pack it into the small hole, stopping it up and disarming the trap\.
action var boxDisarmed 1 when Only after you are convinced that is done do you move on to the tiny metal lever\.  It takes some effort, but you finally bend it away from any spark-causing surfaces\.
action var boxDisarmed 1 when Reaching into the keyhole carefully, you knock free the coin sized piece of metal and it falls to the bottom of the box with a light "thunk"\.
action var boxDisarmed 1 when Slowly, so as not to accidentally jostle the (.*) during the attempt, you work carefully at the bluish azure circle, and bend it away until its metal no longer touches the hinges at all\.
action var boxDisarmed 1 when Unsure as to whether the liquid-filled bladder is poison or something else, you work first at draining it\.  Only after you are convinced that is done do you move on to the tiny metal lever.  It takes some effort, but you finally bend it away from any spark-causing surfaces\.
action var boxDisarmed 1 when With a smirk you wedge a small stick between the tiny hammer and the tube forcing it back until you hear a\.\.\.\"CLICK\"\.  The hammer seems to be in a locked position\.
action var boxDisarmed 1 when With precise control, you shove the pin away from the tumblers and it springs upward and lodges into the frame of the (.*) itself\.
action var boxDisarmed 1 when With sweat forming on your brow, you slowly move the rune away from the lock and push it deep inside the box\.
action var boxDisarmed 1 when With the precision and grace of a skilled craftsman, you nudge the black crystal away from its position next to the lock\.
action var boxDisarmed 1 when Working slowly, you carefully bend the head of the needle so that it can no longer spring out from its hidden compartment\.
action var boxDisarmed 1 when Working slowly, you carefully pry at the studs working them away from what you surmise are contacts located somewhere under the keyhole\.
action var boxDisarmed 1 when Working with extreme care, you cautiously bend closed the metal plates over the bolts so that the openings are sealed shut\.
action var boxDisarmed 1 when Working with extreme care, you locate the spring mechanism attached to the blade, and unhook it from the blade rendering it harmless\.
action var boxDisarmed 1 when Working with extreme care, you poke a small hole in the (.*) and through the vial, allowing the deadly naphtha to drain harmlessly to the ground\.
action var boxDisarmed 1 when Working with extreme care, you unhook the stopper from the lid, allowing it to be opened safely\.
action var boxDisarmed 1 when You cautiously pry the seal away from the lid, being extremely careful not to break it\.
action var boxDisarmed 1 when You manage to work the contact fibers away from the cube of black powder lodged inside the lock casement\.
action var boxLocked 1 when With a soft click, you remove your lockpick and open and remove the lock\.
action var boxLocked 1 ; goto box-mainLoop when It's not even locked, why bother\?
action goto box-healthCheck when You realize very quickly that this was a very bad idea\.\.\.

# - - Box is already disarmed.
action var boxDisarmed 1 ; goto box-pickId when A bent needle sticks harmlessly out from its hidden compartment near the lock\.
action var boxDisarmed 1 ; goto box-pickId when A broken spring is sticking out of a hidden seam on the front of the (.*)\.  It is no longer attached to a razor-sharp scythe blade within the gap\.
action var boxDisarmed 1 ; goto box-pickId when A row of concealed openings on the front of the (.*), have been bent in such a way that they no longer will function\.
action var boxDisarmed 1 ; goto box-pickId when A small hole near the lock houses a tiny dart with a silver tip\.  It appears, however, that the dart has been moved too far out of position for the mechanism to function properly\.
action var boxDisarmed 1 ; goto box-pickId when A tiny hammer and milky-white tube on the front of the (.*) have been bent away from each other\.
action var boxDisarmed 1 ; goto box-pickId when An incredibly sharp blade rests off to the side in the casing of the (.*), indicating the trap is no longer a danger\.
action var boxDisarmed 1 ; goto box-pickId when Looking closely at the (.*) you notice a vial of lime green liquid attached to the lid.  Someone has unhooked the stopper, rendering it harmless\.
action var boxDisarmed 1 ; goto box-pickId when Several small pinholes centered around the keyhole indicate that some sort of apparatus, previously attached, was picked apart and removed from the (.*)\.
action var boxDisarmed 1 ; goto box-pickId when Several strands of wicker detonator lay inside the casement, separated harmlessly from their charge\.  You guess it is already disarmed\.
action var boxDisarmed 1 ; goto box-pickId when There are two tiny holes in the (.*)\.  It looks like there used to be something in them, but whatever it was has been pried out\.
action var boxDisarmed 1 ; goto box-pickId when There is a small hole in the front of the (.*), and a damp stain down the front, as if something had been poured out the hole\.
action var boxDisarmed 1 ; goto box-pickId when There is a stain near a small notch on the front of the (.*), indicating a liquid was drained out\.  Additionally, a tiny metal lever has been bent away from the casing\.
action var boxDisarmed 1 ; goto box-pickId when Two sets of six pinholes on either side of the (.*)'s lock are sealed with dirt, blocking whatever would have come out\.
action var boxDisarmed 1 ; goto box-pickId when While examining the (.*) for traps, you notice a bronze seal with a glass sphere in it.  The seal has been pried away from the lid.
action var boxDisarmed 1 ; goto box-pickId when You notice a sphere with some type of lacing around it\.  It seems a small portion of the trap has been removed\.
action var boxDisarmed 1 ; goto box-pickId when You notice a tiny hole near the lock which has been stuffed with dirt rendering the trap harmless\.
action var boxDisarmed 1 ; goto box-pickId when You see a glowing rune pushed deep within the (.*)\.  It seems far enough away from the lock to be harmless\.
action var boxDisarmed 1 ; goto box-pickId when You see a pin and shaft lodged into the frame of the (.*)\.  It looks safe enough\.
action var boxDisarmed 1 ; goto box-pickId when You see a shattered glass tube with a tiny hammer inside the lock\.  You deem it quite safe\.
action var boxDisarmed 1 ; goto box-pickId when You see nothing of interest in the (.*)\.  It seems harmless\.
action var boxDisarmed 1 ; goto box-pickId when A thin metal circle of bluish azure has been peeled away from the hinges of the (.*)\.
action var boxDisarmed 1; var boxLocked 0 ; goto box-pickId when It is locked\.

# - - Variables
action var boxContent $1 when ^In the.*you see (.*)
action var boxIsEmpty 1 when  but there is nothing in there\.|There is nothing in there\.
action var boxDiff 1 when The (.*)'s trap is a trivially constructed gadget which you can take down any time\.
action var boxDiff 1 when The lock is a trivially constructed piece of junk barely worth your time\.
action var boxDiff 1 when This (trap|lock) is a laughable matter(.*)you could do it blindfolded\!
action var boxDiff 1 when An aged grandmother could (defeat this trap|open this) in her sleep\.
action var boxDiff 2 when Somebody has already inspected the current
action var boxDiff 2 when The (.*) will be a simple matter for you to (disarm|unlock)\.
action var boxDiff 2 when The (.*) should not take long with your skills\.
action var boxDiff 2 when You can (disarm|unlock) the (.*) with only minor troubles\.
action var boxDiff 2 when You think this (trap|lock) is precisely at your skill level\.
action var boxDiff 3 when The (trap|lock) has the edge on you, but you've got a good shot at (disarming|picking open) the (.*)\.
action var boxDiff 3 when The odds are against you, but with persistence you believe you could (disarm|pick open) the (.*)\.
action var boxDiff 3 when You have some chance of being able to (disarm|pick open) the (.*)\.
action var boxFullPouch when anything else|pouch is too full
action var guild $1 when Guild\: (Barbarian|Bard|Commoner|Cleric|Empath|Moon Mage|Necromancer|Paladin|Ranger|Trader|Warrior Mage)
action var race $1 when Race\: (Dwarf|Elothean|Gnome|Gor'Tog|Kaldar|Prydaen|Rakash)
action var strength $1 when Strength \:  (\d+)              Reflex

# - - Too Difficult
action goto box-exit when would be a longshot\.
action goto box-exit when Prayer would be a good start for any attempt of yours
action goto box-exit when You have an amazingly minimal chance
action goto box-exit when You really don't have any chance at
action goto box-exit when You probably have the same shot as a snowball does crossing the desert\.
action goto box-exit when You could just jump off a cliff and save yourself the frustration
action goto box-exit when A pitiful snowball encased in the Flames of Ushnish

# - - Misc
action goto box-error when ^Find a more appropriate tool and try again\!
action put get $1 when ^Your .* falls to the ground\.


###############################
###    VARIABLES
###############################
var boxCareful The (trap|lock) has the edge on you, but you've got a good shot at (disarming|picking open) the (.*)\.|The odds are against you, but with persistence you believe you could (disarm|pick open) the (.*)\.|You have some chance of being able to (disarm|pick open) the (.*)\.
var boxDefault The (.*)) will be a simple matter for you to (disarm|unlock)\.|	The (.*) should not take long with your skills\.|You can (disarm|unlock) the (.*) with only minor troubles\.|You think this (trap|lock) is precisely at your skill level\.
var boxDifficult would be a longshot\.|Prayer would be a good start for any attempt of yours|You have an amazingly minimal chance|You really don't have any chance at|You probably have the same shot as a snowball does crossing the desert\.|You could just jump off a cliff and save yourself the frustration|A pitiful snowball encased in the Flames of Ushnish
var boxEasy An aged grandmother could (defeat|open) this trap in her sleep\.|This (trap|lock) is a laughable matter, you could do it blindfolded\!|The (.*)'s trap is a trivially constructed (gadget which you can take down any|piece of junk barely worth your) time\.
var boxMoreLock You discover another lock protecting the (.*)s contents as soon as you remove this one\.
var boxMoreTrap However, (.*) is not fully disarmed, making any chance of picking it unlikely\.|Careful probing of the (.*) fails to reveal to you what type of trap protects it\.|You believe that the (.*) is not yet fully disarmed\.|You realize that despite this mishap, the (.*) still has more to torment you with\.

var boxDiff 0
var boxDisarmed 0
var boxContent 0
var boxIndex 0
var boxIsEmpty 0
var boxItem 0
var boxLocked 0
var boxes coffer|crate|strongbox|caddy|casket|skippet|trunk|chest|box
var boxType brass|copper|deobar|driftwood|iron|ironwood|mahogany|oaken|pine|steel|wooden
var componentList sealed vial|stoppered vial|capillary tube|short needle|broken needle|bronze seal|animal bladder|silver studs|sharp blade|curved blade|broken rune|coiled spring|metal spring|metal lever|tiny hammer|iron disc|bronze disc|glass reservoir|bronze face|steel pin|steel striker|chitinous leg|(?!cracked )black crystal|metal circle|brown clay|black cube|glass sphere
var craftMaterial bar\b|nugget
var dismantleType 0
var guild 0
var pouch pouch
var race 0
var strength 0
var treasure bark|jadeite|kyanite|leaf|ostracon|papyrus|parchment|\broll\b|\brune\b|\bscroll\b|tablet|vellum
var trash card|cebi root|dira|embroidery needle|flint|hisan grass|hulnik grass|jadice flowers|marble pestle|mortar|nemoih root|oil|riolur leaf|runestone|wax label|wood glue|yelith root


###############################
###    CONFIG
###############################
gosub box-setDismantle
if matchre("$righthandnoun", "(%boxes)") then {
    var boxItem $righthandnoun
    goto box-main
}


###############################
###    MAIN
###############################
box-main:
    if (%boxIndex > 8) then goto box.done
    if ("$righthand" = "Empty") then {
        var boxItem %boxes(%boxIndex)
        if ("%boxItem" = "box") then {
            var boxTypeIndex 0
            gosub box-boxTypeLoop
        }
        gosub get my %boxItem
        if (("$righthand" = "Empty") && ($char.inv.container.eddy <> null)) then {
            gosub look in my portal
            gosub get my %boxItem from my portal
        }
    }

    if ("$righthand" = "Empty") then {
        math boxIndex add 1
        goto box-main
    }


    box-mainLoop:
        if (%boxDisarmed = 0) then {
            gosub box-disarmId
        }
        pause 1
        if (%boxLocked = 0) then {
            gosub box-pickId
        }
        var boxContent 0
        gosub open my %boxItem
        if ("$char.inv.container.autoloot" = "0") then {
            gosub box-lootCoin
        }
        gosub box-lootGems
        gosub box-lootMisc
        gosub box-dismantle
        goto box-main


###############################
###    METHODS
###############################
box-armorCheck:
    var boxArmorCheck 0
    var boxWeaponCheck 0
    gosub inven armor
    gosub inven weapon
    if ((%boxArmorCheck = 1) || (%boxWeaponCheck = 1)) then {
        gosub runScript armor remove
    } else {
        goto box-main
    }
    goto box-armorCheck


box-boxTypeLoop:
    if (%boxTypeIndex < 11) then {
        var boxItem %boxType(%boxTypeIndex) box
        gosub get my %boxItem
        if ("$righthand" = "Empty") then {
            gosub get my %boxItem from my portal
        }
        if ("$righthand" = "Empty") then {
            if (%boxTypeIndex > 10) then {
                goto box-done
            }
            math boxTypeIndex add 1
            goto box-boxTypeLoop
        }
    } else {
        goto box-cleanRoom
    }
    goto box-mainLoop


box-cleanRoom:
    var trashItem 0
    if (matchre("$roomobjs", "%trash") && ($char.locks.bucket <> null)) then {
        var trashItem $0
        gosub get %trashItem
        gosub put my %trashItem in my bucket
        goto box-cleanRoom
    }
    if (matchre("$roomobjs", "junk")) then {
        gosub look junk
        echo [newbox] Calling DUMP to trash ($roomjunk)
        gosub dump junk
    }
    if ($char.locks.bucket <> null) then {
        gosub tap my bucket
        gosub tap my bucket
    }
    goto box-done



box-disarmId:
    pause 2
    var boxDiff 0
    gosub disarm my %boxItem identify
    # Safety check.
    if (%boxDiff = 0) then {
        goto box-disarmId
    }
    if (%boxDiff = 1) then {
        gosub disarm my %boxItem quick
    }
    if (%boxDiff = 2) then {
        gosub disarm my %boxItem
    }
    if (%boxDiff = 3) then {
        gosub disarm my %boxItem careful
    }
    if (%boxDiff = 4) then {
        put #echo >Log [box] The $righthand is too difficult, exiting.
        goto box.exit
    }
    if (%boxDisarmed = 0) then {
        goto box-disarmId
    } else {
        goto box-mainLoop
    }


box-dismantle:
    var boxContent 0
    var boxDisarmed 0
    var boxIsEmpty 0
    var boxLocked 0

    if (%dismantleType <> 0) then {
        gosub dismantle my %boxItem %dismantleType
        if ("$righthand" <> "Empty") then {
            gosub dismantle my %boxItem %dismantleType
        }
    } else {
        gosub dismantle my %boxItem
        if ("$righthand" <> "Empty") then {
            gosub dismantle my %boxItem
        }
    }
    return


box-fullPouch:
    if !(matchre("$righthand|$lefthand", "Empty")) then {
        gosub put my $lefthandnoun in my $char.inv.container.default
    }
    gosub remove my $char.inv.gemPouch
    gosub put my $char.inv.gemPouch in my $char.inv.container.fullGemPouch
    gosub get my $char.inv.gemPouch from my $char.inv.container.emptyGemPouch
    if (matchre("$lefthandnoun", "pouch")) then {
        gosub wear my $char.inv.gemPouch
        gosub fill my $char.inv.gemPouch with my $char.inv.container.default
        gosub tie my $char.inv.gemPouch
        # In case there is more than 70 gems, fill again.
        gosub fill my $char.inv.gemPouch with my $char.inv.container.default
        gosub store gem $char.inv.gemPouch
    } else {
        put #echo >Log [newbox] There are no more empty pouches in your $char.inv.container.emptyGemPouch.  Setting STORE GEM $char.inv.container.default.
        gosub store gem $char.inv.container.default
        put #tvar char.inv.refillGemPouches 1
    }
    goto box-main


box-lootCoin:
    if ("%boxContent" <> "0") then {
        if (matchre("%boxCoinArr", "platinum coin")) then {
            gosub get my platinum coin from my %boxItem
        }
        if (matchre("%boxCoinArr", "gold coin")) then {
            gosub get my gold coin from my %boxItem
        }
        if (matchre("%boxCoinArr", "silver coin")) then {
            gosub get my silver coin from my %boxItem
        }
        if (matchre("%boxCoinArr", "copper coin")) then {
            gosub get my copper coin from my %boxItem
        }
    } else {
        echo [box] No coins inside box.
    }
    return


box-lootGems:
    var boxFullPouch 0
	gosub fill my pouch with my %boxItem
	if (%boxFullPouch = 1) then {
	    gosub box-fullPouch
	}
	return


box-lootMisc:
    var treasureItem 0
    gosub look in my $righthandnoun
    if (%boxIsEmpty = 1) then {
        return
    } else {
        if (matchre("%boxContent", "(%treasure)")) then {
            var treasureItem $1
            gosub get %treasureItem from my %boxItem
            gosub stow my %treasureItem
            put #echo >Log [box] Looted a %treasureItem.
            goto box-lootMisc
        }
        var treasureItem 0
        if ($char.loot.nuggetBars = 1) then {
            if (matchre("%boxContent", "(%craftMaterial)")) then {
                var treasureItem $0
                gosub get %treasureItem from my %boxItem
                gosub stow my %treasureItem
                put #echo >Log [box] Looted a %treasureItem.
                goto box-lootMisc
            }
        }
    }
    return


box-pickId:
    pause 2
    var boxDiff 0
    gosub pick my %boxItem identify
    # Safety check.
    if (%boxDiff = 0) then {
        goto box-pickId
    }
    if (%boxDiff = 1) then {
        gosub pick my %boxItem quick
    }
    if (%boxDiff = 2) then {
        gosub pick my %boxItem
    }
    if (%boxDiff = 3) then {
        gosub pick my %boxItem careful
    }
    if (%boxDiff = 4) then {
        put #echo >Log [box] The $righthand is too difficult, exiting.
        goto box-exit
    }
    if (%boxLocked = 0) then {
        goto box-pickId
    } else {
        goto box-mainLoop
    }


box-removeArmor:
    gosub runScript armor remove
    goto box-main


box-setDismantle:
    gosub info
    if ("%guild" = "Barbarian") then var dismantleType bash
    if ("%guild" = "Bard") then var dismantleType shriek
    if ("%guild" = "Cleric") then var dismantleType pray
    if ("%guild" = "Moon Mage") then var dismantleType focus
    if ("%guild" = "Ranger") then var dismantleType whistle
    if ("%guild" = "Thief") then var dismantleType slip
    #if ("%guild" = "Thief") then var dismantleType thump
    if ("%guild" = "Trader") then var dismantleType salvage
    #if ("%guild" = "Trader") then var dismantleType caravan
    if ("%guild" = "Warrior Mage") then var dismantleType fire
    if ("%guild" = "Commoner" || "%guild" = "Empath" || "%guild" = "Paladin" || "%guild" = "Necromancer") then {
            if ("%race" = "Dwarf") then var dismantleType stomp
            if ("%race" = "Elothean") then var dismantleType press
            if ("%race" = "Gnome") then var dismantleType tinker
            #if ("%race" = "Gnome") then var dismantleType jump
            if ("%race" = "Gor'Tog") then var dismantleType crush
            if ("%race" = "Kaldar") then var dismantleType slam
            if ("%race" = "Prydaen") then var dismantleType claw
            if ("%race" = "Rakash") then var dismantleType chomp
    }
    if (%dismantleType = 0) then {
        if (%strength > 29) then var dismantleType crush
    }
    return


###############################
###    EXIT
###############################
box-done:
    put #echo >log [box] All accessible boxes opened! Locks: ($Locksmithing.LearningRate/34)
    goto box-exit


box-error:
    put #echo >log [box] You are missing lockpicks.
    goto box-exit


box-exit:
    pause .2
    put #parse BOX DONE
    exit
