####################################################################################################
# empty.cmd
# Selesthiel - justin@jmdoyle.com
# Inauri - snmurphy95@gmail.com
#
# USAGE
# .empty [--from] [--to] [--nowear=1|0] [--filter]
#
# If no --to is specified, the item will be STOWed
# if --wear=1 is specified, the item will not be WORN
#
# .empty --from=large sack --to=backpack
# .empty --from=thigh bag --nowear=1
# .empty --from=large sack --to=haversack --filter=gloves|sword|pants
#
####################################################################################################
include libmaster.cmd
include args.cmd

var nowear 0

var fromContainer %args.from
var toContainer %args.to
if (%args.nowear = 1) then var nowear 1
var filter %args.filter
eval filter replacere("%filter", ",", "|")

if ("%toContainer" = ".to") then var empty.stow 1

eval whitelistLength count("$empty.whitelist", "|")
if (%whitelistLength = 0) then put #var empty.whitelist shield

eval blacklistLength count("$empty.blacklist", "|")
if (%blacklistLength = 0) then put #var empty.blacklist the

#action var items %items|$1  when ^  (\w+.*)
action var contents $1 when ^In the.*you see (.*)



pause .2
gosub look in my %fromContainer
pause .2

# contents example: "In the large sack you see some black moonsilk pants, a tiny blue aquamarine and some throwing blades."
# items example: "some black moonsilk pants|a tiny blue aquamarine|some throwing blades"
eval items replacere("%contents", ", ", "|")
eval items replacere("%items", " and ((?:a|some).*?)\.", "|\$1")

var index 0
eval numItems count("%items", "|")

if (%numItems = 0) then {
    echo CONTAINER %fromContainer IS EMPTY!
    goto done
}

loop:
    # item example: "some black moonsilk pants"
    var item %items(%index)

    # words example: "some|black|moonsilk|pants"
    eval words replacere("%item", " ", "|")

    var wordIndex 0
    eval numWords count("%words", "|")

    wordLoop:
        var word %words(%wordIndex)

        var isInFilter 1
        if ("%filter" != ".filter") then {
            if (!matchre("%filter", "%word")) then var isInFilter 0
        }

        if (%isInFilter = 1 && "%word" != "a" && (matchre("($empty.whitelist)", "%word") || !matchre("($empty.blacklist)", "%word"))) then {
            gosub get my %word from my %fromContainer
            if ("$lefthand" != "Empty") then {
                if (!matchre("$empty.whitelist", "%word") then {
	                put #echo >Log [empty] ADDING %word to empty.whitelist
	                put #var empty.whitelist $empty.whitelist|%word
                }
	            if ("%nowear" != "1") then gosub wear my %word
	            if ("$lefthand" != "Empty") then {
	                if (%empty.stow = 1) then {
	                    gosub stow my %word
	                } else {
	                    gosub put my %word in my %toContainer
                    }
                }
            } else {
                if (!matchre("$empty.blacklist", "%word")) then {
                    put #echo >Log [empty] ADDING %word to empty.blacklist
                    put #var empty.blacklist $empty.blacklist|%word
                }
            }
        }
        math wordIndex add 1
        if (%wordIndex <= %numWords) then goto wordLoop

    math index add 1
    if (%index > %numItems) then goto done
    goto loop

done:
    pause .2
    eval sname toupper(%scriptname)
    put #parse %sname DONE
    exit
