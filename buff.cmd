########################################################################################
# .buff
#
# Selesthiel - Justin Doyle <justin@jmdoyle.com>
#
# USAGE
# .buff [args] [spell]
#
# CONFIG
# add new groups with spells to the buffGroups object in the config section
#
# EXAMPLES
#    .buff hunt
#    .buff pvp
#    .buff shadows
#
# NOTE: Currently only harnesses mana, does not use cambrinth
# TODO: Add support for target spells like Cage of Light and Focus Moonbeam
#       Add support for ritual spells
########################################################################################
include libsel.cmd
var buffGroup %1
########################################################################################
###################################### CONFIG ##########################################\
# Set to 1 to use cambrinth, 0 to harness
var useCambrinth 1
# Set to 1 if it is worn, 0 if it needs to be stowed
var isCambrinthWorn 0
var cambrinth yoakena globe

<%
var buffGroups = {
    hunt: [
        { spellName: "seer", mana: 100 },
        { spellName: "maf", mana: 100 }
    ],
    pvp: [
        { spellName: "seer", mana: 100 },
        { spellName: "maf", mana: 100 },
        { spellName: "psy", mana: 100},
        { spellName: "shadows", mana: 100},
        { spellName: "cv", mana: 100}
    ],
    astro: [
        { spellName: "aus", mana: 100},
        { spellName: "pg", mana: 100}
    ],
    nameOfYourChoice: [
        { spellName: "some spell name", mana: 1234} // mana is the amount of the prep + the harness/cambrinth
    ]
}
%>
########################################################################################
########################################################################################




var completed 0
var isFullyPrepped 0

action var isFullyPrepped 1 when ^You feel fully prepared to cast your spell.

<%
    var index = 0;
    var buffGroup = getVar("buffGroup");

    if (!buffGroups[buffGroup]) {
        buffGroups[buffGroup] = [{spellName: buffGroup}];
    }

    var getBuffGroupNames = function () {
        var ret = [];
        for (var groupName in buffGroups) {
            ret.push(groupName);
        }
        return ret.join("|");
    };

    var setNextPrep = function () {
        setVar("spellName", buffGroups[buffGroup][index].spellName);
        setVar("spellMana", buffGroups[buffGroup][index].mana)
        index++;
        if (index >= buffGroups[buffGroup].length) {
            setVar("completed", 1);
        }
    }
%>

preploop:
    if (%completed = 1) then goto buffDone
    if ("$preparedspell" != "None") then gosub release
    js setNextPrep()
    gosub prep %spellName 20
    if (%useCambrinth = 1) then {
        gosub chargeLoop
        if (%isCambrinthWorn = 0) then gosub stow my %cambrinth
    } else {
        gosub harnessLoop
    }
    if (%isFullyPrepped != 1) then gosub waitPrep
    gosub cast
    goto preploop


harnessLoop:
## Since we prepped at 20, we want to take 20 mana straight off the top
math spellMana subtract 20
var harnessIndex 0

harnessLoop1:
    echo %spellMana
    var amount 20
    if (%amount > %spellMana) then var amount %spellMana
    gosub harness %amount
    math spellMana subtract 20
    if (%spellMana < 1) then return
    goto harnessLoop1


chargeLoop:
if (%isCambrinthWorn = 0) then gosub get my %cambrinth
## Since we prepped at 20, we want to take 20 mana straight off the top
math spellMana subtract 20
var chargeIndex 0

chargeLoop1:
    echo %spellMana
    var amount 20
    if (%amount > %spellMana) then var amount %spellMana
    gosub charge my %cambrinth %amount
    math spellMana subtract 20
    if (%spellMana < 1) then {
        gosub focus my %cambrinth
        gosub invoke my %cambrinth
        return
    }
    goto chargeLoop1


waitPrep:
    pause
    if (%isFullyPrepped = 1) then return
    goto waitPrep


buffDone:
    put #parse BUFF DONE
    exit

