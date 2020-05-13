
send sort boots
pause .2
send sort pants
pause .2
send sort baldric
pause .2
send sort band
pause .2
send sort robe

var titleList Shadow Mage|Dikka'staho Ashu|Shadow Reaver|Monk|Ascetic|Fate Reaver
eval len count("%titleList", "|")
random 0 %len
#put title pre choose moon %titleList(%r)
