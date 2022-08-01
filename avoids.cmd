include libmaster.cmd

gosub avoid !join
gosub avoid !drag
gosub avoid !hold
gosub avoid teach
gosub avoid whisper
gosub avoid !danc
gosub avoid touch
gosub avoid !coins
gosub avoid !crime

pause .2
put #parse AVOIDS DONE
exit