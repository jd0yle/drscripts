include libmaster.cmd

var items lace collar|brooch|platinum pin|steel cufflinks|diacan anklet
eval len count("%items", "|")
var index 0

var isHidden 0
action var isHidden 0 when magic no longer hiding
action var isHidden 1 when working to disguise

main:
    gosub activateHider %items(%index)
    math index add 1
    if (%index > %len) then goto done
    goto main


activateHider:
    var hidersTodo $0
    var location activateHider1
    var isHidden 0
    activateHider1:
    gosub turn my %hidersTodo
    if (%isHidden = 0) then goto activateHider1
    return


done:
    put look $charactername
    pause .2
    put #parse HIDERS DONE
    exit
