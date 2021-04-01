#Javascript function tests.
debug 10

include jsstarchart.js

pause 0.5

var testarray Beta|Gamma|Epsilon|Alpha|Omega|Theta

echo Pre-testing state.
echo Array: %testarray

echo Starting testing.

pause 0.5

jscall testarray getConstellationNamesBySkillset("magic");

echo Array: %testarray
pause .5
