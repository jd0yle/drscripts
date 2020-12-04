#Usage:  .ap [destination] [harness times] [mana] [100th-Ability]
#
#    Where:
#          destination     = Any name from the list you get when you run the script with no arguments.
#          harness times   = 0-4. Number of times to harness "mana".
#          mana            = Amount of mana to harness
#          100th-Ability   = Include any 4th variable to use the 100th circle ability to enter the AP.
#
#     *** Must be done while standing at a Grazhir shard or script will exit with an error. ***

debug off
put release
echo
echo ==============================================
echo = Astral Travel script by Foresee, edited by Uversy, Mozzik and Coralin
echo = Last edited: 8/5/2017
echo = Edited by: Randoon
echo = Edited For Genie, duplicate labels, errors and typos fixed by : Gavinne
echo = Version 3.8 for DR 3.0
echo =
echo = ***Include 100 as the 4th variable to use 100th ability***
echo =
echo = Valid Destination names:
echo = Dor'na'torna - Dornatorna - Hibarnhvidar - Hib - Cherulisa
echo = Erekinzil - Taisgath - Ratha - Lomtaun - Cartman - Undarverjah - Underweargnome
echo = Tamigen - Raven'sPoint - RavenPoint - Raven - RP
echo = Rolagi - Crossing - Xing - Kssarh
echo = Marendin - Shard - Ilithi - Mortom
echo = Emalerje - Volcano - LesserFist - Fist - Tiv
echo = Asharshpar'i - Asharshpari - LethDeriel - Leth
echo = Dinegavren - Therenborough - Theren
echo = Mintais - ThroneCity - Throne - TC
echo = Taniendar - Riverhaven - Haven - Gylwyn
echo = Besoge - M'riss - Mriss - Mer'kresh - Merkresh
echo = Tabelrem - Muspar'i - Muspari - Tablerum
echo = Auilusi - Aesry
echo = Vellano - Fang - FangCove
echo ==============================================
echo

if_2 goto setCounter1
goto setCounter2

setCounter1:
setvariable myCounter %2
goto setMana

setCounter2:
setvariable myCounter 3
goto setMana

setMana:
if_3 goto setMana1
goto setMana2

setMana1:
setvariable mana %3
goto myStart

setMana2:
setvariable mana 15
goto myStart

myStart:
setvariable stepsToAxis 0
setvariable stepsFromAxis 0

# These four variables are defined later in the script.
setvariable Start
setvariable Destination
setvariable Pillar
setvariable afterHarness

if_1 goto setStart
goto error_noArguments

