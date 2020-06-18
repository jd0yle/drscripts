
echo %0

# (?!quartz gargoyle)quartz\w

if matchre("a quartz gargoyle", "quartz (?!gargoyle)") then echo it matches a quartz gargoyle

if matchre("crystal-clear quartz,", "quartz.(?!gargoyle)") then echo it matches gems

