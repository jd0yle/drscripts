action goto reconnected when ^You look around, taking a moment to get your bearings\.$
action goto reconnected when Last login

action goto do.connect when ^ReceiveCallback Exception:
action goto do.connect when eval $connected = 0

if (!$connected) then goto do.connect
goto monitor.connection

reconnected:
	action goto do.connect when eval $connected = 0
	if !($connected) then goto do.connect

	put #script abort all except reconnectold
    if ("$charactername" = "Qizhmur") then put .qiztrain
    if ("$charactername" = "Selesthiel") then put .seltrainshard

	put #parse RECONNECTED
	put #echo >Log #0000FF Reconnected!

monitor.connection:
	pause 120
	var last.time $gametime
	pause 30
	if %last.time = $gametime then goto do.connect
	goto monitor.connection

do.connect:
    put #echo >Log #00FF00 [reconnectold]: RECONNECTING!
	action remove eval $connected = 0
	put #script abort all except reconnectold
	put #queue clear
	pause .2
	if ("$lastcommand") = "quit" then exit
	if ($dead) then exit
	put #connect
	pause 15
	put look
	pause 5
	goto do.connect