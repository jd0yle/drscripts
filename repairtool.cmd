include libmaster.cmd

################
# Variables Init
################
var craftTools carving knife|shaper|rasp|drawknife
var craftToolsLength 4
var craftToolsIndex 0
var npc clerk
var repairTargetRoom engineering books

goto repairRoomCheck
################
# Money
################
repairNeedMoney:
  put .deposit
  waitforre ^DEPOSIT DONE
  put withdraw 2 plat
  gosub automove %repairTargetRoom
  goto repairRoomCheck

################
# Checks
################
repairRoomCheck:
  action put #setvariable LOCATION $0 when ^(\[.*\])
  put look
  waitforre ^Obvious
  if "%LOCATION" = "[Catrox's Forge, Entryway]" then {
    var npc Catrox
  }
  if "%LOCATION" = "[Shard Engineering Society, Bookstore]" then {
    var npc clerk
    echo %npc
  }

repairCheckTicket:
  gosub get my ticket
  if ($righthandnoun = "ticket") then {
    gosub give %npc
    gosub tie my $righthandnoun to my toolbelt
    pause
    goto repairCheckTicket
  } else {
    goto repairGetTool
  }

################
# Repair
################
repairGetTool:
  gosub untie %craftTools(%craftToolsIndex) from my toolbelt
  if ($righthandnoun <> null) then {
    gosub give %npc
    gosub stow my ticket
    goto repairNextTool
  } else {
      math craftToolsIndex add 1
      goto repairGetTool
  }

repairToolSkip:
  matchre repairNextTool ^You tie
  gosub tie my $righthandnoun to my toolbelt
  matchwait 5

repairNextTool:
  math craftToolsIndex add 1
  if (%craftToolsIndex > %craftToolsLength) then goto repairExit
  goto repairGetTool

repairExit:
  echo Repair Tools done.
  exit