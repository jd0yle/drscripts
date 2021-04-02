include libmaster.cmd
action put #var activeResearch 0 when ^Breakthrough|^You lose your focus on your research project\.
action put #var activeResearch 2 when ^You make definite progress
action goto magicGafCheck when ^You require some special

##############
# Variables Init
##############
  if (!($activeResearch >0)) then put #var activeResearch 0
  if (!($cambItem >0)) then put #var cambItem viper
  if (!($cambMana >0)) then put #var cambMana 0
  if (!($currentSpell >0)) then put #var currentSpell 0
  if (!($currentMana >0)) then put #var currentMana 0
  if (!($augSpell >0)) then put #var augSpell ags
  if (!($augMana >0)) then put #var augMana 0
  if (!($wardSpell >0)) then put #var wardSpell tranquil
  if (!($wardMana >0)) then put #var wardMana 0
  if (!($utilSpell >0)) then put #var utilSpell awaken
  if (!($utilMana >0)) then put #var utilMana 0
  put #var cambMana 10
  put #var augMana 10
  put #var wardMana 7
  put #var utilMana 10


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

magicBegin:
  gosub prep symb
  gosub prep $currentSpell $currentMana
  gosub charge my $cambItem $cambMana
  gosub invoke my $cambItem spell
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
      gosub charge my $cambItem 20
      pause 2
      gosub invoke my $cambItem spell
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