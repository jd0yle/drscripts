####################################################################################################
# empty.cmd
# Selesthiel - justin@jmdoyle.com
# Inauri - snmurphy95@gmail.com
#
# USAGE
# .empty [nowear] <container>
#
# .empty large sack
# .empty nowear thigh bag
#
####################################################################################################
include libmaster.cmd

var nowear 0

if_1 then {
    if ("%1" = "nowear") then var nowear 1
    shift
    var container %0
} else {
    echo MUST SPECIFY CONTAINER
    echo .%scriptname [nowear] <container>
    echo
    goto done
}

eval whitelistLength count("$empty.whitelist", "|")
if (%whitelistLength = 0) then put #var empty.whitelist shield

eval blacklistLength count("$empty.blacklist", "|")
if (%blacklistLength = 0) then put #var empty.blacklist the

#action var items %items|$1  when ^  (\w+.*)
action var contents $1 when ^In the.*you see (.*)

pause .2
gosub look in my %container
pause .2

# contents example: "In the large sack you see some black moonsilk pants, a tiny blue aquamarine and some throwing blades."
# items example: "some black moonsilk pants|a tiny blue aquamarine|some throwing blades"
eval items replacere("%contents", ", ", "|")
eval items replacere("%items", " and ((?:a|some).*?)\.", "|\$1")

var index 0
eval numItems count("%items", "|")

if (%numItems = 0) then {
    echo CONTAINER %container IS EMPTY!
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
        if (matchre("$empty.whitelist", "%word") || !matchre("$empty.blacklist", "%word")) then {
            gosub get my %word from my %container
            if ("$lefthand" != "Empty") then {
                if (!matchre("$empty.whitelist", "%word") then {
	                put #echo >Log [empty] ADDING %word to empty.whitelist
	                put #var empty.whitelist $empty.whitelist|%word
                }
	            if ("%nowear" != "1") then gosub wear my %word
	            if ("$lefthand" != "Empty") then {
	                gosub stow my %word
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
    if (%index > %numItems) then exit
    goto loop

done:
    pause .2
    eval sname toupper(%scriptname)
    put #parse %sname DONE
    exit
