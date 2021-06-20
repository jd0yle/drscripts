include libmaster.cmd

action send roll my rug when ^You should roll it up first

gosub stow right
gosub stow left

gosub runScript commune

gosub stand

gosub get my rug
gosub unroll my rug
put kneel my rug
put kiss my rug

gosub pray huldah

gosub get my wine
put kneel my rug
put pour my wine on my rug
gosub stow my wine

gosub stand
gosub dance my rug
gosub dance my rug
gosub dance my rug

gosub roll my rug
gosub stow my rug

gosub stow right
gosub stow left


pause .2
put #parse DEVOTION DONE
exit
