var class %1
var target %2

include libsel.cmd

gosub stop teach
gosub stop listen
gosub teach %class to %target
