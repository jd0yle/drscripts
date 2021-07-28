include libmaster.cmd

if_1 then {
	var rs.target %1
} else {
	echo NO TARGET SPECIFIED
	echo .rs <target>
	exit
}

if ($SpellTimer.BraunsConjecture.active != 1 || $SpellTimer.BraunsConjecture.duration < 5) then gosub runScript cast bc
if ($SpellTimer.ClearVision.active != 1 || $SpellTimer.ClearVision.duration < 5) then gosub runScript cast cv

gosub prep locate 50
pause 10
gosub cast %rs.target

gosub runScript cast rs %rs.target
