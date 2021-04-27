action goto utility when maintain your focus on every movement
action goto augmentation when keep your thoughts free from distraction


################
# KHRI
################
goto %1

help:
  if_2 then
    goto %2
  else
    echo *********************
    echo * Usage:
    echo * .khri help (khri)
    echo * .khri help (ambush)
    echo * .khri list
    echo * .khri meditate
    echo *********************
    exit

list:
  echo *********************
  echo * Tier 1
  echo *********************
  echo * [A] Darken, Focus
  echo * [U] Hasten
  echo *********************
  echo *  Tier 2
  echo *********************
  echo * [A] Avoidance, Harrier, Plunder, Safe, Sight, Strike
  echo * [U] Calm, Dampen, Silence
  echo * [W] Dampen
  echo * [D] Prowess, Terrify
  echo *********************
  echo * Tier 3
  echo *********************
  echo * [A] Elusion, Muse
  echo * [U] Shadowstep, Vanish
  echo * [W] Serenity
  echo *********************
#  echo * Tier 4
#  echo *********************
#  echo * [A] Cunning, Flight, Fright
#  echo * [U] Cunning, Evanescence
#  echo * [W] Evanescence, Flight, Sagacity
#  echo *********************
#  echo * Tier 5
#  echo *********************
#  echo * [D] Credence
  exit

#########################
# Meditation
#########################
meditate:
  pause 10
  put khri meditate
  pause .1
  if ($concentration > 75) then return
    goto CONC_REGEN1
  put khri meditate elusion dampen prowess
  exit

#########################
# Training
#########################
train:
augmentation:
  matchre utility Purging yourself of all|You're already
  put khri st elusion
  matchwait
utility:
  matchre skillCheck Focusing your mind|You're already
  put khri st dampen
  matchwait
  
# Requires Combat
debilitation:
  matchre skillCheck Remembering the mantra|You're already
  put khri st prowess
  matchwait
  
skillCheck:
  pause 60
  if $Utility.LearningRate < 30 then goto skillCheck
  if $Warding.LearningRate < 30 then goto skillCheck
# if $Debilitation.LearningRate < 30 then goto skillCheck
  goto exit

#########################
# Help Section
#########################
dar:
dark:
darke:
darken:
  echo Darken [A]
  echo Cost: 8 + 2
  echo Modifier: Stealth
  exit
dam:
damp:
dampe:
dampen:
  echo Dampen [U/W]
  echo Cost: 12 + 3
  echo Modifier: Anti locate/hunt, decrease stealth hindrance
  exit
str:
stri:
strik:
strike:
  echo Strike [A]
  echo Cost: 12 + 3
  echo Modifier: Backstab, Held Weapon
  exit
sil:
sile:
silen:
silenc:
silence:
  echo Silence [U]
  echo Cost: 12 + 3
  echo Modifier: Pulsing Invisibility
  exit 
har:
harr:
harri:
harrie:
harrier:
  echo Harrier [U]
  echo Cost: 12 + 3
  echo Modifier: Strength
  exit
sen:
sens:
sensi:
sensin:
sensing:
  echo Sensing [U]
  echo Cost: 16 + 4
  echo Modifier: Remove view of neighbor room.
  exit
shad:
shado:
shadow:
shadows:
shadowst:
shadowste:
shadowstep:
  echo Shadowstep [U]
  echo Cost: 16 + 4
  echo Modifier: Decrease advance time while hidden, 0RT sneaking in town
  exit
van:
vani:
vanis:
vanish:
  echo Vanish [U]
  echo Cost: 30
  echo Modifier: Instant Invisibility and Retreat
  exit
evan:
evane:
evanes:
evanesc:
evanescence:
  echo Evanescence [U/W]
  echo Cost: 25 + 6
  echo Modifier: Invisibility when hit
  exit
has:
hast:
haste:
hasten:
  echo Hasten [U]
  echo Cost: 8 + 2
  echo Modifier: Chance for -1/2 RT reduc on melee/thrown, locksmithing, wear/remove armor in combat
  exit
saf:
safe:
  echo Safe [A]
  echo Cost: 12 + 3
  echo Modifier: Locksmithing, change to dodge a trap
  exit
avo:
avoi:
avoid:
avoida:
avoidan:
avoidanc:
avoidance:
  echo Avoidance [A]
  echo Cost: 12 + 3
  echo Modifier: Reflex
  exit
plu:
plun:
plund:
plunde:
plunder:
  echo Plunder [A]
  echo Cost: 12 + 3
  echo Modifier: Thievery, Discipline
  exit
mu:
mus:
muse:
  echo Muse [A]
  echo Cost: 16 + 4
  echo Modifier: Alchemy, Engineering
  exit
