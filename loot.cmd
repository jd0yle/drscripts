include libmaster.cmd
include args.cmd
###############################
###    LOOT
###############################
if (%args.boxes = 1) then var lootBoxes 1


###############################
###    VARIABLES
###############################
var scrolls scroll|ostracon|\broll|leaf|vellum|tablet|(?<!of )parchment|bark|papyrus
var treasuremaps \bmap\b
var gems1 agate|alexandrite|amber|amethyst|andalusite|aquamarine|bead|beryl|bloodgem|bloodstone|carnelian|chrysoberyl|carnelian|chalcedony
var gems2 chrysoberyl|chrysoprase|citrine|coral|crystal|diamond|diopside|emerald|egg\b|eggcase|garnet|gem|goldstone|glossy malachite
var gems3 hematite|iolite|ivory|jade|jasper|kunzite|lapis lazuli|malachite stone|minerals|moonstone|morganite|onyx|opal
var gems4 pearl|pebble|peridot|quartz|ruby|sapphire|spinel|star-stone|sunstone|talon|tanzanite|tooth|topaz|tourmaline|tsavorite|turquoise|zircon

var gweths (?:jadeite|kyanite|lantholite|sjatmal|waermodi|lasmodi) stones
var boxtype brass|copper|deobar|driftwood|iron|ironwood|mahogany|oaken|pine|steel|wooden
var boxes coffer|crate|strongbox|caddy|casket|skippet|trunk|chest|\bbox
var miscKeep crumpled page|singed page|book spine|shattered bloodlock|front cover|kirmhiro draught
var craftMaterial bar|nugget
var ammo sphere|bone shard|doorknob|candle stub|brick clump|cougar-claw arrow|boar-tusk arrow|basilisk arrow|barbed arrow|bolt|stone|rock\b|throwing blade|quadrello|blowgun dart|throwing hammer|hhr'ata|bola|boomerang|small rock|frying pan|naphtha|wand|spear
#var ammo bone shard|cougar-claw arrow|boar-tusk arrow|basilisk arrow|bolt|stone|rock\b|throwing blade|quadrello|blowgun dart|throwing hammer|hhr'ata|bola|boomerang|small rock|frying pan|naphtha|wand|spear
var coin coin|coins

var gems %gems1|%gems2|%gems3|%gems4
var boxes (?:brass|copper|deobar|driftwood|iron|ironwood|mahogany|oaken|pine|steel|wooden) (?:coffer|crate|strongbox|caddy|casket|skippet|trunk|chest|\bbox)
var lootables %ammo|%coin|%scrolls|%treasuremaps|%gems1|%gems2|%gems3|%gems4|%miscKeep|%craftMaterial

if (%lootBoxes = 1) then var lootables %lootables|%boxes

var toLoot null
#action (invFeet) var toLoot %toLoot|$1 when (%lootables)
action (invFeet) var toLoot %toLoot|$1 when ^\s\s(.*)
action (invFeet) off

var newGemPouch 0


###############################
###    IDLE ACTION TRIGGERS
###############################
action var newGemPouch 1 when ^You think the .* pouch is too full to fit another gem into\.
action var newGemPouch 1 when ^The .* pouch is too full to fit any more gems\!
action var newGemPouch 1 when ^WARNING: You are carrying an extremely large number of items on your person\.$

###############################
###    MAIN
###############################
loot-main:
    gosub pickupLoot
    gosub pickupLootAtFeet
    pause .2
    put #parse LOOT DONE
    exit


###############################
###    UTILITY
###############################
pickupLoot:
    #eval gwethsInRoom matchre("$roomobjs", "(%gweths)")
    if (1=0 && contains("$roomobjs", "waermodi stone")) then {
        gosub get waermodi stone
        gosub put my waermodi stone in my %specialStorage
        gosub stow my w stone
        goto pickupLoot
    }

    if (1=0 && contains("$roomobjs", "hematite")) then {
        gosub get hematite
        gosub put my hematite in my %specialStorage
        gosub stow my hematite
        goto pickupLoot
    }

    eval numItems count("%lootables", "|")
    var loot.index 0


    pickupLootLoop:
        eval preLootLen len("$roomobjs")
        if (contains("$roomobjs", "%lootables(%loot.index)")) then {
            if (matchre("$roomobjs", "(%gems)")) then {
                var itemGem $1
                echo Found gem: %itemGem
                gosub stow gem
            } else {
                echo Found item: %itemGem
                if ((matchre("%itemGem", "%craftMaterial")) && ($char.loot.nuggetBars = 1)) then {
                    gosub stow %itemGem
                }
                gosub stow %lootables(%loot.index)
            }
            if (%newGemPouch = 1) then {
                if ("$lefthand" != "Empty") then {
                    gosub put my $lefthandnoun in my $char.inv.defaultContainer
                }
                gosub stow right
                gosub stow left
                gosub remove my $char.inv.gemPouch
                gosub put my $char.inv.gemPouch in my $char.inv.fullGemPouchContainer
                gosub get $char.inv.gemPouch from my $char.inv.emptyGemPouchContainer
                gosub wear my $char.inv.gemPouch
                gosub store gem $char.inv.gemPouch
                gosub fill my $char.inv.gemPouch with my $char.inv.defaultContainer
                gosub tie my $char.inv.gemPouch
                gosub drop my %lootables(%loot.index)
                var newGemPouch 0
                goto pickupLootLoop
            }
        }
        if (len("$roomobjs") != %preLootLen) then {
            goto pickupLootLoop
        }

        math loot.index add 1
        if (%loot.index > %numItems) then return
        goto pickupLootLoop


pickupLootAtFeet:
    action (invFeet) on
    var toLoot null
    pause .2
    gosub inv atfeet
    action (invFeet) off
    eval invLength count("%toLoot", "|")
    var invIndex 0


    pickupLootAtFeetLoop:
        #if ("%toLoot(%invIndex)" != "null") then gosub stow %toLoot(%invIndex)
        if ("%toLoot(%invIndex)" != "null") then gosub stow feet
        math invIndex add 1
        if (%invIndex > %invLength) then return
        goto pickupLootAtFeetLoop
