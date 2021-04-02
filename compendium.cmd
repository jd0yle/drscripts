include libmaster.cmd
###############
# Compendium
# Updated 29MAR2021
###############

###############
# Variables
###############
goto $charactername
Inauri:
  var book compendium
  var container satchel
  goto compendiumGetBook

Khurnaarti:
  var book compendium
  var container rucksack
  goto compendiumGetBook

compendiumGetBook:
  gosub get my %book
  gosub open my %book
  goto compendiumReadBook

compendiumReadBook:
  matchre compendiumReadBook ^(You begin|You continue)
  matchre compendiumTurnBook ^(In a sudden|with sudden|With a sudden|You attempt)
  matchre compendiumCloseBook ^Why do you
  put study my %book
  matchwait 5

compendiumTurnBook:
  gosub turn my %book
  goto compendiumReadBook

compendiumCloseBook:
  gosub close my %book
  gosub stow my %book
  exit