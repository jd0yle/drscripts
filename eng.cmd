include libmaster.cmd
########################
# Engineering
# USAGE: .eng <number> <item> [design]
#    EX: .eng 3 bead weasel
########################
action put #queue clear;put #send 1 $lastcommand when ^Sorry,|^\.\.\.wait
action put #var nextTool shaper when ^Shaping with a wood shaper is needed to further smooth the material's surface\.
action put #var nextTool rasp when ^A bulbous knot will make continued shaping difficult unless rubbed out with a rasp\.
action put #var nextTool knife when ^The wood is ready to have more fine detail carved with a carving knife\.
action put #var nextTool engMark when ^Applying the final touches
action goto stunPause when ^You are stunned|^After a brief flare of pain, your senses go numb and you lose all muscular control
action goto shortCord when ^You need another finished short leather cord

########### CONFIG ###########
var chapter 0
var cut 0
var defaultContainer satchel
var engineeringContainer workbag
var page 0
var crafted 0
put #var craftNeed %1
put .look
##############################

########################
#  Variables
########################
setVariables:
  # Chapter 1 - Basics
  if "%2" = "pole" then put #setvariable chapter 1;#setvariable cut 2
  if "%2" = "sphere" then put #setvariable chapter 1;#setvariable cut 2
  # Chapter 2 - Shortbow
  # Chapter 3 - Longbow
  # Chapter 4 - Composite Bow
  # Chapter 5 - Fletching  
  # Chapter 6 - Shaping Enhancements and Materials
  if "%2" = "burin" then put #setvariable chapter 6;#setvariable cut 4
  # Chapter 7 - Accessories
  if "%2" = "earcuff" then put #setvariable chapter 7;#setvariable cut 2
  if "%2" = "brooch" then put #setvariable chapter 7;#setvariable cut 2
  if "%2" = "armband" then put #setvariable chapter 7;#setvariable cut 3
  if "%2" = "buckle" then put #setvariable chapter 7;#setvariable cut 2
  if "%2" = "choker" then put #setvariable chapter 7;#setvariable cut 3
  if "%2" = "locket" then put #setvariable chapter 7;#setvariable cut 2
  if "%2" = "bangles" then put #setvariable chapter 7;#setvariable cut 5
  if "%2" = "tiara" then put #setvariable chapter 7;#setvariable cut 3
  if "%2" = "bracelet" then put #setvariable chapter 7;#setvariable cut 3
  if "%2" = "circlet" then put #setvariable chapter 7;#setvariable cut 3
  if "%2" = "necklace" then put #setvariable chapter 7;#setvariable cut 3
  if "%2" = "crown" then put #setvariable chapter 7;#setvariable cut 3
  if "%2" = "mask" then put #setvariable chapter 7;#setvariable cut 3
  if "%2" = "comb" then put #setvariable chapter 7;#setvariable cut 2
  if "%2" = "haircomb" then put #setvariable chapter 7;#setvariable cut 3
  # Chapter 8 - Shaped Images
  if "%2" = "wand" then put #setvariable chapter 8;#setvariable cut 3
  if "%2" = "rod" then put #setvariable chapter 8;#setvariable cut 3
  if "%2" = "bead" then put #setvariable chapter 8;#setvariable cut 1
  if "%2" = "totem" then put #setvariable chapter 8;#setvariable cut 2
  if "%2" = "figurine" then put #setvariable chapter 8;#setvariable cut 3
  if "%2" = "bead" then goto setDesign
  if "%2" = "figurine" then goto setDesign
  if "%2" = "totem" then goto setDesign
  # Chapter 9 - Weaponry
  if "%2" = "nightstick" then put #setvariable chapter 9;#setvariable cut 6
  # Chapter 10 - Furniture
  goto checkForPartial

findCarvingDesign:
  if ($chapter = 1) then {      
	var option.length 8
  }
  if ($chapter = 6) then {
    var option.length 7
  }
  if ($chapter = 7) then {
    var option.length 30
  }
  if ($chapter = 8) then {
    var option.length 13
  }
  if ($chapter = 9) then {
      var option.length 8
    }
  put turn my book to chapter $chapter
  var option.index 0
