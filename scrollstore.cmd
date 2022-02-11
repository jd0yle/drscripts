include libmaster.cmd

var scrollstore.scrollItems scroll|ostracon|roll|leaf|vellum|tablet|parchment|bark|papyrus
var scrollstore.stackerItems folio|worn book

var tempContainer $char.inv.container.scrollTemp


action var scrollstore.spellName $1; put #echo >Log Scroll: $1 when ^It is labeled "(.*)\."$
action var scrollstore.spellName $1; put #echo >Log Scroll: $1 when contains a complete description of the (.*) spell



gosub stow right
gosub stow left

scrollstore.getScroll:
    var scrollstore.spellName null
    if (!(%scrollstore.scrollIndex > -1)) then var scrollstore.scrollIndex 0
    gosub get my %scrollstore.scrollItems(%scrollstore.scrollIndex) from my $char.inv.container.scroll
    if ("$righthand" = "Empty") then {
        math scrollstore.scrollIndex add 1
        if (%scrollstore.scrollIndex > count("%scrollstore.scrollItems", "|")) then goto scrollstore.done
        goto scrollstore.getScroll
    }
    gosub look my %scrollstore.scrollItems(%scrollstore.scrollIndex)
    if ("%scrollstore.spellName" = "null") then gosub read my %scrollstore.scrollItems(%scrollstore.scrollIndex)



scrollstore.storeScroll:
    var scrollstore.stackerIndex 0

    scrollstore.storeScroll.loop:
        gosub get my %scrollstore.stackerItems(%scrollstore.stackerIndex) from my $char.inv.container.scrollStackers
        if ("$lefthand" = "Empty") then {
            math scrollstore.stackerIndex add 1
            if ("%scrollstore.stackerIndex" > count("%scrollstore.stackerItems", "|") then {
                gosub scrollstore.resetStackerStorage
                goto scrollstore.done
            }
            goto scrollstore.storeScroll.loop
        }
        gosub open my %scrollstore.stackerItems(%scrollstore.stackerIndex)
        gosub push my %scrollstore.stackerItems(%scrollstore.stackerIndex) with my %scrollstore.scrollItems(%scrollstore.scrollIndex)
        gosub put my %scrollstore.stackerItems(%scrollstore.stackerIndex) in my %tempContainer
        if ("$righthand" != "Empty") then goto scrollstore.storeScroll.loop
        gosub scrollstore.resetStackerStorage
        goto scrollstore.getScroll



scrollstore.storeScroll.foundSpell:
    gosub push my %scrollstore.stackerItems(%scrollstore.stackerIndex) with my %scrollstore.scrollItems(%scrollstore.scrollIndex)
    gosub put my %scrollstore.stackerItems(%scrollstore.stackerIndex) in my %tempContainer
    if ("$righthand" != "Empty") then goto scrollstore.storeScroll.loop
    goto scrollstore.getScroll



scrollstore.resetStackerStorage:
    var scrollstore.stackerIndex 0

    scrollstore.resetStackerStorage.loop:
        gosub get my %scrollstore.stackerItems(%scrollstore.stackerIndex) from my %tempContainer
        if ("$righthand" = "Empty") then {
            math scrollstore.stackerIndex add 1
            if (%scrollstore.stackerIndex > count("%scrollstore.stackerItems", "|") then return
        }
        gosub put my %scrollstore.stackerItems(%scrollstore.stackerIndex) in my $char.inv.container.scrollStackers
        goto scrollstore.resetStackerStorage.loop