include libsel.cmd

var options %0


var scrolls scroll|ostracon|\broll|leaf|vellum|tablet|(?<!of )parchment|bark|papyrus
var treasuremaps \bmap\b
var gems1 agate|alexandrite|amber|amethyst|andalusite|aquamarine|bead|beryl|bloodgem|bloodstone|carnelian|chrysoberyl|carnelian|chalcedony
var gems2 chrysoberyl|chrysoprase|citrine|coral|crystal|diamond|diopside|emerald|egg|eggcase|garnet|gem|goldstone|glossy malachite
var gems3 hematite|iolite|ivory|jade|jasper|kunzite|lapis lazuli|malachite stone|minerals|moonstone|morganite|onyx
var gems4 opal|pearl|pebble|peridot|quartz.(?!gargoyle)|ruby|sapphire|spinel|star-stone|sunstone|talon|tanzanite|tooth|topaz|tourmaline|tsavorite|turquoise|zircon
var gweths (?:jadeite|kyanite|lantholite|sjatmal|waermodi|lasmodi) stones
var boxtype brass|copper|deobar|driftwood|iron|ironwood|mahogany|oaken|pine|steel|wooden
var boxes coffer|crate|strongbox|caddy|casket|skippet|trunk|chest|\bbox
var miscKeep crumpled page|singed page|book spine|shattered bloodlock|front cover
var ammo arrow|bolt|stone|rock|throwing blade|quadrello
var coin coin

#var box (?:%boxtype) (?:%boxes)
#var boxes (?:brass|copper|deobar|driftwood|iron|ironwood|mahogany|oaken|pine|steel|wooden) (?:coffer|crate|strongbox|caddy|casket|skippet|trunk|chest|\bbox)

var lootables %scrolls|%treasuremaps|%gems1|%gems2|%gems3|%gems4|%miscKeep|%ammo|%coin

#var lootables throwing blade|arrow|bolt|quadrello|brazier|arrow|coin|coins|iolite|hematite|moonstone|coffer|turquoise|box|morganite|small rock|spinel|dioside|crate|kunzite|caddy|chrysoberyl|coral|card|trunk|tanzanite|amber|chalcedony|tourmaline|skippet|jade|chrysoprase|diopside|peridot|andalusite|carnelian|citrine
var toLoot null
action (invFeet) var toLoot %toLoot|$1 when (%lootables)
action (invFeet) off

gosub pickupLoot
gosub pickupLootAtFeet
put #parse LOOT DONE
exit


pickupLoot:
    #eval gwethsInRoom matchre("$roomobjs", "(%gweths)")
    if (contains("$roomobjs", "waermodi stone")) then {
        gosub get waermodi stone
        gosub put waermodi stone in my telescope case
    }

    eval numItems count("%lootables", "|")
    var loot.index 0

    pickupLootLoop:
        eval preLootLen len("$roomobjs")
        if (contains("$roomobjs", "%lootables(%loot.index)")) then {
            gosub stow %lootables(%loot.index)
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