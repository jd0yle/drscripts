include libsel.cmd

var options %0

if ("$charactername" = "Selesthiel") then {
    var specialStorage tort sack
    var container backpack
    var gemPouchContainer backpack
} else {
    var specialStorage skull
    var container skull
    var gemPouchContainer satchel
}




var scrolls scroll|ostracon|\broll|leaf|vellum|tablet|(?<!of )parchment|bark|papyrus
var treasuremaps \bmap\b
var gems1 agate|alexandrite|amber|amethyst|andalusite|aquamarine|bead|beryl|bloodgem|bloodstone|carnelian|chrysoberyl|carnelian|chalcedony
var gems2 chrysoberyl|chrysoprase|citrine|coral|crystal|diamond\b|diopside|emerald|egg|eggcase|garnet|gem|goldstone|glossy malachite
var gems3 hematite|iolite|ivory|jade|jasper|kunzite|lapis lazuli|malachite stone|minerals|moonstone|morganite|onyx
var gems4 quartz|opal|pearl|pebble|peridot|quartz.(?!gargoyle)|ruby|sapphire|spinel|star-stone|sunstone|talon|tanzanite|tooth|topaz|tourmaline|tsavorite|turquoise|zircon
var gweths (?:jadeite|kyanite|lantholite|sjatmal|waermodi|lasmodi) stones
var boxtype brass|copper|deobar|driftwood|iron|ironwood|mahogany|oaken|pine|steel|wooden
var boxes coffer|crate|strongbox|caddy|casket|skippet|trunk|chest|\bbox
var miscKeep crumpled page|singed page|book spine|shattered bloodlock|front cover|kirmhiro draught
var ammo basilisk arrow|bolt|stone|rock\b|throwing blade|quadrello|blowgun dart|throwing hammer|hhr'ata|bola|boomerang|small rock
var coin coin

var gems %gems1|%gems2|%gems3|%gems4

#var box (?:%boxtype) (?:%boxes)
#var boxes (?:brass|copper|deobar|driftwood|iron|ironwood|mahogany|oaken|pine|steel|wooden) (?:coffer|crate|strongbox|caddy|casket|skippet|trunk|chest|\bbox)

var lootables %ammo|%scrolls|%treasuremaps|%gems1|%gems2|%gems3|%gems4|%miscKeep|%coin

var toLoot null
action (invFeet) var toLoot %toLoot|$1 when (%lootables)
action (invFeet) off

var newGemPouch 0
action var newGemPouch 1 when ^You think the gem pouch is too full to fit another gem into.
action var newGemPouch 1 when ^The gem pouch is too full to fit any more gems!
action var newGemPouch 1 when ^WARNING: You are carrying an extremely large number of items on your person\.$

gosub pickupLoot
gosub pickupLootAtFeet
put #parse LOOT DONE
exit


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
            gosub stow %lootables(%loot.index)
            if (%newGemPouch = 1) then {
                if ("$lefthand" != "Empty") then {
                    gosub put my $lefthandnoun in my %container
                }
                gosub stow right
                gosub stow left
                gosub remove my gem pouch
                gosub put my gem pouch in my portal
                gosub get gem pouch from my %gemPouchContainer
                gosub wear my gem pouch
                gosub store gem gem pouch
                gosub fill my gem pouch with my %container
                gosub tie my gem pouch
                gosub drop my %lootables(%loot.index)
                var newGemPouch 0
                goto pickupLootLoop
                #gosub stow %lootables(%loot.index)
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
        if ("%toLoot(%invIndex)" != "null") then gosub stow %toLoot(%invIndex)
        math invIndex add 1
        if (%invIndex > %invLength) then return
        goto pickupLootAtFeetLoop
