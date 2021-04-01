setVariable move look
counter set 0

MoveMatch:
counter add 1
	pause
	match MoveMatch ...wait
	match MoveMatch you may only
	match ShackMatch You also see a ruined shack
	match Moverandom10 You can't go there
	match LREED Obvious
	put %move
	matchwait

RetMove:
pause
match RetMove ...wait
match RetMove you may only
match RetMove You retreat back to pole range.
match MoveMatch You are already as far away as you can get!
match MoveMatch You retreat from combat.
put ret
matchwait

ShackMatch:
pause
put w
wait
pause
put nw
goto LReed

LReed:
pause
	match MoveRandom%c I could not find what you were referring to.
	match GoReed You see nothing unusual
	match LReed ...wait
	match LReed you may only
	put look reed
	matchwait

MoveRandom1:
setvariable move n
goto MoveMatch

MoveRandom2:
setvariable move ne
goto MoveMatch

MoveRandom3:
setvariable move e
goto MoveMatch

MoveRandom4:
setvariable move se
goto MoveMatch

MoveRandom5:
setvariable move s
goto MoveMatch

MoveRandom6:
setvariable move sw
goto MoveMatch

MoveRandom7:
setvariable move w
goto MoveMatch

MoveRandom8:
setvariable move nw
goto MoveMatch

MoveRandom9:
setvariable move n
goto MoveMatch


MoveRandom10:
counter set 1
goto MoveRandom1

GoReed:
pause
match RetReed You are engaged to
match End The Marsh, Stone Road
match GoReed ...wait
match GoReed you may only
put go reed
matchwait

RetReed:
pause
match RetReed ...wait
match RetReed you may only
match RetReed You retreat back to pole range.
match GoReed You are already as far away as you can get!
match GoReed You retreat from combat.
put ret
matchwait

End:
put #parse EXITCROC DONE