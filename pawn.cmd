include libmaster.cmd

####################################################################################################
# CONFIG

var container backpack

if ("$charactername" = "Qizhmur") then {
    var container portal
}

####################################################################################################

var dryRun false
if_1 then {
    var dryRun true
}

var sellables bathrobe|sphere|cylinder|bangles|towel|cufflinks|bottoms|top|lunchbox|razor|bowl|amulet|skillet|stove|handkerchief|sieve|stick|pillow|mortar|pestle|brush|bear|earrings|choker|haircomb|sieve|knife|broom|cube|dagger|helm|nightgown|comb|cloak|fabric|bank|bowl|nightcap|fan|scissors|paperweight|yardstick|diary|kaleidoscope|hauberk|pajamas|shaper|leaflet|arrows|lamp|slippers|apron|prism|blanket|quill|locket|rod|shield|lens|cylinder|bracer|rasp|ring|charts|distaff|sipar|case|cowbell|hammer|pins|mirror|gloves|telescope|crossbow|scroll|leathers|case|scimitar|statuette|plate|cudgel|slate|briquet|blossom|oil
var soldItems null

action var items $1 when ^You rummage through.*and see (.*)\.$

gosub rummage my %container
pause

eval itemArr replace("%items", ",", "|")
eval itemLength count("%itemArr", "|")
var index 0

loop:
    var item %itemArr(%index)
    if (matchre("%item", "\b(%sellables)\b") then {
        var sellItem $1

        if (%dryRun != true) then {
            gosub get my %sellItem from my %container
            gosub sell my %sellItem
            if ("$righthand" != "Empty") then gosub put my %sellItem in bucket
            if ("$righthand" != "Empty") then gosub drop my %sellItem
            if ("$righthand" != "Empty") then gosub put my %sellItem in my %container
        } else {
            echo Selling %sellItem -- %item
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
    put #echo >Log [pawn]: Sold %soldItems
    put #parse PAWN DONE
    exit


