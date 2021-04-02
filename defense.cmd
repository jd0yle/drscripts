include libmaster.cmd
##############
# Defenses
##############

defenseWait:
  pause 60
defenseSkillCheck:
  if ($Shield.LearningRate < 30) then {
    gosub stance shield
    gosub stance evasion 50
    goto defenseWait
  }
  if ($Parry.LearningRate < 30) then {
    gosub stance parry
    gosub stance evasion 50
    goto defenseWait
  }
  if ($Evasion.LearningRate < 30) then {
    gosub stance evasion
    goto defenseWait
  }
  goto defenseExit

defenseExit:
  put #echo >log yellow  Defense loop done.
  exit
