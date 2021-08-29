include libmaster.cmd
action goto box.mainLoop when However, a (?:/w+) (?:/w+) (%boxes) is not fully disarmed, making any chance of picking it unlikely\.
action var guild $1 when Guild\: (Barbarian|Bard|Commoner|Cleric|Empath|Moon Mage|Necromancer|Paladin|Ranger|Trader|Warrior Mage)
action var race $1 when Race\: (Dwarf|Elothean|Gnome|Gor'Tog|Kaldar|Prydaen|Rakash)
action var strength $1 when Strength \:  (\d+)              Reflex
action goto box.mainLoopLoot when ^It's not even locked, why bother\?$


###############################
###    VARIABLES
###############################
var boxIndex 0
var boxItem 0
var boxType brass|copper|deobar|driftwood|iron|ironwood|mahogany|oaken|pine|steel|wooden
var boxTypeIndex 0
var boxes coffer|crate|strongbox|caddy|casket|skippet|trunk|chest|box
var dismantleType 0
var guild 0
var pouch pouch
var race 0
var strength 0


###############################
###    CONFIG
###############################
gosub box.dismantleSetDismantle
if matchre("$righthandnoun", "(%boxes)") then {
    var boxItem $righthandnoun
    goto box.main
}


###############################
###    MAIN
###############################
box.main:
    if (%boxIndex > 8) then goto box.done
    if ("$righthand" = "Empty") then {
        var boxItem %boxes(%boxIndex)
        if ("%boxItem" = "box") then {
            gosub box.boxTypeLoop
        }
        gosub get my %boxItem
    }

    if ("$righthand" = "Empty") then {
        math boxIndex add 1
        goto box.main
    }


    box.mainLoop:
        gosub disarm %boxItem identify


        box.mainLoopDisarm:
            if ($lib.disarmArgs <> 0) then {
                if ("$lib.disarmArgs" = "default") then {
                    gosub disarm %boxItem
                } else {
                    gosub disarm %boxItem $lib.disarmArgs
                }
                goto box.mainLoopDisarm
            }
        gosub pick %boxItem identify


        box.mainLoopPick:
        if ($lib.pickArgs <> 0) then {
            if ("$lib.pickArgs" = "default") then {
                gosub pick %boxItem
            } else {
                gosub pick %boxItem $lib.pickArgs
            }
            goto box.mainLoopPick
        }

        box.mainLoopLoot:
        gosub open my %boxItem
        gosub box.coinGet
        gosub box.fillPouch
        gosub box.lootCheck
        gosub box.dismantle
        goto box.main


box.boxTypeLoop:
    if (%boxTypeIndex > 10) then {
        math boxIndex add 1
        goto box.main
    }

    var boxItem %boxType(%boxTypeIndex) box
    gosub get my %boxItem
    if ("$righthand" = "Empty") then {
        math boxTypeIndex add 1
        goto box.boxTypeLoop
    }
    goto box.mainLoop


###############################
###    METHODS
###############################
box.coinGetPause:
    pause
box.coinGet:
    matchre box.coinGetPause \.\.\.wait|type ahead|stunned|while entangled in a web\.
    matchre box.coinGet ^You pick up
    matchre return ^What were you referring to\?$
    put get coin from %boxItem
    matchwait 5


box.fillPouchPause:
    pause
box.fillPouch:
    matchre box.fillPouchPause \.\.\.wait|type ahead|stunned|while entangled in a web\.
    matchre box.tiedPouch ^The gem pouch is too valuable|^You'll need to tie it up
	matchre return ^You take|^There aren't any|You fill your|You open your|You have to be holding
	matchre box.fullPouch anything else|pouch is too full
	put fill my pouch with my %boxItem
	matchwait 5


box.lootCheckPause:
    pause
box.lootCheck:
	matchre box.lootCheckPause \.\.\.wait|type ahead|stunned|while entangled in a web\.
	matchre box.getMisc (map|treasure map|Treasure map)
    matchre box.getMisc (nugget|ingot|\bbar\b|jadeite|kyanite|bark|parchment|\bdira\b|papyrus|tablet|vellum|\bscroll\b|\broll\b|ostracon|leaf|\brune\b)
    matchre return ^In the|nothing|^What
	put look in my %boxItem
	matchwait 5


box.getMisc:
    var getItemName $1
    gosub get %getItemName
    gosub stow %getItemName
    put #echo >Log Yellow Found a %getItemName!
    goto box.lootCheck


box.dismantle:
    if (%dismantleType <> 0) then {
        gosub dismantle %boxItem %dismantleType
        if ("$righthand" <> "Empty") then {
            gosub dismantle %boxItem %dismantleType
        }
    } else {
        gosub dismantle %boxItem
        if ("$righthand" <> "Empty") then {
            gosub dismantle %boxItem
        }
    }
    return


box.dismantleSetDismantle:
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
box.done:
    put #echo >log [box] All accessible boxes opened! Locks: ($Locksmithing.LearningRate/34)
    goto box.exit


box.error:
    put #echo >log [box] You are missing lockpicks.
    goto box.exit


box.exit:
    pause .2
    put #parse BOX DONE
    exit
