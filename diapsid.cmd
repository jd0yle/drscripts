include fortunelines.cmd
include libmaster.cmd
action put #var donator $1; goto botAccept when ^(\S+) offers you.*ACCEPT
action put #var donator $1; goto botAcceptCoin when ^(\S+) offers you a tip of
action put #var donator $1; goto botThank when ^(\S+) gives you
action put #var givePerson $1; goto botGive when ^(Inauri|Selesthiel) whispers, "give"
action goto givePrize when ^Inauri whispers, "(.*)prize(.*)"
action put #var fortuneTarget $1; goto giveFortune when ^(\S+) whispers, "fortune"

##############
# Variables
##############
if (!($winner >0)) then put #var winner 0
if (!($prizeMoney >0)) then put #var prizeMoney 0
if (!($prize >0)) then put #var prize 0
if (!($prizeGiven >0)) then put #var prizeGiven 0
if (!($winner2 >0)) then put #var winner2 0
if (!($prizeGiven2 >0)) then put #var prizeGiven2 0
if (!($lastCoinGametime >0)) then put #var lastCoinGametime 0

  put #var winner Inauri
  put #var winner2 0
  put #var prizeMoney 0
  put #var prize backpack
  put #var prizeGiven 0
  put #var prizeGiven2 0

##############
# Basic Methods
##############
botWait:  
    gosub look
    pause 200
    goto botWait
   
botAccept:
    put accept
botAcceptCoin:
    put accept tip
    goto botThank
botThank:
    put ooc $donator [DR Discord Giveaways] Thank you for your donation!
    put #echo >log Accepted donation from $donator.
    pause
    goto botStow

botGive:
    put remove my rucksack
    put give my rucksack to %givePerson
    goto waiting

botStow:
    gosub stow right
    gosub stow left
    goto botWait
  
##############
# Fortunes
##############
giveFortune:    
    eval fortune.number count("$fortune.list", "|")
    Random 1 %fortune.number
    pause 2
    put ooc $fortuneTarget [DR Discord Giveaways][Fortune] $fortune.list(%r)
    put #var fortuneTarget null
    goto botWait

##############
# Prize Distribution
##############
giveCongrats:
    put ooc $winner [DR Discord Giveaways] Here are your $prize platinums!  Enjoy!
    put #var prizeGiven 1
    put #echo >log Delivered $prize plat to $winner.
    goto botWait
  
givePrize:
    if ($prizeGiven = 1) then {
        put ooc $winner [DR Discord Giveaways] It seems you've already picked up your prize, but you can ask me for a fortune and I'll give you that for free!
        goto botWait
    }
    put ooc $winner [DR Discord Giveaways] Hi there!  Congrats on your win!  Please give me a moment to get your prize to you.
    if ($prizeMoney = 1) then {
        pause 2
        matchre errorFound ^\[You have exceeded your coin handoff limit of once every 30 minutes\.
        matchre giveCongrats ^You give
        matchre requestCoinFix ^$winner is not interested in taking coins from you.
    	put give $winner $prize platinum Kronar
    	put #echo >log Awarded $prize platinum to $winner.
    	matchwait 5
    	goto botWait
    }

getPrize:
    matchre testPrize ^What were you
    matchre offerPrize $prize|You are already
    matchre errorFound You cannot|You can't|hands full
    put get my $prize
    matchwait 5
  
offerPrize:
    pause 2
    put ooc $winner [DR Discord Giveaways]  Here is your $prize prize!  Enjoy!
    put give my $prize to $winner
    put #var lastCoinGametime $gametime
    put #var prizeGiven 1
    put #echo >log Awarded $prize to $winner.
    goto botWait
  
requestCoinFix:
    put ooc $winner [DR Discord Giveaways] Please use AVOID COIN so that I can award your coins to you.  You can whisper prize to me again once this is fixed.
    goto botWait

errorFound:
    evalMath nextCoin (lastCoinGametime + 3600)
    put #echo >log Coin Hand Off Timer not ready.
    put ooc $winner [DR Discord Giveaways] I'm incredibly sorry for this, but I am still under a F2P Coin Handoff Timer.  Please check back anywhere from 15 to 30 minutes.
    goto botWait