####################################################################################################
# count.cmd
# Item Counter
#
# Counts the number of specific items in a specific container.
# Clears the $char.countResult variable, then stores the result in it.
# Parses the result as: COUNTRESULT <number>
#
# Args:
#    --item The item to search for
#    --container The container to search in
#    --echo 1 if you want to echo out the result
#
# Example:
# .count --item=incense --container=canvas backpack
#      # echo $char.countResult
#
#
####################################################################################################
include libmaster.cmd
include args.cmd

put #tvar char.countResult 0

var count.container %args.container
var count.itemToFind %args.item
var numItems 0

var count.echo 0
if ("%args.echo" = "1") then var count.echo 1

matchre count.doCount ^You rummage through.*?and see (.*)\.$
gosub rummage my %count.container
matchwait 5
goto count.done


count.doCount:
    var contents $1

    eval itemArr replace("%contents", ",", "|")
    eval itemLength count("%itemArr", "|")
    var index 0

    count.doCountLoop:
        if (matchre("%itemArr(%index)", "%count.itemToFind")) then math numItems add 1
        math index add 1
        if (%index > %itemLength) then goto count.done
        goto count.doCountLoop


count.done:
    pause .2
    if (%count.echo = 1) then echo %numItems %count.itemToFind in %count.container
    put #tvar char.countResult %numItems
    put #parse COUNTRESULT %numItems
    put #parse COUNT DONE
    exit

