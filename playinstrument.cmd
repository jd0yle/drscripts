include libmaster.cmd
action goto playIncreaseDifficulty when ^(You play|You effortlessly)

###########
# Instruments
###########
# scales (ruff), arpeggios (rudiments), ditty, folk, ballad, waltz, lullaby, march, jig, 
# lament, wedding, hymn, rumba, polka, battle, reel, elegy, serenade, minuet, psalm, 
# dirge, gavotte, tango, tarantella, bolero, nocturne, requiem, fantasia, rondo, 
# aria, sonata, and concerto.
###########

###########
# Variable Inits
###########
  if (!($instrument >0)) then put #var instrument 0
  if (!($playSong >0)) then put #tvar playSong 0
  if (!($playNextSong >0)) then put #tvar playNextSong 0
  if (!($playMood >0)) then put #tvar playMood 0
  put #tvar instrument guti'adar
  put #tvar playSong folk
  put #tvar playNextSong ballad
  put #tvar playMood quiet

###########
# Main
###########
put .look
playWeather:
    matchre playInstrument You glance outside|cloud|clear|That's a bit hard to do while
    matchre playExit rain|snow|blizzard|downpour|snowfall|drizzling
    put observe weather
    matchwait 5

playInstrument:
    gosub get my $instrument
    gosub play $playSong $playMood
    waitforre ^You finish playing
    if ($Performance.LearningRate < 30) then goto playInstrument
    gosub stow my $instrument
    exit

playIncreaseDifficulty:
    echo ** Upping Difficulty **
    put #var playSong $playNextSong
    goto playInstrument
