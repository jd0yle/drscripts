touch:
  matchre channel (A chorus of foreign thoughts joins your own.|Since you already have telepathy, nothing more happens.)
  match exit crumble
  put touch my gwe
  matchwait

channel:
  var channels general|local|trade|race|guild|private|personal
  var channelsIndex 0
  eval len count("%channels", "|")
listen:
  if (%channelsIndex > %len) then goto exit
  if ("%channels(%channelsIndex)" <> "null") then {
    put esp listen %channels(%channelsIndex)
  }
  math channelsIndex add 1
  goto listen

exit:
  put esp channel
  exit
