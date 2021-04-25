include args.cmd

var days %args.days
var hours %args.hours
var minutes %args.minutes

evalmath timeSinceLastLogin (((%days * 24) + %hours) * 60 + %minutes) * 60

echo Seconds since last login: %timeSinceLastLogin

put #var lastLoginTime #evalmath $gametime - %timeSinceLastLogin