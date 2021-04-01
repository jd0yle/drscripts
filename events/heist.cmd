action goto cast when Your formation of a targeting pattern around a
action #send guard when You should guard it before it is stolen.
action goto exit when You begin making your way out of the bank.
action #send track when ^You secure the contents

var weapon scimitar
var tmSpell acs
var mana 4

getBlade:
  matchre getBlade ...wait|Sorry
  match getSlip You deftly remove
  match getSlip You draw
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
  put tar %tmSpell %mana
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
  put slice
  matchwait

track:
  match attack It's not safe enough to track anything.
  matchre track ...wait|Sorry
  match listen Roundtime
  put track
  matchwait

exit:
  exit