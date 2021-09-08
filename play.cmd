####################################################################################################
# .play
# Selesthiel - justin@jmdoyle.com
#
# Plays an instrument
#
# ****** MUST DEFINE THESE CHAR VARIABLES FIRST: ******
# char.instrument.noun
# char.instrument.tap
# char.instrument.container
#
# USAGE
# .play [--noWait=1]   #By default, the script will wait until you are done playing to exit
#
# .play
# .play --noWait=1
####################################################################################################
include libmaster.cmd
include args.cmd

var play.songs arpeggios|ditty|ballad|waltz|march|lament|hymn|polka|reel|serenade|psalm|tango|bolero|nocturne|requiem|concerto

var play.songAtStart $char.instrument.song

# By default, we want to try a harder song every time to see if we can play it
var setHarderSong 1
action var setHarderSong 1 when ^You effortlessly begin
action var setEasierSong 1 when ^You (struggle|fumble)
action var setHarderSong 0;var setEasierSong 0 when only the slightest hint of difficulty\.$

action goto play.repairInstrument when ^The damage to your instrument affects your performance\.$
action goto play.cleanInstrument when ^You notice that moisture has accumulated


###############################
###      play.top
###############################
play.top:
	if ("$righthand" != "$char.instrument.tap" && "$righthand" != "Empty") then gosub stow right
	gosub stow left

    if ($Performance.LearningRate < 34) then {
        if ("$righthand" != "$char.instrument.tap") then {
            gosub stow right
            gosub get my $char.instrument.noun
        }

		#if ("$char.instrument.song" = "\$char.instrument.song") then {
		if (!contains("%play.songs", "$char.instrument.song")) then {
			echo $char.instrument.song not set (=$char.instrument.song), setting to default
			gosub play.setCharacterSong
		}

        gosub play $char.instrument.song on my $char.instrument.noun

        if (%setEasierSong = 1) then {
            gosub play.setEasierSong
            gosub stop play
            goto play.top
        }
        if (%setHarderSong = 1) then {
            gosub play.setHarderSong
            gosub stop play
            goto play.top
        }

        if ("$char.instrument.song" != "%play.songAtStart") then put #echo >Log [play] Changed songs from %play.songAtStart to $char.instrument.song
    }
    if (%args.noWait != 1) then gosub play.wait
    goto play.done


###############################
###      play.cleanInstrument
###############################
play.cleanInstrument:
	gosub stop play
	gosub stow left
	gosub get my cloth
	if ("$lefthand" = "Empty") then goto done.noCleaningCloth
	put wipe my $char.instrument.noun with my cloth
	gosub stow my cloth
	goto play.top


###############################
###      play.repairInstrument
###############################
play.repairInstrument:
	gosub stop play
	gosub stow left
	gosub get my repair kit
	if ("$lefthand" = "Empty") then goto done.noRepairKit
	gosub repair my $char.instrument.noun with my repair kit
	gosub stow my repair kit
	goto play.top


###############################
###      play.getSongIndex
###############################
play.getSongIndex:
	var getSongIndex.song $0
	var getSongIndex.index 0

	play.getSongIndex.loop:
		if ("%getSongIndex.song" = "%play.songs(%getSongIndex.index)") then return
		math getSongIndex.index add 1
		if (%getSongIndex.index > count("%play.songs", "|") then {
			# Couldn't find the given song in the array, so return a not found value (-1)
			var getSongIndex.index -1
			return
		}
		goto play.getSongIndex.loop


###############################
###      play.setEasierSong
###############################
play.setEasierSong:
	gosub play.getSongIndex $char.instrument.song

	# Couldn't find this char's song, so set a new default song
	if (%getSongIndex.index = -1) then {
		gosub play.setCharacterSong
		return
	}

	# Can't make it any easier than 0 (arpeggios), so just return
	if (%getSongIndex.index = 0) then return

	evalmath getSongIndex.index (%getSongIndex.index - 1)
	put #tvar char.instrument.song %play.songs(%getSongIndex.index)
	echo [play] Moved to easier song: $char.instrument.song
	return


###############################
###      play.setHarderSong
###############################
play.setHarderSong:
	gosub play.getSongIndex $char.instrument.song

	# Couldn't find this char's song, so set a new default song
	if (%getSongIndex.index = -1) then {
		echo play.setHarderSong couldn't find songIndex of char song ($char.instrument.song)
		gosub play.setCharacterSong
		return
	}

	# Can't make it any harder than 15 (concerto), so just return
	if (%getSongIndex.index = 15) then return

	evalmath getSongIndex.index (%getSongIndex.index + 1)
	put #tvar char.instrument.song %play.songs(%getSongIndex.index)
	echo [play] Moved to harder song: $char.instrument.song
	return


###############################
###      play.wait
###############################
play.wait:
	pause 2
	if ($char.isPerforming != 1) then return
	goto play.wait


###############################
###      play.setCharacterSong
###############################
play.setCharacterSong:
	if ($Performance.Ranks >= 40) then put #tvar char.instrument.song arpeggios
	if ($Performance.Ranks >= 50) then put #tvar char.instrument.song ditty
	if ($Performance.Ranks >= 60) then put #tvar char.instrument.song ballad
	if ($Performance.Ranks >= 70) then put #tvar char.instrument.song waltz
	if ($Performance.Ranks >= 80) then put #tvar char.instrument.song march
	if ($Performance.Ranks >= 100) then put #tvar char.instrument.song lament
	if ($Performance.Ranks >= 125) then put #tvar char.instrument.song hymn
	if ($Performance.Ranks >= 180) then put #tvar char.instrument.song polka
	if ($Performance.Ranks >= 220) then put #tvar char.instrument.song reel
	if ($Performance.Ranks >= 250) then put #tvar char.instrument.song serenade
	if ($Performance.Ranks >= 300) then put #tvar char.instrument.song psalm
	if ($Performance.Ranks >= 350) then put #tvar char.instrument.song tango
	if ($Performance.Ranks >= 450) then put #tvar char.instrument.song bolero
	if ($Performance.Ranks >= 475) then put #tvar char.instrument.song nocturne
	if ($Performance.Ranks >= 525) then put #tvar char.instrument.song requiem
	if ($Performance.Ranks >= 550) then put #tvar char.instrument.song concerto
	return


###############################
###      play.done
###############################
play.done:
	if ($char.isPerforming != 1 && ("$righthand" = "$char.instrument.tap" || "$lefthand" = "$char.instrument.tap")) then gosub put my $char.instrument.noun in my $char.instrument.container
	pause .2
	put #parse PLAY DONE
	exit




#You begin a quiet rumba on your voodoo priest's rattle with only the slightest hint of difficulty.
#You begin a quiet hymn on your voodoo priest's rattle with only the slightest hint of difficulty.
#You effortlessly begin a quiet ditty on your voodoo priest's rattle, your heart swelling in pride at your hard-earned skill.
#You struggle to begin a quiet concerto on your voodoo priest's rattle.
#You fumble slightly as you begin a spritely polka on your voodoo priest's rattle.
#You begin a quiet lament on your voodoo priest's rattle.

#trigger {^You begin|^You effortlessly begin|^You struggle to begin|^You fumble slightly|^You continue playing on your|^You continue to play|^You lean forward as the complex rhythm wafts from your|^A.*floats through the air as you continue playing} {#tvar char.isPerforming 1} {isPerforming}
#trigger {^You stop playing your song|^You finish playing|^In the name of love} {#tvar char.isPerforming 0} {isPerforming}