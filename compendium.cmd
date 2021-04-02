include libmaster.cmd
###############
# Compendium
###############

compendiumGetBook:
  gosub get my $char.compendium
  gosub open my $char.compendium
  goto compendiumReadBook

compendiumReadBook:
  matchre compendiumReadBook ^(You begin|You continue)
  matchre compendiumTurnBook ^(In a sudden|with sudden|With a sudden|You attempt)
  matchre compendiumCloseBook ^Why do you
  put study my $char.compendium
  matchwait 5

compendiumTurnBook:
  gosub turn my $char.compendium
  goto compendiumReadBook

compendiumCloseBook:
  gosub close my $char.compendium
  gosub stow my $char.compendium
  exit