setStart:
    match Dor'na'torna the silvery-white shard Dor'na'torna
    match Erekinzil the silvery-white shard Erekinzil
    match Besoge the silvery-white shard Besoge
    match Auilusi the silvery-white shard Auilusi
    match Tabelrem the silvery-white shard Tabelrem
    match Tamigen [Cragstone Vale, Shrine of the Shell]
    match Rolagi the silvery-white shard Rolagi
    match Marendin the silvery-white shard Marendin
    match Emalerje the silvery-white shard Emalerje
    match Asharshpar'i the silvery shard Asharshpar'i
    match Dinegavren [Gealeranendae College, Tear of Grazhir Exhibit]
    match Mintais [Phelim's Sanctum, Tear of Grazhir]
    match Taniendar the silvery-white shard Taniendar
    match Vellano the silvery-white shard Vellano
    match 100check Obvious exits:
    match 100check Obvious paths:
    put look shard
    put look
    matchwait

Dor'na'torna:
    setvariable Start Dor'na'torna
    goto setDestination
Erekinzil:
    setvariable Start Erekinzil
    goto setDestination
Besoge:
    setvariable Start Besoge
    goto setDestination
Auilusi:
    setvariable Start Auilusi
    goto setDestination
Tabelrem:
    setvariable Start Tabelrem
    goto setDestination
Tamigen:
    setvariable Start Tamigen
    goto setDestination
Rolagi:
    setvariable Start Rolagi
    goto setDestination
Marendin:
    setvariable Start Marendin
    goto setDestination
Emalerje:
    setvariable Start Emalerje
    goto setDestination
Asharshpar'i:
    setvariable Start Asharshpar'i
    goto setDestination
Dinegavren:
    setvariable Start Dinegavren
    goto setDestination
Mintais:
    setvariable Start Mintais
    goto setDestination
Taniendar:
    setvariable Start Taniendar
    goto setDestination
Vellano:
    setvariable Start Vellano
    goto setDestination

# Valid destinations
setDestination:
    goto setDestination_%1

setDestination_Rolagi:
setDestination_Crossing:
setDestination_Xing:
setDestination_Kssarh:
    setvariable Destination Rolagi
    setvariable Pillar Nightmares
    goto prepMoongate

setDestination_Besoge:
setDestination_M'riss:
setDestination_Mriss:
setDestination_Mer'kresh:
setDestination_Merkresh:
    setvariable Destination Besoge
    setvariable Pillar Secrets
    goto prepMoongate

setDestination_Tabelrem:
setDestination_Muspar'i:
setDestination_Muspari:
setDestination_Tablerum:
    setvariable Destination Tabelrem
    setvariable Pillar Nightmares
    goto prepMoongate

setDestination_Auilusi:
setDestination_Aesry:
    setvariable Destination Auilusi
    setvariable Pillar Tradition
    goto prepMoongate

setDestination_Dor'na'torna:
setDestination_Dornatorna:
setDestination_Hibarnhvidar:
setDestination_Hib:
setDestination_Cherulisa:
    setvariable Destination Dor'na'torna
    setvariable Pillar Tradition
    goto prepMoongate

setDestination_Tamigen:
setDestination_Raven'sPoint:
setDestination_RavenPoint:
setDestination_Raven:
setDestination_RP:
    setvariable Destination Tamigen
    setvariable Pillar Heavens
    goto prepMoongate

setDestination_Asharshpar'i:
setDestination_Asharshpari:
setDestination_LethDeriel:
setDestination_Leth:
    setvariable Destination Asharshpar'i
    setvariable Pillar Heavens
    goto prepMoongate

setDestination_Emalerje:
setDestination_Volcano:
setDestination_LesserFist:
setDestination_Fist:
setDestination_Tiv:
    setvariable Destination Emalerje
    setvariable Pillar Shrew
    goto prepMoongate

setDestination_Taniendar:
setDestination_Riverhaven:
setDestination_Haven:
setDestination_Gylwyn:
    setvariable Destination Taniendar
    setvariable Pillar Introspection
    goto prepMoongate

setDestination_Dinegavren:
setDestination_Therenborough:
setDestination_Theren:
    setvariable Destination Dinegavren
    setvariable Pillar Introspection
    goto prepMoongate

setDestination_Mintais:
setDestination_ThroneCity:
setDestination_Throne:
setDestination_TC:
    setvariable Destination Mintais
    setvariable Pillar Fortune
    goto prepMoongate

setDestination_Marendin:
setDestination_Shard:
setDestination_Ilithi:
setDestination_Mortom:
    setvariable Destination Marendin
    setvariable Pillar Secrets
    goto prepMoongate

setDestination_Erekinzil:
setDestination_Taisgath:
setDestination_Ratha:
setDestination_Cartman:
setDestination_Lomtaun:
setDestination_Undarverjah:
setDestination_Underweargnome:
    setvariable Destination Erekinzil
    setvariable Pillar Fortune
    goto prepMoongate

setDestination_Vellano:
setDestination_Fang:
setDestination_FangCove:
    setvariable Destination Vellano
    setvariable Pillar Unity
    goto prepMoongate

prepMoongate:
    put prep moongate
    goto focusShard

focusShard:
    setvariable afterHarness enterAP
    counter set %myCounter

    match error_UnknownShard You do not recognize this shard
    match harnessMana%c You feel fully prepared
    put focus %Start
    matchwait

harnessMana0:
    goto %afterHarness

harnessMana1:
harnessMana2:
harnessMana3:
harnessMana4:
    match wait_harnessMana ...wait
    match wait_harnessMana Sorry, you may only type
    match harnessCount You tap into the mana
    put harness %mana
    matchwait

harnessCount:
    counter subtract 1
    goto harnessMana%c

harnessEmergency:
    setvariable afterHarness exitAP
    counter set 1
    goto harnessMana%c

enterAP:
    match wait_enterAP ...wait
    match wait_enterAP Sorry, you may only type
    match StartIsEnd You attempt to open
    put cast %Start
    matchwait

StartIsEnd:
match exitAP %Destination
    match toAxis none
    put look
   matchwait

toAxis:
counter set %stepsToAxis
    counter add 1
    setvariable stepsToAxis %c

    toAxis1:
        match wait_toAxis1 ...wait
        match wait_toAxis1 Sorry, you may only type
        match toAxis_N the microcosm is to the north.
        match toAxis_NE the microcosm is to the northeast.
        match toAxis_E the microcosm is to the east.
        match toAxis_SE the microcosm is to the southeast.
        match toAxis_S the microcosm is to the south.
        match toAxis_SW the microcosm is to the southwest.
        match toAxis_W the microcosm is to the west.
        match toAxis_NW the microcosm is to the northwest.
        match error_expanse You cannot sense even a single thread of Lunar energy
        match error_dead You are a ghost!
        put perceive
        matchwait

toAxis_N:
    match wait_toAxis_N ...wait
    match wait_toAxis_N Sorry, you may only type
    match toAxis Obvious exits: none.
    match atAxis Obvious exits: north,
    match atAxis Obvious exits: east,
    put north
    matchwait
toAxis_NE:
    match wait_toAxis_NE ...wait
    match wait_toAxis_NE Sorry, you may only type
    match toAxis Obvious exits: none.
    match atAxis Obvious exits: north,
    match atAxis Obvious exits: east,
    put northeast
    matchwait
toAxis_E:
    match wait_toAxis_E ...wait
    match wait_toAxis_E Sorry, you may only type
    match toAxis Obvious exits: none.
    match atAxis Obvious exits: north,
    match atAxis Obvious exits: east,
    put east
    matchwait
toAxis_SE:
    match wait_toAxis_SE ...wait
    match wait_toAxis_SE Sorry, you may only type
    match toAxis Obvious exits: none.
    match atAxis Obvious exits: north,
    match atAxis Obvious exits: east,
    put southeast
    matchwait
toAxis_S:
    match wait_toAxis_S ...wait
    match wait_toAxis_S Sorry, you may only type
    match toAxis Obvious exits: none.
    match atAxis Obvious exits: north,
    match atAxis Obvious exits: east,
    put south
    matchwait
toAxis_SW:
    match wait_toAxis_SW ...wait
    match wait_toAxis_SW Sorry, you may only type
    match toAxis Obvious exits: none.
    match atAxis Obvious exits: north,
    match atAxis Obvious exits: east,
    put southwest
    matchwait
toAxis_W:
    match wait_toAxis_W ...wait
    match wait_toAxis_W Sorry, you may only type
    match toAxis Obvious exits: none.
    match atAxis Obvious exits: north,
    match atAxis Obvious exits: east,
    put west
    matchwait
toAxis_NW:
    match wait_toAxis_NW ...wait
    match wait_toAxis_NW Sorry, you may only type
    match toAxis Obvious exits: none.
    match atAxis Obvious exits: north,
    match atAxis Obvious exits: east,
    put northwest
    matchwait

atAxis:
    move east
    move up
    goto Convergence_to_%Pillar

Convergence_to_Convergence:
    goto exitAxis
Convergence_to_Nightmares:
    move south
    goto exitAxis
Convergence_to_Tradition:
    move southeast
    goto exitAxis
Convergence_to_Secrets:
    move east
    goto exitAxis
Convergence_to_Unity:
    move northeast
    goto exitAxis
Convergence_to_Shrew:
    move north
    goto exitAxis
Convergence_to_Heavens:
    move northwest
    goto exitAxis
Convergence_to_Introspection:
    move west
    goto exitAxis
Convergence_to_Fortune:
    move southwest
    goto exitAxis
Convergence_to_Broken:
    move south
    move down
    goto exitAxis

exitAxis:
    put focus %Destination
    goto fromAxis

fromAxis:
    counter set %stepsFromAxis
    counter add 1
    setvariable stepsFromAxis %c

    fromAxis1:
        match wait_fromAxis1 ...wait
        match wait_fromAxis1 Sorry, you may only type
        match fromAxis_N the conduit lies north.
        match fromAxis_NE the conduit lies northeast.
        match fromAxis_E the conduit lies east.
        match fromAxis_SE the conduit lies southeast.
        match fromAxis_S the conduit lies south.
        match fromAxis_SW the conduit lies southwest.
        match fromAxis_W the conduit lies west.
        match fromAxis_NW the conduit lies northwest.
        match error_expanse You cannot sense even a single thread of Lunar energy
        match error_dead You are a ghost!
        put perceive
        matchwait

fromAxis_N:
    match wait_fromAxis_N ...wait
    match wait_fromAxis_N Sorry, you may only type
    match exitAP You also see the silvery-white shard
    match exitAP You also see the silvery shard
    match fromAxis Obvious exits: none.
    match atAxis Obvious exits: north,
    match atAxis Obvious exits: east,
    put north
    matchwait

fromAxis_NE:
    match wait_fromAxis_NE ...wait
    match wait_fromAxis_NE Sorry, you may only type
    match exitAP You also see the silvery-white shard
    match exitAP You also see the silvery shard
    match fromAxis Obvious exits: none.
    match atAxis Obvious exits: north,
    match atAxis Obvious exits: east,
    put northeast
    matchwait

fromAxis_E:
    match wait_fromAxis_E ...wait
    match wait_fromAxis_E Sorry, you may only type
    match exitAP You also see the silvery-white shard
    match exitAP You also see the silvery shard
    match fromAxis Obvious exits: none.
    match atAxis Obvious exits: north,
    match atAxis Obvious exits: east,
    put east
    matchwait

fromAxis_SE:
    match wait_fromAxis_SE ...wait
    match wait_fromAxis_SE Sorry, you may only type
    match exitAP You also see the silvery-white shard
    match exitAP You also see the silvery shard
    match fromAxis Obvious exits: none.
    match atAxis Obvious exits: north,
    match atAxis Obvious exits: east,
    put southeast
    matchwait

fromAxis_S:
    match wait_fromAxis_S ...wait
    match wait_fromAxis_S Sorry, you may only type
    match exitAP You also see the silvery-white shard
    match exitAP You also see the silvery shard
    match fromAxis Obvious exits: none.
    match atAxis Obvious exits: north,
    match atAxis Obvious exits: east,
    put south
    matchwait

fromAxis_SW:
    match wait_fromAxis_SW ...wait
    match wait_fromAxis_SW Sorry, you may only type
    match exitAP You also see the silvery-white shard
    match exitAP You also see the silvery shard
    match fromAxis Obvious exits: none.
    match atAxis Obvious exits: north,
    match atAxis Obvious exits: east,
    put southwest
    matchwait

fromAxis_W:
    match wait_fromAxis_W ...wait
    match wait_fromAxis_W Sorry, you may only type
    match exitAP You also see the silvery-white shard
    match exitAP You also see the silvery shard
    match fromAxis Obvious exits: none.
    match atAxis Obvious exits: north,
    match atAxis Obvious exits: east,
    put west
    matchwait

fromAxis_NW:
    match wait_fromAxis_NW ...wait
    match wait_fromAxis_NW Sorry, you may only type
    match exitAP You also see the silvery-white shard
    match exitAP You also see the silvery shard
    match fromAxis Obvious exits: none.
    match atAxis Obvious exits: north,
    match atAxis Obvious exits: east,
    put northwest
    matchwait

exitAP:
    put prep moongate

    match error_UnknownShard You do not recognize this shard
    match exitAP_cast feel fully prepared
    put focus %Destination
    matchwait

exitAP_cast:
    match wait_exitAP_cast ...wait
    match wait_exitAP_cast Sorry, you may only type
    match harnessEmergency The spell goes awry!
    match release You attempt to open an astral
    put cast %Destination
    matchwait

release:
    put release
    pause 1
    echo Statistics:  %stepsToAxis from %Start to Axis
    echo Statistics:  %stepsFromAxis from Axis to %Destination
    goto cleanup

cleanup:
    unvar stepsToAxis
    unvar stepsFromAxis
    unvar mana
    unvar Start
    unvar Destination
    unvar Pillar
    unvar counter
    unvar afterHarness
    exit


#################################
# Wait section
wait_harnessMana:
    pause 1
    goto harnessMana%c
wait_harnessEmergency:
    pause 1
    goto harnessEmergency
wait_enterAP:
    pause 1
    goto enterAP
wait_toAxis1:
    pause 1
    goto toAxis1
wait_toAxis_N:
    pause 1
    goto toAxis_N
wait_toAxis_NE:
    pause 1
    goto toAxis_NE
wait_toAxis_E:
    pause 1
    goto toAxis_E
wait_toAxis_SE:
    pause 1
    goto toAxis_SE
wait_toAxis_S:
    pause 1
    goto toAxis_S
wait_toAxis_SW:
    pause 1
    goto toAxis_SW
wait_toAxis_W:
    pause 1
    goto toAxis_W
wait_toAxis_NW:
    pause 1
    goto toAxis_NW
wait_fromAxis1:
    pause 1
    goto fromAxis1
wait_fromAxis_N:
    pause 1
    goto fromAxis_N
wait_fromAxis_NE:
    pause 1
    goto fromAxis_NE
wait_fromAxis_E:
    pause 1
    goto fromAxis_E
wait_fromAxis_SE:
    pause 1
    goto fromAxis_SE
wait_fromAxis_S:
    pause 1
    goto fromAxis_S
wait_fromAxis_SW:
    pause 1
    goto fromAxis_SW
wait_fromAxis_W:
    pause 1
    goto fromAxis_W
wait_fromAxis_NW:
    pause 1
    goto fromAxis_NW
wait_exitAP_cast:
    pause 1
    goto exitAP_cast
#####################################
# 100th
100check:
if_4 goto 100
goto error_badStart

100:
setvariable Start Grazhir
echo *** Using 100th ability ***
    goto setDestination100

setDestination100:
    goto setDestination100_%1

setDestination100_Rolagi:
setDestination100_Crossing:
setDestination100_Xing:
setDestination100_Kssarh:
    setvariable Destination Rolagi
    setvariable Pillar Nightmares
    goto prepMoongate100

setDestination100_Besoge:
setDestination100_M'riss:
setDestination100_Mriss:
setDestination100_Mer'kresh:
setDestination100_Merkresh:
    setvariable Destination Besoge
    setvariable Pillar Secrets
    goto prepMoongate100

setDestination100_Tabelrem:
setDestination100_Muspar'i:
setDestination100_Muspari:
setDestination100_Tablerum:
    setvariable Destination Tabelrem
    setvariable Pillar Nightmares
    goto prepMoongate100

setDestination100_Auilusi:
setDestination100_Aesry:
    setvariable Destination Auilusi
    setvariable Pillar Tradition
    goto prepMoongate100

setDestination100_Dor'na'torna:
setDestination100_Dornatorna:
setDestination100_Hibarnhvidar:
setDestination100_Hib:
setDestination100_Cherulisa:
    setvariable Destination Dor'na'torna
    setvariable Pillar Tradition
    goto prepMoongate100

setDestination100_Tamigen:
setDestination100_Raven'sPoint:
setDestination100_RavenPoint:
setDestination100_Raven:
setDestination100_RP:
    setvariable Destination Tamigen
    setvariable Pillar Heavens
    goto prepMoongate100

setDestination100_Asharshpar'i:
setDestination100_Asharshpari:
setDestination100_LethDeriel:
setDestination100_Leth:
    setvariable Destination Asharshpar'i
    setvariable Pillar Heavens
    goto prepMoongate100

setDestination100_Emalerje:
setDestination100_Volcano:
setDestination100_Fist:
setDestination100_Tiv:
    setvariable Destination Emalerje
    setvariable Pillar Shrew
    goto prepMoongate100

setDestination100_Taniendar:
setDestination100_Riverhaven:
setDestination100_Haven:
setDestination100_Gylwyn:
    setvariable Destination Taniendar
    setvariable Pillar Introspection
    goto prepMoongate100

setDestination100_Dinegavren:
setDestination100_Therenborough:
setDestination100_Theren:
    setvariable Destination Dinegavren
    setvariable Pillar Introspection
    goto prepMoongate100

setDestination100_Mintais:
setDestination100_ThroneCity:
setDestination100_Throne:
setDestination100_TC:
    setvariable Destination Mintais
    setvariable Pillar Fortune
    goto prepMoongate100

setDestination100_Marendin:
setDestination100_Shard:
setDestination100_Ilithi:
setDestination100_Mortom:
    setvariable Destination Marendin
    setvariable Pillar Secrets
    goto prepMoongate100

setDestination100_Erekinzil:
setDestination100_Taisgath:
setDestination100_Ratha:
setDestination100_Lomtaun:
setDestination100_Undarverjah:
setDestination100_Underweargnome:
    setvariable Destination Erekinzil
    setvariable Pillar Fortune
    goto prepMoongate100

setDestination100_Vellano:
setDestination100_Fang:
setDestination100_FangCove:
    setvariable Destination Vellano
    setvariable Pillar Unity
    goto prepMoongate100

prepMoongate100:
    put prep moongate
    setvariable afterHarness enterAP100
    counter set %myCounter
goto harnessMana100%c

harnessMana1000:
    goto %afterHarness

harnessMana1001:
harnessMana1002:
harnessMana1003:
harnessMana1004:
    match wait_harnessMana100 ...wait
    match wait_harnessMana100 Sorry, you may only type
    match harnessCount100 You tap into the mana
    put harness %mana
    matchwait

harnessCount100:
    counter subtract 1
    goto harnessMana100%c

enterAP100:
    put lick inauri
    match wait_enterAP100 ...wait
    match wait_enterAP100 Sorry, you may only type
    match StartIsEnd You attempt to open an astral
    put cast Grazhir
    matchwait


wait_harnessMana100:
    pause 1
    goto harnessMana100%c
wait_enterAP100:
    pause 1
    goto enterAP100

#####################################
# Errors
error_UnknownShard:
    echo
    echo ERROR:  You do not know this shard yet!
    echo         "study %Start" to learn this shard.
    echo
    echo         Until this shard is learned, you can not enter
    echo         or exit the Astral Planes here.
    echo
    echo         Don't forget to "release" if it is safe to do so!
    echo
    echo         If you are still in the Astral Plane, find your
    echo         way to the nearest known shard, ASAP!
    goto cleanup
error_NoArguments:
    echo
    echo ERROR:  This script requires a name for your destination.
    echo         Please see the starting text for a list.
    echo         Proper usage is ".ap destination"
    echo
    goto cleanup
error_badStart:
    echo
    echo ERROR:  You are not at a known Grazhir shard
    echo         and you either lack the 100th ability or
    echo  did not include a 4th variable!
    echo
    goto cleanup
error_expanse:
    echo
    echo *** Uh oh, you're trapped in the grey expanse.
    echo *** You may get out, but it isn't likely.  Good luck!
    echo
    echo Statistics:  %stepsToAxis from %Start to Axis
    echo Statistics:  %stepsFromAxis from Axis to %Destination
    goto cleanup
error_dead:
    echo
    echo *** Uh oh, you didn't survive this trip.
    echo *** I hope the empath likes extra crispy!
    echo
    echo Statistics:  %stepsToAxis from %Start to Axis
    echo Statistics:  %stepsFromAxis from Axis to %Destination
    goto cleanup
labelError:
    echo
    echo ERROR:  You did not type in a valid name for your destination.
    echo         Please see the starting text for a list.
    echo         If you did type in a listed destination or got this error
    echo         while already moving, this this is a bug with the script's labels.
    echo
    goto cleanup
