include libmaster.cmd
###############################
###    SHOP
###############################


###############################
###    IDLE ACTION TRIGGERS
###############################
action put #echo >Log $1 $2 $3 when ^\s\s(.*) for (\d+) (\S+) (Kronars|Dokoras|Lirums)
action var shopSurface %shopSurface|$1 when ^(%surfaces)


###############################
###    VARIABLES
###############################
var shopSurface 0
var shopSurfaceIndex 0
var shopSurfaceLength 0
var surfaces1 altar|armoir|bale|bar|barn|barrel|basket|bedroll|bench|bin|block|blossom|boar|board|bookcase|bookshelf|bookshelves|bookstand|bowl|box|branch|breakfront|broomstick|bucket|buffet|bull|bureau|bust|butterflies|butterfly|
var surfaces2 cabinet|carpet|cart|carton|case|catalog|cauldron|chair|chest|closet|cloud|coffer|container|cord|cornucopia|corral|cot|counter|cradle|crate|cupboard|cushion|
var surfaces3 desk|display|drawer|dresser|drum|dummies|dummy|easel|endtable|fence|firepit|footlocker|footrest|fountain|framework|garderobe|goblin|gourd|grinder|hand|hanger|hatstand|head|highboy|hole|hook|hooks|horse|jar|
var surfaces4 keg|lattice|locker|lowboy|mannequin|mantel|mantle|moon|net|niche|ogre|pail|pallet|panel|peccaries|peccary|pedestal|peg|pegboard|pew|pillow|pipe|pit|plank|planter|platter|plinth|podium|pole|post|pumpkin|quilt|
var surfaces5 rack|rope|rug|salver|sawhorse|shelf|shell|shelves|showcase|sidebar|sideboard|skeleton|skippet|spittoon|stable|stand|star|stool|stove|stump|sun|table|tomb|tray|tree|trestle|trough|trunk|turtle|urn|
var surfaces6 valet|vanities|vanity|vat|wall|wardrobe|waterwheel|web|webbing|workbench|worktable
var surfaces surfaces1 + surfaces2 + surfaces3 + surfaces4 + surfaces5 + surfaces6



###############################
###    OPTIONS
###############################
if_1 then {
    if ("%1" = "limited") then {
        goto shop.limited
    }
} else {
    goto shop.main
}


###############################
###    VARIABLES
###############################
shop.limited:
    gosub move go arch
    gosub shop stand
    gosub shop other stand
    gosub shop third stand
    gosub shop.exit


shop.main:
    gosub shop
    if (%shopSurface <> 0) then {
        eval shopSurfaceLength count("%shopSurface", "|")
    }
    if (contains("%roomobjs", "%surfaces")) then {

    }

shop.exit:
    pause .002
    put #parse SHOP DONE
    exit
