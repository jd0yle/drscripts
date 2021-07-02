include fortunelines.cmd
include libmaster.cmd
action put #tvar diapsid.donator $1; put #tvar diapsid.donation $2 ; goto botAccept when ^(\S+) offers you(.*)\.(.*)Enter ACCEPT to accept
action put #tvar diapsid.donator $1; put #tvar diapsid.coinDonation $2 ; goto botAcceptCoin when ^(\S+) offers you a tip of (\d+)
action put #tvar diapsid.donator $1; put #tvar diapsid.coinDonation $2 ; goto botThank when ^(\S+) gives you (\d+)
action put #tvar diapsid.fortuneTarget $1; goto giveFortune when ^(\S+) whispers, "(.*)fortune(.*)"$/i
action put #tvar diapsid.prizeTarget $1 ; goto botCheckWinner when ^($diapsid.winnerName) whispers, "(.*)prize(.*)"$/i

###############################
###      DONATIONS
###############################
# 0 - Disabled  1 - Enabled
put #tvar diapsid.acceptCoinDonation 0
put #tvar diapsid.acceptItemDonation 0
put #tvar diapsid.coinDonation 0
put #tvar diapsid.donation 0
put #tvar diapsid.donator 0


###############################
###      FORTUNES
###############################
put #tvar diapsid.fortuneTarget 0


###############################
###     PRIZE DISTRIBUTION
###############################
put #tvar diapsid.prizeTarget 0
put #tvar diapsid.winnerName Dantia|Zshhn
put #tvar diapsid.winnerType coin|item
put #tvar diapsid.winnerPrize 1500|nothing


pause .2
put #parse CHARVARS DONE
exit


###############################
###      VARIABLES
###############################
if (!($lastCoinGametime >0)) then put #var lastCoinGametime 0
var avoidCoin null
var index 0
var prizeIndex 0
put #tvar diapsid.prizeGiven 0|0
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
        gosub accept
        goto botThank
    } else {
        gosub decline
        put ooc $diapsid.donator [DR Discord Giveaways] Thank you, but I am not accepting donations at this time.  Please speak to Spicy on discord if you need this feature turned on.
        put #echo >Log [diapsid] $diapsid.donator attempted to donate an item, but I declined.
        goto botWait
    }


