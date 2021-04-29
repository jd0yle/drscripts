include libmaster.cmd
###############################
###    IDLE ACTION TRIGGERS
###############################
action goto engbolt.boltheads when ^The bolts are ready for an application of glue to affix each bolthead\.$
action goto engbolt.flights when ^The bolts are ready for an application of glue to attach the flights\.$
action goto engbolt.knife when ^Now the flights are ready to be trimmed with a carving knife\.$|^A handful of rough edges require carving with a knife to remove\.$
action goto engbolt.shaper when ^The bolts is ready for shaping with a wood shaper\.$
action var engbolt.pageContent $1 when ^You turn your book to page \d+, instructions for crafting (.+) bolts\.$


###############################
###    VARIABLES
###############################
var engbolt.boltheadMaterial fang
var engbolt.boltheadMaterialBag backpack
var engbolt.page 9
var engbolt.pageContent 0
var engbolt.craftbag $char.craft.container
var engbolt.defaultbag $char.craft.default.container



gosub store default %engbolt.craftbag
###############################
###    MAIN
###############################
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
        gosub tie my shaper to my toolbelt
    }
    gosub get my boltheads
    if ("$righthand" = "Empty") then {
        gosub open my %engbolt.boltheadMaterialBag
        gosub get %engbolt.boltHeadMaterial from my %engbolt.boltheadMaterialBag

        if ("$righthand" = "Empty") then {
            put #echo >Log [engbolt] No boltheads and no %engbolt.boltheadMaterial, exiting.
            goto engbolt.exit
        }
        gosub untie my rasp on toolbelt
        if ("$lefthandnoun" <> "rasp") then {
            put #echo >Log [engbolt] Rasp missing, exiting.
            goto engbolt.exit
        }
        gosub shape %eng.boltheadMaterial into bolthead
        gosub tie my rasp to toolbelt
        gosub get my shafts
    }

        gosub assemble my bolts with my boltheads
        gosub stow boltheads
        gosub get my glue
        if ("$lefthandnoun" <> "glue") then {
            put #echo >Log [engbolt] No glue, exiting at bolthead application.
            goto engbolt.exit
        }
        gosub apply my glue to my bolts
        gosub stow glue


        engbolt.boltheadsLoop:
        if ("$lefthandnoun" <> "shaper") then {
            gosub untie my shaper on toolbelt
        }
        if ("$lefthand" = "Empty") then {
            put #echo >Log [engbolt] Missing shaper.
            goto engbolt.exit
        }
        gosub shape bolt with shaper
        pause .2
        goto engbolt.boltheadsLoop


engbolt.flights:
    pause .2
    if ("$lefthandnoun" = "shaper" || "$lefthandnoun" = "knife") then {
        gosub tie my $lefthandnoun to my toolbelt
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
        gosub tie my shaper to my toolbelt
    }
    if ("$lefthandnoun" <> "Empty") then {
        gosub stow left
    }
    gosub untie my carving knife on my toolbelt
    gosub carve my bolts with my knife
    gosub tie my knife to my toolbelt
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
            gosub untie my shaper on toolbelt
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
        gosub untie my shaper to my toolbelt
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
            gosub tie my $lefthandnoun to my toolbelt
        }
        gosub untie my shaper on my toolbelt
        if ("$lefthand" = "Empty") then {
            put #echo >Log [engbolt] Missing shaper.
            goto engbolt.exit
        }
        gosub shape my bolts with shaper
        goto engbolt.shaftsLoop


engbolt.shaper:
    pause .2
    if ("$lefthandnoun" = "knife") then {
        gosub tie my carving knife to my toolbelt
    }
    if ("$lefthandnoun" <> "shaper") then {
        gosub untie my shaper on toolbelt
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
    gosub store default %engbolt.defaultbag
    goto engbolt.exit


engbolt.exit:
    pause .2
    put #parse ENGBOLT DONE
    exit