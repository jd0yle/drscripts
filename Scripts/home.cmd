include libsel.cmd

put .astro
waitforre ^ASTRO DONE$

put .astral crossing
waitforre ^ASTRAL DONE$

gosub automove crossing
gosub automove crossing
gosub automove 258

gosub unlock house
gosub open house
gosub move go house
gosub close door
gosub lock door

put whisper inauri heal
pause 30
put whisper inauri heal
pause 10
put .seltrain