botAcceptCoin:
    if ($diapsid.acceptCoinDonation = 1) then {
        gosub accept tip
        goto botThank
   } else {
        put decline tip
        put ooc $diapsid.donator [DR Discord Giveaways] Thank you, but I am not accepting donations at this time.  Please speak to SpicyDiapsid#0011 on Discord if you need this feature turned on.
        put #echo >Log [diapsid] $diapsid.donator attempted to donate some money, but I declined.
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
        put #echo >log [diapsid] Accepted $diapsid.coinDonation coin donation from $diapsid.donator.
    } else {
        put #echo >log [diapsid] Accepted $diapsid.donation donation from $diapsid.donator.
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
botCheckWinner:
    eval length count("$diapsid.winnerName", "|")
    var index 0


    botCheckWinnerLoop:
        if (matchre("$diapsid.winnerName(%index)", "$diapsid.prizeTarget")) then {
            var prizeIndex %index
        } else {
            math index add 1
            if (%index > %length) then {
                put #echo >log [diapsid] Logic error while looking for winner.
                goto botWait
            }
            goto botCheckWinnerLoop
        }

        if (matchre("$diapsid.prizeGiven(%prizeIndex)", 1)) then {
            gosub botRejectDoublePrize
            goto botWait
        } else {
            goto botGivePrize
       }


botErrorCoin:
    put ooc $diapsid.prizeTarget [DR Discord Giveaways] I'm incredibly sorry for this, but I am still under a F2P Coin Handoff Timer.  Please check back anywhere from 15 to 30 minutes.
    put #echo >Log [diapsid] $diapsid.prizeTarget attempted to collect their prize, but I am unable to make a coin handoff.
    goto botWait


botErrorHands:
    if ("$righthand" <> "Empty" && "$lefthand" <> "Empty") then {
        gosub stow
        gosub stow left
        gosub wear $righthandnoun
        gosub wear $lefthandnoun
        if ("$righthand" <> "Empty" && "$lefthand" <> "Empty") then {
            put ooc $diapsid.prizeTarget [DR Discord Giveaways]  I am incredibly sorry, but the bot is experiencing an issue right now.  Please check back later.  If this issue persists, please let SpicyDiapsid#0011 on Discord know.
            put #echo >log [diapsid] $diapsid.prizeTarget attempted to collect their prize, but I am unable to clear my hands.
            gosub botClearWinner
            goto botWait
        }
    }
    goto botGivePrize


botGiveCongrats:
    put ooc $diapsid.prizeTarget [DR Discord Giveaways] Here are your $diapsid.winnerPrize(%prizeIndex) platinums!  Enjoy!
    put #var lastCoinGametime $gametime
    gosub botMarkPrizeGiven
    put #echo >log [diapsid] Delivered $diapsid.winnerPrize(%prizeIndex) platinums to $diapsid.prizeTarget.
    goto botWait


botGivePrize:
    put ooc $diapsid.prizeTarget [DR Discord Giveaways] Hi there!  Congrats on your win!  Please give me a moment to get your prize to you.
    if ("$diapsid.winnerType(%prizeIndex)" = "coin") then {
        evalmath nextCoinAt $lastCoinGametime + 1800
        if (%nextCoinAt > $gametime) then {
            goto botErrorCoin
        }
        pause 2
        matchre botErrorCoin ^\[You have exceeded your coin handoff limit of once every 30 minutes\.
        matchre botGiveCongrats ^You give
        matchre botRequestCoinFix ^$diapsid.prizeTarget is not interested in taking coins from you.
        put give $diapsid.prizeTarget $diapsid.winnerPrize(%prizeIndex) platinum Kronar
        matchwait 5
    } else {
        matchre botTestPrize ^What were you
        matchre botOfferPrize $diapsid.winnerPrize(%prizeIndex)|You are already
        matchre botErrorHands You cannot|You can't|hands full
        put get my $diapsid.winnerPrize(%prizeIndex)
        matchwait 5
    }


# Rebuild the prizeGiven array because Genie is ass.
botMarkPrizeGiven:
    var tempArray 0
    var index 0

    botMarkPrizeGivenLoop:
        echo index %index
        echo prizeIndex %prizeIndex
        if (%index = 0) then {
            if (%index = %prizeIndex) then {
                echo index %index
                echo prizeIndex %prizeIndex
                var tempArray 1
                echo tempArray %tempArray
            } else {
                var tempArray 0
                echo tempArray %tempArray
            }
        } else {
            if (%index = %prizeIndex) then {
                echo index %index
                echo prizeIndex %prizeIndex
                var tempArray %tempArray|1
                echo tempArray %tempArray
            } else {
                var tempArray %tempArray|$diapsid.prizeGiven(%index)
                echo tempArray %tempArray
            }
        }
        math index add 1
        echo index %index
        echo prizeIndex %prizeIndex
        if (%index > %length) then {
            return
        }
        goto botMarkPrizeGivenLoop


botOfferPrize:
    pause 2
    put ooc $diapsid.prizeTarget [DR Discord Giveaways]  Here is your $diapsid.winnerPrize(%prizeIndex) prize!  Enjoy!
    put give my $diapsid.winnerPrize(%prizeIndex) to $diapsid.prizeTarget
    gosub botMarkPrizeGiven
    put #echo >log [diapsid] Awarded $diapsid.winnerPrize(%prizeIndex) to $diapsid.prizeTarget.
    goto botWait


botRejectDoublePrize:
    put ooc $diapsid.prizeTarget [DR Discord Giveaways] It seems you've already picked up your prize, but you can ask me for a fortune and I'll give you that for free!
    put #echo >Log [diapsid] $diapsid.prizeTarget attempted to collect their prize again, but I stopped them.
    goto botWait


botRequestCoinFix:
    put ooc $diapsid.prizeTarget [DR Discord Giveaways] Please use AVOID COIN so that I can award your coins to you.  You can whisper prize to me again once this is fixed.
    put #echo >Log [diapsid] $diapsid.prizeTarget attempted to collect their prize again, but they were avoiding coins.
    goto botWait


botTestPrize:
    put ooc $diapsid.prizeTarget [DR Discord Giveaways]  Here is your $diapsid.winnerPrize(%prizeIndex) prize!  Enjoy!
    put #echo >log [diapsid-test] Awarded $diapsid.winnerPrize(%prizeIndex) to $diapsid.prizeTarget.
    goto botWait
