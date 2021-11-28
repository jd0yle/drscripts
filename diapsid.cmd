include fortunelines.cmd
include libmaster.cmd
###############################
###     IDLE ACTION TRIGGERS
###############################
action put #tvar diapsid.donator $1; put #tvar diapsid.donation $2 ; goto botAccept when ^(\S+) offers you(.*)\.(.*)Enter ACCEPT to accept
action put #tvar diapsid.donator $1; put #tvar diapsid.coinDonation $2 ; goto botAcceptCoin when ^(\S+) offers you a tip of (\d+)
action put #tvar diapsid.donator $1; put #tvar diapsid.coinDonation $2 ; goto botThank when ^(\S+) gives you (\d+)
action put #tvar diapsid.fortuneTarget $1; goto giveFortune when ^(\S+) whispers, "(.*)fortune(.*)"$/i
action goto givePrize when ^$diapsid.winner whispers, "(.*)prize(.*)"$/i
action goto givePickup when ^$diapsid.name whispers, "(.*)($diapsid.keyword)(.*)"$/i
action goto failPickup when ^$diapsid.name has declined the offer\.|Your offer to $diapsid.name has expired\.
action put #tvar diapsid.pickupDone 1; goto successPickup when ^$diapsid.name has accepted your offer.*


###############################
###      VARIABLES
###############################
if (!($lastCoinGametime >0)) then put #var lastCoinGametime 0
var avoidCoin null
put #tvar diapsid.prizeGiven 0
put #tvar diapsid.pickupDone 0


###############################
###      METHODS
###############################
botWait:
    gosub botAvoids
    pause 2
    if ($standing = 0) then gosub stand
    gosub tdp
    pause 200
    goto botWait


botAccept:
    if ($diapsid.acceptItemDonation = 1) then {
        gosub accept
        goto botThank
    } else {
        gosub decline
        gosub ooc $diapsid.donator [DR Discord Giveaways] Thank you, but I am not accepting donations at this time.  Please speak to Spicy on discord if you need this feature turned on.
        goto botWait
    }


botAcceptCoin:
    if ($diapsid.acceptCoinDonation = 1) then {
        put accept tip
        goto botThank
   } else {
        gosub decline tip
        gosub ooc $diapsid.donator [DR Discord Giveaways] Thank you, but I am not accepting donations at this time.  Please speak to Spicy on discord if you need this feature turned on.
        goto botWait
    }


botAvoids:
    if ($diapsid.acceptCoinDonation = 1 && %avoidCoin <> 1) then {
        gosub avoid coins
        var avoidCoin 1
    }
    if ($diapsid.acceptCoinDonation = 0 && %avoidCoin <> 0) then {
        gosub avoid !coins
        var avoidCoin 0
    }
    return


botThank:
    gosub ooc $diapsid.donator [DR Discord Giveaways] Thank you for your donation!
    if ($diapsid.coinDonation <> 0) then {
        put #echo >log Accepted $diapsid.coinDonation coin donation from $diapsid.donator.
    } else {
        put #echo >log Accepted $diapsid.donation donation from $diapsid.donator.
    }
    put #var diapsid.donation 0
    put #var diapsid.donator 0
    pause
    goto botStow


botStow:
    gosub stow right
    gosub stow left
    goto botWait


###############################
###      FORTUNES
###############################
giveFortune:    
    eval fortune.number count("$fortune.list", "|")
    Random 1 %fortune.number
    pause 2
    gosub ooc $diapsid.fortuneTarget [DR Discord Bot][Fortune] $fortune.list(%r)
    var $diapsid.fortuneTarget 0
    goto botWait


###############################
###      ITEM PICK UP
###############################
givePickup:
    if ($diapsid.pickupDone = 1) then {
        pause 2
        put #echo >Log [diapsid] $diapsid.name has attempted to pick up $diapsid.item, but already picked it up.
        gosub ooc $diapsid.name [DR Discord Bot] Oh hi, $diapsid.name.  It appears you have already picked up your $diapsid.item.  If you believe you are seeing this in error, please contact Spicy on Discord.
        goto botWait
    } else {
        pause 2
        put #echo >Log [diapsid] $diapsid.name has used the keyword ($diapsid.keyword) to pick up $diapsid.item.
        gosub ooc $diapsid.name [DR Discord Bot] Oh hi, $diapsid.name!  My instructions are to give you the following item:  $diapsid.item.
        pause 2
        gosub get my $diapsid.item
        gosub give my $diapsid.item to $diapsid.name
        pause 30
    }


