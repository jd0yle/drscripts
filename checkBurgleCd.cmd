evalmath remainingSeconds ($lib.timers.nextBurgleAt - $gametime)
evalmath remainingMinutes floor(%remainingSeconds / 60)
math remainingSeconds modulus 60

echo Next Burgle In: %remainingMinutes minutes, %remainingSeconds seconds