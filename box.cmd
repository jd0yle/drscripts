include boxlibrary.cmd

var boxtype brass|copper|deobar|driftwood|iron|ironwood|mahogany|oaken|pine|steel|wooden
var boxes coffer|crate|strongbox|caddy|casket|skippet|trunk|chest|box

action var baddisarm 1 when ^However, a \w+ \w+ \w+ is not fully disarmed, making any chance of picking it unlikely\.

var baddisarm 0
var pouch pouch

if_1 then
else
{
  put #echo mono Options are:
  put #echo mono "     auto - attempts to pick all of your boxes."
  put #echo mono "     hand - picks the box in your hand."
  exit
}

if %1 = "auto" then
{
  var repeating 1
  var boxindex 0
}
if %1 = "hand" then
{
  var boxitem $righthandnoun
  var repeating 0
}

MAIN:
  if %repeating = 1 then
  {
    var boxitem %boxes(%boxindex)
    gosub GETITEM %boxitem
  }
  if $righthand = "Empty" then
  {
    if %repeating = 1 then
    {
      math boxindex add 1
      if %boxindex > 8 then exit
      goto MAIN
    }
    else
    {
      echo No box!
      exit
    }
  }
  gosub DISARM
  var openitemname %boxitem
  gosub OPENITEM
  gosub BOXCOINGET
  gosub FILLPOUCH
  gosub BOXLOOTCHECK
  gosub DISMANTLE
  if %repeating = 1 then goto MAIN
  else exit


DISARMP:
  pause
DISARM:
  matchre DISARMP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  match DISARM2Q An aged grandmother could defeat this trap in her sleep.
  match DISARM2Q This trap is a laughable matter, you could do it blindfolded!
  match DISARM2Q trap is a trivially constructed gadget which you can take down any time.
  match DISARM2Q will be a simple matter for you to disarm.
  match DISARM2C should not take long with your skills.
  match DISARM2C with only minor troubles.
  match DISARM2C You think this trap is precisely at your skill level.
  match DISARM2C The trap has the edge on you, but you've got a good shot at disarming the
  match DISARM2C The odds are against you, but with persistence you believe you could disarm the
  match DISARM2C You have some chance of being able to disarm the
  match DISARM2C would be a longshot.
  match DISARM2C Prayer would be a good start for any attempt of yours at disarming the
  match DISARM2C You have an amazingly minimal chance at disarming the
  match DISARM2C You really don't have any chance at disarming this
  match DISARM2C You probably have the same shot as a snowball does crossing the desert.
  match DISARM2C You could just jump off a cliff and save yourself the frustration of attempting this
  match DISARM2C A pitiful snowball encased in the Flames of Ushnish would fare better than you.
  match DISARM You get the distinct feeling your careless examination caused something to shift inside the trap mechanism.  This is not likely to be a good thing.
  match DISARM fails to reveal to you what type of trap protects it.
  match PICK You guess it is already disarmed.
  match PICK Roundtime:
  put disarm %boxitem identify
  matchwait

DISARM2Q:
  var disarmtype quick
  goto DISARM2
  
DISARM2C:
  var disarmtype careful
  goto DISARM2 
  
DISARM2P:
  pause
DISARM2:
  matchre DISARM2P \.\.\.wait|type ahead|stunned|while entangled in a web\.
  match PICK Roundtime:
  match DISARM2 You work with the trap for a while but are unable to make any progress.
  matchre DISARM is not yet fully disarmed\.|You work with the trap for a while but are unable to make any progress\.
  put disarm %boxitem %disarmtype
  matchwait

PICKP:
  pause
PICK:
  if %badisarm = 1 then
  {
    var baddisarm 0
    goto DISARM
  }
  matchre PICKP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  match PICK fails to teach you anything about the lock guarding it.
  match PICK2Q An aged grandmother could open this in her sleep.
  match PICK2Q This lock is a laughable matter, you could do it blindfolded!
  match PICK2Q The lock is a trivially constructed piece of junk barely worth your time.
  match PICK2Q will be a simple matter for you to unlock.
  match PICK2C should not take long with your skills.
  match PICK2C with only minor troubles.
  match PICK2C You think this lock is precisely at your skill level.
  match PICK2C The lock has the edge on you, but you've got a good shot at picking open the
  match PICK2C The odds are against you, but with persistence you believe you could pick open the
  match PICK2C You have some chance of being able to pick open the
  match PICK2C would be a longshot.
  match PICK2C Prayer would be a good start for any attempt of yours at picking open the
  match PICK2C You have an amazingly minimal chance at picking open the
  match PICK2C You really don't have any chance at picking open this
  match PICK2C You probably have the same shot as a snowball does crossing the desert.
  match PICK2C You could just jump off a cliff and save yourself the frustration of attempting this
  match PICK2C A pitiful snowball encased in the Flames of Ushnish would fare better than you.
  match RETURN It's not even locked, why bother?
  put pick %boxitem identify
  matchwait
    
PICK2Q:
  var picktype quick
  goto PICK2
  
PICK2C:
  var picktype careful
  goto PICK2
  
PICK2P:
  pause
PICK2:
  if %badisarm = 1 then
  {
    var baddisarm 0
    goto DISARM
  }
  matchre PICK2P \.\.\.wait|type ahead|stunned|while entangled in a web\.
  match PICK You discover another lock protecting the
  match PICK2 You are unable to make any progress towards opening the lock.
  match RETURN Roundtime:
  #match RETURN With a soft click, you remove your lockpick and open and remove the lock.
  put pick %boxitem %picktype
  matchwait
  
BOXCOINGETP:
  pause
BOXCOINGET:
  matchre BOXCOINGETP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  match BOXCOINGET You pick up
  match RETURN What were you referring to?
  put get coin from %boxitem
  matchwait
 
FILLPOUCHP:
  pause
FILLPOUCH:
  matchre FILLPOUCHP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre tied_Pouch The gem pouch is too valuable|You'll need to tie it up
	matchre RETURN ^You take|^There aren't any|You fill your|You open your|You have to be holding
	matchre full_Pouch anything else|pouch is too full
	put fill my %pouch with my %boxitem
	matchwait
  
BOXLOOTCHECKP:
  pause
BOXLOOTCHECK:
	matchre BOXLOOTCHECKP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	#look in matchre stow_Gear (gear|\bbolt\b|\bnut\b|glarmencoupler|spangleflange|rackensprocket|flarmencrank)
	matchre GETMISC (map|treasure map|Treasure map)
  matchre GETMISC (nugget|ingot|\bbar\b|jadeite|kyanite|bark|parchment|\bdira\b|papyrus|tablet|vellum|\bscroll\b|\broll\b|ostracon|leaf|\brune\b)
  matchre RETURN In the|nothing|What
	put look in my %boxitem
	matchwait

GETMISC:
  var getitemname $1
  gosub GETITEM %getitemname
  var stowitemname %getitemname
  gosub STOWITEM
  put #echo >Log Yellow Found a %getitemname!
  goto BOXLOOTCHECK

DISMANTLEP:
  pause
DISMANTLE:
  matchre DISMANTLEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN Roundtime
  match DISMANTLE You can not dismantle the
  match DISMANTLE2 Try as you may
  put dismantle %boxitem slip
  matchwait

DISMANTLE2:
  matchre DISMANTLEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN Roundtime
  match DISMANTLE2 You can not dismantle the
  put dismantle %boxitem
  matchwait