include libmaster.cmd
###############
# Lockpicking Practice Boxes
###############
action var newBox 1 when ^The lock looks weak

###############
# Variables Init
###############
var box box
var boxStorage wallet

practiceBoxLoop:
  if (%newBox = 1) then goto newBox
  gosub get my %box
  gosub lock my %box
  gosub pick my %box
  if $Locksmithing.LearningRate < 30 then goto practiceBoxLoop
  goto practiceBoxExit
  
practiceBoxExit:
  gosub stow my %box
  exit

newBox:
  gosub stow my %box
  gosub open my %boxStorage
  gosub get %box from my %boxStorage
  var newBox 0
  if ($righthandnoun = null) then {
    goto practiceBoxExit
  }
  goto practiceBoxLoop