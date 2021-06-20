include libmaster.cmd

if ($char.magic.train.useInstrument = 1) then {
    if ($Performance.LearningRate < 33 && $char.isPerforming != 1) then {
        if ("$righthand" != "$char.instrument.tap") then {
            gosub stow right
            gosub get my $char.instrument.noun
        }
        gosub play $char.instrument.song on my $char.instrument.noun
    } else {
        if ("$righthand" = "$char.instrument.tap") then gosub put my $char.instrument.noun in my $char.instrument.container
    }
}

if ($char.magic.train.useInstrument = 1 && ("$righthand" = "$char.instrument.tap" || "$lefthand" = "$char.instrument.tap")) then gosub put my $char.instrument.noun in my $char.instrument.container