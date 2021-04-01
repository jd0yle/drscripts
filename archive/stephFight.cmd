action put #queue clear;put #send 1 $lastcommand when ^Sorry,|^\.\.\.wait
action put #send loot when A granite gargoyle grumbles and falls over|A granite gargoyle grumbles and goes still|A quartz gargoyle grumbles and falls over with a

variables:
  put #setvariable heavyThrow spear
  put #setvariable lightThrow mallet
  put #setvariable smallEdgeWeap blade

skillCheck:
brawlCheck:
  if $Brawling.LearningRate < 30 then goto brawling
smallEdgedCheck:
  if $Small_Edged.LearningRate < 30 then goto smallEdged
  goto exit

analyze:
  match assess Analyze what
  match analyze You fail
  match claw landing a claw
  match elbow landing an elbow
  match kick landing a kick
  match gouge landing a gouge
  match slap landing a slap
  match punch landing a punch
  match thrust landing a thrust
  match jab landing a jab
  match feint landing a feint
  match lunge landing a lunge
  match chop landing a chop
  match slice landing a slice
  match draw landing a draw
  put analyze
  matchwait

claw:
  put #setvariable attackMove claw
  goto attack
elbow:
  put #setvariable attackMove elbow
  goto attack
kick:
  put #setvariable attackMove kick
  goto attack
gouge:
  put #setvariable attackMove gouge
  goto attack
slap:
  put #setvariable attackMove slap
  goto attack
punch:
  put #setvariable attackMove punch
  goto attack
thrust:
  put #setvariable attackMove thrust
  goto attack
jab:
  put #setvariable attackMove jab
  goto attack
feint:
  put #setvariable attackMove feint
  goto attack
lunge:
  put #setvariable attackMove lunge
  goto attack
chop:
  put #setvariable attackMove chop
  goto attack
slice:
  put #setvariable attackMove slice
  goto attack
draw:
  put #setvariable attackMove draw
  goto attack

attack:
  match engage close enough
  matchre assess (what|I could not)
  match analyze Roundtime
  put $attackMove
  matchwait

assess:
  matchre faceNext (facing|behind you|facing you|flanking you)
  put assess
  matchwait

faceNext:
  match exit nothing
  match analyze You turn
  put face next
  matchwait

engage:
  matchre exit nothing|Advance on
  match engage2 You begin
  put engage
  matchwait
engage2:
  pause 5
  goto analyze

brawling:
  matchre stow ($heavyThrow|$lightThrow)
  match sheath $smallEdgeWeap
  match analyze glance down at your empty hands
  put glance
  matchwait

stow:
  matchre brawling (You store|You stow|You put)
  put stow
  matchwait

sheath:
  match brawling You hang
  put sheath $smallEdgeWeap
  matchwait

wield:
  match smallEdged You deftly
  put wield $smallEdgeWeap
  matchwait

smallEdged:
  matchre stow (%heavyThrow|%lightThrow)
  match analyze $smallEdgeWeap
  match wield glance down at your empty hands
  put glance
  matchwait
