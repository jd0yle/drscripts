include libmaster.cmd
action put #var activeResearch 0 when ^Breakthrough|^You lose your focus on your research project\.
action put #var activeResearch 2 when ^You make definite progress
action goto magicGafCheck when ^You require some special

##############
# Variables Init
##############
  if (!($activeResearch >0)) then put #var activeResearch 0
  if (!($cambMana >0)) then put #var cambMana 0


put #script abort all except inamagic
put .look
##############
# Main
##############
magicPickTopic:
  if ($mana < 80) then goto magicPause
  if $Warding.LearningRate < 30 then goto magicWarding
  if $Utility.LearningRate < 30 then goto magicUtility
  if $Augmentation.LearningRate < 30 then goto magicAugmentation
  if $Sorcery.LearningRate < 30 then goto justiceCheck
  goto magicExit

magicPause:
  pause 60
  gosub perc
  if ($activeResearch <> 0) then {
    goto magicSorcery
  }
  if ($mana < 80) then {
    goto magicPause
  }
  goto magicPickTopic

magicAugmentation:
  put #var currentSpell $char.magic.train.spell.Augmentation
  put #var currentMana $char.magic.train.prep.Augmentation
  put #var cambMana $char.magic.train.charge.Augmentation
  goto magicBegin

magicWarding:
  put #var currentSpell $char.magic.train.spell.Warding
  put #var currentMana $char.magic.train.prep.Warding
  put #var cambMana $char.magic.train.charge.Warding
  goto magicBegin

magicUtility:
  put #var currentSpell $char.magic.train.spell.Utility
  put #var currentMana $char.magic.train.prep.Utility
  put #var cambMana $char.magic.train.charge.Utility
  goto magicBegin

magicBegin:
  gosub prep symb
  gosub prep $currentSpell $currentMana
  gosub charge my $char.cambrinth $cambMana
  gosub invoke my $char.cambrinth spell
  waitforre ^You feel fully prepared to cast your
  gosub cast
  gosub perc
  goto magicPickTopic

##############
# Research Topics
##############
justiceCheck:
  matchre magicGafCheck ^You're fairly certain this area is lawless and unsafe\.
  matchre magicExit you think local law enforcement keeps an eye
  put justice
  matchwait 5

magicGafCheck:
  if ($SpellTimer.GaugeFlow.duration < 6) then {
      gosub prep gaf 20
      pause 2
      gosub charge my $char.cambrinth 20
      pause 2
      gosub invoke my $char.cambrinth spell
      waitforre ^You feel fully prepared
      gosub cast
  }
  goto magicSorcery

magicSorcery:
  if ($Sorcery.LearningRate < 15) then {
    if ($$activeResearch <> 1) then {
      put #var activeResearch 1
      gosub research sorcery 300
    }
    goto magicPause
    }
  }
  goto magicExit

magicExit:
  put .inaidle
  put #script abort all except inaidle