elu:
elus:
elusi:
elusio:
elusion:
  echo Elusion [A]
  echo Cost: 12 + 3
  echo Modifier: Brawling, Evasion
  exit
sli:
slig:
sligh:
slight:
  echo Slight [U]
  echo Cost: 20 + 5
  echo Modifier: Reduce chance of being caught shoplifting
  exit
gui:
guil:
guile:
  echo Guild [D]
  echo Cost: 20 + 5
  echo Modifier: Debuff Evasion to all engaged targets
  exit
fli:
flig:
fligh:
flight:
  echo Flight [A/W]
  echo Cost: 16 + 4
  echo Modifier: Athletics, Balance healing, chance to catch and return throw weapons thrown at you
  exit
cun:
cunn:
cunni:
cunnin:
cunning:
  echo Cunning [U/A]
  echo Cost: 16 + 4
  echo Modifier: Tactics, Charisma, pulsing anti-web/immo
  exit
cred:
crede:
creden:
credenc:
credence:
  echo Credence [D]
  echo Cost: 20 + 5
  echo Modifier: Calm all engaged target
  exit
foc:
focu:
focus:
  echo Focus [A]
  echo Cost: 8 + 2
  echo Modifier: Agility
  exit
sig:
sigh:
sight:
  echo Sight [A]
  echo Cost: 12 + 3
  echo Modifier: Perception, darkvision
  exit
prow:
prowe:
prowes:
prowess:
  echo Prowess [D]
  echo Cost: 16 + 4
  echo Modifier: Debuff Tactics(pvp), Reflex, Offensive Factor(pve).
  exit
cal:
calm:
  echo Calm [U]
  echo Cost: 25
  echo Modifier: Dispel
  exit
ter:
terr:
terri:
terrif:
terrify:
  echo Terrify [D]
  echo Cost: 12 + 3
  echo Modifier: Single target immobilize
  exit
ins:
insi:
insig:
insigh:
insight:
  echo Insight [A]
  echo Cost: 12 + 3
  echo Modifier: First Aid, Outdoorsmanship
  exit
eli:
elim:
elimi:
elimin:
elimina:
eliminat:
eliminate:
  echo Eliminate [D]
  echo Cost: 35
  echo Modifier: SE attacks ignore armor and shield
  exit
ste:
stea:
stead:
steady:
  echo Steady [A]
  echo Cost: 16 + 4
  echo Modifier: Bows, Crossbows, Heavy and Light Thrown, faster aim
  exit
end:
endu:
endur:
endure:
  echo Endure [U/A]
  echo Cost: 16 + 4
  echo Modifier: Stamina
  exit
sere:
seren:
sereni:
serenit:
serenity:
  echo Serenity [W]
  echo Cost: 16 + 4
  echo Modifier: SvS Barrier vs Will. Protects against roars, MM spells, bard spells, clout, terrify, credence, and guile.
  exit
int:
inti:
intim:
intimi:
intimid:
intimida:
intimidat:
intimidate:
  echo Intimidate [D]
  echo Cost: 16 + 4
  echo Modifier: prevents engagement
  exit
sag:
saga:
sagac:
sagaci:
sagacit:
sagacity:
  echo Sagacity [W]
  echo Cost: 20 + 5
  echo Modifier: Ablative physical damage barrier
  exit
fri:
frig:
frigh:
fright:
  echo Fright [A]
  echo Cost: 16 + 4
  echo Modifier: Debilitation, Intelligence
  exit
slash:
  echo Ambush Slash
  echo Cost: 4
  echo Effect:  Prevent target from retreating or moving for a short period.  Drop target to knees and inflict a leg bleeder with max success.
  echo Requires Slice Weapon
  exit
stun:
  echo Ambush Stun
  echo Cost: 4
  echo Effect:  Head damage and variable duration stun.
  echo Requires: Any Melee weapon or brawling items from Thief shops
  exit
scree:
screen:
  echo Ambush Screen
  echo Cost: 4
  echo Effect: Debuff Perception and inflict random RT to all engaged targets
  echo Requires:  Dirt
  exit
ign:
igni:
ignit:
ignite:
  echo Ambush Ignite
  echo Cost: 4
  echo Effect:  Lower armor value by damaging armor or physical damage to unarmed body locations.
  echo Requires:  Blade in Right hand, Naphtha in left hand and coins
  exit
clo:
clou:
clout:
  echo Ambush Clout
  echo Cost: 4
  echo Effect: Concentration damage, pulsing drain, loss of prepared spell.
  echo Requires:  empty hand
  exit
cho:
chok:
choke:
  echo Ambush Choke
  echo Cost: 4
  echo Effect: Debuff Stamina, fatigue damage
  echo Requires:  dirt.
  exit

exit:
  exit