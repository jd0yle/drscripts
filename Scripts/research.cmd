include libsel.cmd

var researchProject null

action var researchProject $1 when ^You.*begin to bend the mana streams.*(utility|augmentation|ward)
action var researchProject stream when ^You focus your magical perception as tightly as possible
action var researchProject sorcery when ^Abandoning the normal discipline required to manipulate the mana streams
action var researchProject fundamental when ^You tentatively reach out and begin manipulating the mana streams

action var researchProject null when ^You decide to cancel your project
action var researchProject null when ^Breakthrough!

action echo researchProject %researchProject when eval %researchProject

loop:
pause 2
goto loop