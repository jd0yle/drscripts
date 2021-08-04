include libmaster.cmd

action put exit when eval $health < 20
action put exit when eval $dead = 1
#action put exit when eval $bleeding = 1
#action put exit when eval $stunned = 1


action put #script abort all except idle; put exit when ^Inauri whispers, "!quit
action put #script abort all except idle when ^Inauri whispers, "!stop
action send awake when ^Inauri whispers, "!awake
action send awake; send sleep; send sleep when ^Inauri whispers, "!sleep
action goto goHouse when ^Inauri whispers, "!house
action put tellexp Inauri $1 when ^Inauri whispers, "!tellexp (.*)
action var skill $1; goto tellSKillLearningRate when ^Inauri whispers, "!skill (.*)"
action goto castTv when ^Inauri whispers, "tv"
action send accept when ^.*offers you.*ACCEPT

action put ooc inauri I know teach, quit, stop, awake, sleep, house, and tellexp when ^Inauri whispers, "!help

var nextAlarmAt 0
var nextAllowableWhisperAt 0
timer start


loop:
    if (%t > %nextAlarmAt) then {
        evalmath nextAlarmAt %t + 240
        # echo [$time]
        gosub tdps
    }
    pause 2
    goto loop


goHouse:
    put #script pause all except idle
    pause
    send unlock house
    pause
    send open house
    pause
    send go house
    goto loop


tellSKillLearningRate:
    if (%nextAllowableWhisperAt < %t) then {
        evalmath nextAllowableWhisperAt (%t + 2)
        if (contains("$%skill.LearningRate", "LearningRate")) then {
            put whisper inauri It's ok to make mistakes, I still love you
        } else {
            put whisper inauri %skill: $%skill.Ranks ($%skill.LearningRate/34)
        }
    }
    goto loop


castTv:
    put #script pause all except idle
    pause .3
    gosub release spell
    gosub release mana
    gosub release symbi
    gosub prep tv 60
    pause 20
    gosub cast Selesthiel
    pause 60
    put #script resume all
    goto loop

