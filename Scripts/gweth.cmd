var channelIsClosed null
action var channelIsClosed 1 when ^With a moment of focus you close your mind to the \S+ channel\.$


touch:
  matchre channel (A chorus of foreign thoughts joins your own.|Since you already have telepathy, nothing more happens.)
  matchre channel You touch the stones on a gwethdesuan.
  match exit crumble
  put touch my gweth
  matchwait

channel:
  var channels general|local|trade|race|guild|private|personal
  var channelsIndex 0
  eval len count("%channels", "|")
listen:
  if (%channelsIndex > %len) then goto exit

  if ("%channels(%channelsIndex)" <> "null") then {
    put esp listen %channels(%channelsIndex)
    waitforre ^With a moment of focus
  }
  if (%channelIsClosed != 1) then math channelsIndex add 1
  var channelIsClosed null
  goto listen

exit:
  put esp channel
  exit
