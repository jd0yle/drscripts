##############################
# Engineering
# USAGE: .eng <item> [design]
#    EX: .eng bead weasel
##############################

########### CONFIG ###########
var defaultContainer steelsilk backpack
var engineeringContainer shadows
##############################

action put #queue clear;put #send 1 $lastcommand when ^Sorry,|^\.\.\.wait

########################
#  Variables
########################
echo First va is %1
setVariables:
  #if "%1" = "pole" then put #setvariable chapter 1;#setvariable page 5;#setvariable cut 2
  #if "%1" = "sphere" then put #setvariable chapter 1;#setvariable page 7;#setvariable cut 2
  #if "%1" = "burin" then put #setvariable chapter 6;#setvariable page 3;#setvariable cut 4
  #if "%1" = "earcuff" then put #setvariable chapter 7;#setvariable page 15;#setvariable cut 2
  #if "%1" = "brooch" then put #setvariable chapter 7;#setvariable page 16;#setvariable cut 2
  #if "%1" = "buckle" then put #setvariable chapter 7;#setvariable page 18;#setvariable cut 2
  #if "%1" = "choker" then put #setvariable chapter 7;#setvariable page 19;#setvariable cut 3
  #if "%1" = "wand" then put #setvariable chapter 8;#setvariable page 6;#setvariable cut 3
  #if "%1" = "bead" then put #setvariable chapter 8;#setvariable page 2;#setvariable cut 1
  #if "%1" = "totem" then put #setvariable chapter 8;#setvariable page 3;#setvariable cut 2
  #if "%1" = "figurine" then put #setvariable chapter 8;#setvariable page 5;#setvariable cut 3
  #if "%1" = "rod" then put #setvariable chapter 8;put #setvariable page 7;put #setvariable cut 3
  #if "%1" = ("bead"|"totem"|"figurine") then goto setDesign

  put #setvariable chapter 8;put #setvariable page 7;put #setvariable cut 3
  goto setStore
########################
# Codex Variables
########################
setDesign:
  #if "%1" = "bead" then put #setvariable chapter 8;#setvariable page 2;#setvariable cut 1
  #if "%1" = "totem" then put #setvariable chapter 8;#setvariable page 3;#setvariable cut 2
  #if "%1" = "figurine" then put #setvariable chapter 8;#setvariable page 5;#setvariable cut 3
setDesignRace:
  var race.list human|elf|dwarf|elothean|gor'tog|halfling|s'kra mur|rakash|prydaen|gnome|kaldar
  eval race.len count("%race.list", "|")
  var race.index 0
designRaceLoop:
  if ("%2" = "%race.list(%race.index)") then {
    echo %race.list(%race.index)
    put #setvariable codexChapter 1
    math race.index add 1
    put #setvariable codexPage %race.index
    goto setStore
  }
  math race.index add 1
  if (%race.index > %race.len) then {
    goto setDesignImmortal
  }
  goto designRaceLoop
setDesignImmortal:
  var immortal.list welkin|cow|owl|nightingale|wolverine|magpie|kingsnake|albatross|donkey|dove|phoenix|mongoose|jackal|raven|unicorn|wolf|panther|boar|ox|cobra|dolphin|ram|cat|wren|lion|scorpion|raccoon|adder|shrew|shrike|centaur|weasel|viper|shark|coyote|spider|heron|goshawk|vulture
  eval immortal.len count ("%immortal.list", "|")
  var immortal.index 1
designImmortalLoop:
  if ("%2" = "%immortal.list(%immortal.index)") then {
    put #setvariable codexChapter 2
    math immortal.index add 1
    put #setvariable codexPage %immortal.index
    goto setStore
  }
  math immortal.index add 1
  if (%immortal.index > %immortal.len) then {
    goto setDesignAnimal
  }
  goto designImmortalLoop
setDesignAnimal:
  var animal.list ship's rat|boobrie|bear|wind hound|bobcat|cougar|hog|beetle|silverfish|grass eel|blood wolf|beisswurm
  eval animal.len count ("%animal.list", "|")
  var animal.index 1
