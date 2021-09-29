include libmaster.cmd

var container $char.pawn.container

var dryRun false
if_1 then {
    var dryRun true
}
put .BurgleVariables
var donotsell $BURGLE.KEEP
var trashItems $BURGLE.TRASHITEMS
var sellables amulet|apron|bangles|bank|bathrobe|bear|blanket|blossom|bottoms|bowl|bracer|briquet|broom|brush|canvas tote|charts|choker|cloak|comb|cookbook|cowbell|cube|cudgel|cufflinks|cylinder|diary|distaff|earrings|fan|hammer|handkerchief|haircomb|jug|kaleidoscope|knife|knives|lamp|leaflet|lens|locket|lunchbox|mirror|mortar|napkin|nightcap|nightgown|oil|opener|pajamas|paperweight|pestle|pil|ow|pins|plate|prism|quill|rasp|razor|ring|rod|scissors|scroll|shakers|shaper|sieve|sipar|skillet|slate|slippers|snare|sphere|statuette|sti|k|stove|tankard|towel|top|twine|vaseyardstick
var soldItems null

action var items $1 when ^You rummage through.*and see (.*)\.$

if ($SpellTimer.RefractiveField.active = 1) then gosub release rf

gosub rummage my %container
pause

eval itemArr replace("%items", ",", "|")
eval itemLength count("%itemArr", "|")
var index 0

loop:
    var item %itemArr(%index)
    if (matchre ("%item", "\b(%donotsell)\b") then {
        put #echo >Log [pawn] Keeping %item.
    }
    if (matchre ("%item", "\b(%trashItems)\b") then {
        gosub get my %item from my %container
        gosub put my %item in bucket
        put #echo >Log [pawn] Trashing %item.
    }
    if (matchre("%item", "\b(%sellables)\b") then {
        var sellItem $1

        if (%dryRun != true) then {
            gosub get my %sellItem from my %container
            gosub sell my %sellItem
            if ("$righthand" != "Empty") then gosub put my %sellItem in bucket
            if ("$righthand" != "Empty") then gosub drop my %sellItem
            if ("$righthand" != "Empty") then gosub put my %sellItem in my %container
        } else {
            put #echo >Log [pawn] Selling %sellItem -- %item
        }

        if ("%soldItems" = "null") then {
            var soldItems %item
        } else {
            var soldItems %soldItems, %item
        }
    }
    math index add 1
    if (%index >= %itemLength) then goto done
    goto loop



done:
    if (%soldItems <> null) then {
        put #echo >Log [pawn] Sold %soldItems
    } else {
        put #echo >Log [pawn] Nothing sold.
    }
    put #parse PAWN DONE
    exit


