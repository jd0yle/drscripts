include libmaster.cmd

var keepQualities flawless|perfect|excellent|great|good

action var materialQuality $1 when ^You get (?:a|an) (\S+) chunk of \S+ material

if ("$righthandnoun" = "material") then gosub put my material in my $char.inv.materialContainer
gosub stow right
if ("$lefthandnoun" = "material") then gosub put my material in my $char.inv.materialContainer
gosub stow left


gosub sortNecroMaterial.moveToMaterialContainer
gosub sortNecroMaterial.moveAndDiscard
gosub sortNecroMaterial.moveToMaterialContainer

goto sortNecroMaterial.done


sortNecroMaterial.moveToMaterialContainer:
    gosub get my material from my $char.inv.tempContainer
    if ("$righthand" = "Empty") then return
    gosub put my material in my $char.inv.materialContainer
    goto sortNecroMaterial.moveToMaterialContainer


sortNecroMaterial.moveAndDiscard:
    var materialQuality null
    gosub get my material from my $char.inv.materialContainer
    if ("$righthand" = "Empty") then return
    if (!matchre("%materialQuality", "(%keepQualities)")) then gosub drop my material
    if ("$righthand" != "Empty") then gosub put my material in my $char.inv.tempContainer
    goto sortNecroMaterial.moveAndDiscard


sortNecroMaterial.done:
    pause .2
    put #parse SORTNECROMATERIAL DONE
    exit