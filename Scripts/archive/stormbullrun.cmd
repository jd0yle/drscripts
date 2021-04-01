include libsel.cmd

one:
    match sconce YOU HAVE ARRIVED
    match one AUTOMAPPER MOVEMENT FAILED!
    put #walk 114
    matchwait

sconce:
    put turn sconce
    pause
    goto two

two:
    match door YOU HAVE ARRIVED
    match two AUTOMAPPER MOVEMENT FAILED!
    put #walk 113
    matchwait

door:
    pause
    move go door
    pause
    goto three

three:
    match four YOU HAVE ARRIVED
    match three AUTOMAPPER MOVEMENT FAILED!
    put #walk leth
    matchwait

four:
    match five YOU HAVE ARRIVED
    match four AUTOMAPPER MOVEMENT FAILED!
    put #walk leth
    matchwait

five:
    match six YOU HAVE ARRIVED
    match five AUTOMAPPER MOVEMENT FAILED!
    put #walk il
    matchwait

six:
    put #walk 31
    waitforre YOU HAVE ARRIVED

put #parse STORMBULLRUN DONE
exit