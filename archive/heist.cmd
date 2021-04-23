#TODO:  Rewrite.
# This is for Inauri in the Duskruin heist.

#action goto cast when Your formation of a targeting pattern around a
action goto cast when You feel fully prepared
action #send guard when You should guard it before it is stolen.
action goto sheath when You begin making your way out of the bank.
action goto listen when You make your way deeper inside the bank.
action #send track when ^You secure the contents

var weapon assassin blade
var tmSpell nb
var mana 15

getBlade:
  matchre getBlade ...wait|Sorry
  match getSlip You deftly remove
  put wield my %weapon
  matchwait

getSlip:
  matchre getSlip ...wait|Sorry
  match join You get a dueling slip 
  put get my slip
  matchwait

join:
  matchre join ...wait|Sorry
  match listen You hold out your dueling slip and a Chrematistic Investor battlemaster takes it, escorting you to the bank.
  put join battlemaster
  matchwait

listen:
  matchre listen  ...wait|Sorry
  matchre attackWait  Roundtime|You've already listened to your surroundings.
  put listen
  matchwait

attackWait:
  waitforre assassin|bandit|asp|eagle
  put prep %tmSpell %mana
  goto attack

cast:
  matchre cast ...wait|Sorry
  match attack Roundtime
  put cast
  matchwait

attack:
  matchre attack ...wait|Sorry
  matchre track There is nothing else to face
  match attack Roundtime
  put attack
  matchwait

track:
  match attack It's not safe enough to track anything.
  matchre track ...wait|Sorry
  match listen Roundtime
  put track
  matchwait

sheath:
  matchre sheath ...wait|Sorry
  match openPouch You hang 
  put sheath
  matchwait

openPouch:
  matchre getBS You open your burlap pouch.
  match openPouch ...wait|Sorry
  put open my pouch
  matchwait

getBS:
  matchre getBS ...wait|Sorry
  match rummagePouch You pick up
  put get my bloo
  matchwait

rummagePouch:
  match exit You rummage through
  matchre rummagePouch ...wait|Sorry
  put rummage my pouch
  matchwait

exit:
  exit