include libsel.cmd

if ($charactername = Qizhmur) then {
    var container portal
}

if_1 then {
    var container %0
}


var items blanket|earrings|kaleidoscope|telescope case|cowbell|harp|earrings|scimitar|ring|letter opener|manual
eval itemLen count("%items", "|")
var index 0

gosub stow right
gosub stow left

loop:
    gosub get my %items(%index) from my %container
    if ("$righthand" != "Empty") then {
        if ("$charactername" = "Selesthiel") then {
            gosub put my %items(%index) in my bucket
        } else {
            gosub drop my %items(%index)
        }
        if ("$righthand" != "Empty") then {
            gosub drop my %items(%index)
        }
        goto loop
    }
    math index add 1
    if (%index > %itemLen) then goto done
    goto loop


done:
    pause .2
    put #parse BURGLEDROP DONE
    exit