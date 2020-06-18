include libsel.cmd


swimLoop:
    put #walk 550
    waitforre ^YOU HAVE ARRIVED
    put #walk 551
    waitforre ^YOU HAVE ARRIVED
    put #walk 552
    waitforre ^YOU HAVE ARRIVED
    put #walk 549
    waitforre ^YOU HAVE ARRIVED
    if ($Athletics.LearningRate < 34) then goto swimLoop
    goto done

done:
    echo SWIM DONE
    put #parse SWIM DONE
    exit

