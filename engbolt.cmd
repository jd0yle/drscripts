include libmaster.cmd
###############################
###    IDLE ACTION TRIGGERS
###############################
action goto engbolt.boltheads when ^The bolts are ready for an application of glue to affix each bolthead\.$|^The bolts must have glue applied to them for affixing the boltheads\.$
action goto engbolt.flights when ^The bolts are ready for an application of glue to attach the flights\.$|^The bolts must have glue applied to them for affixing the flights\.$
action goto engbolt.knife when ^Now the flights are ready to be trimmed with a carving knife\.$|^A handful of rough edges require carving with a knife to remove\.$|^The arrows must be carved with a knife to trim and shape the flights\.$|^Several adjustments must be made to the bolt by carving it with a knife\.$
action goto engbolt.shaper when ^The bolts is ready for shaping with a wood shaper\.$
action var engbolt.pageContent $1 when ^You turn your book to page \d+, instructions for crafting (.+) bolts\.$


###############################
###    VARIABLES
###############################
var engbolt.boltheadMaterial fang
var engbolt.boltheadMaterialBag backpack
var engbolt.numberCrafted 0
var engbolt.numberNeeded %1
var engbolt.page 9
var engbolt.pageContent 0
var engbolt.craftbag $char.inv.container.craft
var engbolt.defaultbag $char.inv.container.default


if (%engbolt.numberNeeded = null) then {
    var engbolt.numberNeeded 1
}
gosub store default %engbolt.craftbag
put #echo >log [engbolt] Beginning. 0/%engbolt.numberNeeded
###############################
###    MAIN
###############################
engbolt.checkForPartial:
    if ("$righthand" <> "Empty") then {
        gosub analyze my $righthandnoun
    }


engbolt.book:
    gosub get my tinker book
    gosub turn my book to chap 7
    gosub turn my book to page %engbolt.page
    if ("%engbolt.pageContent" <> "basilisk") then {
        put #echo >Log [engbolt] Page for basilisk bolts is wrong.  Fix it nerd.
        goto engbolt.exit
    }
    gosub study my book
    gosub stow my book
    goto engbolt.shafts


engbolt.boltheads:
    pause .2
    if ("$lefthandnoun" = "shaper") then {
        gosub stow my shaper
    }
    gosub get my boltheads
    if ("$lefthand" = "Empty") then {
        gosub stow bolts
        gosub open my %engbolt.boltheadMaterialBag
        gosub get %engbolt.boltheadMaterial from my %engbolt.boltheadMaterialBag

        if ("$righthand" = "Empty") then {
            put #echo >Log [engbolt] No boltheads and no %engbolt.boltheadMaterial, exiting.
            goto engbolt.exit
        }
        gosub get my rasp
        if ("$lefthandnoun" <> "rasp") then {
            put #echo >Log [engbolt] Rasp missing, exiting.
            goto engbolt.exit
        }
        gosub shape my %engbolt.boltheadMaterial into bolthead
        gosub stow my rasp
        gosub swap
        gosub get my bolts
    }

        gosub assemble my bolts with my boltheads
        if ("$lefthandnoun" = "boltheads") then {
            gosub stow boltheads
        }
        gosub get my glue
        if ("$lefthandnoun" <> "glue") then {
            put #echo >Log [engbolt] No glue, exiting at bolthead application.
            goto engbolt.exit
        }
        gosub apply my glue to my bolts
        if ("$lefthandnoun" = "glue") then {
            gosub stow glue
        }


        engbolt.boltheadsLoop:
        if ("$lefthandnoun" <> "shaper") then {
            gosub get my shaper
        }
        if ("$lefthand" = "Empty") then {
            put #echo >Log [engbolt] Missing shaper.
            goto engbolt.exit
        }
        gosub shape my bolt with shaper
        pause .2
        goto engbolt.boltheadsLoop


engbolt.flights:
    pause .2
    if ("$lefthandnoun" = "shaper" || "$lefthandnoun" = "knife") then {
        gosub stow my $lefthandnoun
    }
    gosub get my flights
    if ("$lefthand" = "Empty") then {
        put #echo >Log [engbolt] Missing flights, exiting.
        goto engbolt.exit
    }

    gosub assemble my bolts with my flights
    gosub stow flights
    gosub get my glue
    if ("$lefthand" = "Empty") then {
        put #echo >Log [engbolt] Missing glue at flights application, exiting.
        goto engbolt.exit
    }
    gosub apply my glue to my bolts
    gosub stow glue
    goto engbolt.knife


engbolt.knife:
    pause .2
    if ("$lefthandnoun" = "shaper") then {
        gosub stow my shaper
    }
    if ("$lefthandnoun" <> "Empty") then {
        gosub stow left
    }
    gosub get my carving knife
    gosub carve my bolts with my knife
    gosub stow carving knife
    goto engbolt.analyze


engbolt.shafts:
    pause .2
    gosub get my shafts

    # Make shafts from lumber.
    if ("$righthand" = "Empty") then {
        gosub get my lumber
        if ("$righthand" = "Empty") then {
            put #echo >Log [engbolt] No shafts and no lumber, exiting.
            goto engbolt.exit
        }
        gosub mark my lumber at 2
        gosub get my scissors
        gosub cut my lumber with my scissors
        gosub stow scissors
        gosub stow lumber
        gosub get my lumber
        if ("$lefthandnoun" <> "shaper") then {
            gosub get my shaper
        }
        if ("$lefthand" = "Empty") then {
            put #echo >Log [engbolt] Missing shaper.
            goto engbolt.exit
        }
        gosub shape my lumber into bolt shaft
    }

    # Make bolts from shafts.
    pause .2
    if ("$lefthandnoun" <> "shaper") then {
        gosub get my shaper
    }
    if ("$lefthand" = "Empty") then {
        put #echo >Log [engbolt] Missing shaper.
        goto engbolt.exit
    }
    gosub shape shaft with my shaper
    gosub stow my shaper
    gosub get shafts
    gosub stow shafts
    gosub get my shaper


    engbolt.shaftsLoop:
        pause .2
        if ("$lefthandnoun" = "shaper" || "$lefthandnoun" = "knife") then {
            gosub stow my $lefthandnoun
        }
        gosub get my shaper
        if ("$lefthand" = "Empty") then {
            put #echo >Log [engbolt] Missing shaper.
            goto engbolt.exit
        }
        gosub shape my bolts with shaper
        goto engbolt.shaftsLoop


engbolt.shaper:
    pause .2
    if ("$lefthandnoun" = "knife") then {
        gosub stow my carving knife
    }
    if ("$lefthandnoun" <> "shaper") then {
        gosub get my shaper
    }
    if ("$lefthand" = "Empty") then {
        put #echo >Log [engbolt] Missing shaper.
        goto engbolt.exit
    }


    engbolt.shaperLoop:
        gosub shape my bolts with my shaper
        goto engbolt.shaperLoop


engbolt.analyze:
    gosub analyze my bolts
    gosub stow bolts
    evalmath engbolt.numberCrafted (%engbolt.numberCrafted + 1)
    if (%engbolt.numberNeeded > %engbolt.numberCrafted) then {
        put #echo >log [engbolt] Progress %engbolt.numberCrafted/%engbolt.numberNeeded
        goto engbolt.book
    }
    gosub store default %engbolt.defaultbag
    put #echo >log [engbolt] Complete.
    goto engbolt.exit


engbolt.exit:
    pause .2
    put #parse ENGBOLT DONE
    exit