designAnimalLoop:
  if ("%2" = "%animal.list(%animal.index)") then {
    put #setvariable codexChapter 3
    math animal.index add 1
    put #setvariable codexPage %animal.index
    goto setStore
  }
  math animal.index add 1
  if (%animal.index > %animal.len) then {
    echo Could not find that design.  Exiting.
    exit
  }
  goto designAnimalLoop
########################
# Main
########################
setStore:
  put store default %engineeringContainer
getLumber:
  match combine You pick up
  match markLumber You get
  match exit What were you referring
  match markLumber You are already
  put get my lumber
  matchwait

combine:
  match combinex You get
  match exit What were you referring
  put get lumber from gear
  matchwait

combinex:
  match markLumber You combine the stacks
  matchre exit (You need|Combine)
  put combine
  matchwait

markLumber:
  put #setvariable cut 3
  match count There is not enough of the lumber
  matchre getScissors (You mark|You count)
  #put mark my lumber at $cut
  put mark my lumber at 3
  matchwait

count:
  #match getBook $cut
  match getBook 3
  match exit You count out
  put count lumber
  matchwait

getScissors:
  match exit What were you
  match cut You get
  put get my scissor
  matchwait

cut:
  put cut my lumber with my scissor
  put stow
  put stow left
  pause
  put get lumber
  goto getBook

getBook:
  matchre turnChapter (You get|You are already)
  match exit What were you
  put get my shap book
  matchwait

turnChapter:
  matchre turnPage (The book is|You turn)
  match exit What were you
  put turn my book to chapter $chapter
  matchwait

turnPage:
  put #setvariable page 7
  matchre study (The book is|You turn)
  match exit What were you
  put turn my book to page $page
  matchwait

study:
  matchre drawknife (You scan|You review)
  put study my book
  matchwait

drawknife:
  pause
  put stow book
  put stow codex
drawknife2:
  match scrape You get
  match exit What were you
  put get my drawknife
  matchwait

codex:
  pause
  put stow drawknife
codex2:
  match turnCodexChapter You get
  match exit What were
  put get my codex
  matchwait

turnCodexChapter:
  matchre turnCodexPage (You turn|The codex)
  put turn my codex to chapter $codexChapter
  matchwait

turnCodexPage:
  matchre studyCodex (You turn|The codex)
  put turn my codex to page $codexPage
  matchwait

studyCodex:
  match drawknife You study the codex until you
  match exit What were you
  put study my codex
  matchwait

scrape:
  match codex You must study a design
  match shaper Shaping with a wood shaper
  match rasp rubbed out with a rasp
  match knife carved with a carving knife
  match done Applying the final touches
  put scrape my lumber with my drawknife
  matchwait

shaper:
  pause
  put stow left
  pause
shaper2:
  match shape You get
  match exit What were you
  put get my shaper
  matchwait

shape:
  match shape Shaping with a wood shaper
  match rasp rubbed out with a rasp
  match knife carved with a carving knife
  match done Applying the final touches
  match shortCord You need another finished short leather cord
  put shape my %1 with my shaper
  matchwait

shortCord:
  match assemble You get
  match exit What were you
  put get my short cord
  matchwait

assemble:
  match shaper You place your cord
  match exit What were you
  put assemble my %1 with my cord
  matchwait

knife:
  pause
  put stow left
  pause
knife2:
  match carve You get
  match exit What were you
  put get my carving knife
  matchwait

carve:
  match shaper Shaping with a wood shaper
  match rasp rubbed out with a rasp
  match carve carved with a carving knife
  match done Applying the final touches
  put carve my %1 with my carving knife
  matchwait

rasp:
  pause
  put stow left
  pause
rasp2:
  match rub You get
  match exit What were you
  put get my rasp
  matchwait

rub:
  match shaper Shaping with a wood shaper
  match rub rubbed out with a rasp
  match knife carved with a carving knife
  match done Applying the final touches
  put rub my %1 with my rasp
  matchwait

########################
# Exit
########################
done:
  pause
  put stow left
  put analyze my %1
  waitfor Roundtime:
  pause
  put stow
exit:
  put store default in %defaultContainer
  exit
