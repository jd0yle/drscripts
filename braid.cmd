include libmaster.cmd
action goto braidGetMaterial when ^You need to have more material in your other hand to continue braiding\.
action goto braidPull when ^You are certain that the braided (grass|vines) could become a good quality heavy rope\.

braidCheckHands:
  matchre braid (grass|vine|vines)
  match braidGetMaterial empty
  put glance
  matchwait 5

braidGetMaterial:
  gosub forage %1
  if ($lefthandnoun = %1) then goto continueBraid
  goto braidGetMaterial

continueBraid:
  gosub braid my %1
  goto continueBraid

braidPull:
  gosub pull my %1
  put coil my rope
  gosub stow my rope
  exit