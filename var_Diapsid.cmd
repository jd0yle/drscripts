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
###     ITEM PICK UP
###############################
# Keyword for item pickup
    put #tvar diapsid.keyword 0
    #put #tvar diapsid.keywords 0|0
# Name of person to pickup
    put #tvar diapsid.name 0
    #put #tvar diapsid.names 0|0
# Item being picked up
    put #tvar diapsid.item 0
    #put #tvar diapsid.items 0|0


###############################
###     PRIZE DISTRIBUTION
###############################
# Use to identify the amount of platinum coins or the adjective and noun of the prize.
    put #tvar diapsid.prize 0
    #put #tvar diapsid.prizes 0|0
# Is the prize coins?  0 for no.  1 for yes.
    put #tvar diapsid.prizeMoney 0
    #put #tvar diapsid.prizesMoney 0|0
# Name of the winner that can be given a prize.
    put #tvar diapsid.winner 0
    #put #tvar diapsid.winner 0|0


pause .2
put #parse CHARVARS DONE
exit