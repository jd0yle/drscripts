include libmaster.cmd
action goto targetLoop when ^Your concentration slips for a moment|^Your concentration lapses
action goto targetSkin when eval $skin = 1
action goto targetFaceNext when ^Target what|^Your pattern dissipates with the loss of your target\.
action goto targetPauseObserve when ^You feel you have sufficiently pondered your latest observation\.

#####################
# Variables
#####################
if (!($lastAppGametime >0)) then put #var lastAppGametime 0
if (!($lastHuntGametime >0)) then put #var lastHuntGametime 0
if (!($lastPercGametime >0)) then put #var lastPercGametime 0

if ("$charactername" = "Inauri") then {
    var tmMana paralysis
    var tmMana 5
}
if ("$charactername" = "Khurnaarti") then {
    var debilSpell calm
    var debilMana 3
    var tmSpell do
    var tmMana 3
}
goto targetSkillCheck

#####################
# Main
#####################
targetSkillCheck:
  if ($Targeted_Magic.LearningRate < 30) then goto targetLoop
  goto targetExit

targetLoop:
  if ($mana < 80) then {
    pause 10
  }
  gosub targetApp
  gosub targetHunt
  gosub targetPerc
  gosub prep %debilSpell %debilMana
  waitforre ^You feel fully prepared
  gosub cast
  gosub target %tmSpell %tmMana
  waitforre ^Your formation of a targeting pattern around
  gosub cast
  goto targetSkillCheck


#####################
# Utilities
#####################
targetApp:
  if ($Appraisal.LearningRate > 15) then {
    return
  }
  evalmath nextAppAt $gametime + 60
  if (%nextAppAt < $gametime) then {
      return
  }
  gosub retreat
  gosub app my pouch
  put #var lastAppGametime $gametime
  return

targetFaceNext:
  put face next
  goto targetLoop

targetHunt:
  if ($Perception.LearningRate > 15) then {
    return
  }
  evalmath nextHuntAt $gametime + 75
  if (%nextHuntAt < $gametime) then {
      return
  }
  gosub hunt
  put #var lastHuntGametime $gametime
  return

targetPauseObserve:
  if ($Astrology.LearningRate > 30) then {
    return
  }
  put .observe
  waitforre ^OBSERVE DONE
  goto targetSkillCheck

targetPerc:
  if ($Attunement.LearningRate > 15) then {
    return
  }
  evalmath nextPercAt $gametime + 60
  if (%nextPercAt < $gametime) then {
      return
  }
  gosub perc
  put #var lastPercGametime $gametime
  return

targetSkin:
  pause 1
  gosub skin
  pause 1
  gosub loot
  goto targetLoop

targetExit:
  if ("$charactername" = "Khurnaarti") then {
    put .khurmagic
  }
  exit