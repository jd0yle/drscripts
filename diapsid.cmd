include fortunelines.cmd
include libmaster.cmd
action put #tvar diapsid.donator $1; put #tvar diapsid.donation $2 ; goto botAccept when ^(\S+) offers you(.*)\.(.*)Enter ACCEPT to accept
action put #tvar diapsid.donator $1; put #tvar diapsid.coinDonation $2 ; goto botAcceptCoin when ^(\S+) offers you a tip of (\d+)
action put #tvar diapsid.donator $1; put #tvar diapsid.coinDonation $2 ; goto botThank when ^(\S+) gives you (\d+)
action put #tvar diapsid.fortuneTarget $1; goto giveFortune when ^(\S+) whispers, "(.*)fortune(.*)"$/i
action goto givePrize when ^$diapsid.winner whispers, "(.*)prize(.*)"$/i

###############################
###      VARIABLES
###############################
if (!($lastCoinGametime >0)) then put #var lastCoinGametime 0
var avoidCoin null
put #tvar diapsid.prizeGiven 0
put #window hide Talk

###############################
###      METHODS
###############################
botWait:
    gosub botAvoids
    pause 2
    if ($standing = 0) then gosub stand
    gosub look
    pause 200
    goto botWait


botAccept:
    if ($diapsid.acceptItemDonation = 1) then {
        put accept
        goto botThank
    } else {
        put decline
        put ooc $diapsid.donator [DR Discord Giveaways] Thank you, but I am not accepting donations at this time.  Please speak to Spicy on discord if you need this feature turned on.
        goto botWait
    }


botAcceptCoin:
    if ($diapsid.acceptCoinDonation = 1) then {
        put accept tip
        goto botThank
   } else {
        put decline tip
        put ooc $diapsid.donator [DR Discord Giveaways] Thank you, but I am not accepting donations at this time.  Please speak to Spicy on discord if you need this feature turned on.
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
    put ooc $diapsid.donator [DR Discord Giveaways] Thank you for your donation!
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
    put ooc $diapsid.fortuneTarget [DR Discord Giveaways][Fortune] $fortune.list(%r)
    var $diapsid.fortuneTarget 0
    goto botWait


###############################
###      PRIZE DISTRIBUTION
###############################
giveCongrats:
    put ooc $diapsid.winner [DR Discord Giveaways] Here are your $diapsid.prize platinums!  Enjoy!
    put #tvar $diapsid.prizeGiven 1
    put #echo >log Delivered $diapsid.prize platinum to $diapsid.winner.
    goto botWait


givePrize:
    if ($diapsid.prizeGiven = 1) then {
        put ooc $diapsid.winner [DR Discord Giveaways] It seems you've already picked up your prize, but you can ask me for a fortune and I'll give you that for free!
        goto botWait
    }
    put ooc $diapsid.winner [DR Discord Giveaways] Hi there!  Congrats on your win!  Please give me a moment to get your prize to you.
    put #window show Talk

    if ($diapsid.prizeMoney = 1) then {
        pause 2
        matchre errorFound ^\[You have exceeded your coin handoff limit of once every 30 minutes\.
        matchre giveCongrats ^You give
        matchre requestCoinFix ^$diapsid.winner is not interested in taking coins from you.
    	put give $diapsid.winner $diapsid.prize platinum Kronar
    	matchwait 5
    	put #echo >log Awarded $diapsid.prize platinum to $diapsid.winner.
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
    put ooc $diapsid.winner [DR Discord Giveaways]  Here is your $diapsid.prize prize!  Enjoy!
    put give my $diapsid.prize to $diapsid.winner
    put #var lastCoinGametime $gametime
    put #tvar $diapsid.prizeGiven 1
    put #echo >log Awarded $diapsid.prize to $diapsid.winner.
    goto botWait


requestCoinFix:
    put ooc $diapsid.winner [DR Discord Giveaways] Please use AVOID COIN so that I can award your coins to you.  You can whisper prize to me again once this is fixed.
    goto botWait


errorFound:
    evalMath nextCoin (lastCoinGametime + 3600)
    put #echo >log Coin Hand Off Timer not ready.
    put ooc $diapsid.winner [DR Discord Giveaways] I'm incredibly sorry for this, but I am still under a F2P Coin Handoff Timer.  Please check back anywhere from 15 to 30 minutes.
    goto botWait


testPrize:
    put ooc $diapsid.winner [DR Discord Giveaways]  Here is your $diapsid.prize prize!  Enjoy!
    put #echo >log Awarded $diapsid.prize to $diapsid.winner.
    goto botWait