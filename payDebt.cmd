include libmaster.cmd

var debt.provinceNumber.Zoluren 1
var debt.provinceNumber.Therengia 2
var debt.provinceNumber.Ilithi 3
var debt.provinceNumber.Qi 4
var debt.provinceNumber.Forfedhdar 5


gosub runScript dep
gosub automove teller

debt.checkDebt:
	matchre debt.payDebt (Ilithi|Zoluren|Qi|Therengia|Forfedhdar)\. \((\d+).* copper (Dokoras|Kronars|Lirums)\)
	match debt.done Wealth:
	put wealth
	matchwait 5
	goto debt.checkDebt


debt.payDebt:
    var province $1
    var amount $2
    var currency $3
    echo DOING bank debt %province %amount %currency
    if ("%currency" != "$currency") then {
        evalmath withdrawAmount (%amount + 10000)
        gosub withdraw %withdrawAmount copper
        gosub automove exchange
        gosub exchange all $currency for %currency
    } else {
        gosub withdraw %amount copper
    }

    echo bank debt %debt.provinceNumber.%province all
    gosub bank debt %debt.provinceNumber.%province all
    goto debt.checkDebt


debt.done:
    pause .2
    put #parse PAYDEBT DONE
    exit


