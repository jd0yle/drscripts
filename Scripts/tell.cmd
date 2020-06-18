action send tellexp Inauri $1 when ^Inauri whispers, "!exp(.*)"

#trigger {^Inauri whispers, "!exp(.*)"} {#send tellexp Inauri $1}

loop:
    pause 2
    goto loop
