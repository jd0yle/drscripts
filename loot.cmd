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
var coin coin|coins

var gems %gems1|%gems2|%gems3|%gems4
var boxes (?:brass|copper|deobar|driftwood|iron|ironwood|mahogany|oaken|pine|steel|wooden) (?:coffer|crate|strongbox|caddy|casket|skippet|trunk|chest|\bbox)
var lootables %ammo|%coin|%scrolls|%treasuremaps|%gems1|%gems2|%gems3|%gems4|%miscKeep

if (%lootBoxes = 1) then var lootables %lootables|%boxes

if ($char.loot.nuggetBars = 1) then var lootables %lootables|%craftMaterial

var toLoot null
action (invFeet) var toLoot %toLoot|$1 when ^\s\s(.*)
action (invFeet) off

var newGemPouch 0


###############################
###    IDLE ACTION TRIGGERS
###############################
action var newGemPouch 1 when ^You think the .* pouch is too full to fit another gem into\.
action var newGemPouch 1 when ^The .* pouch is too full to fit any more gems\!
action var newGemPouch 1 when ^WARNING: You are carrying an extremely large number of items on your person\.$
action goto loot-tieOff when ^You've already got a wealth of gems in there\!  You'd better tie it up before putting more gems inside\.
#action put #tvar char.loot.untiedGemPouch 1 when ^Tie it off when it's empty\?  Why\?


###############################
###    MAIN
###############################
loot-main:
    gosub loot-pickupLoot
    gosub loot-pickupLootAtFeet
    pause .2
    put #parse LOOT DONE
    exit


###############################
###    UTILITY
###############################
loot-tieOff:
    if !(matchre("$righthand|$lefthand", "Empty")) then {
        gosub put my $righthandnoun in my $char.inv.container.default
        gosub put my $lefthandnoun in my $char.inv.container.default
    }
    gosub tie my $char.inv.container.gemPouch
    gosub fill my $char.inv.container.gemPouch with my $char.inv.container.default
    goto loot-main


loot-pickupLoot:
    eval objArray replacere("$roomobjs", ",", "|")
    eval objArray replacere("%objArray", " and ", "|")
    var loot.index 0

    loot-pickupLootLoop:
        eval preLootLen len("$roomobjs")
        if (matchre("%objArray(%loot.index)", "(%lootables)")) then {
            var item $1

            # Commented this in case bars and nuggets need to use STOW GEM instead of STOW %item
            #if (matchre("%item", "(%gems)") || matchre("%item", "(%craftMaterial)") then {
            if (matchre("%item", "(%gems)")) then {
                gosub stow gem
                if ($char.loot.untiedGemPouch = 1) then {
                    put #tvar char.loot.untiedGemPouch 0
                    gosub tie my $char.inv.container.gemPouch
                }
            } else {
                gosub stow %item
            }
        }

        if (%newGemPouch = 1) then {
            if (!matchre("$lefthand", "Empty")) then {
                gosub put my $lefthandnoun in my $char.inv.container.default
            }
            if (!matchre("$righthand", "Empty")) then {
                gosub put my $righthandnoun in my $char.inv.container.default
            }
            gosub remove my $char.inv.container.gemPouch
            gosub put my $char.inv.container.gemPouch in my $char.inv.container.fullGemPouch
            gosub get my $char.inv.container.gemPouch from my $char.inv.container.emptyGemPouch

            if (matchre("$lefthandnoun", "pouch") || matchre("$righthandnoun", "pouch")) then {
                gosub wear my $char.inv.container.gemPouch
                gosub fill my $char.inv.container.gemPouch with my $char.inv.container.default
                gosub tie my $char.inv.container.gemPouch
                # In case there is more than 70 gems, fill again.
                gosub fill my $char.inv.container.gemPouch with my $char.inv.container.default
                gosub store gem $char.inv.container.gemPouch
            } else {
                gosub drop my %lootables(%loot.index)
            }
            var newGemPouch 0
            goto loot-pickupLootLoop
        }

        math loot.index add 1
        if (%loot.index > count ("%objArray", "|")) then return
        goto loot-pickupLootLoop


loot-pickupLootAtFeet:
    action (invFeet) on
    var toLoot null
    pause .2
    gosub inv atfeet
    action (invFeet) off
    eval invLength count("%toLoot", "|")
    var invIndex 0


    loot-pickupLootAtFeetLoop:
        #if ("%toLoot(%invIndex)" != "null") then gosub stow %toLoot(%invIndex)
        if ("%toLoot(%invIndex)" != "null") then gosub stow feet
        math invIndex add 1
        if (%invIndex > %invLength) then return
        goto loot-pickupLootAtFeetLoop
