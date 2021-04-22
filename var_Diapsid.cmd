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
# Use to identify the amount of platinums or the adjective and noun of the prize.
    put #tvar diapsid.prize indigo pouch
# Has the prize been given away?
    put #tvar diapsid.prizeGiven 0
# Is the prize coins?  0 for no.  1 for yes.
    put #tvar diapsid.prizeMoney 0
# Name of the winner that can be given a prize.
    put #tvar diapsid.winner Devast


pause .2
put #parse CHARVARS DONE
exit