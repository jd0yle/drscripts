
action put #queue clear;put #send 1 $lastcommand when ^Sorry,|^\.\.\.wait

start:
  goto pickTopic
  goto exit
prep:
gaugeCheckx:

  if ($SpellTimer.GaugeFlow.active = 0 || $SpellTimer.GaugeFlow.duration < 15) then {
     put .cast n gaf
     waitforre ^CAST DONE
  }
  goto research


wait:
  pause 60
pickTopic:
  match fundamental Fundamental
  match warding Warding
  match augmentation Augmentation
  match streams Mana Stream
  match utility Utility
  match sorcery Sorcerous
  #match checkPrimary You're not researching
  match checkSorcery You're not researching
  put research status
  matchwait

checkPrimary:
  if $Primary_Magic.LearningRate > 20 then goto checkAttune
  goto fundamental

checkAttune:
  if $Attunement.LearningRate > 20 then goto checkWard
  goto stream

checkWard:
  if $Warding.LearningRate > 20 then goto checkUtil
  goto warding

checkUtil:
  if $Utility.LearningRate > 20 then goto checkAug
  goto utility

checkAug:
  if $Augmentation.LearningRate > 20 then goto checkSorcery
  goto augmentation

checkSorcery:
  if $Sorcery.LearningRate > 20 then goto checkWard
  goto sorcery

research:
fundamental:
  matchre prep (Your eyes briefly darken|You require some special means)
  match wait You are already busy
  match fundamental decide to take a break
  matchre pickTopic (Breakthrough|You cannot)
  put research fundamental 300
  matchwait

stream:
  matchre prep (Your eyes briefly darken|You require some special means)
  match stream decide to take a break
  match pickTopic Breakthrough
  put research stream 300
  matchwait

warding:
  matchre prep (Your eyes briefly darken|You require some special means)
  match warding decide to take a break
  match pickTopic Breakthrough
  put research warding 300
  matchwait

augmentation:
  matchre prep (Your eyes briefly darken|You require some special means)
  match augmentation decide to take a break
  match pickTopic Breakthrough
  put research augmentation 300
  matchwait

utility:
  matchre prep (Your eyes briefly darken|You require some special means)
  match utility decide to take a break
  match pickTopic Breakthrough
  put research utility 300
  matchwait

sorcery:
  matchre prep (Your eyes briefly darken|You require some special means)
  match sorcery decide to take a break
  match pickTopic Breakthrough
  put research sorcery 300
  matchwait


exit:
  exit