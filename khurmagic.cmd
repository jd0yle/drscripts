include libmaster.cmd
action goto magicPickTopic when ^Your concentration slips for a moment, and your spell is lost\.
action put remove my $cambItem when ^Try though you may

##############
# Variables Init
##############
if (!($augSpell >0)) then put #var augSpell cv
if (!($augMana >0)) then put #var augMana 0
if (!($cambItem >0)) then put #var cambItem armband
if (!($cambMana >0)) then put #var cambMana 1
if (!($currentSpell >0)) then put #var currentSpell 0
if (!($currentMana >0)) then put #var currentMana 0
if (!($observeOffCooldown >0)) then put #var observeOffCooldown 0
if (!($utilSpell >0)) then put #var utilSpell pg
if (!($utilMana >0)) then put #var utilMana 0
if (!($wardSpell >0)) then put #var wardSpell psy
if (!($wardMana >0)) then put #var wardMana 0
put #var augMana 10
put #var cambMana 3
put #var utilMana 10
put #var wardMana 10


put #script abort all except khurmagic
put .look
gosub remove my $cambItem
##############
# Main
##############
magicPickTopic:
    gosub magicAstrology
    if ($mana < 80) then goto magicPause
    if ($Warding.LearningRate < 30) then goto magicWarding
    if ($Utility.LearningRate < 30) then goto magicUtility
    if ($Augmentation.LearningRate < 30) then goto magicAugmentation
  # if ($Sorcery.LearningRate < 30) then goto justiceCheck
    goto magicExit

magicPause:
    pause 60
    gosub perc
    if ($mana < 80) then {
        goto magicPause
    }
    goto magicPickTopic

magicAugmentation:
    put #var currentSpell $augSpell
    put #var currentMana $augMana
    goto magicBegin

magicWarding:
    put #var currentSpell $wardSpell
    put #var currentMana $wardMana
    goto magicBegin

magicUtility:
    put #var currentSpell $utilSpell
    put #var currentMana $utilMana
    goto magicBegin

magicAstrology:
    if ($Astrology.LearningRate > 30) then {
        return
    }
    if ($observeOffCooldown = false) then {
        return
    } else {
        if ("$righthandnoun" = "$cambItem") then {
            gosub wear my $cambItem
        }
        put .khurobserve
        waitforre ^OBSERVE DONE
        return
    }

magicBegin:
  # gosub prep symb
    gosub prep $currentSpell $currentMana
    if ("$righthandnoun" <> "$cambItem") then {
        gosub remove my $cambItem
    }
    gosub charge my $cambItem $cambMana
    gosub invoke my $cambItem spell
    waitforre ^You feel fully prepared to cast your
    gosub cast
    gosub perc
    goto magicPickTopic

magicExit:
    gosub wear my $cambItem
    put .khuridle
    put #script abort all except khuridle
    exit