failPickup:
    put #echo >Log [diapsid] $diapsid.name failed to accept the offer of $diapsid.pickupItem.
    if (matchre("$righthand|$lefthand", "$diapsid.pickupItem")) then {
        gosub ooc $diapsid.name [DR Discord Bot] It seems you are busy or unable to accept the $diapsid.item right now.  Please feel free to try again.
        gosub stow $diapsid.item
    }
    goto botWait


successPickup:
    if (matchre("$righthand|$lefthand", "$diapsid.pickupItem")) then {
        put #echo >Log [diapsid] $diapsid.name has successfully picked up $diapsid.item, but I am still holding it.
        gosub stow $diapsid.item
    } else {
        put #echo >Log [diapsid] $diapsid.name has successfully picked up $diapsid.item.

    }
    goto botWait


###############################
###      PRIZE DISTRIBUTION
###############################
giveCongrats:
    gosub ooc $diapsid.winner [DR Discord Giveaways] Here are your $diapsid.prize platinums!  Enjoy!
    put #tvar $diapsid.prizeGiven 1
    put #echo >log Delivered $diapsid.prize platinum to $diapsid.winner.
    goto botWait


givePrize:
    if ($diapsid.prizeGiven = 1) then {
        gosub ooc $diapsid.winner [DR Discord Giveaways] It seems you've already picked up your prize, but you can ask me for a fortune and I'll give you that for free!
        goto botWait
    }
    gosub ooc $diapsid.winner [DR Discord Giveaways] Hi there!  Congrats on your win!  Please give me a moment to get your prize to you.

    if ($diapsid.prizeMoney = 1) then {
        pause 2
        matchre errorFoundFunds ^You don't have that many platinum Kronars to give\.$
        matchre errorFound ^\[You have exceeded your coin handoff limit of once every 30 minutes\.
        matchre giveCongrats ^You give
        matchre requestCoinFix ^$diapsid.winner is not interested in taking coins from you.
    	put give $diapsid.winner $diapsid.prize platinum Kronar
    	matchwait 5
    	put #echo >log Awarded $diapsid.prize platinum to $diapsid.winner.
    	put #var lastCoinGametime $gametime
    	goto botWait
    } else {
        goto getPrize
    }


getPrize:
    matchre testPrize ^What were you
    matchre offerPrize $diapsid.prize|You are already
    matchre errorFound You cannot|You can't|hands full
    put get my $diapsid.prize
    matchwait 5


offerPrize:
    pause 2
    gosub ooc $diapsid.winner [DR Discord Giveaways]  Here is your $diapsid.prize prize!  Enjoy!
    put give my $diapsid.prize to $diapsid.winner
    put #var lastCoinGametime $gametime
    put #tvar $diapsid.prizeGiven 1
    put #echo >log Awarded $diapsid.prize to $diapsid.winner.
    goto botWait


requestCoinFix:
    gosub ooc $diapsid.winner [DR Discord Giveaways] Please use AVOID COIN so that I can award your coins to you.  You can whisper prize to me again once this is fixed.
    goto botWait


errorFound:
    evalMath nextCoin ($lastCoinGametime + 3600)
    put #echo >log Coin Hand Off Timer not ready.
    evalMath pickupWait (%nextCoin / 60)
    gosub ooc $diapsid.winner [DR Discord Giveaways] I'm incredibly sorry for this, but I am still under a F2P Coin Handoff Timer.  Please check back in %pickupWait minute(s).
    goto botWait


errorFoundFunds:
    put #echo >Log We do not have $diapsid.prize platinums.
    gosub ooc $diapsid.winner [DR Discord Giveaways] I'm incredibly sorry for this, but I seem to have encountered a funding error.  I have logged the error for now.  Please check back later or notify SpicyDiapsid in Discord, thank you!
    goto botWait


testPrize:
    gosub ooc $diapsid.winner [DR Discord Giveaways]  Here is your $diapsid.prize prize!  Enjoy!
    put #echo >log Awarded $diapsid.prize to $diapsid.winner.
    goto botWait