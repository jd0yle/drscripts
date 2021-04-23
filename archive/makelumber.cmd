action put #queue clear;put #send 1 $lastcommand when ^Sorry,|^\.\.\.wait
################################
# Make lumber from wood.
################################

roomCheck:
  action put #setvariable LOCATION $0 when ^(\[.*\])
  put look
  waitforre ^Obvious
  if "%LOCATION" = "[Crossing Engineering Society, Workshop]" then goto getDeed
  goto getDeed

################################
# In the Engineering Society Hall
################################
getDeed:
  match combine You need
  match tapDeed You get
  match exit What were you
  put get my deed from my satchel
  matchwait

tapDeed:
  match exit Tap what
  match stick2 You pick up the stick
  match branch2 You pick up the branch
  match limb2 You pick up the limb
  match log2 You pick up the log
  put tap my deed
  matchwait

stick2:
  setvariable WOOD.TYPE stick
  goto useTableSaw
log2:
  setvariable WOOD.TYPE log
  goto useTableSaw
branch2:
  setvariable WOOD.TYPE branch
  goto useTableSaw
limb2:
  setvariable WOOD.TYPE limb
  goto useTableSaw

useTableSaw:
  match combine lumber
  put cut my %WOOD.TYPE with saw
  matchwait

combine:
  put combine
  goto getDeed

################################
# Not in the Engineering Society Hall
################################
saw:
  pause
  put tie my draw to my toolb
sawx:
  match whatWood You untie
  match exit What were you
  put untie my wood saw
  matchwait

whatWood:
  match log log
  match limb limb
  match branch branch
  match stick stick
  matchre exit (you see|You rummage)
  put look in my %1
  matchwait

log:
  put #setvariable WOOD.TYPE log
  goto getWood

limb:
  put #setvariable WOOD.TYPE limb
  goto getWood

branch:
  put #setvariable WOOD.TYPE branch
  goto getWood

stick:
  put #setvariable WOOD.TYPE stick
  goto getWood

getWood:
  match cutWood You get a
  match whatWood What were you
  put get my $WOOD.TYPE from my %1
  matchwait

cutWood:
  match cutWood Roundtime
  match drawknife Finally you
  put cut my $WOOD.TYPE with my saw
  matchwait

drawknife:
  pause
  put tie saw to toolb
drawknifex:
  match scrape You untie
  match exit What were you
  put untie my drawknife
  matchwait

scrape:
  match scrape Roundtime
  match stow At last your work
  put scrape my $WOOD.TYPE with my draw
  matchwait

stow:
  put stow my lumber
  goto saw

exit:
  exit