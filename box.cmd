action var badDisarm 1 when ^However, a \w+ \w+ \w+ is not fully disarmed, making any chance of picking it unlikely\.
action var guild $1 when Guild\: (Barbarian|Bard|Commoner|Cleric|Empath|Moon Mage|Necromancer|Paladin|Ranger|Trader|Warrior Mage)
action var race $1 when Race\: (Dwarf|Elothean|Gnome|Gor'Tog|Kaldar|Prydaen|Rakash)
action var strength $1 when Strength \:  (\d+)              Reflex

###############################
###    VARIABLES
###############################
var boxtype brass|copper|deobar|driftwood|iron|ironwood|mahogany|oaken|pine|steel|wooden
var boxes coffer|crate|strongbox|caddy|casket|skippet|trunk|chest|box
var badDisarm 0
var pouch pouch


###############################
###    CONFIG
###############################
if_1 then
else {
    put #echo mono Options are:
    put #echo mono "     auto - attempts to pick all of your boxes."
    put #echo mono "     hand - picks the box in your hand."
    exit
}

if ("%1" = "auto") then {
    var repeating 1
    var boxindex 0
}
if ("%1" = "hand") then {
    var boxitem $righthandnoun
    var repeating 0
}


###############################
###    MAIN
###############################
box.main:
    if (%repeating = 1) then {
        var boxitem %boxes(%boxindex)
        gosub box.getItem %boxItem
    }

    if ("$righthand" = "Empty") then {
        if (%repeating = 1) then {
            math boxindex add 1
            if (%boxindex > 8) then exit
            goto box.main
        } else {
            echo No box!
            exit
        }
    }

    box.mainDisarmLoop:
        gosub disarm %boxItem identify
        gosub disarm %boxItem $disarmArgs
        if ($disarmArgs <> 0) then goto box.mainDisarmLoop

    box.mainPickLoop:
        gosub pick %boxItem identify
        gosub pick %boxItem $pickArgs
        if ($pickArgs <> 0) then goto box.mainPickLoop

        gosub open my %boxItem
        gosub box.coinGet
        gosub box.fillPouch
        gosub box.lootCheck
        gosub box.dismantle
        if (%repeating = 1) then goto box.main
        else exit


###############################
###    METHODS
###############################

box.disarmIdentify:
    pause
box.disarmIdentify:
    matchre box.disarmIdentifyPause \.\.\.wait|type ahead|stunned|while entangled in a web\.
    matchre box.disarmQuick ^An aged grandmother could defeat this trap in her sleep\.$
    matchre box.disarmQuick ^This trap is a laughable matter, you could do it blindfolded\!$
    matchre box.disarmQuick trap is a trivially constructed gadget which you can take down any time.
    matchre box.disarmQuick will be a simple matter for you to disarm\.$
    matchre box.disarmCareful ^A pitiful snowball encased in the Flames of Ushnish would fare better than you\.$
    matchre box.disarmCareful ^Prayer would be a good start for any attempt of yours at disarming the
    matchre box.disarmCareful should not take long with your skills\.$
    matchre box.disarmCareful ^The odds are against you, but with persistence you believe you could disarm the
    matchre box.disarmCareful ^The trap has the edge on you, but you've got a good shot at disarming the
    matchre box.disarmCareful with only minor troubles\.$
    matchre box.disarmCareful would be a longshot\.$
    matchre box.disarmCareful ^You could just jump off a cliff and save yourself the frustration of attempting this
    matchre box.disarmCareful ^You have an amazingly minimal chance at disarming the
    matchre box.disarmCareful ^You have some chance of being able to disarm the
    matchre box.disarmCareful ^You probably have the same shot as a snowball does crossing the desert.
    matchre box.disarmCareful ^You really don't have any chance at disarming this
    matchre box.disarmCareful ^You think this trap is precisely at your skill level\.$
    matchre box.disarmIdentify fails to reveal to you what type of trap protects it\.$
    matchre box.disarmIdentify ^You get the distinct feeling your careless examination caused something to shift inside the trap mechanism\.  This is not likely to be a good thing\.$
    matchre box.pick ^You guess it is already disarmed\.$
    matchre box.pick Roundtime:
    put disarm %boxItem identify
    matchwait 5


box.disarmQuick:
    var disarmtype quick
    goto box.disarm


box.disarmCareful:
    var disarmtype careful
    goto box.disarm


box.disarmPause:
    pause
box.disarm:
    matchre box.disarmPause \.\.\.wait|type ahead|stunned|while entangled in a web\.
    matchre box.pick Roundtime\:
    matchre box.disarm ^You work with the trap for a while but are unable to make any progress\.$
    matchre box.disarmIdentify is not yet fully disarmed\.$
    put disarm %boxItem %disarmtype
    matchwait 5


box.pickIdentifyPause:
    pause
box.pickIdentify:
    if (%badDisarm = 1) then {
        var badDisarm 0
        goto box.disarmIdentify
    }
    matchre box.pickIdentifyPause \.\.\.wait|type ahead|stunned|while entangled in a web\.
    matchre box.pickIdentify fails to teach you anything about the lock guarding it\.$
    matchre box.pickQuick ^An aged grandmother could open this in her sleep\.$
    matchre box.pickQuick ^This lock is a laughable matter, you could do it blindfolded\!$
    matchre box.pickQuick ^The lock is a trivially constructed piece of junk barely worth your time\.$
    matchre box.pickQuick will be a simple matter for you to unlock.
    matchre box.pickCareful ^A pitiful snowball encased in the Flames of Ushnish would fare better than you\.$
    matchre box.pickCareful ^Prayer would be a good start for any attempt of yours at picking open the
    matchre box.pickCareful should not take long with your skills\.$
    matchre box.pickCareful ^The lock has the edge on you, but you've got a good shot at picking open the
    matchre box.pickCareful ^The odds are against you, but with persistence you believe you could pick open the
    matchre box.pickCareful with only minor troubles\.$
    matchre box.pickCareful would be a longshot\.$
    matchre box.pickCareful ^You could just jump off a cliff and save yourself the frustration of attempting this
    matchre box.pickCareful ^You have an amazingly minimal chance at picking open the
    matchre box.pickCareful ^You have some chance of being able to pick open the
    matchre box.pickCareful ^You probably have the same shot as a snowball does crossing the desert\.$
    matchre box.pickCareful ^You really don't have any chance at picking open this
    matchre box.pickCareful ^You think this lock is precisely at your skill level\.$
    matchre return ^It's not even locked, why bother\?$
    put pick %boxItem identify
    matchwait 5
    

box.pickQuick:
    var picktype quick
    goto box.pick
  
  
box.pickCareful:
    var picktype careful
    goto box.pick
  
  
box.pickPause:
    pause    
box.pick:
    if (%badDisarm = 1) then {
        var baddisarm 0
        goto box.disarmIdentify
    }
    matchre box.pickPause \.\.\.wait|type ahead|stunned|while entangled in a web\.
    matchre box.pickIdentify ^You discover another lock protecting the
    matchre box.pick ^You are unable to make any progress towards opening the lock\.$
    matchre return ^Roundtime:
    #match return ^With a soft click, you remove your lockpick and open and remove the lock\.$
    put pick %boxItem %picktype
    matchwait 5
  

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
    if (%dismantleType = null) then {
        gosub box.dismantleSetDismantle
        if (%dismantleType <> 0) then gosub dismantle %boxItem %dismantleType
        else gosub dismantle %boxItem
    }
    return


box.dismantleSetDismantle:
    put info
    var dismantleType 0
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
    if ($dismantleType = 0) then {
        if (%strength > 29) then var dismantleType crush
    }
    return