findCarvingDesignLoop:
  pause .2
  math option.index add 1
  if (%option.index < %option.length) then {    	
	matchre matchFound %2
	matchre findCarvingDesignLoop ^(You turn your book to page|You are already on page)
	put turn my book to page %option.index
	matchwait 5	
  }
  echo Could not find design %2, exiting.
  goto exit
matchFound:
  put #var page option.index
  goto engStudy
########################
# Codex Variables
########################
setDesign:
  if "%2" = "bead" then put #setvariable chapter 8;#setvariable page 2;#setvariable cut 1
  if "%2" = "totem" then put #setvariable chapter 8;#setvariable page 3;#setvariable cut 2
  if "%2" = "figurine" then put #setvariable chapter 8;#setvariable page 5;#setvariable cut 3
setDesignRace:
  var race.list human|elf|dwarf|elothean|gor'tog|halfling|s'kra mur|rakash|prydaen|gnome|kaldar
  eval race.len count("%race.list", "|")
  var race.index 0
designRaceLoop:
  if ("%3" = "%race.list(%race.index)") then {
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
  if ("%3" = "%immortal.list(%immortal.index)") then {
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
  if ("%3" = "%animal.list(%animal.index)") then {
    put #setvariable codexChapter 3
    math animal.index add 1
    put #setvariable codexPage %animal.index
    goto setStore
  }
  math animal.index add 1
  if (%animal.index > %animal.len) then {
    put #echo >log red Could not find that design.  Exiting.
    exit
  }
  goto designAnimalLoop
########################
# Main
########################
checkForPartial:    
  if ($nextTool <> 0) then {
	  var %2 $righthandnoun
      goto $nextTool
	}
  } 
setStore:
  put #var craftNeed %1
  put store default %engineeringContainer
engGetLumber:
  matchre engGetLumberStack ^You pick up
  matchre engMarkLumber ^You get
  matchre engExit ^What were you referring
  matchre engMarkLumber ^You are already
  put get my lumber
  matchwait 5

engGetLumberStack:
  matchre engCombine ^You get
  matchre engExit ^What were you referring
  put get my lumber from %engineeringContainer
  matchwait 5

engCombine:
  matchre engMarkLumber ^You combine the stacks
  matchre engExit ^(You need|Combine)
  put combine
  matchwait 5

engMarkLumber:
  matchre engCount ^There is not enough of the lumber
  matchre engGetScissors ^(You mark|You count)
  put mark my lumber at $cut
  matchwait 5

engCount:
  match engGetBook $cut
  matchre engNeedLumber ^You count out
  put count my lumber
  matchwait 5

engGetScissors:
  matchre engStow ^You need a free hand
  matchre engExit ^What were you
  matchre engCut ^You get
  put get my scissor
  matchwait 5

engStow:
  gosub stow left
  gosub stow right
  if ($nextTool <> 0) then {
    goto $nextTool
  }
  goto engGetLumberStack

engCut:
  put cut my lumber with my scissor
  gosub stow right
  gosub stow left
  pause
  matchre checkPageSetting ^You pick up
  matchre engExit ^What were you
  put get my lumber
  matchwait 5

checkPageSetting:
  if (%page <> 0) then {
    gosub get my shap book
    goto engStudy
  }

engGetBook:
  matchre findCarvingDesign ^(You get|You are already)
  matchre engExit ^What were you
  put get my shap book
  matchwait 5
  
engStudy:
  matchre engStowBook ^(You scan|You review)
  put study my book
  matchwait 5

engStowBook:
  gosub stow book
  gosub stow codex
  goto drawknife

drawknife:
  matchre engScrapeLumber ^You untie
  matchre engExit ^What were you
  put untie my drawknife on my toolbelt
  matchwait 5

codex:
  gosub tieTool
codex2:
  matchre turnCodexChapter ^You get
  matchre engExit ^What were
  put get my codex
  matchwait 5

turnCodexChapter:
  matchre turnCodexPage ^(You turn|The codex)
  put turn my codex to chapter $codexChapter
  matchwait 5

turnCodexPage:
  matchre studyCodex ^(You turn|The codex)
  put turn my codex to page $codexPage
  matchwait 5

studyCodex:
  matchre engStowBook ^You study the codex until you
  matchre engExitxit ^What were you
  put study my codex
  matchwait 5

engScrapeLumber:
  put #var nextTool 0  
engScrapeLumber1:
  matchre codex ^You must study a design
  matchre findNextTool ^Roundtime
  put scrape my lumber with my drawknife
  matchwait 5
  
findNextTool:  
  if ($nextTool <> 0 ) then {
    goto $nextTool
  }
  goto errorExit   

knife:
  gosub tieTool
  pause
knife2:
  matchre engStow ^You need a free hand
  matchre carve ^You untie
  matchre engExit ^What were you
  put untie my carving knife on my toolbelt
  matchwait 5

carve:
  matchre findNextTool ^Roundtime
  matchre engMark ^Applying the final touches
  put carve my %2 with my knife
  matchwait 5

rasp:
  gosub tieTool
  pause
rasp2:
  matchre rasp2 ^You need a free hand
  matchre scrape ^You untie
  matchre engExit ^What were you
  put untie my rasp on my toolbelt
  matchwait 5

scrape:
  matchre findNextTool ^Roundtime
  put scrape my %2 with my rasp
  matchwait 5
  
shaper:
  gosub tieTool
  pause
shaper2:
  matchre engStow ^You need a free hand
  matchre shape ^You untie
  matchre engExit ^What were you
  put untie my shaper on my toolbelt
  matchwait 5

shape:
  matchre findNextTool ^Roundtime
  matchre shortCord ^You need another finished short leather cord
  matchre strips ^You need another finished leather strips
  put shape my %2 with my shaper
  matchwait 5
  
shortCord:
    var location shortCord1
    if ("$lefthand" <> "Empty") then {
        gosub tie my $lefthand to my tool
    }
    gosub get my cord
    goto engAssemble

strips:
    var location strips1
    strips1:
    matchre engExtraStow ^You need a free hand
    matchre engAssemble ^You get
    matchre engExit ^What were you
    put get my strips
    matchwait 5

engExtraStow:
    gosub tieTool
    goto %location

engStowCord:
    gosub stow my cord
    goto shaper


engAssemble:
    matchre engStowCord ^The short cord is not required to continue
    matchre findNextTool ^You place your
    matchre engExit ^What were you
    put assemble my $righthandnoun with my $lefthandnoun
    matchwait 5
  
tieTool:
  pause
  if ("$lefthandnoun" = "shaper") then {
    put tie my $lefthandnoun to my toolbelt
  }
  else {
    put tie my $lefthand to my toolbelt
  }
  pause
  return

engStunPause:
  if ($stunned <> 0) then {
    pause 2
    goto engStunPause
  }
  if ($nextTool <> 0) then {
    gosub get my nextTool
    gosub get my %1
  }
  goto checkForPartial

engMark:
    put #var nextTool 0
    gosub tieTool
    gosub get my stamp
    gosub mark $righthandnoun with stamp
    gosub stow my stamp
    goto engDone

########################
# Exit
########################
engDone:
  gosub analyze my %2
  pause
  gosub stow
  evalmath crafted (%crafted + 1)
  if (%crafted < $craftNeed) then {
    put #echo >log yellow [eng] Progress %crafted/$craftNeed
	goto setStore
  }
engExit:
  if ("$righthand" <> "Empty") then gosub stow
  if ("$lefthand" <> "Empty") then gosub stow left
  put #echo >log yellow [eng] Engineering done.
  put store default in %defaultContainer
  pause .2
  put #parse ENG DONE
  exit
  
errorExit:
  put #echo >log red Next Tool was not found.  Exiting.
  exit

engNeedLumber:
  put #var eng.needLumber 1
  put #echo >log yellow [eng] Need more lumber.
  put store default in %defaultContainer
  goto engExit

