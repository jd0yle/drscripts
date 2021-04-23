action put #queue clear;put #send 1 $lastcommand when ^Sorry,|^\.\.\.wait
action goto danger when ^You notice an unusual smell drifting through the area.
action goto danger when ^A loud cracking sound resonates from somewhere closeby.
action goto danger when ^A monotonous buzzing sound fills the air.

Begin:
  match watch axe
  match wield empty
  put glance
  matchwait

wield:
  put get my axe
watch:
  match chop certain that continued lumberjacking will be quite safe.
  match notree no trees are available
  match wait Roundtime
  put watch forest
  matchwait

chop:
  pause
chopx:
  match stick stick away
  match log log away
  match branch branch away
  match limb limb away
  matchre notree (rotted core|unable to find a tree)
  match chop Roundtime:
  put chop tree
  matchwait

stick:
  setvariable WOOD.TYPE stick
  goto push
log:
  setvariable WOOD.TYPE log
  goto push
branch:
  setvariable WOOD.TYPE branch
  goto push
limb:
  setvariable WOOD.TYPE limb
  goto push

push:
  match pickUp not enough
  match chop Push what?
  match stowdeed You push
  put push %WOOD.TYPE
  matchwait

pickUp:
  matchre chop (What were you|You put)
  match exit cannot
  put stow %WOOD.TYPE
  matchwait

stowdeed:
  pause
  put stow deed
  goto chop

danger:
  match watch stack a pile of stones
  match danger unable
  put watch forest danger
  matchwait

wait:
  echo ******************************
  echo ** Waiting 30 seconds for danger to pass
  echo ******************************
  pause 30
  goto watch

noTree:
  match chop marker to direct
  match stowAxe no additional resources
  put watch forest careful
  matchwait

stowAxe:
  pause
  put stow my axe
  exit
getRegister:
  match deedCheck You get
  match exit What were you
  put get deed register
  matchwait

deedCheck:
  match exit You see
  match getDeed deed
  put look in satchel
  matchwait

getDeed:
  match fillRegister You get
  match stowRegister What were you
  put get deed from satchel
  matchwait

fillRegister:
  match exit What were
  match getDeed You place
  put put my deed in my register
  matchwait

stowRegister:
  put stow my regist
exit:
  exit