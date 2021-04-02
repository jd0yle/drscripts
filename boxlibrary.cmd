var buffs aa|aeg|ags|art|aus|auspice|benediction|blur|botf|bg|bs|bue|centering|ch|cv|col|courage|da|dc|db|dr|drum|echo|ease|ecry|emc|es|fin|gg|gol|harm|hes|ic|iots|ivm|ks|lgv|lw|maf|mapp|mef|meg|mis|mpp|name|nou|obfuscation|pfe|pg|php|pom|pop|psy|rage|refresh|rei|repr|rw|seer|shadowling|shadows|sol|sos|sr|substratum|suf|sw|tranquility|trc|turi|tw|vigor|voi|will|worm|ys
var ombuffs auspice|benediction|bless|centering|dr|gg|halo|mapp|mpp|mf|pfe|pom|sl|sol
var abuffs etf|nexus|rm
var cyctms |aban|ars|fr|gs|iz|pyre|rim|ros|sa|sls|usol|
var cycdbs |aewo|alb|dalu|dema|ee|hyh|
var cyclics |ac|ad|af|bes|botf|care|cs|eye|fae|ghs|gj|hodi|how|mom|regenerate|rev|roc|rog|sanctuary|sov|tr|
var allcyclics %cyclics-%cyctms-%cycdbs
var rituals |abs|aeg|all|ag|bc|cos|dc|echo|eli|mf|mof|mon|iots|mf|pom|pop|rtr|soul|vos|will|word|
var heavytm ms
var transnecro ivm|ks|bue|worm|ch|php

goto LIBEND

RETURN:
  delay 0.001
  pause 0.001
  var timeoutcount 0
  return

TIMEOUT:
  if %timeoutcount < 1 then math timeoutcount add 1
  else
  {
    var timeouttext %timeoutsub has timed out!  Trying again.  If you see this repeatedly, there is a problem with the script that needs to be addressed.
    if !def(alertwindow) then put #echo Yellow %timeouttext
    else put #echo >$alertwindow Yellow %timeouttext
    put #flash
    put #play JustArrived
    put !!!marker
	}
	goto %timeoutsub

DEADWAIT:
  pause 4
  put #flash
  put #play JustArrived
  goto DEADWAIT

TITLE:
  put #echo
	put #echo mono ------------------------------------------------
	put #echo mono ------------------ TRAINING! -------------------
	put #echo mono ------------------------------------------------
	put #echo
  return

SETDEFAULTS:
  #GENERAL
  if !def(guild) then
  {
    action (info) put #var guild $1 when Guild:\s+(Barbarian|Bard|Cleric|Commoner|Empath|Moon Mage|Necromancer|Paladin|Ranger|Thief|Trader|Warrior Mage)$
    put info
    pause 2
  }
  if !matchre("$guild", "\b(Barbarian|Bard|Cleric|Commoner|Empath|Moon Mage|Necromancer|Paladin|Ranger|Thief|Trader|Warrior Mage)\b") then
  {
    action (info) put #var guild $1 when Guild:\s+(Barbarian|Bard|Cleric|Commoner|Empath|Moon Mage|Necromancer|Paladin|Ranger|Thief|Trader|Warrior Mage)$
    put info
    pause 2
  }
  if !matchre("$explogging", "\b(YES|NO)\b") then put #var explogging NO
  if $exploggingtimer >= 300 then
  else put #var exploggingtimer 300
  if !matchre("$spelltracking", "\b(YES|NO)\b") then put #var spelltracking NO
  if !matchre("$almanac", "\b(YES|NO)\b") then put #var almanac NO
  if !def(almanacitem) then put #var almanacitem almanac
  if !matchre("$almanacalerts", "\b(YES|NO)\b") then put #var almanacalerts NO
  if !matchre("$ejournal", "\b(YES|NO)\b") then put #var ejournal NO
  if !def(ejournalitem) then put #var ejournalitem journal
  if $ejournalstates > 0 then
  else put #var ejournalstates 600
  if !matchre("$tarantula", "\b(YES|NO)\b") then put #var tarantula NO  
  if !def(tarantulaitem) then put #var tarantulaitem tarantula
  if !def(tarantulaskill1) then put #var tarantulaskill1 evasion
  if !def(tarantulaskill2) then put #var tarantulaskill2 shield
  
  #ALERTS
  if !matchre("$alertwindow", "\b(Main|Log|Conversation)\b") then put #var alertwindow Main
  if !matchre("$healthalerts", "\b(YES|NO)\b") then put #var healthalerts YES
  if !matchre("$healthalarm", "\b(1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53|54|55|56|57|58|59|60|61|62|63|64|65|66|67|68|69|70|71|72|73|74|75|76|77|78|79|80|81|82|83|84|85|86|87|88|89|90|91|92|93|94|95|96|97|98|99)\b") then put #var healthalarm 85
  if !matchre("$nervealerts", "\b(YES|NO)\b") then put #var nervealerts YES
  if !matchre("$sorceryalerts", "\b(YES|NO)\b") then put #var sorceryalerts YES
  if !matchre("$speechalerts", "\b(YES|NO)\b") then put #var speechalerts YES
  if !matchre("$arrivalalerts", "\b(YES|NO)\b") then put #var arrivalalerts NO
  if !matchre("$emotealerts", "\b(YES|NO)\b") then put #var emotealerts YES
  if !matchre("$gmalerts", "\b(YES|NO)\b") then put #var gmalerts YES
  if !matchre("$pvpstealthalerts", "\b(YES|NO)\b") then put #var pvpstealthalerts NO
  if !matchre("$inventoryalerts", "\b(YES|NO)\b") then put #var inventoryalerts YES
  if !matchre("$scriptalerts", "\b(YES|NO)\b") then put #var scriptalerts NO
  
  #UPKEEP
  #if !matchre("$aumoveclenchshard", "\b(YES|NO)\b") then put #var aumoveclenchshard NO
  if !matchre("$movewhistle", "\b(YES|NO)\b") then put #var movewhistle NO
  if !matchre("$movescream", "\b(YES|NO)\b") then put #var movescream NO
  if !matchre("$movevanish", "\b(YES|NO)\b") then put #var movevanish NO
  if !matchre("$bugout", "\b(YES|NO)\b") then put #var bugout NO
  if $bugoutnum > 0 then
  else put #var bugoutnum 1
  if !matchre("$bugoutonbleed", "\b(YES|NO)\b") then put #var bugoutonbleed NO
  if $bugoutroom > 0 then
  else put #var bugoutroom 1
  if !matchre("$autoupkeep", "\b(YES|NO)\b") then put #var autoupkeep NO
  if !matchre("$auonhealth", "\b(YES|NO)\b") then put #var auonhealth NO
  if $auhealthnum >= 0 then
  else put #var auhealthnum 80
  if !matchre("$auonbleed", "\b(YES|NO)\b") then put #var auonbleed NO
  if !matchre("$auonnerves", "\b(YES|NO)\b") then put #var auonnerves NO
  if !matchre("$auonburden", "\b(YES|NO)\b") then put #var auonburden NO
  if $auburdennum >= 0 then
  else put #var auburdennum 3
  if !matchre("$premiumring", "\b(YES|NO)\b") then put #var premiumring NO
  if !def(premiumringitem) then put #var premiumringitem band
  if !matchre("$autravel", "\b(YES|NO)\b") then put #var autravel NO
  if !def(autraveldest) then put #var autraveldest crossing
  if !matchre("$aumove", "\b(YES|NO)\b") then put #var aumove NO
  if !def(aumovelist) then put #var aumovelist 1|42
  if !matchre("$aureturntravel", "\b(YES|NO)\b") then put #var aureturntravel NO
  if !def(aureturntraveldest) then put #var aureturntraveldest theren
  if !matchre("$aureturnmove", "\b(YES|NO)\b") then put #var aureturnmove NO
  if !def(aureturnmovelist) then put #var aureturnmovelist 1|start
  if $minmoney >= 0 then
  else put #var minmoney 0
  if !matchre("$exchange", "\b(YES|NO)\b") then put #var exchange NO
  if !matchre("$premiumheal", "\b(YES|NO)\b") then put #var premiumheal NO
  if !matchre("$nonpremheal", "\b(YES|NO)\b") then put #var nonpremheal NO
  if !matchre("$repair", "\b(YES|NO)\b") then put #var repair NO
  if !def(repairlist) then put #var repairlist scimitar|nightstick
  if !matchre("$bundlesell", "\b(YES|NO)\b") then put #var bundlesell NO
  if !matchre("$bundlevault", "\b(YES|NO)\b") then put #var bundlevault NO
  if (($bundlevault = "YES") && ($bundlesell = "YES")) then put #var bundlesell NO 
  if !matchre("$vaultmove", "\b(YES|NO)\b") then put #var vaultmove NO
  if $bundlerope >= 0 then
  else put #var bundlerope 0
  if !matchre("$gemvault", "\b(YES|NO)\b") then put #var gemvault NO
  if $gempouches >= 0 then
  else put #var gempouches 0
  if !matchre("$appfocus", "\b(YES|NO)\b") then put #var appfocus NO
  if !def(appfocusitem) then put #var appfocusitem shark
  if !matchre("$spiderfeed", "\b(YES|NO)\b") then put #var spiderfeed NO
  if $incense >= 0 then
  else put #var incense 0
  if !def(burglestorage) then put #var burglestorage haversack
  if !matchre("$burgletool", "\b(pick|rope|both)\b") then put #var burgletool rope
  if !def(burglepickitem) then put #var burglepickitem lockpick
  if !matchre("$burglepickworn", "\b(YES|NO)\b") then put #var burglepickworn NO
  if !def(burgleropeitem) then put #var burgleropeitem heavy rope
  if !matchre("$burglemaxgrabs", "\b(0|1|2|3|4|5|6)\b") then put #var burglemaxgrabs 6
  if !matchre("$burgleloot", "\b(YES|NO)\b") then put #var burgleloot NO
  if !def(burglekeeplist) then put #var burglekeeplist none
  if !matchre("$burglepawn", "\b(YES|NO)\b") then put #var burglepawn NO
  if !matchre("$burglethiefbin", "\b(YES|NO)\b") then put #var burglethiefbin NO
  if !matchre("$burglekhrihasten", "\b(YES|NO)\b") then put #var burglekhrihasten NO
  if !matchre("$burglekhriplunder", "\b(YES|NO)\b") then put #var burglekhriplunder NO
  if !matchre("$burglekhrisilence", "\b(YES|NO)\b") then put #var burglekhrisilence NO
  if !matchre("$burglekhrislight", "\b(YES|NO)\b") then put #var burglekhrislight NO
  if !matchre("$burglerf", "\b(YES|NO)\b") then put #var burglerf NO
  if $burglerfdelay >= 0 then
  else put #var burglerfdelay 10 
  if !matchre("$burgleeotb", "\b(YES|NO)\b") then put #var burgleeotb NO
  if $burgleeotbdelay >= 0 then
  else put #var burgleeotbdelay 10

  #LOOT
  if !matchre("$lootalerts", "\b(YES|NO)\b") then put #var lootalerts YES
  if !matchre("$loottype", "\b(treasure|boxes|equipment|goods|all)\b") then put #var loottype treasure
  if !matchre("$lootalldead", "\b(YES|NO)\b") then put #var lootalldead NO
  if !matchre("$collectcoin", "\b(YES|NO)\b") then put #var collectcoin YES
  if !matchre("$collectgem", "\b(YES|NO)\b") then put #var collectgem YES
  if !matchre("$collectscroll", "\b(YES|NO)\b") then put #var collectscroll YES
  if !matchre("$collectmaps", "\b(YES|NO)\b") then put #var collectmaps YES
  if !def(misckeeplist) then put #var misckeeplist none
  if !matchre("$savegwethstones", "\b(YES|NO)\b") then put #var savegwethstones NO
  if !def(storage) then put #var storage backpack
  if !matchre("$skinning", "\b(YES|NO)\b") then put #var skinning YES
  if !matchre("$arrange", "\b(0|1|2|3|4|5)\b") then put #var arrange 0
  if !matchre("$arrangeforpart", "\b(YES|NO)\b") then put #var arrangeforpart NO
  if !matchre("$dropskins", "\b(YES|NO)\b") then put #var dropskins NO

  #COMBAT
  if !matchre("$combat", "\b(YES|NO)\b") then put #var combat YES
  #if !def(stanceset) then put #var stanceset custom
  if !def(stancemain) then
  {
    if !def(stanceset) then put #var stanceemain custom
    else put #var stancemain $stanceset
  }
  if !matchre("$eventrain", "\b(YES|NO)\b") then put #var eventrain NO
  if (($maxswings >= 0) && ($maxswings < 60)) then
  else put #var maxswings 0
  if !matchre("$lowestfirst", "\b(YES|NO)\b") then put #var lowestfirst NO
  if (($weaponnum >= 1) && ($weaponnum <= 14)) then
  else put #var weaponnum 1
  if !matchre("$killafterlock", "\b(YES|NO)\b") then put #var killafterlock NO
  if !matchre("$weapon1", "\b(SE|LE|THE|SB|LB|THB|BOW|XBOW|SLING|LT|HT|STAVE|POLE|BRAWL)\b") then put #var weapon1 SE
  if !matchre("$weapon2", "\b(SE|LE|THE|SB|LB|THB|BOW|XBOW|SLING|LT|HT|STAVE|POLE|BRAWL)\b") then put #var weapon2 LE
  if !matchre("$weapon3", "\b(SE|LE|THE|SB|LB|THB|BOW|XBOW|SLING|LT|HT|STAVE|POLE|BRAWL)\b") then put #var weapon3 THE
  if !matchre("$weapon4", "\b(SE|LE|THE|SB|LB|THB|BOW|XBOW|SLING|LT|HT|STAVE|POLE|BRAWL)\b") then put #var weapon4 SB
  if !matchre("$weapon5", "\b(SE|LE|THE|SB|LB|THB|BOW|XBOW|SLING|LT|HT|STAVE|POLE|BRAWL)\b") then put #var weapon5 LB
  if !matchre("$weapon6", "\b(SE|LE|THE|SB|LB|THB|BOW|XBOW|SLING|LT|HT|STAVE|POLE|BRAWL)\b") then put #var weapon6 THB
  if !matchre("$weapon7", "\b(SE|LE|THE|SB|LB|THB|BOW|XBOW|SLING|LT|HT|STAVE|POLE|BRAWL)\b") then put #var weapon7 BOW
  if !matchre("$weapon8", "\b(SE|LE|THE|SB|LB|THB|BOW|XBOW|SLING|LT|HT|STAVE|POLE|BRAWL)\b") then put #var weapon8 XBOW
  if !matchre("$weapon9", "\b(SE|LE|THE|SB|LB|THB|BOW|XBOW|SLING|LT|HT|STAVE|POLE|BRAWL)\b") then put #var weapon9 SLING
  if !matchre("$weapon10", "\b(SE|LE|THE|SB|LB|THB|BOW|XBOW|SLING|LT|HT|STAVE|POLE|BRAWL)\b") then put #var weapon10 LT
  if !matchre("$weapon11", "\b(SE|LE|THE|SB|LB|THB|BOW|XBOW|SLING|LT|HT|STAVE|POLE|BRAWL)\b") then put #var weapon11 HT
  if !matchre("$weapon12", "\b(SE|LE|THE|SB|LB|THB|BOW|XBOW|SLING|LT|HT|STAVE|POLE|BRAWL)\b") then put #var weapon12 STAVE
  if !matchre("$weapon13", "\b(SE|LE|THE|SB|LB|THB|BOW|XBOW|SLING|LT|HT|STAVE|POLE|BRAWL)\b") then put #var weapon13 POLE
  if !matchre("$weapon14", "\b(SE|LE|THE|SB|LB|THB|BOW|XBOW|SLING|LT|HT|STAVE|POLE|BRAWL)\b") then put #var weapon14 BRAWL
  if !matchre("$offhand", "\b(YES|NO)\b") then put #var offhand NO
  if !def(seweapon) then put #var seweapon scimitar
  if !matchre("$seoffhand", "\b(YES|NO)\b") then put #var seoffhand NO
  if !matchre("$secombo", "\b(slice|puncture)\b") then put #var secombo slice
  if !def(leweapon) then put #var leweapon broadsword
  if !matchre("$leoffhand", "\b(YES|NO)\b") then put #var leoffhand NO
  if !def(theweapon) then put #var theweapon claymore
  if !def(sbweapon) then put #var sbweapon mace
  if !matchre("$sboffhand", "\b(YES|NO)\b") then put #var sboffhand NO
  if !def(lbweapon) then put #var lbweapon hammer
  if !matchre("$lboffhand", "\b(YES|NO)\b") then put #var lboffhand NO
  if !def(thbweapon) then put #var thbweapon maul
  if !def(staveweapon) then put #var staveweapon nightstick
  if !matchre("$staveoffhand", "\b(YES|NO)\b") then put #var staveoffhand NO
  if !matchre("$staveworn", "\b(YES|NO)\b") then put #var staveworn NO
  if !matchre("$stavetied", "\b(YES|NO)\b") then put #var stavetied NO
  if !def(poleweapon) then put #var poleweapon spear
  if !matchre("$poleworn", "\b(YES|NO)\b") then put #var poleworn NO
  if !matchre("$poletied", "\b(YES|NO)\b") then put #var poletied NO
  if !matchre("$polecombo", "\b(slice|puncture)\b") then put #var polecombo puncture
  if !def(ltweapon) then put #var ltweapon bola
  if !matchre("$ltoffhand", "\b(YES|NO)\b") then put #var ltoffhand NO
  if !matchre("$ltbond", "\b(YES|NO)\b") then put #var ltbond NO
  if !matchre("$ltverb", "\b(lob|throw|hurl)\b") then put #var ltverb lob
  if !def(htweapon) then put #var htweapon spear
  if !matchre("$htoffhand", "\b(YES|NO)\b") then put #var htoffhand NO
  if !matchre("$htbond", "\b(YES|NO)\b") then put #var htbond NO
  if !matchre("$htverb", "\b(lob|throw|hurl)\b") then put #var htverb lob
  if !def(xbowweapon) then put #var xbowweapon crossbow
  if !def(xbowammo) then put #var xbowammo bolt
  if !matchre("$xbowworn", "\b(YES|NO)\b") then put #var xbowworn NO
  if !def(bowweapon) then put #var bowweapon bow
  if !def(bowammo) then put #var bowammo arrow
  if !matchre("$bowworn", "\b(YES|NO)\b") then put #var bowworn NO
  if !def(slingweapon) then put #var slingweapon sling
  if !def(slingammo) then put #var slingammo stone
  if !matchre("$collectammo", "\b(YES|NO)\b") then put #var collectammo YES
  if !matchre("$platring", "\b(YES|NO)\b") then put #var platring NO
  if !def(platringitem) then put #var platringitem scimitar
  if !matchre("$armorswap", "\b(YES|NO)\b") then put #var armorswap NO
  if !matchre("$armornum", "\b(1|2|3|4)\b") then put #var armornum 4
  if !def(shieldname) then put #var shieldname sipar
  if !def(shielddesc) then put #var shielddesc a lumium round sipar
  if !def(armor1name) then put #var armor1name hauberk
  if !def(armor1desc) then put #var armor1desc a quilted fine silk hauberk sealed with protective wax
  if !matchre("$a1stealthrem", "\b(YES|NO)\b") then put #var a1stealthrem NO
  if !def(armor2name) then put #var armor2name gloves
  if !def(armor2desc) then  put #var armor2desc some lumium scale gloves
  if !matchre("$a2stealthrem", "\b(YES|NO)\b") then put #var a2stealthrem NO
  if !def(armor3name) then put #var armor3name helm
  if !def(armor3desc) then put #var armor3desc a lumium ring helm
  if !matchre("$a3stealthrem", "\b(YES|NO)\b") then put #var a3stealthrem NO
  if !def(armor4name) then put #var armor4name mask
  if !def(armor4desc) then put #var armor4desc a light lumium plate mask
  if !matchre("$a4stealthrem", "\b(YES|NO)\b") then put #var a4stealthrem NO
  
  #NONCOMBAT
  if !matchre("$noncomdelay", "\b(YES|NO)\b") then put #var noncomdelay NO
  if !matchre("$appraise", "\b(YES|NO)\b") then put #var appraise NO
  if !matchre("$appraisetarget", "\b(bundle|creature)\b") then put #var appraisetarget bundle
  if $appraisetimer >= 75 then
  else put #var appraisetimer 75
  if !matchre("$appsaveitem", "\b(none|tight|lumpy)\b") then put #var appsaveitem none
  if !def(appsaveitemstorage) then put #var appsaveitemstorage haversack
  if !matchre("$hunting", "\b(YES|NO)\b") then put #var hunting YES
  if $huntingtimer >=75 then
  else put #var huntingtimer 75
  if !matchre("$outdoor", "\b(YES|NO)\b") then put #var outdoor YES
  if $outdoortimer >= 0 then
  else put #var outdoortimer 90
  if !matchre("$collectitem", "\b(rock|bunny)\b") then put #var collectitem rock
  if !matchre("$stealth", "\b(YES|NO)\b") then put #var stealth NO
  if !matchre("$tactics", "\b(YES|NO)\b") then put #var tactics YES
  if !matchre("$nvtactics", "\b(YES|NO)\b") then put #var nvtactics NO
  if !matchre("$recall", "\b(YES|NO)\b") then put #var recall YES
  if !matchre("$compendium", "\b(YES|NO)\b") then put #var compendium NO
  if $compendiumtimer >= 0 then
  else put #var compendiumtimer 60
  if !matchre("$textbook", "\b(YES|NO)\b") then put #var textbook NO
  if $textbooktimer >= 0 then
  else put #var textbooktimer 60
  if !def(textbookitem) then put #var textbookitem tome
  if !def(textbooklist) then put #var textbooklist human|elf|elothean
  if !matchre("$teaching", "\b(YES|NO)\b") then put #var teaching NO
  if !def(teachskill) then put #var teachskill skinning
  #
  # Put new teaching target stuff here.
  #
  if !matchre("$windboard", "\b(YES|NO)\b") then put #var windboard NO
  if $windboardcharge >= 0 then
  else put #var windboardcharge 50
  if !def(windboardtrick) then put #var windboardtrick tilt
  if !matchre("$perform", "\b(YES|NO)\b") then put #var perform NO
  if !def(instrument) then put #var instrument zills
  if !matchre("$instrumentworn", "\b(YES|NO)\b") then put #var instrumentworn NO
  if (($instrumenthands >= 1) && ($instrumenthands < 3)) then
  else put #var instrumenthands 2
  if !matchre("$instclean", "\b(YES|NO)\b") then put #var instclean NO
  if !def(instcleancloth) then put #var instcleancloth cloth
  if !def(songtype) then put #var songtype scales
  if !matchre("$locksmithbox", "\b(YES|NO)\b") then put #var locksmithbox NO
  if !def(locksmithboxitem) then put #var locksmithboxitem training box
  if !matchre("$climbingrope", "\b(YES|NO)\b") then put #var climbingrope NO
  if !def(climbingropename) then put #var climbingropename rope
  if !matchre("$climbingropehum", "\b(YES|NO)\b") then put #var climbingropehum YES
  if !def(humsong) then put #var humsong scales
  
  #MOVETRAIN
  if !matchre("$movetrain", "\b(YES|NO)\b") then put #var movetrain NO
  if !matchre("$mttravel", "\b(YES|NO)\b") then put #var mttravel NO
  if !def(mttraveldest) then put #var mttraveldest crossing
  if !matchre("$mtmove", "\b(YES|NO)\b") then put #var mtmove NO
  if !def(mtmovelist) then put #var mtmovelist 1|42
  if !matchre("$mtreturntravel", "\b(YES|NO)\b") then put #var mtreturntravel NO
  if !def(mtreturntraveldest) then put #var mtreturntraveldest theren
  if !matchre("$mtreturnmove", "\b(YES|NO)\b") then put #var mtreturnmove NO
  if !def(mtreturnmovelist) then put #var mtreturnmovelist 1|start
  if !matchre("$moveperform", "\b(YES|NO)\b") then put #var moveperform NO
  if !matchre("$moveburgle", "\b(YES|NO)\b") then put #var moveburgle NO
  if !matchre("$performcyclic", "\b(YES|NO)\b") then put #var performcyclic NO
  
  #MAGIC
  if !matchre("$attune", "\b(YES|NO)\b") then put #var attune YES
  if $minconcentration >= 0 then
  else put #var minconcentration 80
  if $minmana >= 10 then
  else put #var minmana 30
  if !matchre("$straightcast", "\b(YES|NO)\b") then put #var straightcast NO
  if !matchre("$harnessing", "\b(YES|NO)\b") then put #var harnessing NO
  if $harnessmax >= 5 then
  else put #var harnessmax 20
  if !matchre("$cambrinth", "\b(YES|NO)\b") then put #var cambrinth NO
  if $chargemax >= 5 then
  else put #var chargemax 20
  if !matchre("$dedicatedcambrinth", "\b(YES|NO)\b") then put #var dedicatedcambrinth NO
  if (($cambitems >= 0) && ($cambitems < 3)) then
  else put #var cambitems 1
  if !def(cambitem1) then put #var cambitem1 armband
  if $cambitem1mana >= 1 then
  else put #var cambitem1mana 1
  if !matchre("$cambitem1worn", "\b(YES|NO)\b") then put #var cambitem1worn YES
  if !def(cambitem2) then put #var cambitem2 armband
  if $cambitem2mana >= 1 then
  else put #var cambitem2mana 1
  if !matchre("$cambitem2worn", "\b(YES|NO)\b") then put #var cambitem2worn YES
  if !def(ritualfocus) then put #var ritualfocus rod
  if !matchre("$ritualfocusworn", "\b(YES|NO)\b") then put #var ritualfocusworn NO
  if !matchre("$ritualfocusstorage", "\b(YES|NO)\b") then put #var ritualfocusstorage NO
  if !def(ritualfocuscontainer) then put #var ritualfocuscontainer backpack
  if !matchre("$tmfocus", "\b(YES|NO)\b") then put #var tmfocus NO
  if !def(tmfocusitem) then put #var tmfocusitem wand
  if !matchre("$tmfocusstorage", "\b(YES|NO)\b") then put #var tmfocusstorage NO
  if !matchre("$tmfocusworn", "\b(YES|NO)\b") then put #var tmfocusworn NO
  if !matchre("$tmdbprior", "\b(YES|NO)\b") then put #var tmdbprior NO
  if !matchre("$combatsanowret", "\b(YES|NO)\b") then put #var combatsanowret NO
  if !matchre("$noncomsanowret", "\b(YES|NO)\b") then put #var noncomsanowret NO
  if !def(sanowretitem) then put #var sanowretitem crystal
  
  #BUFFS
  if !matchre("$buff", "\b(YES|NO)\b") then put #var buff NO
  if $buffbuffer >= 1 then
  else put #var buffbuffer 2
  if !matchre("$postbuffperc", "\b(YES|NO)\b") then put #var postbuffperc NO
  if (($buffnum >= 0) && ($buffnum <= 16)) then
  else put #var buffnum 0
  if !def(buff1) then put #var buff1 maf
  if $buff1prepmana >= 0 then
  else put #var buff1prepmana 1
  if $buff1addmana >= 0 then
  else put #var buff1addmana 0
  if !def(buff2) then put #var buff2 maf
  if $buff2prepmana >= 0 then
  else put #var buff2prepmana 1
  if $buff2addmana >= 0 then
  else put #var buff2addmana 0
  if !def(buff3) then put #var buff3 maf
  if $buff3prepmana >= 0 then
  else put #var buff3prepmana 1
  if $buff3addmana >= 0 then
  else put #var buff3addmana 0
  if !def(buff4) then put #var buff4 maf
  if $buff4prepmana >= 0 then
  else put #var buff4prepmana 1
  if $buff4addmana >= 0 then
  else put #var buff4addmana 0
  if !def(buff5) then put #var buff5 maf
  if $buff5prepmana >= 0 then
  else put #var buff5prepmana 1
  if $buff5addmana >= 0 then
  else put #var buff5addmana 0
  if !def(buff6) then put #var buff6 maf
  if $buff6prepmana >= 0 then
  else put #var buff6prepmana 1
  if $buff6addmana >= 0 then
  else put #var buff6addmana 0
  if !def(buff7) then put #var buff7 maf
  if $buff7prepmana >= 0 then
  else put #var buff7prepmana 1
  if $buff7addmana >= 0 then
  else put #var buff7addmana 0
  if !def(buff8) then put #var buff8 maf
  if $buff8prepmana >= 0 then
  else put #var buff8prepmana 1
  if $buff8addmana >= 0 then
  else put #var buff8addmana 0
  if !def(buff9) then put #var buff9 maf
  if $buff9prepmana >= 0 then
  else put #var buff9prepmana 1
  if $buff9addmana >= 0 then
  else put #var buff9addmana 0
  if !def(buff10) then put #var buff10 maf
  if $buff10prepmana >= 0 then
  else put #var buff10prepmana 1
  if $buff10addmana >= 0 then
  else put #var buff10addmana 0
  if !def(buff11) then put #var buff11 maf
  if $buff11prepmana >= 0 then
  else put #var buff11prepmana 1
  if $buff11addmana >= 0 then
  else put #var buff11addmana 0
  if !def(buff12) then put #var buff12 maf
  if $buff12prepmana >= 0 then
  else put #var buff12prepmana 1
  if $buff12addmana >= 0 then
  else put #var buff12addmana 0
  if !def(buff13) then put #var buff13 maf
  if $buff13prepmana >= 0 then
  else put #var buff13prepmana 1
  if $buff13addmana >= 0 then
  else put #var buff13addmana 0
  if !def(buff14) then put #var buff14 maf
  if $buff14prepmana >= 0 then
  else put #var buff14prepmana 1
  if $buff14addmana >= 0 then
  else put #var buff14addmana 0
  if !def(buff15) then put #var buff15 maf
  if $buff15prepmana >= 0 then
  else put #var buff15prepmana 1
  if $buff15addmana >= 0 then
  else put #var buff15addmana 0
  if !def(buff16) then put #var buff16 maf
  if $buff16prepmana >= 0 then
  else put #var buff16prepmana 1
  if $buff16addmana >= 0 then
  else put #var buff16addmana 0
  if !matchre("$tattoobuff", "\b(YES|NO)\b") then put #var tattoobuff NO
  if !def(tattoospell) then put #var tattoospell will
  if $tattooaddmana >= 0 then
  else put #var tattooaddmana 0
  if !matchre("$wandbuff", "\b(YES|NO)\b") then put #var wandbuff NO  
  if !def(wanditem) then put #var wanditem scepter
  if !def(wandstorage) then put #var wandstorage backpack
  if (($wandnum > 0) && ($wandnum <= 2)) then
  else put #var wandnum 1
  if !def(wandspell) then put #var wandspell rw
  if !matchre("$abuff", "\b(YES|NO)\b") then put #var abuff NO
  if (($abuffnum >= 0) && ($abuffnum <= 8)) then
  else put #var abuffnum 0
  if !def(abuff1) then put #var abuff1 maf
  if $abuff1prepmana >= 0 then
  else put #var abuff1prepmana 1
  if $abuff1addmana >= 0 then
  else put #var abuff1addmana 0
  if !def(abuff2) then put #var abuff2 maf
  if $abuff2prepmana >= 0 then
  else put #var abuff2prepmana 1
  if $abuff2addmana >= 0 then
  else put #var abuff2addmana 0
  if !def(abuff3) then put #var abuff3 maf
  if $abuff3prepmana >= 0 then
  else put #var abuff3prepmana 1
  if $abuff3addmana >= 0 then
  else put #var abuff3addmana 0
  if !def(abuff4) then put #var abuff4 maf
  if $abuff4prepmana >= 0 then
  else put #var abuff4prepmana 1
  if $abuff4addmana >= 0 then
  else put #var abuff4addmana 0
  if !def(abuff5) then put #var abuff5 maf
  if $abuff5prepmana >= 0 then
  else put #var abuff5prepmana 1
  if $abuff5addmana >= 0 then
  else put #var abuff5addmana 0
  if !def(abuff6) then put #var abuff6 maf
  if $abuff6prepmana >= 0 then
  else put #var abuff6prepmana 1
  if $abuff6addmana >= 0 then
  else put #var abuff6addmana 0
  if !def(abuff7) then put #var abuff7 maf
  if $abuff7prepmana >= 0 then
  else put #var abuff7prepmana 1
  if $abuff7addmana >= 0 then
  else put #var abuff7addmana 0
  if !def(abuff8) then put #var abuff8 maf
  if $abuff8prepmana >= 0 then
  else put #var abuff8prepmana 1
  if $abuff8addmana >= 0 then
  else put #var abuff8addmana 0
  if !matchre("$gbuff", "\b(YES|NO)\b") then put #var gbuff NO
  if (($gbuffnum >= 0) && ($gbuffnum <= 8)) then
  else put #var gbuffnum 0
  if !def(gbuff1) then put #var gbuff1 maf
  if $gbuff1prepmana >= 0 then
  else put #var gbuff1prepmana 1
  if $gbuff1addmana >= 0 then
  else put #var gbuff1addmana 0
  if !def(gbuff2) then put #var gbuff2 maf
  if $gbuff2prepmana >= 0 then
  else put #var gbuff2prepmana 1
  if $gbuff2addmana >= 0 then
  else put #var gbuff2addmana 0
  if !def(gbuff3) then put #var gbuff3 maf
  if $gbuff3prepmana >= 0 then
  else put #var gbuff3prepmana 1
  if $gbuff3addmana >= 0 then
  else put #var gbuff3addmana 0
  if !def(gbuff4) then put #var gbuff4 maf
  if $gbuff4prepmana >= 0 then
  else put #var gbuff4prepmana 1
  if $gbuff4addmana >= 0 then
  else put #var gbuff4addmana 0
  if !def(gbuff5) then put #var gbuff5 maf
  if $gbuff5prepmana >= 0 then
  else put #var gbuff5prepmana 1
  if $gbuff5addmana >= 0 then
  else put #var gbuff5addmana 0
  if !def(gbuff6) then put #var gbuff6 maf
  if $gbuff6prepmana >= 0 then
  else put #var gbuff6prepmana 1
  if $gbuff6addmana >= 0 then
  else put #var gbuff6addmana 0
  if !def(gbuff7) then put #var gbuff7 maf
  if $gbuff7prepmana >= 0 then
  else put #var gbuff7prepmana 1
  if $gbuff7addmana >= 0 then
  else put #var gbuff7addmana 0
  if !def(gbuff8) then put #var gbuff8 maf
  if $gbuff8prepmana >= 0 then
  else put #var gbuff8prepmana 1
  if $gbuff8addmana >= 0 then
  else put #var gbuff8addmana 0
  
  #SPELL
  if !matchre("$spell", "\b(YES|NO)\b") then put #var spellprepping YES
  if !matchre("$spellnum", "\b(1|2|3|4)\b") then put #var spellnum 1
  if !def(spell1) then put #var spell1 ys
  if !def(skill1) then put #var skill1 augmentation
  if $spell1prepmana >= 0 then
  else put #var spell1prepmana 1
  if $spell1addmana >= 0 then
  else put #var spell1addmana 0
  if !matchre("$spell1symb", "\b(YES|NO)\b") then put #var spell1symb NO
  if !def(spell2) then put #var spell2 ab
  if !def(skill2) then put #var skill2 utility
  if $spell2prepmana >= 0 then
  else put #var spell2prepmana 2
  if $spell2addmana >= 0 then
  else put #var spell2addmana 0
  if !matchre("$spell2symb", "\b(YES|NO)\b") then put #var spell2symb NO
  if !def(spell3) then put #var spell3 maf
  if !def(skill3) then put #var skill3 warding
  if $spell3prepmana >= 0 then
  else put #var spell3prepmana 3
  if $spell3addmana >= 0 then
  else put #var spell3addmana 0
  if !matchre("$spell3symb", "\b(YES|NO)\b") then put #var spell3symb NO
  if !def(spell4) then put #var spell4 bless
  if !def(skill4) then put #var skill4 sorcery
  if $spell4prepmana >= 0 then
  else put #var spell4prepmana 4
  if $spell4addmana >= 0 then
  else put #var spell4addmana 0
  if !matchre("$spell4symb", "\b(YES|NO)\b") then put #var spell4symb NO
  if !matchre("$tm", "\b(YES|NO)\b") then put #var tm NO
  if !def(spelltm) then put #var spelltm fb
  if $spelltmprepmana >= 1 then
  else put #var spelltmprepmana 1
  if $spelltmaddmana >= 0 then
  else put #var spelltmaddmana 0
  if !matchre("$spelltmtattoo", "\b(YES|NO)\b") then put #var spelltmtattoo NO
  if !matchre("$debil", "\b(YES|NO)\b") then put #var debil NO
  if !def(spelldb) then put #var spelldb frb
  if $spelldbprepmana >= 1 then
  else put #var spelldbprepmana 1
  if $spelldbaddmana >= 0 then
  else put #var spelldbaddmana 0
  if !matchre("$spelldbtattoo", "\b(YES|NO)\b") then put #var spelldbtattoo NO
  if !matchre("$cyclic", "\b(YES|NO)\b") then put #var cyclic NO
  if !matchre("$cyclicpriority", "\b(YES|NO)\b") then put #var cyclicpriority NO
  if !matchre("$spellcnum", "\b(1|2|3)\b") then put #var spellcnum 1
  if !def(spellc1) then put #var spellc1 ac
  if !def(skillc1) then put #var skillc1 warding
  if $spellc1prepmana >= 1 then
  else put #var spellc1prepmana 1
  if !def(spellc2) then put #var spellc2 sov
  if !def(skillc2) then put #var skillc2 utility
  if $spellc2prepmana >= 1 then
  else put #var spellc2prepmana 1
  if !def(spellc3) then put #var spellc3 how
  if !def(skillc3) then put #var skillc3 augmentation
  if $spellc3prepmana >= 1 then
  else put #var spellc3prepmana 1
  if !matchre("$cyctm", "\b(YES|NO)\b") then put #var cyctm NO
  if !def(spellctm) then put #var spellctm rim
  if $spellctmprepmana >= 1 then
  else put #var spellctmprepmana 1
  if !matchre("$cycdebil", "\b(YES|NO)\b") then put #var cycdebil NO
  if !def(spellcdb) then put #var spellcdb ee
  if $spellcdbprepmana >= 1 then
  else put #var spellcdbprepmana 1
  if !matchre("$debilassist", "\b(YES|NO)\b") then put #var debilassist NO
  if !matchre("$dbanum", "\b(0|1|2|3)\b") then put #var dbanum 0
  if !def(dbaspell1) then put #var dbaspell1 anc
  if $dbaspell1prepmana > -1 then
  else put #var dbaspell1prepmana 0
  if $dbaspell1addmana > -1 then
  else put #var dbaspell1addmana 0
  if !def(dbaspell2) then put #var dbaspell2 vertigo
  if $dbaspell2prepmana > -1 then
  else put #var dbaspell2prepmana 0
  if $dbaspell2addmana > -1 then
  else put #var dbaspell2addmana 0
  if !def(dbaspell3) then put #var dbaspell3 tremor
  if $dbaspell3prepmana > -1 then
  else put #var dbaspell3prepmana 0
  if $dbaspell3addmana > -1 then
  else put #var dbaspell3addmana 0
  
  if !matchre("$research", "\b(YES|NO)\b") then put #var research NO
  if $gafprepmana >= 5 then
  else put #var gafprepmana 5
  if $gafaddmana >= 0 then
  else put #var gafaddmana 0
  if !matchre("$researchnum", "\b(1|2|3|4|5)\b") then put #var researchnum 1
  if !matchre("$researchtype1", "\b(fundamental|augmentation|stream|sorcery|utility|warding|energy|field|plane|spell)\b") then put #var researchtype1 fundamental
  if !matchre("$researchtype2", "\b(fundamental|augmentation|stream|sorcery|utility|warding|energy|field|plane|spell)\b") then put #var researchtype2 fundamental
  if !matchre("$researchtype3", "\b(fundamental|augmentation|stream|sorcery|utility|warding|energy|field|plane|spell)\b") then put #var researchtype3 fundamental
  if !matchre("$researchtype4", "\b(fundamental|augmentation|stream|sorcery|utility|warding|energy|field|plane|spell)\b") then put #var researchtype4 fundamental
  if !matchre("$researchtype5", "\b(fundamental|augmentation|stream|sorcery|utility|warding|energy|field|plane|spell)\b") then put #var researchtype5 fundamental
  
  
  #GUILD-BARBARIAN
  if !matchre("$warhorn", "\b(YES|NO)\b") then put #var warhorn NO
  if !def(warhornitem) then put #var warhornitem warhorn
  if !matchre("$expertise", "\b(YES|NO)\b") then put #var expertise NO
  if !matchre("$dualload", "\b(YES|NO)\b") then put #var dualload NO
  if !matchre("$yogi", "\b(YES|NO)\b") then put #var yogi NO
  if !matchre("$berserkava", "\b(YES|NO)\b") then put #var berserkava NO
  if $avafatigue >= 0 then
  else put #var avafatigue 90
  if !matchre("$berserkfamine", "\b(YES|NO)\b") then put #var berserkfamine NO
  if $faminevit >= 0 then
  else put #var faminevit 90
  if !matchre("$meditatestaunch", "\b(YES|NO)\b") then put #var meditatestaunch NO
  if !matchre("$berserkcyclone", "\b(YES|NO)\b") then put #var berserkcyclone NO
  if !matchre("$berserkearthquake", "\b(YES|NO)\b") then put #var berserkearthquake NO
  if !matchre("$berserkflashflood", "\b(YES|NO)\b") then put #var berserkflashflood NO
  if !matchre("$berserklandslide", "\b(YES|NO)\b") then put #var berserklandslide NO
  if !matchre("$berserktornado", "\b(YES|NO)\b") then put #var berserktornado NO
  if !matchre("$berserktsunami", "\b(YES|NO)\b") then put #var berserktsunami NO
  if !matchre("$berserkvolcano", "\b(YES|NO)\b") then put #var berserkvolcano NO
  if !matchre("$berserkwildfire", "\b(YES|NO)\b") then put #var berserkwildfire NO
  if !matchre("$bearform", "\b(YES|NO)\b") then put #var bearform NO
  if !matchre("$buffaloform", "\b(YES|NO)\b") then put #var buffaloform NO
  if !matchre("$dragonform", "\b(YES|NO)\b") then put #var dragonform NO
  if !matchre("$eagleform", "\b(YES|NO)\b") then put #var eagleform NO
  if !matchre("$monkeyform", "\b(YES|NO)\b") then put #var monkeyform NO
  if !matchre("$owlform", "\b(YES|NO)\b") then put #var owlform NO
  if !matchre("$pantherform", "\b(YES|NO)\b") then put #var pantherform NO
  if !matchre("$piranhaform", "\b(YES|NO)\b") then put #var piranhaform NO
  if !matchre("$pythonform", "\b(YES|NO)\b") then put #var pythonform NO
  if !matchre("$wolverineform", "\b(YES|NO)\b") then put #var wolverineform NO
  if !matchre("$meditatebastion", "\b(YES|NO)\b") then put #var meditatebastion NO
  if !matchre("$meditatecontemplation", "\b(YES|NO)\b") then put #var meditatecontemplation NO
  if !matchre("$meditatetenacity", "\b(YES|NO)\b") then put #var meditatetenacity NO
  if !matchre("$debiltrain", "\b(YES|NO)\b") then put #var debiltrain NO
  if !matchre("$debiltraintype", "\b(roar|berserk)\b") then put #var debiltraintype roar
  if !def(debiltrainname) then put #var debiltrainname rage
  if !matchre("$augmenttrain", "\b(YES|NO)\b") then put #var augmenttrain NO
  if !matchre("$augmenttraintype", "\b(form|meditation|berserk)\b") then put #var augmenttraintype berserk
  if !def(augmenttrainname) then put #var augmenttrainname avalanche
  if !matchre("$wardingtrain", "\b(YES|NO)\b") then put #var wardingtrain NO
  if !matchre("$wardingtraintype", "\b(form|meditation|berserk)\b") then put #var wardingtraintype berserk
  if !def(wardingtrainname) then put #var wardingtrainname famine
  #GUILD-BARD
  if !matchre("$whistlepiercing", "\b(YES|NO)\b") then put #var whistlepiercing NO
  if !matchre("$eilliescry", "\b(YES|NO)\b") then put #var eilliescry NO
  if $eilliescryprepmana >= 1 then
  else put #var eilliescryprepmana 1
  if $eilliescryaddmana >= 0 then
  else put #var eilliescryaddmana 0
  if !matchre("$misdirection", "\b(YES|NO)\b") then put #var misdirection NO
  if $misdirectionprepmana >= 10 then
  else put #var misdirectionprepmana 10
  if $misdirectionaddmana >= 0 then
  else put #var misdirectionaddmana 0
  #GUILD-CLERIC
  if !matchre("$theurgy", "\b(YES|NO)\b") then put #var theurgy NO
  if !matchre("$pray", "\b(YES|NO)\b") then put #var pray NO
  if !def(praydeity) then put #var praydeity meraud
  if !matchre("$anloralpin", "\b(YES|NO)\b") then put #var anloralpin NO
  if !def(anloralpinitem) then put #var anloralpinitem pin
  if !matchre("$pilgrimbadge", "\b(YES|NO)\b") then put #var pilgrimbadge NO
  if !def(pilgrimbadgeitem) then put #var pilgrimbadgeitem badge
  if !matchre("$meraudcommune", "\b(YES|NO)\b") then put #var meraudcommune NO
  if !matchre("$elunedcommune", "\b(YES|NO)\b") then put #var elunedcommune NO
  if !matchre("$tamsinecommune", "\b(YES|NO)\b") then put #var tamsinecommune NO
  if $blessdelay >= 0 then
  else put #var blessdelay 2
  if !matchre("$dirtstacker", "\b(YES|NO)\b") then put #var dirtstacker NO
  if !def(dirtstackeritem) then put #var dirtstackeritem pouch
  if !matchre("$lighter", "\b(YES|NO)\b") then put #var lighter NO
  if !def(lighteritem) then put #var lighteritem dragon
  if !def(watercontainer) then put #var watercontainer chalice
  if !matchre("$recite", "\b(YES|NO)\b") then put #var recite NO
  if !matchre("$dance", "\b(YES|NO)\b") then put #var dance NO
  if !matchre("$prayermat", "\b(YES|NO)\b") then put #var prayermat NO
  if !def(prayermatitem) then put #var prayermatitem mat
  if !matchre("$hyhcast", "\b(coz|male)\b") then put #var hyhcast male
  if !matchre("$osrelmeraud", "\b(YES|NO)\b") then put #var osrelmeraud NO
  if $omprepmana >= 30 then
  else put #var omprepmana 30
  if $omaddmana >= 0 then
  else put #var omaddmana 0
  if $ombuffnum >= 0 then
  else put #var ombuffnum 0
  #GUILD-EMPATH
  if !matchre("$avoidshock", "\b(YES|NO)\b") then put #var avoidshock NO
  if !matchre("$perchealth", "\b(YES|NO)\b") then put #var perchealth NO
  if !matchre("$manipulate", "\b(YES|NO)\b") then put #var manipulate NO
  if !matchre("$manipnum", "\b(1|2)\b") then put #var manipnum 2
  if !matchre("$paralysis", "\b(YES|NO)\b") then put #var paralysis NO
  if $paralysisprepmana >= 10 then
  else put #var paralysisprepmana 2
  if $paralysisaddmana >= 0 then
  else put #var paralysisaddmana 0
  if !matchre("$vitheal", "\b(YES|NO)\b") then put #var vitheal NO
  if $vithealprepmana >= 5 then
  else put #var vithealprepmana 5
  if $vithealaddmana >= 0 then
  else put #var vithealaddmana 0
  if $vithealnum >= 0 then
  else put #var vithealnum 80
  if !matchre("$heal", "\b(YES|NO)\b") then put #var heal NO
  if $healprepmana >= 15 then
  else put #var healprepmana 15
  if $healaddmana >= 0 then
  else put #var healaddmana 0
  if !matchre("$curedisease", "\b(YES|NO)\b") then put #var curedisease NO
  if $cdprepmana >= 15 then
  else put #var cdprepmana 15
  if $cdaddmana >= 0 then
  else put #var cdaddmana 0
  if !matchre("$adcheal", "\b(YES|NO)\b") then put #var adcheal NO
  if !matchre("$adcdisease", "\b(YES|NO)\b") then put #var adcdisease NO
  if !matchre("$adcpoison", "\b(YES|NO)\b") then put #var adcpoison NO
  if !matchre("$absolution", "\b(YES|NO)\b") then put #var absolution NO
  if $absolutionprepmana >= 150 then
  else put #var absolutionprepmana 150
  if !matchre("$iztouch", "\b(YES|NO)\b") then put #var iztouch NO
  if $izprepmana >= 0 then
  else put #var izprepmana 15
  if $iztimer >= 0 then
  else put #var iztimer 30
  #GUILD-MM
  if !matchre("$astro", "\b(YES|NO)\b") then put #var astro NO
  if $astrotimer >= 0 then
  else put #var astrotimer 0
  if !def(tktitem) then put #var tktitem dagger
  if !matchre("$predictiontool", "\b(none|bones|mirror)\b") then put #var predictiontool none
  if !def(predictiontoolitem) then put #var predictiontoolitem bones
  if $pgprepmana >= 5 then
  else put #var pgprepmana 5
  if $pgaddmana >= 0 then
  else put #var pgaddmana 0
  if !matchre("$mindshout", "\b(YES|NO)\b") then put #var mindshout NO
  #GUILD-NECRO
  if !matchre("$necrosafety", "\b(YES|NO)\b") then put #var necrosafety NO
  if !def(necrowhitelist) then put #var necrowhitelist person1|person2
  if !matchre("$riteofgrace", "\b(YES|NO)\b") then put #var riteofgrace NO
  if $rogprepmana > 4 then
  else put #var rogprepmana 5
  if !matchre("$rogcycle", "\b(YES|NO)\b") then put #var rogcycle NO
  if !matchre("$devour", "\b(YES|NO)\b") then put #var devour NO
  if $devourprepmana >= 30 then
  else put #var devourprepmana 30
  if $devouraddmana >= 0 then
  else put #var devouraddmana 0
  if !matchre("$siphonvit", "\b(YES|NO)\b") then put #var siphonvit NO
  if $siphonvitprepmana >= 30 then
  else put #var siphonvitprepmana 30
  if $siphonvitaddmana >= 0 then
  else put #var siphonvitaddmana 0
  
  if !matchre("$preserve", "\b(YES|NO)\b") then put #var preserve NO
  if !matchre("$dissect", "\b(YES|NO)\b") then put #var dissect NO
  if !matchre("$harvest", "\b(YES|NO)\b") then put #var harvest NO
  if !matchre("$harveststore", "\b(YES|NO)\b") then put #var harveststore NO
  if $harveststorenum >= 0 then
  else put #var harveststorenum 5
  if !matchre("$eotbrel", "\b(YES|NO)\b") then put #var eotbrel NO
  #GUILD-PALADIN
  if !matchre("$smite", "\b(YES|NO)\b") then put #var smite NO
  #GUILD-THIEF
  if !matchre("$backstab", "\b(YES|NO)\b") then put #var backstab NO
  if !matchre("$snipe", "\b(YES|NO)\b") then put #var snipe NO
  if !matchre("$khriavoidance", "\b(YES|NO)\b") then put #var khriavoidance NO
  if !matchre("$khricunning", "\b(YES|NO)\b") then put #var khricunning NO
  if !matchre("$khridampen", "\b(YES|NO)\b") then put #var khridampen NO
  if !matchre("$khridarken", "\b(YES|NO)\b") then put #var khridarken NO
  if !matchre("$khrielusion", "\b(YES|NO)\b") then put #var khrielusion NO
  if !matchre("$khriendure", "\b(YES|NO)\b") then put #var khriendure NO
  if !matchre("$khrifocus", "\b(YES|NO)\b") then put #var khrifocus NO
  if !matchre("$khriharrier", "\b(YES|NO)\b") then put #var khriharrier NO
  if !matchre("$khrihasten", "\b(YES|NO)\b") then put #var khrihasten NO
  if !matchre("$khriplunder", "\b(YES|NO)\b") then put #var khriplunder NO
  if !matchre("$khrisagacity", "\b(YES|NO)\b") then put #var khrisagacity NO
  if !matchre("$khristeady", "\b(YES|NO)\b") then put #var khristeady NO
  if !matchre("$khristrike", "\b(YES|NO)\b") then put #var khristrike NO
  if !matchre("$khriguile", "\b(YES|NO)\b") then put #var khriguile NO
  if !matchre("$khriprowess", "\b(YES|NO)\b") then put #var khriprowess NO
  if !matchre("$khriterrify", "\b(YES|NO)\b") then put #var khriterrify NO
  if !matchre("$khridebil", "\b(YES|NO)\b") then put #var khridebil NO
  if !matchre("$khridebiltype", "\b(prowess|guile|credence|terrify|intimidate|eliminate)\b") then put #var khridebiltype prowess
  if !matchre("$movevanish", "\b(YES|NO)\b") then put #var movevanish NO
  #GUILD-WM
  if !matchre("$summoning", "\b(YES|NO)\b") then put #var summoning NO
  if !matchre("$summonweapon", "\b(YES|NO)\b") then put #var summonweapon NO
  if !matchre("$pathway", "\b(YES|NO)\b") then put #var pathway NO
  if !def(pathwaytype) then put #var pathwaytype precise
  if !matchre("$domain", "\b(YES|NO)\b") then put #var domain NO
  if !matchre("$domaintype", "\b(fire|air|earth|water|electricity|aether|metal)\b") then put #var domaintype fire
  if !def(ignitebackup) then put #var ignitebackup scimitar
  #OTHER-PREPTIMER
  if !matchre("$fastertargeting", "\b(YES|NO)\b") then put #var fastertargeting NO
  if !matchre("$fasterbattleprep", "\b(YES|NO)\b") then put #var fasterbattleprep NO
  if !matchre("$fastermatrices", "\b(YES|NO)\b") then put #var fastermatrices NO
  if !matchre("$silentprep", "\b(YES|NO)\b") then put #var silentprep NO
  if !matchre("$hideprep", "\b(YES|NO)\b") then put #var hideprep NO
  #OTHER-P
  if !matchre("$pcambrinth", "\b(YES|NO)\b") then put #var pcambrinth NO
  if $pchargemax >=0 then
  else put #var pchargemax 20
  if !matchre("$pharness", "\b(YES|NO)\b") then put #var pharness YES
  if $pharnessmax >=0 then
  else put #var pharnessmax 20
  #OTHER-ASTRAL
  if !matchre("$astralsafe", "\b(YES|NO)\b") then put #var astralsafe YES
  if !matchre("$hundredth", "\b(YES|NO)\b") then put #var hundredth NO
  #OTHER-KILL
  #if !matchre("$killtype", "\b(TMFOCUS)\b") then put #var killtype TMFOCUS
  if !matchre("$killloot", "\b(YES|NO)\b") then put #var killloot YES
  if !matchre("$killadvance", "\b(YES|NO)\b") then put #var killadvance YES
  if !matchre("$killretreat", "\b(YES|NO)\b") then put #var killretreat NO
  if !matchre("$killtmfocus", "\b(YES|NO)\b") then put #var killtmfocus NO
  if !matchre("$killbuffing", "\b(YES|NO)\b") then put #var killbuffing NO
  if !matchre("$killcyclic", "\b(YES|NO)\b") then put #var killcyclic NO
  if !def(killcycspell) then put #var killcycspell rim
  if $killcycprepmana >= 0 then
  else put #var killcycprepmana 0
  if !matchre("$killdb", "\b(YES|NO)\b") then put #var killdb NO
  if !def(killdbspell) then put #var killdbspell ip
  if $killdbprepmana >= 0 then
  else put #var killdbprepmana 0
  if $killdbaddmana >= 0 then
  else put #var killdbaddmana 0
  if !matchre("$killtm", "\b(YES|NO)\b") then put #var killtm NO
  if !def(killtmspell) then put #var killtmspell cl
  if $killtmprepmana >= 0 then
  else put #var killtmprepmana 0
  if $killtmaddmana >= 0 then
  else put #var killtmaddmana 0
  if !matchre("$bgdbcombo", "\b(YES|NO)\b") then put #var bgdbcombo NO
  if !matchre("$dragonsbreath", "\b(YES|NO)\b") then put #var dragonsbreath NO
  if $dbprepmana >= 30 then
  else put #var dbprepmana 15
  if $dbaddmana >= 0 then
  else put #var dbaddmana 0
  if !matchre("$magneticballista", "\b(YES|NO)\b") then put #var magneticballista NO
  if $mabprepmana >= 30 then
  else put #var mabprepmana 15
  if $mabaddmana >= 0 then
  else put #var mabaddmana 0
  
  if !matchre("$killweapon", "\b(YES|NO)\b") then put #var killweapon NO
  if !matchre("$killweapontype", "\b(melee|brawl|thrown|aimed)\b") then put #var killweapontype brawl
  if !def(killweaponitem) then put #var killweaponitem scimitar
  if !def(killweaponammo) then put #var killweaponammo bolt
  if !matchre("$killweaponcombo", "\b(edged|blunt|piercing)\b") then put #var killweaponcombo edged
  if !matchre("$killthrownverb", "\b(lob|throw|hurl)\b") then put #var killthrownverb lob
  if !matchre("$killthrownbond", "\b(YES|NO)\b") then put #var killthrownbond NO
  
  #CONDITIONAL_VARIABLE_SWITCHES
  if (($bugoutonbleed = "YES") && ($auonbleed = "YES") && ($autoupkeep = "YES")) then put #var bugoutonbleed NO
  if $harvest = "YES" then put #var preserve YES
  if $tmfocus = "YES" then put #var tmdbprior YES
  if (($necrosafety = "YES") && ($riteofgrace = "YES")) then
  {
    put #var cyctm NO
    put #var cycdebil NO
    put #var cyclic NO
  }
  if %iztouch = "YES" then
  {
    put #var cyclic NO
    put #var cyctm NO
    put #var cycdebil NO
  }
  if (($tmfocusworn = "YES") && ($tmfocusstorage = "YES")) then put #var tmfocusstorage NO
  if (($ritualfocusworn = "YES") && ($ritualfocusstorage = "YES")) then put #var ritualfocusstorage NO
  if (($guild = "Barbarian") || ($guild = "Thief")) then
  {
    put #var attune NO
    put #var spellprepping NO
    put #var cyclic NO
    put #var cycdebil NO
    put #var cyctm NO
    put #var buff NO
    put #var abuff NO
    put #var gbuff NO
  }
  if $premiumring = "YES" then
  {
    put #var aumove NO
    put #var autravel NO
    put #var aureturnmove NO
    put #var aureturntravel NO
  }
  #KILL_SCRIPT_CONDITIONALS
  if $killtmfocus = "YES" then put #var killweapon NO
  if $bgdbcombo = "YES" then
  {
    put #var killtm YES
    put #var killtmspell bg
    if $killtmprepmana < 30 then put #var killtmprepmana 30
    if $killtmaddmana > 70 then put #var killtmaddmana 70 
  }
  put #var save 
  return

EXPLOG:
  put #log >Explog-$charactername.txt Alchemy,$Alchemy.LearningRate,$Alchemy.Ranks,$date,$time
  put #log >Explog-$charactername.txt Appraisal,$Appraisal.LearningRate,$Appraisal.Ranks,$date,$time
  put #log >Explog-$charactername.txt Arcana,$Arcana.LearningRate,$Arcana.Ranks,$date,$time
  put #log >Explog-$charactername.txt Athletics,$Athletics.LearningRate,$Athletics.Ranks,$date,$time
  put #log >Explog-$charactername.txt Attunement,$Attunement.LearningRate,$Attunement.Ranks,$date,$time
  put #log >Explog-$charactername.txt Augmentation,$Augmentation.LearningRate,$Augmentation.Ranks,$date,$time
  put #log >Explog-$charactername.txt Bow,$Bow.LearningRate,$Bow.Ranks,$date,$time
  put #log >Explog-$charactername.txt Brawling,$Brawling.LearningRate,$Brawling.Ranks,$date,$time
  put #log >Explog-$charactername.txt Brigandine,$Brigandine.LearningRate,$Brigandine.Ranks,$date,$time
  put #log >Explog-$charactername.txt Chain,$Chain_Armor.LearningRate,$Chain_Armor.Ranks,$date,$time
  put #log >Explog-$charactername.txt Crossbow,$Crossbow.LearningRate,$Crossbow.Ranks,$date,$time
  put #log >Explog-$charactername.txt Debilitation,$Debilitation.LearningRate,$Debilitation.Ranks,$date,$time
  put #log >Explog-$charactername.txt Defending,$Defending.LearningRate,$Defending.Ranks,$date,$time
  put #log >Explog-$charactername.txt Enchanting,$Enchanting.LearningRate,$Enchanting.Ranks,$date,$time
  put #log >Explog-$charactername.txt Engineering,$Engineering.LearningRate,$Engineering.Ranks,$date,$time
  put #log >Explog-$charactername.txt Evasion,$Evasion.LearningRate,$Evasion.Ranks,$date,$time
  put #log >Explog-$charactername.txt First Aid,$First_Aid.LearningRate,$First_Aid.Ranks,$date,$time
  put #log >Explog-$charactername.txt Forging,$Forging.LearningRate,$Forging.Ranks,$date,$time
  put #log >Explog-$charactername.txt Heavy Thrown,$Heavy_Thrown.LearningRate,$Heavy_Thrown.Ranks,$date,$time
  put #log >Explog-$charactername.txt Large Blunt,$Large_Blunt.LearningRate,$Large_Blunt.Ranks,$date,$time
  put #log >Explog-$charactername.txt Large Edged,$Large_Edged.LearningRate,$Large_Edged.Ranks,$date,$time
  put #log >Explog-$charactername.txt Light Armor,$Light_Armor.LearningRate,$Light_Armor.Ranks,$date,$time
  put #log >Explog-$charactername.txt Light Thrown,$Light_Thrown.LearningRate,$Light_Thrown.Ranks,$date,$time
  put #log >Explog-$charactername.txt Locksmithing,$Locksmithing.LearningRate,$Locksmithing.Ranks,$date,$time
  put #log >Explog-$charactername.txt Mechanical Lore,$Mechanical_Lore.LearningRate,$Mechanical_Lore.Ranks,$date,$time
  put #log >Explog-$charactername.txt Melee Mastery,$Melee_Mastery.LearningRate,$Melee_Mastery.Ranks,$date,$time
  put #log >Explog-$charactername.txt Missile Mastery,$Missile_Mastery.LearningRate,$Missile_Mastery.Ranks,$date,$time
  put #log >Explog-$charactername.txt Offhand,$Offhand_Weapon.LearningRate,$Offhand_Weapon.Ranks,$date,$time
  put #log >Explog-$charactername.txt Outdoorsmanship,$Outdoorsmanship.LearningRate,$Outdoorsmanship.Ranks,$date,$time
  put #log >Explog-$charactername.txt Outfitting,$Outfitting.LearningRate,$Outfitting.Ranks,$date,$time
  put #log >Explog-$charactername.txt Parry,$Parry_Ability.LearningRate,$Parry_Ability.Ranks,$date,$time
  put #log >Explog-$charactername.txt Perception,$Perception.LearningRate,$Perception.Ranks,$date,$time
  put #log >Explog-$charactername.txt Performance,$Performance.LearningRate,$Performance.Ranks,$date,$time
  put #log >Explog-$charactername.txt Plate,$Plate_Armor.LearningRate,$Plate_Armor.Ranks,$date,$time
  put #log >Explog-$charactername.txt Polearms,$Polearms.LearningRate,$Polearms.Ranks,$date,$time
  put #log >Explog-$charactername.txt Primary Magic,$Primary_Magic.LearningRate,$Primary_Magic.Ranks,$date,$time
  put #log >Explog-$charactername.txt Scholarship,$Scholarship.LearningRate,$Scholarship.Ranks,$date,$time
  put #log >Explog-$charactername.txt Shield,$Shield_Usage.LearningRate,$Shield_Usage.Ranks,$date,$time
  put #log >Explog-$charactername.txt Skinning,$Skinning.LearningRate,$Skinning.Ranks,$date,$time
  put #log >Explog-$charactername.txt Slings,$Slings.LearningRate,$Slings.Ranks,$date,$time
  put #log >Explog-$charactername.txt Small Blunt,$Small_Blunt.LearningRate,$Small_Blunt.Ranks,$date,$time
  put #log >Explog-$charactername.txt Small Edged,$Small_Edged.LearningRate,$Small_Edged.Ranks,$date,$time
  put #log >Explog-$charactername.txt Sorcery,$Sorcery.LearningRate,$Sorcery.Ranks,$date,$time
  put #log >Explog-$charactername.txt Stealth,$Stealth.LearningRate,$Stealth.Ranks,$date,$time
  put #log >Explog-$charactername.txt Summoning,$Summoning.LearningRate,$Summoning.Ranks,$date,$time
  put #log >Explog-$charactername.txt Tactics,$Tactics.LearningRate,$Tactics.Ranks,$date,$time
  put #log >Explog-$charactername.txt Targeted Magic,$Targeted_Magic.LearningRate,$Targeted_Magic.Ranks,$date,$time
  put #log >Explog-$charactername.txt Thievery,$Thievery.LearningRate,$Thievery.Ranks,$date,$time
  put #log >Explog-$charactername.txt Twohanded Blunt,$Twohanded_Blunt.LearningRate,$Twohanded_Blunt.Ranks,$date,$time
  put #log >Explog-$charactername.txt Twohanded Edged,$Twohanded_Edged.LearningRate,$Twohanded_Edged.Ranks,$date,$time
  put #log >Explog-$charactername.txt Utility,$Utility.LearningRate,$Utility.Ranks,$date,$time
  put #log >Explog-$charactername.txt Warding,$Warding.LearningRate,$Warding.Ranks,$date,$time
  echo Experience logged!
  return

#==============ITEM_MANIPULATION==============  


#####ITEM_HANDLING_SUBS#####
AMMOGETP:
	pause
AMMOGET:
  if matchre ("$roomobjs", "%ubowammo") then
  {
	  matchre AMMOGETP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	  matchre AMMOGET You pick up|You pull a|out of the pile of rubble.|You pull a small rock out|You fade in|You put your
	  matchre RETURN You must unload|You stop as you realize the|Stow what?|You stop as|What were you referring to?
	  matchre AMMOGETBAD You need a free hand to pick that up.
	  put stow %ubowammo
	  matchwait 5
	  var timeoutsub AMMOGET
	  goto TIMEOUT
	}
	else return

AMMOGETBAD:
  var stowhand left
  gosub STOW
  goto AMMOGET

ATMOTOGGLEP:
  pause
ATMOTOGGLE:
  matchre ATMOTOGGLEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN Setting your .* to (active|inactive) status, you can (deactivate|reactivate) it using the ATMOSPHERE verb\.
  put atmo righthand
  matchwait 5
  var timeoutsub ATMOTOGGLE
	goto TIMEOUT

BUNDLEPULLP:
  pause
BUNDLEPULL:
  matchre BUNDLEPULLP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre WEARITEM You adjust the ropes of your
  put pull my bundle
  matchwait 5
  var timeoutsub BUNDLEPULL
	goto TIMEOUT

COILROPEP:
  pause
COILROPE:
  matchre COILROPEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  match RETURN You can't do that.tem
  match RETURN You coil up your rope.
  match RETURN What were you referring to?
  put coil heavy rope
  matchwait 5
  var timeoutsub COILROPE
	goto TIMEOUT

DEPOSITCOINP:
	pause
DEPOSITCOIN:
	matchre DEPOSITCOINP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	matchre RETURN You find your jar with little effort, thankfully, and drop your coins inside
	put deposit %depositamount
	matchwait 5
	var timeoutsub DEPOSITCOIN
	goto TIMEOUT

DROPITEMP:
	pause
DROPITEM:
	matchre DROPITEMP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	match DROPLOWER Trying to go unnoticed, are you?
  match DROPITEM Whoah!
	matchre RETURN What were you referring to?|You drop|You wince as the|You spread|You drop your
	match DROPUNHIDE Doing that would give away your hiding place!
	put drop my %dumpitemname
	matchwait 5
	var timeoutsub DROPITEM
	goto TIMEOUT
	
DROPUNHIDE:
  gosub UNHIDE
  goto DROPITEM

DROPLOWER:
	var loweritemname %dumpitemname
	gosub LOWERITEM
	gosub EMPTYFEET
	return

DUMPITEM:
	if matchre ("$roomobjs", "(bucket|large stone turtle|disposal bin|waste bin|tree hollow|oak crate|firewood bin|ivory urn|pit|trash receptacle|marble statue)") then
	{
	  var putitemname %dumpitemname
	  var putlocation $1
	  gosub PUTITEM
	}
	else gosub DROPITEM
  return

EMPTYFEETP:
  pause
EMPTYFEET:
  matchre EMPTYFEETP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  match EMPTYFEET You consider kicking the contents at your feet onto the ground.
	matchre RETURN You kick .* onto the ground in front of you\.|But there's nothing at your feet\!
	put empty feet
	matchwait 5
	var timeoutsub EMPTYFEET
	goto TIMEOUT

GETITEM:
  var getitemstring $0
  goto GETITEMMAIN
GETITEMP:
  pause
GETITEMMAIN:
  matchre GETITEMP \.\.\.wait|type ahead|stunned|while entangled in a web\.|You grab hold
  matchre UNTIEITEM You pull at it, but the ties prevent you.  Maybe if you untie it, first?|You should untie the
  matchre RETURN You get|You're already holding|You are already holding that.|You pick up|What were you referring to?|You stop as you realize|You must unload|You fade in for a moment|You remove|You pull|What were you referring to?|You try to grab your
  match RETURN Get what?
  matchre GETITEMP You try to grab your
  matchre GETITEMBAD You need a free hand to pick that up.
  matchre CLIMBPRACBAD You should stop practicing 
  matchre GETITEMADV Sheesh, it's still alive! 
  match GETITEMREM But that is already in your inventory.
  matchre GETITEMPLAYSTOP You should stop playing before you do that.
  put get %getitemstring
  matchwait 5
  var timeoutsub GETITEM
	var timeoutcommand get %getitemstring
	goto TIMEOUT

GETITEMREM:
  gosub REMITEM %getitemstring
  return
 
GETITEMPLAYSTOP:
  gosub PLAYSTOP
  goto GETITEMMAIN

CLIMBPRACBAD:
  pause 10
  goto GETITEM
  
GETITEMADV:  
  gosub ADV
  goto GETITEMMAIN

GETITEMBAD:
  var stowhand left
  gosub STOW
  goto GETITEMMAIN

LOWERITEMP:
  pause
LOWERITEM:
  matchre LOWERITEMP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN What did you want to lower\?|You lower the .* and place it on the ground at your feet\.
  put lower %loweritemname ground
  matchwait 5
	var timeoutsub LOWERITEM
	goto TIMEOUT

OPENITEMP:
  pause
OPENITEM:
  matchre OPENITEMP \.\.\.wait|type ahead|stunned|while entangled in a web\.'
  matchre RETURN You open the|That is already open\.
  put open %openitemname
  matchwait 5
	var timeoutsub OPENITEM
	goto TIMEOUT

PLATRINGP:
  pause
PLATRING:
  matchre PLATRINGP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You touch your platinum ring
  match PLATRINGLP The magical energy within your platinum ring
  put touch platinum ring
  matchwait 5
  var timeoutsub PLATRING
	goto TIMEOUT

PLATRINGLP:
  pause 10
  goto PLATRING  

PUTALL:
  if $righthand != "Empty" then
  {
    var putitemname $righthand
    gosub PUTITEM
  }
  if $lefthand != "Empty" then
  {
    var putitemname $lefthand
    gosub PUTITEM
  }
  return
	
PUTITEMP:
	pause
PUTITEM:
	matchre PUTITEMP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	matchre RETURN You put|What were you referring to?|You drop|Perhaps you should be holding that first.|A bored-looking Human boy says|You briefly twist the top off of|There doesn't seem to be any more room left|is too long, even after stuffing it, to fit in the|There isn't any more room in|But that's closed\.|You just can't get the .* to fit in the \w*, no matter how you arrange it\.|Perhaps you should be holding that first\.
  matchre PUTSTEALSTOW A bored-looking Human boy raises an eyebrow in your direction.
	put put my %putitemname in %putlocation
	matchwait 5
	var timeoutsub PUTITEM
	goto TIMEOUT

PUTSTEALSTOW:
  var stowitemname %putitemname
  gosub STOWITEM
  return
  
REMITEM:
  var substring $0
REMITEMP:
  pause
REMITEMMAIN:
  matchre REMITEMP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You sling|You remove|You pull off|You work your way|You loosen|Remove what?|You slide|You take|You aren't wearing that\.|You detach
  match REMOVESTOW You need a free hand for that.
  put remove %substring
  matchwait 5
  var timeoutsub REMITEM
	var timeoutcommand remove %substring
	goto TIMEOUT

REMOVESTOW:
  gosub STOWALL
  goto REMITEMMAIN

SHEATHEITEMP:
  pause
SHEATHEITEM:
  matchre SHEATHEITEMP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre SHEATHEBAD Sheathe your
  matchre RETURN Sheathe what?|You sheathe|You hang|You secure|You easily strap|Sheathing a
  if %stowhand = "right" then put sheathe $righthandnoun
  else put sheathe $lefthandnoun
  matchwait 5
  var timeoutsub SHEATHEITEM
	goto TIMEOUT

SHEATHEBAD:
  if %stowhand = "right" then var stowitemname $righthandnoun
  else var stowitemname $lefthandnoun
  gosub STOWITEM
  return

SLIPITEMP:
	pause
SLIPITEM:
	matchre SLIPITEMP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	matchre RETURN You silently slip|You put
	put slip my %putitemname in %putlocation
	matchwait 5
	var timeoutsub SLIPITEM
	goto TIMEOUT

STOWP:
  pause
STOW:
  if %stowhand = "left" then
  {
    if $lefthand = "Empty" then return
  }
  if %stowhand = "right" then
  {
    if $righthand = "Empty" then return
  }
  gosub STOWCUSTOM
  var stowoverride 0
  if %stowcustomsuccess = 1 then return
  matchre STOWP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre STOWUNLOAD You need to unload|You should unload
  matchre STOWSTOPPLAY You should stop playing before you do that.
  matchre STOWSKINBAD You try to stuff your
  matchre STOWCOIL The heavy rope is too long, even after stuffing it, to fit in the
  matchre RETURN You put your|Stow what\?|You open your pouch|You stop as|What were you referring to?|You think the gem pouch
  put stow %stowhand
  matchwait 5
  var timeoutsub STOW
	goto TIMEOUT

STOWUNLOADP:
  pause
STOWUNLOAD:
  if $lefthand != "Empty" then
  {
    var stowhand left
    gosub STOW 
  }
  gosub UNLOAD
  gosub STOWALL
  return

STOWCOIL:
  gosub COILROPE
  goto STOW

STOWSKINBAD:
  if %stowhand = "right" then var dumpitemname $righthandnoun
  else var dumpitemname $lefthandnoun
  gosub DUMPITEM
  return

STOWSTOPPLAY:
  gosub PLAYSTOP
  goto STOW

STOWFEETP:
  pause
STOWFEET:
  matchre STOWFEETP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  match STOWFEET You pick up
  match RETURN Stow what?
  put stow feet  
  matchwait 5
  var timeoutsub STOWFEET
	goto TIMEOUT
  
STOWCUSTOM:
 if %platring = "YES" then
  {
    if matchre ("$%stowhandhand", "%platringitem") then
    {
      if %stowhand = "left" then gosub SWAP
      gosub PLATRING
      var stowcustomsuccess 1
      return
    }
  }
  if matchre ("$%stowhandhand", "%cambitem1") then
  {
    if %cambitem1worn = "YES" then
    {
      var wearitemname %cambitem1
      gosub WEARITEM
      var stowcustomsuccess 1
      return
    }
  }
  if matchre ("$%stowhandhand", "%cambitem2") then
  {
    if %cambitem2worn = "YES" then
    {
      var wearitemname %cambitem2
      gosub WEARITEM
      var stowcustomsuccess 1
      return
    }
  }
  if matchre ("$%stowhandhand", "%bowweapon") then 
  {
    if %bowworn = "YES" then
    {
      var wearitemname %bowweapon
      gosub WEARITEM
      var stowcustomsuccess 1
      return
    }
  }
  if matchre ("$%stowhandhand", "%xbowweapon") then
  {
    if %xbowworn = "YES" then
    {
      var wearitemname %xbowweapon
      gosub WEARITEM
      var stowcustomsuccess 1
      return
    }
  }
  if matchre ("$%stowhandhand", "%poleweapon") then
  {
    if %poleworn = "YES" then
    {
      var wearitemname %poleweapon
      gosub WEARITEM
      var stowcustomsuccess 1
      return
    }
    if %poletied = "YES" then
    {
      var wearitemname %poleweapon
      gosub TIEITEM
      var stowcustomsuccess 1
      return
    }
  }
  if matchre ("$%stowhandhand", "%staveweapon") then
  {
    if %staveworn = "YES" then
    {
      var wearitemname %staveweapon
      gosub WEARITEM
      var stowcustomsuccess 1
      return
    }
    if %stavetied = "YES" then
    {
      var wearitemname %staveweapon
      gosub TIEITEM
      var stowcustomsuccess 1
      return
    }
  }
  if %ritualfocusstorage = "YES" then
  {
    if matchre ("$%stowhandhand", "%ritualfocus") then
    {
      var putitemname %ritualfocus
      var putlocation %ritualfocuscontainer
      gosub PUTITEM
      var stowcustomsuccess 1
      return
    }
  }
  if %ritualfocusworn = "YES" then
  {
    if matchre ("$%stowhandhand", "%ritualfocus") then
    {
      var wearitemname %ritualfocus
      gosub WEARITEM
      var stowcustomsuccess 1
      return
    }
  }
  if %tmfocusstorage = "YES" then
  {
    if matchre ("$%stowhandhand", "%tmfocusitem") then
    {
      var putitemname %tmfocusitem
      var putlocation %tmfocuscontainer
      gosub PUTITEM
      var stowcustomsuccess 1
      return
    }
  }
  if %tmfocusworn = "YES" then
  {
    if matchre ("$%stowhandhand", "%tmfocus") then
    {
      var wearitemname %tmfocusitem
      gosub WEARITEM
      var stowcustomsuccess 1
      return     
    }
  }
  if matchre ("$%stowhandhand", "%wanditem") then
  {
    var putitemname %wanditem
    var putlocation %wandstorage
    gosub PUTITEM
    var stowcustomsuccess 1
    return
  }
  if matchre ("$%stowhandhand", "%nonwornweapons") then
  {
    gosub SHEATHEITEM
    var stowcustomsuccess 1
    return
  }
  var stowcustomsuccess 0
  return
  
STOWALL:
  if $lefthand != "Empty" then
  {
    var stowhand left
    gosub STOW
  }
  if $righthand != "Empty" then
  {
    var stowhand right
    gosub STOW
  }
  return

STOWITEMP:
  pause
STOWITEM:
  matchre STOWITEMP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You put your|You sling|You attach|You open your pouch|You stop as
  match RETURN Stow what?  Type 'STOW HELP' for details.
  put stow %stowitemname
  matchwait 5
  var timeoutsub STOWITEM
	goto TIMEOUT

SWAPP:
  pause
SWAP:
  matchre SWAPP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You move|You have nothing to swap!|Your (right|left) hand is too injured to do that\.
  put swap
  matchwait 5
  var timeoutsub SWAP
	goto TIMEOUT

TIEITEMP:
  pause
TIEITEM:
  matchre TIEITEMP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre STUDYCONTAINER There's no more room on
  matchre TIEUNHIDE That would give away your hiding place!
  matchre RETURN Sheathing a|You attach
  put tie %wearitemname to my %storage
  matchwait 5
  var timeoutsub TIEITEM
	goto TIMEOUT
  
TIEUNHIDE:
  gosub UNHIDE
  goto TIEITEM

STUDYCONTAINER:
  put study %storage
  goto TIEITEM

SELLITEM:
  var substring $0
  goto SELLITEMMAIN
SELLITEMP:
  pause
SELLITEMMAIN:
  matchre SELLITEMP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You ask|You hold up your|There is no merchant here to buy that\.|Sell what?|^.* takes your|Cormyn whistles and says|Relf briefly glances at
  match SELLITEMWAIT There doesn't seem to be anyone around.
  put sell my %substring
  matchwait 5
  var timeoutsub SELLITEM
  var timeoutcommand sell my %substring
	goto TIMEOUT

SELLITEMWAIT:
  pause 10
  goto SELLITEM

UNCOILROPEP:
  pause
UNCOILROPE:
  matchre UNCOILROPEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You can't do that\.|You uncoil your rope\.
  put uncoil heavy rope
  matchwait 5
  var timeoutsub UNCOILROPE
	goto TIMEOUT

UNLOADP:
  pause
UNLOAD:
  matchre UNLOADP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You unload|isn't loaded!|You remain concealed by your surroundings
  put unload
  matchwait 5
  var timeoutsub UNLOAD
	goto TIMEOUT

UNTIEITEMP:
  pause
UNTIEITEM:
  matchre UNTIEITEMP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You untie|Please rephrase that command.|Untie what?
  put untie %getitemname
  matchwait 5
  var timeoutsub UNTIEITEM
	goto TIMEOUT

WEARITEMP:
  pause
WEARITEM:
  matchre WEARITEMP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You put|You slip|You sling|You work your way into|You attach|You slide your|You hang|You are already wearing that.|You slide|You drape
  matchre WEARCANT You can't wear any more items like that.
  matchre WEARUNLOAD You need to unload|You should unload
  match RETURN But that is already in your inventory.
  put wear %wearitemname
  matchwait 5
  var timeoutsub WEARITEM
	goto TIMEOUT

WEARCANT:
  if %wearitemname = "bundle" then goto BUNDLEPULL
  else return

WEARUNLOADP:
  pause
WEARUNLOAD:
  if $lefthand != "Empty" then
  {
    var stowhand left
    gosub STOW
  }
  gosub UNLOAD
  gosub STOWALL
  return

WIELDP:
  pause
WIELD:
  matchre WIELDP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You draw out your|You're already holding|You draw your
  matchre WIELDGET You can't seem|You find it difficult to wield|Your (right|left) hand is too injured to draw
  match WIELDBOND Wield what?
  match WIELDSTOW You need to have your
  matchre WIELDREM You'll need to remove it first!|You're wearing
  put wield %getitemhand %getitemname
  matchwait 5
  var timeoutsub WIELD
  var timeoutcommand wield %getitemhand %getitemname
	goto TIMEOUT

WIELDGET:
  gosub GETITEM %getitemname
  return

WIELDBOND:
  if matchre ("%getitemname", "%ltweapon") then
  {
    if %ltbond = "YES" then goto THROWBOND
  }
  if matchre ("%getitemname", "%htweapon") then
  {
    if %htbond = "YES" then goto THROWBOND
  }
  return

WIELDSTOW:
  gosub STOWALL
  goto WIELD
  
WIELDREM:
  gosub REMITEM %getitemname
  return


##########


ACTIVEWEAPONS:
  var activeweaponlist
  var activeweaponscount 1
  goto ACTIVEWEAPONSLOOP
  
ACTIVEWEAPONSLOOP:
  if %weaponnum < %activeweaponscount then return
  if %activeweaponscount =  1 then
  {
    var activeweaponslist |%weapon1|
  }
  else var activeweaponslist %activeweaponslist%weapon%activeweaponscount|
  math activeweaponscount add 1
  goto ACTIVEWEAPONSLOOP


COLLECTAMMOLOGIC:
  if %collectammo = "YES" then
  {
    if contains("%activeweaponslist", "|bow|") then
    {
      if matchre ("$roomobjs", "%bowammo") then
      {
        var ubowammo %bowammo
        gosub AMMOGET
      }
    }
    if contains("%activeweaponslist", "|xbow|") then
    {
      #echo roomobjs: $roomobjs
      #echo xbowammo: %xbowammo
      if matchre ("$roomobjs", "%xbowammo") then
      {
        var ubowammo %xbowammo
        gosub AMMOGET
      }
    }
    if contains("%activeweaponslist", "|sling|") then
    {
      if matchre ("$roomobjs", "%slingammo") then
      {
        var ubowammo %slingammo
        gosub AMMOGET
      }
    }
  }
  if contains("%activeweaponslist", "|ht|") then
  {
    if matchre ("$roomobjs", "%htweapon") then
    {
      if %htbond = "YES" then put invoke bond
      else
      {
        gosub GETITEM %htweapon 
      }
    }
  }
  if contains("%activeweaponslist", "|lt|") then
  {
    if matchre ("$roomobjs", "%ltweapon") then
    {  
      if %ltbond = "YES" then put invoke bond
      else
      {
        gosub GETITEM %ltweapon 
      }
    }
  }
  return


SWAPCHECK:
  if ((%getitemname = "sword") || (%getitemname = "white sword") || (%getitemname = "bastard sword") || (%getitemname = "broadaxe") || (%getitemname = "war sword")) then gosub SWORDSWAP
  if (%getitemname = "half-handled riste") then 
  {
    var ristetype hh
    gosub RISTESWAP 
  }
  if (%getitemname = "riste") then
  {
    var ristetype n 
    gosub RISTESWAP
    return
  }
  if ((%getitemname = "war icon") || (%getitemname = "icon")) then gosub ICONSWAP
  return


SWORDSWAPP:
  pause
SWORDSWAP:
  if tolower("%weapon%currentweapon") = "le" then
  {
    if %bastardsword = 1 then return
  }
  if tolower("%weapon%currentweapon") = "the" then
  {
    if %bastardsword = 2 then return
  }
  match SWAPSTOW You must have two free hands
  matchre SSWAPLE as a heavy edged weapon
  matchre SSWAPTHE as a two-handed edged weapon
  matchre SWORDSWAPP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  put swap %getitemname
  matchwait

SSWAPLE:
  var bastardsword 1
  goto SWORDSWAP

SSWAPTHE:
  var bastardsword 2
  GOTO SWORDSWAP
  
SWAPSTOW:
  if %getitemhand = "right" then
  {
    var stowhand left
    gosub stow
  }
  else
  {
    var stowhand right
    gosub stow
  }
  goto SWORDSWAP

RISTESWAPP:
  pause
RISTESWAP:
  #echo RisteType: %ristetype
  if tolower("%weapon%currentweapon") = "sb" then
  {
    #echo %ristetyperiste: %%ristetyperiste
    if %%ristetyperiste = 1 then return
  }
  if tolower("%weapon%currentweapon") = "se" then
  {
    #echo %ristetyperiste: %%ristetyperiste
    if %%ristetyperiste = 2 then return
  }
  if tolower("%weapon%currentweapon") = "lb" then
  {
    #echo %ristetyperiste: %%ristetyperiste
    if %%ristetyperiste = 3 then return
  }
  if tolower("%weapon%currentweapon") = "le" then
  {
    #echo %ristetyperiste: %%ristetyperiste
    if %%ristetyperiste = 4 then return
  }
  if tolower("%weapon%currentweapon") = "thb" then
  {
    #echo %ristetyperiste: %%ristetyperiste
    if %%ristetyperiste = 5 then return
  }
  match RSWAPSTOW You must have two free hands
  matchre RSWAPLB as a heavy blunt weapon
  matchre RSWAPTHB as a two-handed blunt weapon
  matchre RSWAPLE as a heavy edged weapon
  matchre RSWAPSB as a medium blunt weapon
  matchre RSWAPSE as a medium edged weapon
  matchre RISTESWAPP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  put swap %getitemname
  matchwait
  
RSWAPSB:
  if %ristetype = "hh" then var hhriste 1
  if %ristetype = "n" then var nriste 1
  goto RISTESWAP
  
RSWAPSE:
    if %ristetype = "hh" then var hhriste 2
  if %ristetype = "n" then var nriste 2
  goto RISTESWAP

RSWAPLB:
  if %ristetype = "hh" then var hhriste 3
  if %ristetype = "n" then var nriste 3
  goto RISTESWAP

RSWAPLE:
  if %ristetype = "hh" then var hhriste 4
  if %ristetype = "n" then var nriste 4
  goto RISTESWAP

RSWAPTHB:
  if %ristetype = "hh" then var hhriste 5
  if %ristetype = "n" then var nriste 5
  goto RISTESWAP

RSWAPSTOW:
  if %getitemhand = "right" then
  {
    var stowhand left
    gosub stow
  }
  else
  {
    var stowhand right
    gosub stow
  }
  goto RISTESWAP

ICONSWAPP:
  pause
ICONSWAP:
  if tolower("%weapon%currentweapon") = "the" then
  {
    if %waricon = 1 then return
  }
    if tolower("%weapon%currentweapon") = "thb" then
  {
    if %waricon = 2 then return
  }
  match ISWAPSTOW You must have two free hands
  matchre ISWAPTHE as a two-handed edged weapon
  matchre ISWAPTHB as a two-handed blunt weapon
  matchre ICONSWAPP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  put swap %getitemname
  matchwait

ISWAPTHE:
  var waricon 1
  goto ICONSWAP
  
ISWAPTHB:
  var waricon 2
  goto ICONSWAP

ISWAPSTOW:
  if %getitemhand = "right" then
  {
    var stowhand left
    gosub stow
  }
  else
  {
    var stowhand right
    gosub stow
  }
  goto ICONSWAP



####COMBAT_SUBS####

STANCECHANGEP:
  pause
STANCECHANGE:
  matchre STANCECHANGEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You are now set|Setting your
  put stance %stance
  matchwait  

BRAWLCOMBO:
  var usingbow 0
  var lowfatattack punch
  var lowattack bob
  var medattack punch
  var highattack kick
	var weaponmode melee
  return
  	
BLUNTCOMBO:
  var usingbow 0
  var lowfatattack swing
  var lowattack feint
  var medattack draw
  var highattack chop
	var weaponmode melee
	return
	
EDGEDCOMBO:
  var usingbow 0
  var lowfatattack slice
  var lowattack feint
  var medattack draw
  var highattack chop
  var weaponmode melee
  return
  
PIERCECOMBO:
  var usingbow 0
  var lowfatattack thrust
  var lowattack jab
  var medattack draw
  var highattack lunge
  var weaponmode melee
  return

THROWNCOMBO:
  var usingbow 0
	var combonum 0
  var weaponmode thrown
  var att %%weapontypeverb
  return
  
BOWCOMBO:
  if %lastweapon != %currentweapon then
  {
    if %aiming = 1 then
    {
      echo Weapon switched.  Killing aiming just in case.
      var aiming 0
    }
  }
	var combonum 0
  var weaponmode bow
  var usingbow 1
  if %weapontype = "xbow" then var ubowammo %xbowammo
  if %weapontype = "bow" then var ubowammo %bowammo
  if %weapontype = "sling" then var ubowammo %slingammo
  gosub BOWSTANCECHECK
  return

MOVECHOOSE:
  #echo Balance: %balance    Fatigue: $stamina%
  if $stamina < 80 then
  {
    var att %lowfatattack %hand
    return
  }
  if %balance = "incredibly" then
  {
    var att %highattack %hand
    return
  }
  if %balance = "adeptly" then
  {
    var att %highattack %hand
    return
  }
  if %balance = "nimbly" then
  {
    var att %medattack %hand
    return
  }
  if %balance = "solidly" then
  {
    var att %medattack %hand
    return
  }
  var att %lowattack %hand
  return

ATTACKMELEEP:
	pause
ATTACKMELEE:
  if %usingstealth = 1 then 
  { 
    gosub STEALTH
  }
	var lasthit 0
	matchre ATTACKMELEEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	match ATTACKMELEEP Strangely, you don't feel like fighting right now.
	matchre ATTACKSTAND You'll need to stand up first.
	matchre ATTACKFACE nothing else|at what are you|You lean back and kick your feet|Face what?|Backstab what?
	matchre BRAWLFAIL You can not slam with that|Please rephrase that command\.
	match BRAWLFAIL Wouldn't it be better if you used a melee weapon?
	matchre ADV aren't close enough|You must be closer|It would help if you were closer
	match TWOHANDSTOW You need two hands to wield this weapon!
	match GOODHIT lands a
  matchre RETURN already in a position|But you are already dodging|pointlessly hack|There is nothing else to face!|Blindsiding is much more effective when you use a melee weapon.
  matchre ATTACKRETURN You move into a position to|Roundtime|You slip out of concealment
  matchre ATTMELEEFLYING is flying too high for you to attack.
	matchre BADBACKSTAB You can't backstab that.
	matchre BACKSTABHIDE You must be hidden to blindside.
	if ((%backstab = "YES") && (%guild = "Thief")) then
	{
	  if ((%usingstealth = 1) && ($hidden = 1) && (%badbackstab = 0)) then
	  {
	    if ((%weapontype = "se") || (%weapontype = "sb")) then put backstab %hand
	    else put %att
	  }
	  else put %att
	}
  else put %att
	matchwait

ATTACKSTAND:
  gosub STAND
  goto ATTACKMELEE

BACKSTABHIDE:
  gosub HIDE
  goto ATTACKMELEE

ATTACKRETURN:
  math weapon%currentweaponcount add 1
  return

BADBACKSTAB:
  var badbackstab 1
  goto ATTACKMELEE

ATTACKFACE:
  gosub FACE
  if %badface = 1 then
  {
    var badface 0
    return
  }
  else goto ATTACKMELEE

BRAWLFAIL:
  if %usingtactics = 1 then var tacticsdone 1
  if %usingexpert = 1 then
  {
    var expertdone 1
    var expertpause 1
  }
  if %avoidshock = "YES" then var facebrawlfail 1
  gosub FACE
  if %badface = 1 then
  {
    var badface 0
    return
  }
  return

ATTMELEEFLYING:
  if $hidden = 1 then gosub UNHIDE
  gosub FACE
  if %badface = 1 then
  {
    var badface 0
    return
  }
  goto ATTACKMELEE

GOODHIT:
  var lasthit 1
  math weapon%currentweaponcount add 1
  return

ATTACKTHROWNP:
	pause
ATTACKTHROWN:
	matchre ATTACKTHROWNP Strangely, you don't feel like fighting right now.
	matchre FACE at what are you
	matchre RETURN There is nothing else to face!
	matchre ATTACKTHROWNP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	matchre THROWGET Roundtime|What are you trying to|You must hold the|What are you trying to lob?
	matchre THROWSTOW You need a free hand to hurl the
	#matchre ATTACKTHROWNSWAP You must hold the
  if %hand = "left" then put %att left
  else put %att
	matchwait

THROWSTOW:
  if %hand = "left" then var stowhand right
  else var stowhand left
  gosub STOW
  goto ATTACKTHROWN

ATTACKTHROWNSWAP:
  gosub SWAP
  goto ATTACKTHROWN

STEALTH:
  if matchre ("%abufflist", "rm") then
  {
    if %mist != 1 then return
  }
  if %misdirection = "YES" then
  {
    if $SpellTimer.Misdirection.active != 1 then return
  }
  if %pantherform = "YES" then
  {
    if $SpellTimer.Panther.active != 1 then return
  }
  if matchre ("%bufflist", "shadows") then
  {
    if $SpellTimer.Shadows.active != 1 then return
  }
  if matchre ("%bufflist", "obfuscation") then 
  {
    if $SpellTimer.Obfuscation.active != 1 then return
  }
  if matchre ("%bufflist", "mis") then
  {
    if $SpellTimer.Misdirection.active != 1 then return
  }
  gosub HIDE
  return

ANALYZEP:
  pause
ANALYZE:
  var lasthit 1
  matchre ANALYZEP Strangely, you don't feel like fighting right now.
  matchre ANASUCC You fail to find any holes|Your analysis reveals a slight|You reveal a tiny weakness|You reveal a small|Your analysis reveals a small|Your analysis reveals a moderate|Your analysis reveals a good|Your analysis reveals a substantial|Your analysis reveals a large|Your analysis reveals a great|Your analysis reveals an exceptional|You reveal a moderate|You reveal a slight
  matchre MOVESET Your analysis reveals a massive
	matchre ANAADV ^You must be closer
	matchre ANAFACE ^Analyze what|There is nothing else to face!
  matchre ANALYZE ^You fail to find any
  matchre ANALYZEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre ANAFLYING is flying too high for you to attack.
  matchre ANAPRONE You should stand up first.
  matchre RETURN Face what?
  put analyze
  matchwait

ANASUCC:
  gosub STATUSCHECK
  goto ANALYZE

ANAPRONE:
  gosub STAND
  goto ANALYZE

ANAFLYING:
  gosub FACE
  if %badface = 1 then
  {
    var badface 0
    return
  }
  goto ANALYZE

ANAFACEP:
  pause
ANAFACE:
  if $monstercount < 1 then RETURN
  gosub FACE
  if %badface = 1 then
  {
    var badface 0
    return
  }
  goto ANALYZE
  
EANALYZEP:
  pause
EANALYZE:
  var lasthit 1
  matchre MOVESET Roundtime:|With a keen eye you study the battlefield
	matchre EANALYZEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre EANAADV Analyze what?
  put analyze flame
  matchwait
  
EANAADV:
  gosub ADV
  goto EANALYZE
  
TACTICSSET:
  var movenum 0
  if "%tmove5" != "none" then
  {
    var tacticsmax 5
    return
  }
  if "%tmove4" != "none" then
  {
    var tacticsmax 4
    return
  }
  if "%tmove3" != "none" then
  {
    var tacticsmax 3
    return
  }
  if "%tmove2" != "none" then
  {
    var tacticsmax 2
    return
  }
  if "%tmove1" = "none" then var tacticsdone 1
  var tacticsmax 1
  return
  
EXPERTSET:
  var emovenum 0
  if "%emove5" != "none" then
  {
    var expertmax 5
    return
  }
  if "%emove4" != "none" then
  {
    var expertmax 4
    return
  }
  if "%emove3" != "none" then
  {
    var expertmax 3
    return
  }
  if "%emove2" != "none" then
  {
    var expertmax 2
    return
  }
  if "%emove1" = "none" then var expertdone 1
  var expertmax 1
  return
  

ANAADV:
  gosub ADV
  goto ANALYZE

TACTICSRESET:
  var tmove1 none
  var tmove2 none
  var tmove3 none
  var tmove4 none
  var tmove5 none
  var tacticsdone 0
  var analyzedone 0
  var movenum 1
  var tacticsmax 0
  return

EXPERTRESET:
  var emove1 none
  var emove2 none
  var emove3 none
  var emove4 none
  var emove5 none
  var expertdone 0
  var eanalyzedone 0
  var emovenum 1
  var expertmax 0
  return


NVTACTICSP:
  pause
NVTACTICS:
  matchre NVTACTICSP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN Roundtime|What are you trying to attack?
  matchre NVTACTICSADV You must be closer to 
  put %tmaneuver
  matchwait

NVTACTICSADV:
  gosub ADV
  goto NVTACTICS

THROWGETP:
	pause
THROWGET:
  math weapon%currentweaponcount add 1
  matchre THROWGETP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You pick up|You fade in for a moment as you pick up|You are already holding that.|You pull|You get
  matchre THROWBOND What were you|Sheesh, it's still alive!
	put get %weaponname
	matchwait

THROWBONDP:
  pause
THROWBOND:
  if %weapontype = "lt" then
  {
    if %ltbond != "YES" then return
  }
  else
  {
    if %weapontype = "ht" then
    {
      if %htbond != "YES" then return
    }
  }
  matchre RETURN and flies toward you!|suddenly leaps toward you!|You don't have any bonds to invoke!|Strong magic shields the bonded item from your grasp.|Are you sure you want to do that?
  matchre THROWBONDP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	#put invoke bond %weaponname
	put invoke bond
	matchwait

HIDE:
  var hideattempts 0
  goto HIDEACTION

HIDEACTIONP:
	pause
HIDEACTION:
  if %hideattempts >= 2 then RETURN
  if $hidden = 0 then
  {
	  matchre RETURN You melt into the background,|But you're already hidden!|You blend in with your surroundings
	  matchre HIDEACTIONP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	  matchre BADHIDE notices your attempt to hide!|discovers you, ruining your hiding place!
	  put hide
	  matchwait
	}
	else return

BADHIDE:
  math hideattempts add 1
  goto HIDEACTION

UNHIDEP:
	pause
UNHIDE:
  if $hidden = 1 then
  {
	  matchre RETURN You come out of hiding.|But you are not hidden|You slip out of hiding, although you remain invisible.
	  matchre UNHIDEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	  match UNHIDESTAND You try to creep out of hiding but your injuries cause you to stumble and crash to the ground!
	  put unhide
	  matchwait
	}
	else return

UNHIDESTAND:
  gosub STAND
  return

STEALP:
	pause
STEAL:
  matchre STEALP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	matchre RETURN Roundtime 
	put steal %stealitem
	matchwait

MARKP:
  pause
MARK:
  matchre MARKP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN Roundtime
  put mark %stealitem
  matchwait


ATTACKBOWP:
	pause
ATTACKBOW:
  if %aiming = 0 then
  {
    matchre ATTACKBOWP Strangely, you don't feel like fighting right now.
    matchre GETLOAD isn't loaded!
    match BOWSTOW You need both hands in order to aim.
	  matchre FACE at what are you|I could not find what you were referring to.
	  matchre AIMSUCCESS You begin to target|You are already targetting|You shift your target to 
	  matchre ATTACKBOWP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	  matchre RETURN Face what?|There is nothing else to face!|You don't have a ranged weapon to aim with!
    put aim
	  matchwait
	}
	gosub STATUSCHECK
	return

FIREP:
  pause
FIRE:
  if %usingstealth = 1 then 
  {  
    #echo Using Stealth - $Stealth.LearningRate
    gosub STEALTH
  }
  var aiming 0
  var aimready 0
  math weapon%currentweaponcount add 2
  matchre FIREP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre FIREP Strangely, you don't feel like fighting right now\.|That weapon must be in your right hand to fire\!
  matchre GETLOAD isn't loaded\!
  matchre AMMOGET lands nearby|falls to the ground\!|falls to the floor\!
  matchre RETURN Roundtime|There is nothing else to face!|What are you trying to attack?|But you don't have a ranged|You can't fire|How can you poach|You remain concealed by your surroundings,|Face what?|How can you snipe if you are not hidden?
  if %usingstealth = 1 then 
  {
    if $hidden = 1 then
    {
      if ((%guild = "Thief") || (%guild = "Ranger")) then
      {
        if $snipe = "YES" then put snipe
        else put poach
      }
      else put poach
    }
    else put fire
  }
  else put fire
  matchwait

AIMSUCCESS:
  var aiming 1
  RETURN

BOWSTOW:
  var stowhand left
  gosub STOW
  goto ATTACKBOW

GETLOAD:
  var usingdualload 0
  #BARBARIAN
  if ((%dualload = "YES") && ($SpellTimer.Eagle.active = 1) && (%weapontype = "bow")) then
  {
    goto BOWLOAD
    goto ATTACKBOW
    var usingdualload 1
  }
  #RANGER
  if ((%dualload = "YES") && ($SpellTimer.SeetheWind.active = 1) && (%weapontype = "bow")) then
  {
    goto BOWLOAD
    goto ATTACKBOW
    var usingdualload 1
  }
  #THIEF
  if ((%dualload = "YES") && ($SpellTimer.KhriSteady.active = 1) && (%weapontype = "bow")) then
  {
    goto BOWLOAD
    goto ATTACKBOW
    var usingdualload 1
  }

  gosub GETITEM my %ubowammo
  if matchre ("$righthand", "(%ubowammo)") then gosub SWAP
  if matchre ("$lefthand", "(%ubowammo)") then
  {
    gosub BOWLOAD
    goto ATTACKBOW
  }
  else
  {
    echo ===OUT OF AMMO===
    put #flash
    put #play Advance
    pause 5
    goto GETLOAD
  }

BOWLOADP:
	pause
BOWLOAD:
	matchre BOWLOADP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	matchre BOWLOADSTOW is already loaded|to load the|You load|You reach into your
	matchre BOWLOADGET You don't have the proper ammunition
	match BOWNOEAGLE You focus on the image of an eagle but are unable to draw upon its majesty.
	if %usingdualload != 1 then put load my %ubowammo
	else put load my %ubowammos
	matchwait

BOWLOADSTOW:
  if matchre ("$lefthand", "%ubowammo") then
  {
    var stowitemname %ubowammo
    gosub STOWITEM
  }
  return

BOWLOADGET:
  var stowhand left
  gosub STOW
  gosub GETITEM %ubowammo
  goto BOWLOAD

BOWNOEAGLE:
  var usingdualload 0
  goto BOWLOAD

	
TWOHANDSTOW:
  if matchre ("$righthand", "%cambitem1") then put wear %cambitem1
  if matchre ("$lefthand", "%cambitem1") then put wear %cambitem1
  var stowhand left
  gosub STOW
  goto ATTACKMELEE

#==============COMBAT_POSITIONING==============
ADVP:
	pause
ADV:
  if %avoidshock = "YES" then gosub TARGETSELECT
  matchre FACE You stop advancing|You have lost sight|advance towards?
  matchre ADVRETURN to melee range|already at melee|You are already advancing|You begin to 
  matchre ADVP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  match ADVSTAND You had better stand up first.
  put advance
  matchwait
  
ADVRETURN:
  pause 2
  return

ADVSTAND:
  gosub STAND
  goto ADV

FACEP:
	pause
FACE:
	if %avoidshock != "YES" THEN
	{
	  var badface 0
	  matchre FACEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	  matchre RETURN You turn
	  matchre INVALIDFACE Face what?|nothing else to face|There isn't anything like that here to face\!
	  match DEADFACE What's the point in facing
	  put face next
	  matchwait
	}
	else
	{
	  gosub TARGETSELECT
	  var facebrawlfail 0
	  return
	}

INVALIDFACE:
  var badface 1
  if %avoidshock = "YES" then
  {
    var goodtarget 0
    var goodtarget 0
    var shockcritter 1
    var currentcritter 0
  }
  return
	
FACETARGETP:
	pause
FACETARGET:
  var badface 0
	matchre FACETARGETP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	matchre RETURN nothing else to face|You are already facing|You turn
	match DEADFACE What's the point in facing
	match INVALIDFACE Face what?
	matchre FACETARGETRET You are too closely engaged
	put face %faceadj %facenoun
	matchwait

DEADFACE:
  if %avoidshock = "YES" then
  {
    put look
    pause 1
    gosub MONTEST
    var goodtarget 0
    var currentcritter 0
    var shockcritter 1
  }
  var badface 1
  var deadcheck 1
  gosub MONTEST
  put look
  pause .5
  return

FACETARGETRET:
  gosub RETREAT
  goto FACETARGET

OLDMOVE:
  pause 0.1
  put #goto %roomtarget
  waitforre YOU HAVE ARRIVED
  return

MOVE:
  delay 0.0001
  var move.skip 0
  var move.retry 0
  var move.fail 0
  var move.room $0
  if $roomid = 0 then
  {
    put #mapper reset
    pause 1
    if $roomid = 0 then
    {
      put #flash
      put #play JustArrived
      if !def(alertwindow) then  put #echo Yellow Genie has lost track of your room number and cannot move!
      else put #echo >$alertwindow Yellow Genie has lost track of your room number and cannot move!
    }
  }
  goto MOVE.GOTO

MOVE.RETRY:
  math move.retry add 1
  if %move.retry > 3 then goto move.fail
  echo ***
  echo *** Retrying move to $1 $2 in %move.retry second(s).
  echo ***
  pause %move.retry
  goto MOVE.GOTO

MOVE.GOTO:
  #gosub retreat
  matchre MOVE.GOTO ^\.\.\.wait|^Sorry\,
  matchre MOVE.RETURN ^YOU HAVE ARRIVED
  matchre MOVE.RETURN ^Darkness settles like a thick cloak 
  matchre MOVE.SKIP ^SHOP CLOSED
  matchre MOVE.RETRY ^MOVE FAILED
  matchre MOVE.FAIL ^DESTINATION NOT FOUND
  matchre MOVE.RETRY ^You can't go
  matchre MOVE.RETRY ^You're still recovering from your recent attack\.
  matchre MOVE.RETREAT ^You are engaged
  matchre MOVE.RETREAT ^You can't do that while engaged\!
  put #goto %roomtarget
  matchwait

MOVE.FAIL:
  var move.fail 1
  goto MOVE.RETURN

MOVE.RETREAT:
  pause 0.1
  gosub RETREAT
  pause 0.1
  goto MOVE.RETRY

MOVE.SKIP:
  var move.skip 1

MOVE.RETURN:
  pause 0.001
  pause 0.1
  pause 0.1
  #put #mapper reset
  RETURN

RETREATP:
  pause
RETREAT:
  matchre RETREAT You retreat back to pole range.|You try to back away from|You stop advancing on|You sneak back out|You try to back out of combat but are unable to get away!|You try to sneak out of combat,|discovers you trying to sneak out of combat, revealing your hiding place!|You stop advancing.
  matchre RETURN You retreat from combat.|You are already as far away as you can get!
  match STAND You must stand first.
  matchre RETREATP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  put retreat
  matchwait

MOVEANYROOM:
  var moveroomlist n|ne|e|se|s|sw|w|nw|out|up|down
  var moveroomcount 0
  goto MOVEANYROOM1

MOVEANYROOM1P:
  pause
MOVEANYROOM1:
  eval roomtry element("%moveroomlist", %moveroomcount)
  matchre MOVEANYROOM1P \.\.\.wait|type ahead|stunned|while entangled in a web\.
  match MOVEANYROOM2 You can't go there.
  matchre RETURN ^Obvious
  matchre MOVEANYROOMRET You are engaged to
  put %roomtry
  matchwait

MOVEANYROOM2:
  math moveroomcount add 1
  goto MOVEANYROOM1

MOVEANYROOMRET:
  gosub RETREAT
  goto MOVEANYROOM1

MOVEROOMS:
  pause .1
  pause .01
  var movement $0
  goto MOVEROOMS1

MOVEROOMS1P:
  pause
MOVEROOMS1:
    matchre MOVEROOMS1P \.\.\.wait|type ahead|stunned|while entangled in a web\.
    matchre RETURN ^Obvious
    matchre RETURN ^You can't
    #match RETURN Please rephrase that command.
    matchre MOVEROOMSRET You are engaged to
    put %movement
    matchwait

MOVEROOMSRET:
  gosub RETREAT
  goto MOVEROOMS1
 
SNEAKROOMS:
  pause .1
  pause .01
  var movement $0
  goto SNEAKROOMS1

SNEAKROOMS1P:
  pause
SNEAKROOMS1:
    matchre SNEAKROOMS1P \.\.\.wait|type ahead|stunned|while entangled in a web\.
    matchre RETURN ^Obvious
    matchre RETURN ^You can't|
    match SNEAKROOMSATFEET You find yourself unable to sneak with items at your feet.
    put sneak %movement
    matchwait

SNEAKROOMSATFEET:
  gosub STOWALL
  gosub STOWFEET
  goto SNEAKROOMS1


DEFSTANCEP:
  pause  
DEFSTANCE:
  matchre DEFSTANCEP \.\.\.wait|type ahead|stunned|while entangled in a web\.|It's all a blur!
  matchre RETURN Viewing current combat stance...|Setting your Evasion stance to 100%, 
  put stance set 100 0 100 0
  matchwait

RETREATFLEE:
  var retreatcount 0
  goto RETREATFLEE1

RETREATFLEE1P:
  pause
RETREATFLEE1:
  if %retreatcount > 6 then
  {
    var fleegood 0
    goto FLEE
  }
  matchre RETREATFLEE2 You retreat back to pole range.|You try to back away from|You stop advancing on|You sneak back out|You try to back out of combat but are unable to get away!|You try to sneak out of combat,
  matchre RETURN You retreat from combat.|You are already as far away as you can get!
  match STAND You must stand first.
  matchre RETREATFLEE1P \.\.\.wait|type ahead|stunned|while entangled in a web\.
  put retreat
  matchwait

RETREATFLEE2:
  math retreatcount add 1
  goto RETREATFLEE1

FLEEP:
  pause
FLEE:
  matchre FLEEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre FLEE2 You foresee the situation deteriorating rapidly.|You realize you're out of your element!|Either you're looking really tasty|You feel the wrenching pain of dejection as you|Hoping the gods will come to your rescue, you mutter|You suddenly realize that you may be completely outclassed in this match.
  put flee
  matchwait
  
FLEE2:
  if %fleegood = 1 then return
  pause .1
  goto FLEE2
  
SMITETESTP:
  pause
SMITETEST:
  matchre SMITETESTP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre SMITEGOOD Your conviction is enough to deliver
  matchre SMITEBAD Your conviction is shaken and spent.
  put smite check
  matchwait

SMITEGOOD:
  var smitesleft 1
  return
  
SMITEBAD:
  var smitesleft 0
  return
  
KHRIP:
  pause
KHRI:
  matchre KHRIP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre KHRIRETURN Roundtime|You're already using the|You have not recovered from your previous use|Your body is willing, but you can't seem to concentrate
  matchre KHRIKNEEL Your mind and body are willing, but you feel you lack the skill to begin that khri.
  put khri %khritype
  matchwait

KHRIKNEEL:
  gosub KNEEL
  goto KHRI
  
KHRIRETURN:
  if $sitting = 1 then gosub STAND
  if $kneeling = 1 then gosub STAND
  if $prone = 1 then gosub STAND
  return

KHRISTOPP:
  pause
KHRISTOP:
  matchre KHRISTOPP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You attempt to relax your mind from
  put khri stop %khritype
  matchwait


#BARBARIAN_STUFF
BERSERKP:
  pause
BERSERK:
  var nextberserk %t
  math nextberserk add %barbpause
  matchre BERSERKP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  match BERSERKWRONG You have no idea how to do that.
  match BERSERKTRAIN You have not been trained in that manner of berserking.
  matchre RETURN Roundtime|The momentus rage of the avalanche replenishes your energy\!|But you are already enraged with that berserk\.|A ravenous energy fills your limbs and you feel yourself growing healthier\!|You struggle\, but find yourself lacking the inner fire to enact such a rage\!|Your inner fire lacks the strength to fuel such a rage at this time\.|A vortex of malice springs into being\, expanding your focus and steadying your shield arm\!|Fury storming forth\, your pulse whips itself up to a furious tempo\!|Your hands shake in anticpation of releasing the fury of the tsunami down upon your foes\!|You sense the rage within you well up and explode in a wild rage of dangerous power\.|You form the epicenter of a violent rage bent on crumbling your enemies\!|The momentus eruption of the volcano hardens you against damage\!|Careful control and timing of rage can provide reflexes capable of weathering even a landslide\.|In a flash your body fills with a flood of resilient rage\!
  put berserk %berserktype
  matchwait

BERSERKWRONG:
  put #echo %alertwindow Yellow Tried to start %berserktype berserk, but that is not a valid form!  Please investigate.
  put #flash
  put #play JustArrived
  return

BERSERKTRAIN:
  put #echo %alertwindow Yellow Tried to start %berserktype berserk, but you are not trained in that yet!  Please investigate.
  put #flash
  put #play JustArrived
  return

FORMP:
  pause
FORM:
  var nextform %t
  math nextform add %barbpause
  matchre FORMP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  match FORMBAD You find yourself unable to focus on an additional form.  Perhaps try stopping one first?
  match FORMWRONG You have no idea how to do that.
  match FORMTRAIN You have not been trained in that form.
  matchre RETURN But you are already practicing that form!|Roundtime
  put form start %formtype
  matchwait

FORMBAD:
  put #echo %alertwindow Yellow Tried to start %formtype form, but there were already 5 forms up!  Please investigate.
  put #flash
  put #play JustArrived
  return

FORMWRONG:
  put #echo %alertwindow Yellow Tried to start %formtype form, but that is not a valid form!  Please investigate.
  put #flash
  put #play JustArrived
  return

FORMTRAIN:
  put #echo %alertwindow Yellow Tried to start %formtype form, but you are not trained in that yet!  Please investigate.
  put #flash
  put #play JustArrived
  return

FORMSTOPP:
  pause
FORMSTOP:
  put #var SpellTimer.%formtype.active 0
  matchre FORMSTOPP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN But you are not practicing that form!|You feel your inner fire cool as you finish practicing the Form|The powerful gait of the Buffalo form
  put form stop %formtype
  matchwait

MEDITATIONP:
  pause
MEDITATION:
  if %yogi = "NO" then
  {
    gosub RETREAT
    gosub SIT
  }
  var nextmeditation %t
  math nextmeditation add %barbpause
  matchre MEDITATIONP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  match MEDITATIONBAD You find yourself unable to focus on an additional meditation.  Perhaps try stopping one first?
  match MEDITATIONWRONG You have no idea how to do that.
  match MEDITATIONTRAIN You have not been trained in that type of meditation.
  match MEDITATIONRETURN Roundtime
  put meditate %meditationtype
  matchwait

MEDITATIONRETURN:
  if %yogi != "YES" then gosub STAND
  return

MEDITATIONBAD:
  put #echo %alertwindow Yellow Tried to start %meditationtype meditation, but there were already 3 meditations up!  Please investigate.
  put #flash
  put #play JustArrived
  return

MEDITATIONWRONG:
  put #echo %alertwindow Yellow Tried to start %meditationtype meditation, but that is not a valid form!  Please investigate.
  put #flash
  put #play JustArrived
  return
  
MEDITATIONTRAIN:
  put #echo %alertwindow Yellow Tried to start %meditationtype meditation, but you are not trained in that yet!  Please investigate.
  put #flash
  put #play JustArrived
  return

MEDITATIONSTOPP:
  pause
MEDITATIONSTOP:
  matchre MEDITATIONSTOPP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  match RETURN You take a deep breath and exhale, releasing the beneficial flames burning deep within your mind.
  put meditation stop %medittype
  matchwait

ROARP:
  pause
ROAR:
  var nextroar %t
  math nextroar add 120
  matchre ROARP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre ROARFACE You are not facing an enemy to roar at!
  matchre RETURN Roundtime|Strain though you might, you cannot muster|You have not been trained in that roar.
  put roar quiet %roartype
  matchwait

ROARFACE:
  gosub FACE
  if %badface = 1 then
  {
    var badface 0
    return
  }
  goto ROAR

WARHORNP:
  pause
WARHORN:
  matchre WARHORNP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN Roundtime
  put exhale %warhornitem lure
  matchwait


ENTERVAULTP:
  pause
ENTERVAULT:
  matchre ENTERVAULTP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre NOVAULT The attendant says, "Hey bub, are you lost?|The attendant says, "Hey lady, are you lost?
  matchre PAYRENT The Dwarven attendant grabs you by the wrist.
  matchre VAULTOPEN The attendant opens a small panel and fiddles with some controls
  matchre SECONDARCH The attendant steps in front of
  put go arch
  matchwait
  
SECONDARCH:
  matchre THIRDARCH The attendant steps in front of
  matchre VAULTOPEN The attendant opens a small panel and fiddles with some controls
  put go second arch
  matchwait
  
THIRDARCH:
  matchre FOURTHARCH The attendant steps in front of
  matchre VAULTOPEN The attendant opens a small panel and fiddles with some controls
  put go third arch
  matchwait

FOURTHARCH:
  matchre RETURN The attendant steps in front of
  matchre VAULTOPEN The attendant opens a small panel and fiddles with some controls
  put go fourth arch
  matchwait
  
NOVAULT:
  if %vaultmove = "YES" then
  {
    move go desk
    put ring bell
    pause .5
    move out
    waitfor A young Dwarf trots up to you and says,
    goto ENTERVAULT
  }
  else return
  
PAYRENT:
  move go desk
  put pay 5000
  pause .5
  move out
  goto ENTERVAULT
  
VAULTOPEN:
  var vaultsuccess 1
  put pull lever
  pause .5
  move go door
  put open vault
  return
  
EXITVAULT:
  put close vault
  pause .5
  move go door
  move go arch
  move out
  return
  
EXCHANGEP:
  pause
EXCHANGE:
  matchre EXCHANGEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You hand your|You don't have that many|You count|One of the guards mutters|The money-changer says crossly
  put exchange %examount to %excurrency
  matchwait
  
WEALTHCHECK:
  var copperkro 0
  var bronzekro 0
  var silverkro 0
  var goldkro 0
  var platinumkro 0
  var copperlir 0
  var bronzelir 0
  var silverlir 0
  var goldlir 0
  var platinumlir 0
  var copperdok 0
  var bronzedok 0
  var silverdok 0
  var golddok 0
  var platinumdok 0

  action (wealth) var copperkro $1 when .+ (\d+) copper Kronars \((\d+) copper Kronars\).
  action (wealth) var bronzekro $1 when .+ (\d+) bronze.+Kronars \((\d+) copper Kronars\).
  action (wealth) var silverkro $1 when .+ (\d+) silver.+Kronars \((\d+) copper Kronars\).
  action (wealth) var goldkro $1 when .+ (\d+) gold.+Kronars \((\d+) copper Kronars\).
  action (wealth) var platkro $1 when .+ (\d+) platinum.+Kronars \((\d+) copper Kronars\).
  action (wealth) var copperlir $1 when .+ (\d+) copper Lirums \((\d+) copper Lirums\).
  action (wealth) var bronzelir $1 when .+ (\d+) bronze.+Lirums \((\d+) copper Lirums\).
  action (wealth) var silverlir $1 when .+ (\d+) silver.+Lirums \((\d+) copper Lirums\).
  action (wealth) var goldlir $1 when .+ (\d+) gold.+Lirums \((\d+) copper Lirums\).
  action (wealth) var platlir $1 when .+ (\d+) platinum.+Lirums \((\d+) copper Lirums\).
  action (wealth) var copperdok $1 when .+ (\d+) copper Dokoras \((\d+) copper Dokoras\).
  action (wealth) var bronzedok $1 when .+ (\d+) bronze.+Dokoras \((\d+) copper Dokoras\).
  action (wealth) var silverdok $1 when .+ (\d+) silver.+Dokoras \((\d+) copper Dokoras\).
  action (wealth) var golddok $1 when .+ (\d+) gold.+Dokoras \((\d+) copper Dokoras\).
  action (wealth) var platdok $1 when .+ (\d+) platinum.+Dokoras \((\d+) copper Dokoras\).
  put wealth
  pause 1
  action (wealth) off
  return

GEMPOUCHGETLOOP:
  gosub POUCHASK
  gosub STOWALL
  math pouchestoget subtract 1
  if %pouchestoget < 1 then return
  else goto GEMPOUCHGETLOOP

POUCHASKP:
  pause
POUCHASK:
  matchre POUCHASKP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre POUCHASKGOOD hands you (a|an) (\S+) gem pouch\.
  matchre RETURN Usage: ASK|"All I know about are skins 
  put ask %appraiser for gem pouch
  matchwait
  
POUCHASKGOOD:
  var didgetpouch 1
  return

BUYLOOP:
  if %buyloopcount > %buylooptotal then RETURN
  gosub ORDER
  pause 1
  gosub PAY
  var stowitemname %buytarget
  gosub STOWITEM 
  math buyloopcount add 1
  goto BUYLOOP


BUNDLEROPEGETLOOP:
  gosub ROPEASK
  gosub STOWALL
  math ropestoget subtract 1
  if %ropestoget < 1 then return
  else goto BUNDLEROPEGETLOOP

ORDERP:
  pause
ORDER:
  matchre ORDERP ...wait|type ahead|stunned|while entangled in a web.
  matchre RETURN Brother Durantine nods slowly|Friar Othorp grins broadly|Sister Nongwen smiles and nods|Sister Imadrail smiles and nods
  put order %buytarget
  matchwait
  
PAYP:
  pause
PAY:
  matchre PAYP ...wait|type ahead|stunned|while entangled in a web.
  matchre RETURN Durantine waves a small censer|Othorp prays over your purchase|Sister Nongwen carefully|Sister Imadrail reverently
  put offer %cost
  matchwait

ROPEASKP:
  pause
ROPEASK:
  matchre ROPEASKP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre ROPEASKGOOD hands you a rope.
  matchre RETURN Usage: ASK|"All I know about are skins 
  put ask %furrier for bundling rope
  matchwait

ROPEASKGOOD:
  var didgetrope 1
  return

RUMMAGEP:
  pause
RUMMAGE:
  matchre RUMMAGEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN I don't know what you are referring to.|You rummage|While it's closed?
  put rummage %rummageitem
  matchwait


STATUSCHECK:
  if matchre("$roomobjs", "a maeldryth") then
  {
    put #echo %alertwindow Yellow [GM]: Maeldryth in the area.
    pause .5
    put #play Evil
    pause .5
    put #flash
  }
  #ROOMID_CHECKING
  if %scriptmode = 1 then
  {
    if ((%autoupkeep = "YES") || (%bugout = "YES")) then
    {
      if $roomid = 0 then
      {
        put #mapper reset
        pause 2
        if $roomid = 0 then
        {
          put #flash
          put #play JustArrived
          put #echo %alertwindow Yellow [Upkeep]: Genie has lost track of your room number!
        }
      }
    }
  }
  #STANDING
  if %scriptmode = 1 then
  {
    if $sitting = 1 then gosub STAND
    if $kneeling = 1 then gosub STAND
    if $prone = 1 then gosub STAND
  }
  if %buffingonly != 1 then
  {
    #BLEEDING
    if (($bleeding = 1) && (%scriptmode = 1)) then
    {
      if %auonbleed = "YES" then var goupkeep 1
      if %t > %nextbleed then gosub BLEEDCHECK
    }
    #BURDEN
    if ((%auonburden = "YES") && (%autoupkeep = "YES") && (%scriptmode = 1)) then
    {
      if %t > %nextburdencheck then
      {
        gosub BURDENCHECK
        pause 1
        #echo encumbrance: %encumbrance
        if %encumbrance >= $auburdennum then
        {
          var goupkeep 1
          var autype burden
        }
        var nextburdencheck %t
        math nextburdencheck add 120
      }
    }
    #NERVES
    if ((%autoupkeep = "YES" ) && (%auonnerves = "YES") && (%scriptmode = 1)) then
    {
      if %t > %nextnervecheck then
      {
        var badnerves 0
        action (nerves) on
        gosub HEALTHCHECK
        pause 1
        action (nerves) off
        var nextnervecheck %t
        math nextnervecheck add 120
        if %badnerves = 1 then
        {
          var goupkeep 1
          var autype nerves
          var badnerves 0
        }
      }
    }
    #AUTOUPKEEP
    if ((%autoupkeep = "YES") && (%scriptmode = 1)) then
    {
      if %goupkeep = 1 then
      {
        gosub AUTOUPKEEPLOGIC
      }
    }
    #ALFAR_COMMAND
    if %alfarcommand = 1 then
    {
	    var warriorcommand behavior aggressive
	    gosub COMMANDWARRIOR
	    var alfarcommand 0
	  }
    #TMFOCUS
    if ((%tmfocus = "YES") && (%scriptmode = 1)) then
    {
      if %tmfocusinuse = 1 then
      {
        if matchre ("$righthandnoun", "%tmfocusitem") then
        else
        {
          var stowhand right
          gosub STOW
          gosub GETITEM %tmfocusitem
          gosub TMFOCUSINVOKE
        }
      }
    }
    #COLLECTAMMO
    if %scriptmode = 1 then gosub COLLECTAMMOLOGIC
    #DEAD_MONSTER
    if %scriptmode = 1 then
    {
      gosub MONTEST
      if %tmdead = 1 then
      {
        if %casting = 1 then
        {
          if %tmcast = 1 then gosub RETARGET
        }
        var tmdead 0
      }
      if %eotbrel = "YES" then
      {
        if $SpellTimer.EyesoftheBlind.active = 1 then
        {
          if %t > %nexteotbrel then
          {
            gosub RELEOTB
            var nexteotbrel %t
            math nexteotbrel add 30
          }
        }
      }
      if %aimready = 1 then gosub FIRE
    }
  }
  #BARBARIAN
  if %guild = "Barbarian" then
  {
    gosub BARBLOGIC
    if %wandbuff = "YES" then gosub WANDBUFFING
  }
  #KHRI
  if %guild = "Thief" then
  {
    gosub KHRILOGIC
    if %wandbuff = "YES" then gosub WANDBUFFING
  }
  #SPELL_CANCEL
  if %scancel = 1 then
  {
    var scancel 0
    gosub SPELLCANCEL
  }
  #SPELL_PREPPING
  if %scriptmode = 1 then gosub MAINSPELLLOGIC
  #CASTING
  if %casting = 1 then gosub CASTINGLOGIC
  return

STANDP:
  pause
STAND:
  matchre RETURN You are already standing.|You stand back up.|You stand up in the water.
  matchre STAND The weight of all your possessions prevents you from standing.|You are so unbalanced you cannot manage to stand.
  match RETURN You're unconscious!
  matchre STANDP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  put stand
  matchwait

SITP:
  pause
SIT:
  matchre SITP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You sit down\.|You sit up\.|You are already sitting\.
  put sit
  matchwait

KNEELP:
  pause
KNEEL:
  matchre KNEELP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN Subservient type, eh?|You kneel down upon the ground.|You rise to a kneeling position.|You kneel.
  put kneel
  matchwait

#==============TREASURE==============
NRITUAL:
  if %preserve = "YES" then gosub NPRESERVE
  if %devour = "YES" then
  {
    if $SpellTimer.Devour.active != 1 then
    {
      gosub HEALTHCHECK
      if %healthcheckgood != 1 then
      {
        gosub CASTRESET
        var spellprepping devour
        var prepmana %devourprepmana
        var addmana %devouraddmana
        var spellsymb 0
        var casting 1
        var scancel 0
        var prepped 0
        var charged 0
        var harnessed 0
        gosub DEVOURLOOP
        return
      }
    }
  }  
  if $Skinning.LearningRate > 24 then
  {
    if %dissect = "YES" then
    {
      gosub NDISSECT
      var necroskin 1
    }
    if %harvest = "YES" then
    {
      if $Thanatology.LearningRate != 34 then
      {
        gosub NHARVEST
        var necroskin 1
      }
    }
  }
  return

DEVOURLOOP:
  gosub CASTINGLOGIC
  pause 1
  if %casting != 1 then
  {
    return
  }
  goto DEVOURLOOP


COUNTMATERIAL:
  action (material) var rummagestring $1 when You rummage (.+)
  var rummageitem $storage
  gosub RUMMAGE
  pause .5
  action (material) off
  eval materialnum count("%rummagestring","material")
  return

NDISSECTP:
  pause
NDISSECT:
  matchre NDISSECTP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN Roundtime:|A skinned creature is worthless for your purposes.
  matchre NDISSECTBAD This ritual may only be performed on a creature's corpse.|This ritual may only be performed on a corpse.|A failed or completed ritual has rendered this corpse unusable for your purposes.
  put perform dissect on %monster
  matchwait
  return  

NDISSECTBAD:
  var necroskin 0
  return

NPRESERVEP:
  pause
NPRESERVE:
	matchre NPRESERVEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN This ritual may only be performed on a creature's corpse.|Roundtime:|A skinned creature is worthless for your purposes.|This corpse has already been preserved.|Rituals do not work upon constructs.
  put perform preserve on %monster
  matchwait

NCONSUMEP:
  pause
NCONSUME:
	matchre NCONSUMEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN This ritual may only be performed on a creature's corpse.|Roundtime:|A skinned creature is worthless for your purposes.|Rituals do not work upon constructs.
  put perform consume on %monster
  matchwait

NHARVESTP:
  pause
NHARVEST:
  matchre NHARVESTP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre NHARVESTDISP Roundtime:
  matchre NHARVESTBAD This ritual may only be performed on a creature's corpse.|Rituals do not work upon constructs.|This corpse has already been harvested.|A skinned creature is worthless for your purposes.|A failed or completed ritual has rendered this corpse unusable for your purposes.
  matchre NHARVESTFULL You need a hand free to perform this ritual.
  match NHARVEST2 You cannot harvest useful material
  put perform harvest on %monster
  matchwait
  
NHARVESTFULL:
  gosub STOWALL
  goto NHARVEST 
  
NHARVESTBAD:
  var necroskin 0
  return

NHARVEST2:
  gosub NPRESERVE
  goto NHARVEST

NHARVESTDISP:
  if %harveststore = "YES" then
  {
    gosub COUNTMATERIAL
    if %materialnum > %harveststorenum then goto NHARVESTDROP
    else
    {
      var stowitemname material
      gosub STOWITEM
      return
    }
  }
  else goto NHARVESTDROP

NHARVESTDROPP:
  pause
NHARVESTDROP:
  matchre NHARVESTDROPP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN Having no further use|What were you referring to?|In a moment of foolishness
  put drop material
  matchwait
  
SEARCHP:
  pause
SEARCH:
  if %noloot = "YES" then return
  if matchre ("$roomobjs", "((which|that) appears dead|\(dead\))") then
  {
    matchre RETURN You search|You should probably wait until|You find nothing of interest.|I could not find what you were referring to.
    matchre SEARCH and get ready to search it!
    matchre SEARCHP \.\.\.wait|type ahead|stunned|while entangled in a web\.
    put loot %loottype
    matchwait
  }
  else return

LOOTCHECK:
  if %collectcoin = "YES" then gosub COINGET
  if %savegwethstones = "YES" then gosub GWETHGET
  if %collectgem = "YES" then gosub GEMGET
  if %collectscroll = "YES" then gosub SCROLLGET
  if %collectmaps = "YES" then gosub MAPGET
  if %misckeeplist != "none" then
  {
    eval keeplistnum count("%misckeeplist", "|")
    var miscgetcounter 0
    gosub MISCGET
  }
  return

COINGET:
  if matchre ("$roomobjs", "(coin|coins)") then
  {
    gosub GETITEM coin
    goto COINGET
  }
  else
  {
    return
  }

MISCGETP:
  pause
MISCGET:
  if %miscgetcounter > %keeplistnum then return
  #echo keepitem: %misckeeplist(%miscgetcounter)
  if matchre ("$roomobjs", "%misckeeplist(%miscgetcounter)") then
  {
    if %lootalerts = "YES" then put #echo %alertwindow Yellow [Treasure]: Found a misc item - %misckeeplist(%miscgetcounter)!
    gosub GETITEM %misckeeplist(%miscgetcounter)
    var stowitemname %misckeeplist(%miscgetcounter)
    gosub STOWITEM
  }
  math miscgetcounter add 1
  goto MISCGET  


GEMGETP:
  pause
GEMGET:
  if (matchre ("$roomobjs", "\b(%gems1|%gems2|%gems3|%gems4|%gweths)\b(,|\.| and)")) then
  {
    matchre GEMGETP \.\.\.wait|type ahead|stunned|while entangled in a web\.
    matchre RETURN Stow what?|What were you referring to?
    matchre GEMGET You open your|You put your
    matchre GEMGETBAD You need a free hand to pick that up.
    matchre FULLPOUCH You think the .*gem pouch is too full
    matchre TIEPOUCH You've already got a wealth of gems in there! 
    put stow gem
    matchwait
  }
  return

GEMGETBAD:
  var stowhand left
  gosub STOW
  goto GEMGET

TIEPOUCHP:
  pause
TIEPOUCH:
  matchre TIEPOUCHP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre TIEGEMGET You tie up the gem pouch.|The gem pouch has already been tied off.
  put tie gem pouch
  matchwait

TIEGEMGETP:
  pause
TIEGEMGET:
  if (matchre ("$righthandnoun", "\b(%gems1|%gems2|%gems3|%gems4|%gweths)\b(,|\.| and)")) then
  {
    var stowhand right
    gosub STOW
  }
  if (matchre ("$lefthandnoun", "\b(%gems1|%gems2|%gems3|%gems4|%gweths)\b(,|\.| and)")) then
  {
    var stowhand left
    gosub STOW
  }
  matchre TIEGEMGETP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre GEMGET Stow what?|What were you referring to?
  matchre GEMGET You open your|You put your
  matchre TIEGEMGETBAD You need a free hand to pick that up.
  matchre FULLPOUCH You think the gem pouch is too full
  put stow gem
  matchwait

TIEGEMGETBAD:
  var stowhand left
  gosub STOW
  goto TIEGEMGET

FULLPOUCH:
  gosub STOWALL
  gosub REMITEM gem pouch
  var stowitemname gem pouch
  gosub STOWITEM
  var pouchcount 1
  gosub FINDEMPTYPOUCH
  gosub GETITEM %pouchnum gem pouch
  var wearitemname gem pouch
  gosub WEARITEM
  gosub STOWALL
  return

FINDEMPTYPOUCH:
  matchre BADPOUCH You sort through the contents of the gem pouch and find 500 gems in it.|You'll really need to be holding or wearing
  matchre RETURN You sort through the contents of the gem pouch|gem pouch is empty.
  matchre NOPOUCH I could not find
  if %pouchcount = 1 then var pouchnum first
  if %pouchcount = 2 then var pouchnum second
  if %pouchcount = 3 then var pouchnum third
  if %pouchcount = 4 then var pouchnum fourth
  if %pouchcount = 5 then var pouchnum fifth
  if %pouchcount = 6 then var pouchnum sixth
  if %pouchcount = 7 then var pouchnum seventh
  if %pouchcount = 8 then var pouchnum eighth
  if %pouchcount = 9 then var pouchnum ninth
  put count %pouchnum gem pouch
  matchwait

BADPOUCH:
  math pouchcount add 1
  goto FINDEMPTYPOUCH

NOPOUCH:
  echo ===OUT OF GEM POUCHES===
  put #flash
  put #play Advance
  pause 5
  goto NOPOUCH
  

GWETHGET:
  if (matchre ("$roomobjs", "\b(%gweths)\b(,|\.| and)")) then
  {
    if %savegwethstones = "YES" then
    {
      gosub GETITEM stones
      if %lootalerts = "YES" then put #echo %alertwindow Yellow [Treasure]: Found a gweth stone!
      var putitemname stones
      var putlocation my %storage
      gosub PUTITEM
    }
    if (matchre ("$roomobjs", "\b(%gweths)\b(,|\.| and)")) then goto GEMGET
  }
  return

SCROLLGET:
  if matchre("$roomobjs", ".*(?<!page of )\b(%scrolls)\b(,|\.| and)") then
  {
    var stowitemname $1
    if %lootalerts = "YES" then put #echo %alertwindow Yellow [Treasure]: Found a scroll - %stowitemname!
    gosub STOWITEM
    
  }
  if matchre("$roomobjs", ".*(?<!page of )\b(%scrolls)\b(,|\.| and)") then goto SCROLLGET
  return

MAPGET:
  if matchre ("$roomobjs", "\b(%treasuremaps)\b(,|\.| and)") then
  {
    gosub GETITEM $1
    if %lootalerts = "YES" then put #echo %alertwindow Yellow [Treasure]: Found a treasure map!
    var stowitemname $1
    gosub STOWITEM
  }
  if matchre ("$roomobjs", "\b(%treasuremaps)\b(,|\.| and)") then goto MAPGET
  return

ARRSUB:
  math arrcount subtract 1
  goto ARRANGE

ARRANGEP:
	pause
ARRANGE:
  #echo Arrange count: %arrcount
  #echo Arrange echo badskin %badskin
  pause 1
	if (%arrcount > 0) then
	{
		matchre RETURN You complete|That has already been arranged as much as you can manage.
		match NOSKIN That creature cannot produce skins.
		matchre ARRANGEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
		matchre ARRSUB You begin to arrange|You make a mistake in the|You continue arranging
		matchre BADSKIN You work at|Arrange what\?|You make a serious mistake|has already been skinned\.|cannot be skinned\, so you can't arrange|currently being arranged to produce a skin\,  and cannot be changed\.
		put arrange %arrangetype
		matchwait
	}
	return

NOSKIN:
  var arrangetype
  goto ARRANGE

BADSKIN:
  var badskin 1
  return

SKINNINGP:
	pause
SKINNING:
  matchre RETURN You can't skin something that's not dead!|but end up destroying the skin.|You carefully fit|renders your skinning attempt|You hideously bungle|You make a series of cuts|cannot be skinned|I don't know|twists and slips in your grip|You claw wildly|Skin what?|You manage to slice it to dripping tatters.
	match SKINSTOW You must have one hand free to skin.
	matchre SKINNINGP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	matchre RETURN Roundtime: \d+
	put skin
	matchwait

PACKSTOW:
  gosub STOWALL
  return

SKINSTOW:
  gosub STOWALL
  goto SKINNING

BUNDLESWAP:
  if %dropskins = "YES" then
  {
    if %hand = "left" then var dumpitemname $righthandnoun
    else var dumpitemname $lefthandnoun
    gosub DUMPITEM
    return
  }
  if tolower("%weapon%currentweapon") != "brawl" then 
  {
    if %hand = "left" then 
    {
      if $lefthand != "Empty" then
      {
        var stowhand left
        gosub STOW
      }
    }
    else 
    {
      if $righthand != "Empty" then
      {
        var stowhand right
        gosub STOW
      }
    }
  }
  return

BUNDLETIEP:
  pause
BUNDLETIE:
  matchre BUNDLETIEP 	\.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre BUNDLETIE Once you've tied off your bundle
  matchre RETURN Using the length of the rope|But this bundle has already been tied off!|Tie what?
  #matchre BUNDLEMAKE Tie what?
  put tie my bundle
  matchwait

BUNDLEMAKEP:
	pause
BUNDLEMAKE:
  gosub GETITEM bundling rope
  pause 2
  if ((matchre("$righthandnoun", "rope")) || (matchre("$lefthandnoun", "rope"))) then
  {
	  matchre BUNDLEMAKEP \.\.\.wait|type ahead|stunned|while entangled in a web\. 
	  match RETURN You bundle up
	  matchre BUNDLEBAD That's not going to work.|What were you referring to?
	  put bundle
	  matchwait
	}
	else goto NOROPE
	
BUNDLEBAD:
  gosub STOWALL
  return

NOROPE:
  put #echo Yellow Alarm: Attention Needed - Out of bundling ropes!
  put #flash
  put #play Advance
  pause 5
  goto NOROPE
  
BUNDLEADJUSTP:
  pause
BUNDLEADJUST:
  matchre BUNDLEADJUSTP \.\.\.wait|type ahead|stunned|while entangled in a web\. 
  matchre RETURN You adjust your tight bundle so that you can more easily
  matchre BUNDLEADJUST You adjust your tight bundle to make it neat and compact
  put adjust bundle
  matchwait

#==============SPELLCASTING============== 

NSAFETYCHECK:
  var necrogood 1
  if $roomplayers != "" then 
  {
    var roomplayers $roomplayers
    gosub RPLAYERSCRUB
    var rcounter 0
    eval nsafenum count("%necrowhitelist", "|")
    eval rplayernum count("%roomplayers", "|")
    #TURNING_TO_LOWERCASE
    eval roomplayers tolower("%roomplayers")
    eval necrowhitelist tolower("%necrowhitelist")
    gosub RPLAYERSORT
    if %roomplayers != "" then
    {
      echo Not engaging in spellcasting for Necro Safety!  Players are in the room!
      echo Roomplayers: %roomplayers
      var necrogood 0       
    }
  }
  return	
	
RPLAYERSCRUB:
  eval roomplayers replace("%roomplayers", " and ", ", "
  eval roomplayers replace("%roomplayers", ", ", "|"
  eval roomplayers replace("%roomplayers", "Also here: ", "")
  eval roomplayers replace("%roomplayers", ".", "")
  eval roomplayers replace("%roomplayers", " who is hiding", "")
  eval roomplayers replace("%roomplayers", " who is sitting", "")
  eval roomplayers replace("%roomplayers", " who is kneeling", "")
  eval roomplayers replace("%roomplayers", " who is lying down", "")
  eval roomplayers replace("%roomplayers", " who is stunned", "")
  eval roomplayers replace("%roomplayers", " who is immobilized", "")
  eval roomplayers replace("%roomplayers", " who is webbed", "")
  eval roomplayers replace("%roomplayers", " (sitting)", "")
  eval roomplayers replace("%roomplayers", " (kneeling)", "")
  eval roomplayers replace("%roomplayers", " (prone)", "")
  
  #PRETITLE_REMOVAL
  eval roomplayers replace("%roomplayers", "'", ""
  eval roomplayers replacere("%roomplayers", "([A-Z][a-z]+) ([A-Z][a-z]+) ([A-Z][a-z]+)", "\$3")
  eval roomplayers replacere("%roomplayers", "([A-Z][a-z]+) ([A-Z][a-z]+)", "\$2")
  #POSTFIX_REMOVAL
  eval roomplayers replacere("%roomplayers", ".who is .*\|", "|")
  eval roomplayers replacere("%roomplayers", ".who is.*", "")
  return
	
RPLAYERSORT:
  if %rcounter > %nsafenum then return
  if %rplayernum > 0 then eval roomplayers replace("%roomplayers", "%necrowhitelist(%rcounter)|", "")
  else eval roomplayers replace("%roomplayers", "%necrowhitelist(%rcounter)", "")
  }
  math rcounter add 1
  goto RPLAYERSORT

CASTINGLOGIC:
  if %necrosafety = "YES" then
  {
    gosub NSAFETYCHECK
    if %necrogood != 1 then return
  }
  if %prepped != 1 then
  {
    if %straightcast = "YES" then
    {
      #echo AM - Arcanalock: %arcanalock    Arcana.LearningRate: $Arcana.LearningRate
      #echo AM - Attunelock: %attunelock    Attunement.LearningRate: $Attunement.LearningRate
      if ((%attunelock = 1) && (%arcanalock = 1)) then
      {
        #echo Straight casting!
        math prepmana add %addmana
        var addmana 0
      }
    }
    if $concentration > %minconcentration then
    {
      if %tmcast = 1 then gosub PREPTAR
      else gosub PREP
    }
  }
  if %prepped = 1 then
  {
    if contains("%rituals", "|%spellprepping|") then
    {
      if %invoked != 1 then
      {
        gosub RITUAL
      }
    }
    if %charged != 1 then
    {
      if %cambtapped > 0 then
      {
        if %t > %cambtapped then gosub CHARGE
      }
      else
      {
        gosub ARRANGEMANA
        gosub CHARGE
      }
    }
  }
  if %ready = 1 then 
  {
    if %cambtapped = 0 then
    {
      #echo spellsymb: %spellsymb
      if %spellsymb = 1 then
      {
        #echo symbiosis: %symbiosis
        if %symbiosis = 0 then gosub SYMBIOSIS
      }
      else
      {
        if %symbiosis = 1 then gosub RELSYMBIOSIS
      }
      gosub CAST
    }
  }
  else
  {
    var preptimetest %t
    math preptimetest subtract %preptime
    if %preptimetest > 300 then gosub SPELLCANCEL
  }
  return

ARRANGEMANA:
  var harnmana 0
  var cambmana 0
  #Lock_checking
  if %buffingonly != 1 then
  {
    if $Arcana.LearningRate < 20 then var arcanalock 0
    if $Arcana.LearningRate > 31 then var arcanalock 1
    if $Attunement.LearningRate < 20 then var attunelock 0
    if $Attunement.LearningRate > 31 then var attunelock 1
  }
  else
  {
    var attunelock 0
    var arcanalock 0
  }
  #Arrange_logic
  if %harnessing = "YES" then
  {
    if %cambrinth = "NO" then
    {
      var harnmana %addmana
      return
    }
    if %arcanalock = 1 then var harnmana %addmana
    else
    {
      if %addmana > %totalcamb then
      {
        var cambmana %totalcamb
        var harnmana %addmana
        math harnmana subtract %totalcamb
        #echo harnmana: %harnmana
        #echo cambmana: %cambmana
      }  
      else var cambmana %addmana 
    }
  }
  else
  {
    if %cambrinth = "YES" then
    {
      if %addmana <= %totalcamb then var cambmana %addmana
      else var cambmana %totalcamb
    }
  }
  return


PREPP:
	pause
PREP:	
  if %tmcast = 1 then goto PREPTAR
	if %tattoocast = 1 then goto PREPTATTOO
	var preptime %t
	var prepped 1
	var casting 1
  matchre PREPP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	matchre BADHEAVYTM You are still too fatigued from your previous efforts to manifest another major feat of offensive magic.
	matchre RETURN You trace a|You raise your|You raise an|You begin chanting|With rigid|With meditative|With calm|With tense|You mutter|You briskly utter a few sharp words|Darkly gleaming motes of
	matchre RETURN You begin to hum|You begin your enchante|The first gentle notes|With a sharp cut to your voice|Low, hummed tones form|You begin to chant a mesmerizing|With a resounding "POP"|You begin to sing, a gentle|Wrapped in winter|You weave a soft|Slow, rich tones|Though softly humming|In a low tone you|The wailing of lost souls|Turning your focus solemnly inward|You hear the slow, rich tones of|as you trace your finger along mana|Images of streaking stars falling from the heavens flash across your vision|With great force, you slap your hands together
	matchre PREPREL you're already preparing|You have already fully prepared|You are already preparing
	#match BADPREP You feel intense strain
	match PREPPLAYING You should stop playing before you do that.
	if %prepmana != 0 then put prep %spellprepping %prepmana
	else put prep %spellprepping
	matchwait	

PREPREL:
  gosub RELSPELL
  goto PREP
  #gosub CASTRESET
  #if %symbiosis = 1 then gosub RELSYMBIOSIS
  #return

PREPPLAYING:
  gosub PLAYSTOP
  goto PREP

BADHEAVYTM:
  gosub RELSPELL
  gosub CASTRESET
  return

PREPTATTOOTM:
  gosub PREPTATTOO
  
  return

PREPTATTOOP:
  pause
PREPTATTOO:
	var preptime %t
	var prepped 1
	var casting 1
  matchre PREPTATTOOP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN Closing your eyes, you carefully bend some mana streams
  matchre BADTATTOO Invoke what?
  matchre PREPTATTOOUNHIDE You cannot use the tattoo while maintaining the effort to stay hidden.
  put invoke tattoo
  matchwait
  
PREPTATTOOUNHIDE:
  gosub UNHIDE
  goto PREPTATTOO

BADTATTOO:
  put #echo %alertwindow Tried to invoke a tattoo, but did not have one!  Turning off variable.
  var tattoobuff NO
  put #var tattoobuff NO
  return

WANDINVOKEP:
  pause
WANDINVOKE:
  var wandinvokegood 1
  matchre WANDINVOKEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN A good positive attitude never hurts\.|The world around you seems to slow as the spell grips your mind\.|The spell pulses through your soul, rekindling your holy rage\.
  matchre WINVOKEBAD ^The \w+ remains inert\.|You are in no condition to do that\.
  put invoke %invokeitemname
  put yes
  matchwait

WINVOKEBAD:
  var wandinvokegood 0
  return

PREPTARP:
	pause
PREPTAR:
	if %tattoocast = 1 then gosub PREPTATTOO
	var cambcharge 0
	var prepped 1
	var casting 1
	var preptime %t
  matchre SPELLCANCEL You are not engaged to anything, so you must specify a target to focus on!|You cannot target
	matchre RETURN You begin to weave mana lines into
	matchre PREPTARREL you're already preparing|You have already fully prepared|You are already preparing
	#match SPELLCANCEL You feel intense strain
	matchre PREPTARP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	matchre PREPTARP Your desire to prepare this offensive spell suddenly slips away.
	if %tattoocast = 1 then put target
	else
	{
	  if %ctoverride = 1 then put target %spellprepping %prepmana %ctoverridevar
	  else put target %spellprepping %prepmana
	}
	matchwait

PREPTARREL:
  gosub RELSPELL
  goto PREPTAR

RETARGETP:
  pause
RETARGET:
  matchre RETARGETP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETARGETP Your desire to prepare this offensive spell suddenly slips away.
  matchre SPELLCANCEL You are not engaged to anything, so you must specify a target to focus on!|You must be preparing a spell in order to target it!
  matchre RETURN You begin to weave mana lines into|Your target pattern is already around|You cannot target|You are already preparing an area target pattern!
  put target
  matchwait

BADPREP:
  if contains("%rituals", "|%spellprepping|") then return
  goto SPELLCANCEL

SPELLCANCEL:
  if %harnmana > 0 then gosub RELMANA
  if $preparedspell != "None" then gosub RELSPELL
  gosub CASTRESET
  return

CHARGE:
  if %cambmana = 0 then
  {
    var charged 1
    return
  }
  if %cambtapped > 0 then
  {
    if %t > %cambtapped then
    {
      goto CHARGELOOP
    }
    else return
  }
  #CAMBRINTH_DEVICE_SPLITTING
  if %cambmana > %totalcamb then var cambmana %totalcamb
  if %cambmana > %cambitem1mana then
  {
    var cambnumber 2
    var cambmodulus %cambmana
    math cambmodulus modulus 2
    var cambmana1 %cambmana
    math cambmana1 subtract %cambmodulus
    math cambmana1 divide 2
    var cambmana2 %cambmana1
    math cambmana1 add %cambmodulus
    var cambnumber 2
    if %cambmana1 > %cambitem1mana then
    {
      var cambmana1 %cambitem1mana
      var cambmana2 %cambmana
      math cambmana2 subtract %cambmana1
    }
    if %cambmana2 > %cambitem2mana then
    {
      var cambmana2 %cambitem2mana
      var cambmana1 %cambmana
      math cambmana1 subtract %cambmana2
    }  
  }
  else
  {
    var cambnumber 1
    var cambmana1 %cambmana
    var cambmana2 0
  }
  #echo cambmana1: %cambmana1
  #echo cambmana2: %cambmana2
  var cambnumbercount 1
  #echo cambnumber: %cambnumber
  gosub CHARGESPLIT
  var cambcount 1
  var splitcount 1
  var invokecount 1
  goto CHARGELOOP
  
CHARGESPLITLOOP:
  var cambsplitting %cambmana%cambnumbercount
  math cambsplitting divide %splitcounter
  if %cambsplitting <= %chargemax then
  {
    var cambitem%cambnumbercountsplit %splitcounter
    var cambitem%cambnumbercountmod %cambmana%cambnumbercount
    math cambitem%cambnumbercountmod modulus %splitcounter
    var camb%cambnumbercountsplit1 %cambmana%cambnumbercount
    math camb%cambnumbercountsplit1 subtract %cambitem%cambnumbercountmod
    math camb%cambnumbercountsplit1 divide %splitcounter
    #echo cambitem%cambnumbercountsplit: %cambitem%cambnumbercountsplit
    var splitcounter2 2
    var ctotal%cambnumbercount 0
    gosub CHARGESPLITLOOP2
    return
  }
  else
  {
    math splitcounter add 1
    goto CHARGESPLITLOOP
  }

CHARGESPLITLOOP2:
  if %splitcounter2 > %splitcounter then
  { 
    math camb%cambnumbercountsplit1 add %cambitem%cambnumbercountmod
    math ctotal%cambnumbercount add %camb%cambnumbercountsplit1
    #echo camb%cambnumbercountsplit1: %camb%cambnumbercountsplit1
    return
  }
  var camb%cambnumbercountsplit%splitcounter2 %camb%cambnumbercountsplit1
  math ctotal%cambnumbercount add %camb%cambnumbercountsplit%splitcounter2
  #echo camb%cambnumbercountsplit%splitcounter2: %camb%cambnumbercountsplit%splitcounter2
  math splitcounter2 add 1
  goto CHARGESPLITLOOP2
  

CHARGESPLIT:
  if %cambnumbercount > %cambnumber then return
  var cambitems %cambnumbercount
  if %cambmana%cambnumbercount > %chargemax then
  {
    var splitcounter 2
    gosub CHARGESPLITLOOP
  }
  else
  {
    var ctotal%cambnumbercount %cambmana%cambnumbercount
    var cambitem%cambnumbercountsplit 0
  }
  math cambnumbercount add 1
  goto CHARGESPLIT


CHARGELOOPP:
  pause
CHARGELOOP:
  if %cambcount > %cambitems then goto INVOKE
  if %cambitem%cambcountsplit > 1 then
  {
    if %splitcount > %cambitem%cambcountsplit then
    {
      math cambcount add 1
      var splitcount 1
      goto CHARGELOOP
    }
  }
  if %cambitem%cambcountworn = "NO" then
  {
    if ((matchre ("$righthandnoun", "%cambitem%cambcount")) || (matchre ("$lefthandnoun", "%cambitem%cambcount"))) then
    else
    {
      gosub GETITEM %cambitem%cambcount
    }
  }
  var cambtapped 0
  matchre CHARGELOOPP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre CHARGESUCC You are able to channel|How much do you want to charge
  matchre CHARGEFAIL You fail to channel
  matchre CAMBREM Try though you may|You'll have to hold it, set it
  matchre CAMBTAP You strain
  #echo cambcount: %cambcount
  #echo splitcount: %splitcount
  if %cambitem%cambcountsplit > 1 then put charge my %cambitem%cambcount %camb%cambcountsplit%splitcount
  else put charge my %cambitem%cambcount %cambmana%cambcount
  matchwait

CHARGEFAIL:
  put #echo Yellow Alarm: Attention Needed - Cambrinth amount is more than your skill can support!
  put #flash
  put #play Advance
  pause 5
  goto CHARGEFAIL

CHARGESUCC:
  if %cambitem%cambcountsplit > 1 then
  {
    math cambcharge add %camb%cambcount%splitcount
    math cambcharge%cambcount add %camb%cambcount%splitcount
    if %splitcount > %cambitem%cambcountsplit then
    {
      math cambcount add 1
      var splitcount 1
      if %cambitem%cambcountworn = "NO" then
      {
        var stowitemname %cambitem%chargecount
        gosub STOWITEM
      }
    }
    else
    {
      math splitcount add 1
      goto CHARGELOOP
    }
  }
  else
  {
    math cambcharge add %cambmana%cambcount
    math cambcharge%cambcount add %cambmana%cambcount
    math cambcount add 1
    var splitcount 1
    if %cambitem%cambcountworn = "NO" then
    {
      var stowitemname %cambitem%chargecount
      gosub STOWITEM
    }
  }
  goto CHARGELOOP

CAMBREM:
  gosub REMITEM %cambitem%cambcount
  goto CHARGELOOP

CAMBSTOW:
  gosub STOWALL
  goto CAMBREM

INVOKEP:
  pause
INVOKE:
	if %cambitem%invokecountworn = "NO" then
  {
    if ((matchre ("$righthandnoun", "%cambitem%invokecount")) || (matchre ("$lefthandnoun", "%cambitem%invokecount"))) then
    else
    {
      gosub GETITEM %cambitem%invokecount
    }
  }
	matchre INVOKEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	matchre INVOKESUCC You reach for its center|Your link to|dim, almost magically null.
	matchre INVOKEREM Try though you may
	#echo ctotal%invokecount: %ctotal%invokecount
	if %dedicatedcambrinth != "YES" then put invoke %cambitem%invokecount %ctotal%invokecount
	else put invoke %cambitem%invokecount %ctotal%invokecount spell
	matchwait

INVOKESUCC:
  if %cambitem%tempcountworn = "NO" then
  {
    if ((matchre ("$righthand", "%cambitem%invokecount")) || (matchre ("$lefthand", "%cambitem%invokecount"))) then
    {
      var stowitemname %cambitem%invokecount
      gosub STOWITEM
    }
  }
  else
  {
    if ((matchre ("$righthand", "%cambitem%invokecount")) || (matchre ("$lefthand", "%cambitem%invokecount"))) then
    {
      var wearitemname %cambitem%invokecount
      gosub WEARITEM
    }
  }
  if %cambnumber > %invokecount then
  {
    math invokecount add 1
    goto INVOKE
  }
  else
  {
    var charged 1
    RETURN
  }

INVOKEREM:
  gosub REMITEM %cambitem%invokecount
  goto INVOKE


RITUAL:
  gosub STOWALL
  gosub GETITEM %ritualfocus
  gosub RITUALINVOKE
  gosub STOWALL
  return

RITUALINVOKEP:
  pause
RITUALINVOKE:
  var invoked 1
  matchre RITUALINVOKEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You must begin preparing a ritual spell|You make sweeping gestures|Invoke what?|toward the sky and will the mana streams|toward the ceiling and will the mana streams|Kneeling down, you draw|reverently above your head and steadily harness mana streams through it.
  matchre RITUALINVIS Magical rituals are exceedingly obvious.  You cannot do it while remaining hidden.
  put invoke %ritualfocus
  matchwait

RITUALINVIS:
  gosub RELINVIS
  goto RITUALINVOKE
  
TMFOCUSINVOKEP:
  pause
TMFOCUSINVOKE:
  matchre TMFOCUSINVOKEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN Roundtime:|Invoke what?|
  put invoke %tmfocusitem
  matchwait

SYMBIOSISP:
  pause
SYMBIOSIS:
  matchre SYMBIOSISP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You recall the exact details|But you've already prepared
  put prepare symbiosis
  matchwait

PREPSYMBIOSISP:
  pause
PREPSYMBIOSIS:
  matchre PREPSYMBIOSISP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN But you've already prepared the|You recall the exact details of the 
  put prepare symbiosis
  matchwait

RELSYMBIOSISP:
  pause
RELSYMBIOSIS:
  matchre RELSYMBIOSISP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN But you haven't prepared a symbiosis!|You pause for a moment|Are you sure you'd lke to remove the
  put release symbiosis
  matchwait

HARNESS:
  if %harnmana = 0 then
  {
    var harnessed 1
    return
  }
  if %harntapped > 0 then
  {
    if %t > %harntapped then
    {
      goto HARNLOOP
    }
    else return
  }
  if %harnmana > %harnessmax then
  {
    var hsplitcounter 1
    gosub HARNSPLITLOOP
  }
  else
  {
    var harnnumber 1
    var harnmana1 %harnmana
  }
  var harncount 1
  goto HARNLOOP

HARNSPLITLOOP:
  var harnsplitting %harnmana
  math harnsplitting divide %hsplitcounter
  if %harnsplitting <= %harnessmax then
  {
    var harnnumber %hsplitcounter
    var harnmanamod %harnmana
    math harnmanamod modulus %hsplitcounter
    var harnmana1 %harnmana
    math harnmana1 subtract %harnmanamod
    math harnmana1 divide %hsplitcounter
    var hsplitcounter2 2
    gosub HARNSPLITLOOP2
    return
  }
  else
  {
    math hsplitcounter add 1
    goto HARNSPLITLOOP
  }

HARNSPLITLOOP2:
  if %hsplitcounter2 > %hsplitcounter then
  { 
    math harnmana1 add %harnmanamod
    #echo Harnmana1: %harnmana1
    return
  }
  var harnmana%hsplitcounter2 %harnmana1
  #echo harnmana%hsplitcounter2: %harnmana%hsplitcounter2
  math hsplitcounter2 add 1
  goto HARNSPLITLOOP2

HARNLOOPP:
  pause 1
HARNLOOP:
  var harntapped 0
  if %harncount > %harnnumber then return
  matchre HARNLOOP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  match HARNSUCC You tap into the mana
  match HARNTAP Strain though you may
  put harness %harnmana%harncount
  matchwait

HARNSUCC:
  var harnessed 1
  math harncount add 1
  goto HARNLOOP

HARNTAP:
  if %harnnumber >  1 then
  {
    if %harncount = 2 then 
    {
      #echo harnmana%harncount: %harnmana%harncount
      math harnmana subtract %harnmana%harncount
    }
    else var harnmana 0
    var harnessed 1
  }
  else
  {
    var harntapped %t
    math harntapped add 5
  }
  return

SAHARNESSP:
  pause
SAHARNESS:
  matchre SAHARNESSP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN Roundtime
  put harness %harnessamount
  matchwait

CASTP:
	pause
CAST:
  if %harnmana > 0 then
  {
    if %harnessed = 0 then
    {
      gosub HARNESS
      pause
    }
  }
  var casttarget
  if %spellprepping = "sap" then var casttarget augmentation
  if %spellprepping = "bless" then
  {
    if $righthandnoun = "wine" then var casttarget wine
  }
  if %spellprepping = "devour" then
  {
    if matchre ("$roomobjs", "(\w+) ((which|that) appears dead|\(dead\))") then
	  {
	    var monster $1
	    gosub NCONSUME
	  }
	  else
	  {
      if ((matchre("$righthandnoun", "material")) || (matchre("$lefthandnoun", "material"))) then 
      else
      {
        if (($righthand != "Empty") && ($lefthand != "Empty")) then
        {
          var stowhand right
          gosub STOW
        }
        gosub GETITEM material
        if ((matchre("$righthandnoun", "material")) || (matchre("$lefthandnoun", "material"))) then 
        else
        {
          var scancel 1
          return
        }
      }
	  }
  }
  if %spellprepping = "ignite" then
  {
    if %ctoverride != 1 then
    {
      if $righthand != "Empty" then var irighthandnoun $righthandnoun
      else var irighthandnoun ----
      if $lefthand != "Empty" then var ilefthandnoun $lefthandnoun
      else var ilefthandnoun ----
      #echo IgniteWeapons: %igniteweapon
      #echo Righthand: %irighthandnoun
      #echo Lefthand: %ilefthandnoun
      if ((matchre ("%igniteweapon", "%irighthandnoun")) || (matchre ("%igniteweapon", "%ilefthandnoun"))) then
      {
        if (matchre ("%igniteweapon", "%irighthandnoun")) then
        {
          #echo Right hand!
          var casttarget $righthand
        }
        else
        {
          #echo Left hand!
          var casttarget $lefthand
        }
      }
      else
      {
        #echo Ignite: Grabbing a weapon to cast on.
        var ignitestow 1
        gosub GETITEM %ignitebackup
        var casttarget %ignitebackup
      }
      if $SpellTimer.Ignite.active = 1 then
      {
        gosub RELIGNITE
        #if %lastignite != %casttarget then waitfor The flames dancing
        #var lastignite %casttarget
      }
    }
    else if $SpellTimer.Ignite.active = 1 then gosub RELIGNITE
  }
  if %spellprepping = "hyh" then var casttarget male offense
  if %spellprepping = "om" then var casttarget orb
  if %spellprepping = "shadowling" then put release shadowling
  if %spellprepping = "tks" then
	{
    if matchre ("$roomobjs", "%tktitem") then
    {
    }
    else
    {
      gosub GETITEM %tktitem
      var dumpitemname %tktitem
      gosub DROPITEM
    }
  }
  if %cycliccast = 1 then
	{
	  var nextcyc %t
    math nextcyc add 300
	}
	if %debilcast = 1 then
	{
	  var casttarget creature  
	  if %spellprepping = "pv" then var casttarget
		if %spellprepping = "rend" then var casttarget %rendtarget
	}
  if %othercast != 0 then
 	{
 	  var casttarget %othercast
 	}
 	if %tmcast = 1 then
 	{
 	  var casttarget
 	  if $SpellTimer.AetherCloak.active = 1 then
	  {
	    var currentcyc 0
	    var nextcyc 0
	    put rel ac
	  }
	  if %spellprepping = "acs" then var casttarget
	  var deadcheck 1
	}
 	if %spellprepping = "etf" then var casttarget electricity
  if %spellprepping = "col" then
  {
    if $Time.isKatambaUp = 1 then var casttarget katamba
	  else
	  {
	    if $Time.isXibarUp = 1 then var casttarget xibar
	     else
	     {
	       if $Time.isYavashUp = 1 then var casttarget yavash
	       else var casttarget
      }
    }
  }
  if %spellprepping = "hyh" then var casttarget %hyhcast
	if %spellprepping = "hw" then var casttarget chest  
	if %spellprepping = "iots" then
	{
	  gosub RELIOTS
	  #echo %verena|%szeldia|%dawgolesh|%merewalda
	  if %verena = 1 then
	  {
	    var casttarget verena
	  }
	  else
	  {
	    if %szeldia = 1 then
	    {
	      var casttarget szeldia
	    }
	    else
	    {
	      if %dawgolesh = 1 then
	      {
	        var casttarget dawgolesh
	      }
	      else
	      {
	        if %merewalda = 1 then
	        {
	          var casttarget merewalda
	        }
	      }
	    }
	  }
	}
  matchre CASTP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	matchre CASTCLEANUP You gesture.|You gesture at|You wave your hand|With a wave of your hand|You roll your hands in an elliptical|You clasp your hands together|You cup your hand before|You clap your hands once|Your spell|You press your fist|You reach with your fist toward the ground.|You speak a few words of righteousness|You whisper|Tendrils of flame|You make a holy gesture|You close your eyes and take several slow|You clench your hands into fists and grit your teeth|You don't think you can manage to ignite another weapon at the moment.|The flames dancing along your fingertips|Mentally steeling yourself in preparation for|You shudder involuntarily|You release an accompaniment of elemental|You thrust your (right|left) arm before you, fingers splayed.|With a wave of your hand, your vitality is fully restored\.|You strike your heel against the ground|A sense of calm focus|Roundtime|Your heart skips a beat as your spell|You clench your fists, pressing your fingernails painfully into your flesh\.
	matchre BADCAST Currently lacking the skill|You don't have a spell prepared!|Your target pattern dissipates because|You can't cast that on anyone else!|You strain, but are too|The spell pattern resists the influx|I could not find what you were referring to.|You must specify one of the thirteen planets.|The spell pattern resists the influx of .* mana and fails completely\.
	#match CASTFACE You can't cast that at yourself!
	#matchre CASTLOOT is already dead, so that's a bit pointless.
	match CASTCLEANUP You can't cast that at yourself!
	matchre CASTCLEANUP is already dead, so that's a bit pointless.
	if %ctoverride = 1 then var casttarget %ctoverridevar
	if %omcast = 1 then put touch orb
	if %omcast != 1 then put cast %casttarget
	matchwait

CASTLOOT:
  gosub SEARCH
  goto CAST
	
BADCAST:
  #put #flash
  #put #play Echo
  #put #echo Yellow Alarm: Bad cast via Sub!
	if $preparedspell != "None" then gosub RELSPELL
  if %harnmana > 0 then gosub RELMANA
	goto CASTRESET

CASTCLEANUP:
  if ((%pcast = 1) || (%kcast = 1)) then goto CASTCLEANUPSIMPLE
  goto CASTCLEANUPMAIN

CASTCLEANUPSIMPLE:
  if %spellprepping = "shadowling" then gosub INVOKESHADOW
  if %spellprepping = "iots" then put invoke circle
	if %spellprepping = "mab" then
	{
	  send prep cantrip r s
	  send gesture ballista
	  pause 1
	  gosub MABRUB
	}
	if %astralcast = 1 then return
  if %multicast = 1 then goto MULTICASTRESET
  if %kcast = 1 then return
  goto END

CASTCLEANUPMAIN:
  if %badcast = 1 then
  {
    #put #flash
    #put #play Echo
    #put #echo Yellow Alarm: Bad cast via Trigger!
    if %harnmana > 0 then gosub RELMANA
    goto CASTRESET
  }
  if %symbiosis = 1 then
  {
    gosub PREPSYMBIOSIS
    gosub RELSYMBIOSIS
  }
  if $Attunement.LearningRate > 33 then var attunelock 1
  if $Arcana.LearningRate > 33 then var arcanalock 1
  if %spellprepping = "db" then var dbready 1
	if %spellprepping = "ignite" then
	{
	  if %buffing != 1 then gosub RELIGNITE
	  if %ignitestow = 1 then
	  {
	    var ignitestow 0
	    var stowitem %ignitebackup
	    gosub STOWITEM
	  }
	}
	
	if %spellprepping = "abs" then
  {
    if %postbuffperc != "YES" then gosub PERC
	}
	if %spellprepping = "aus" then
	{
	  if %postbuffperc != "YES" then gosub PERC
	}
	if %spellprepping = "col" then
	{
	  if %postbuffperc != "YES" then gosub PERC
	}
	if %spellprepping = "iots" then
	{
	  put invoke circle
	  if %postbuffperc != "YES" then gosub PERC
	}
  if %spellprepping = "lgv" then
	{
	  if %postbuffperc != "YES" then gosub PERC
	}
  if %spellprepping = "mab" then
	{
	  send prep cantrip r s
	  send gesture ballista
	  pause 1
	  gosub MABRUB
	}
  if %spellprepping = "shadowling" then
	{
	  gosub INVOKESHADOW
	  if %postbuffperc != "YES" then gosub PERC
	}
	if %spellprepping = "tks" then
	{
  	gosub GETITEM %tktitem
    var stowitemname %tktitem
    gosub STOWITEM
	}
	#gosub CASTINGSUMMARY
	gosub CASTRESET
	if %buffing = 1 then
	{
	  if %postbuffperc = "YES" then gosub PERC
	}
	return
	
CASTINGSUMMARY:
  echo ===Spell Information===
  echo Spellprepping: %spellprepping
  if %spellsymb = "YES" then echo Symbiosis: YES
  if %tmcast = 1 then echo TM Cast: YES
  if %debilcast = 1 then echo Debil Cast: YES
  if %cycliccast = 1 then echo Cyclic Cast: YES
  echo --Prepmana: %prepmana     --Cambmana: %cambmana    --Harnmana: %harnmana
  echo --Cambcharge1: %cambcharge1    --Cambcharge2: %cambcharge2     --Totalcharge: %cambcharge
  echo
  return
	
CASTRESET:
	var cambcharge 0
  var cambcharge1 0
  var cambcharge2 0
  var ready 0
  var prepped 0
  var charged 0
  var invoked 0
  var harnessed 0
  var spellprepping
  var prepmana 0
  var cambmana 0
  var harnmana 0
  var harntapped 0
  var cambmana1 0
  var cambmana2 0
  var tattoocast 0
  var tmcast 0
  var debilcast 0
  var cycliccast 0
  var casting 0
  var othercast 0
  var spellsymb 0
  var cambtapped 0
  var cambsplitting 0
  var splittingmana 0
  var splitcount 0
  var multicast 0
  var badcast 0
  var scancel 0
  var ctoverride 0
  var omcast 0
  return
	
CASTFACE:
  var castfacecheck 1
  gosub FACE
  if %badface = 1 then
  {
    var badface 0
    return
  }
  var castfacecheck 0
  goto CAST

CAMBTAP:
  var cambtapped %t
  math cambtapped add 5
  return

tapped:  
  gosub RELSPELL
	gosub CASTRESET
  return

RELSPELLP:
	pause
RELSPELL:
	matchre RELSPELLP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	matchre RETURN You let your concentration|You aren't preparing a spell.
	put release spell
	matchwait

RELALLP:
	pause
RELALL:
  if ((%guild = "Barbarian") || (%guild = "Thief")) then return
	var nextcyc 0
	var currentcyc 0
	gosub CASTRESET
	matchre RELALLP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	matchre RETURN You let your concentration|You aren't preparing a spell.|You aren't harnessing any mana.|You have no cyclic spell active to release.
	put release all
	matchwait

RELMANAP:
	pause
RELMANA:
	matchre RELMANAP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	matchre RETURN You release all the streams|You aren't harnessing any mana.|You release your connection
	put release mana
	matchwait

RELEOTBP:
	pause
RELEOTB:
	matchre RELEOTBP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	matchre RETURN Your corruption fades, revealing you to the world once more.|Release what?
	put release eotb
	matchwait

RELRFP:
	pause
RELRF:
	matchre RELRFP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	matchre RETURN The refractive field surrounding you fades away\.|Release what?
	put release rf
	matchwait

RELIOTSP:
	pause
RELIOTS:
	matchre RELIOTSP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	matchre RETURN You feel the energy of|Release what?
	put release iots
	matchwait

RELCYCLICP:
	pause
RELCYCLIC:
	if %guild = "Barbarian" then return
	if %guild = "Thief" then return
	if %guild = "Necromancer" then
	{
	  if %necrosafety = "YES" then
	  {
	    if $SpellTimer.RiteofGrace.active = 1 then return
	  }
	}
	var nextcyc 0
	var currentcyc 0
	matchre RELCYCLICP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	match RETURN You have no cyclic spell active to release.
  put release cyclic
	matchwait .5
	goto RELCYCLIC2

RELCYCLIC2P:
	pause
RELCYCLIC2:
	matchre RELCYCLIC2P \.\.\.wait|type ahead|stunned|while entangled in a web\.
	match RETURN You have no cyclic spell active to release.
	put release cyclic
	matchwait 2
	return

RELINVIS:
  if $SpellTimer.StepsofVuan.active = 1 then
  {
    var invisspell sov
    gosub RELINVISSPELL
  }
  if $SpellTimer.RefractiveField.active = 1 then
  {
    var invisspell rf
    gosub RELINVISSPELL
  }
  return
  
RELIGNITEP:
  pause
RELIGNITE: 
  matchre RELINVISP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	matchre RETURN The warm feeling in your hand goes away.|Release what?
	put release ignite
	matchwait

RELINVISSPELLP:
  pause
RELINVISSPELL: 
  matchre RELINVISP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	matchre RETURN The refractive field surrounding you fades away.|Release what?
	put release %invisspell
	matchwait


BALLISTALOADP:
  pause
BALLISTALOAD:
  matchre BALLISTALOADP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	matchre RETURN Roundtime|The earthen ballista is already loaded with a large rock!|What weapon are you trying to load?
	put load ballista
	matchwait
	
EXHALEP:
  pause	
EXHALE:
  var dbready 0
  matchre EXHALEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You sharply inhale, drawing upon|Your throat is too sore to breathe fire|You slowly and deliberately empty your filled lungs.|There is nothing else to face!
  put exhale
  matchwait

EXHALETARGETP:
  pause	
EXHALETARGET:
  var dbready 0
  matchre EXHALEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You sharply inhale, drawing upon|You slowly and deliberately empty your filled lungs.|There is nothing else to face!|You'll need to pick a target to exhale fire at.
  match RETURN Your throat is too sore to breathe fire again so soon!
  matchre EXHALETLOOT That's just a wee bit pointless now, don't you think?
  put exhale %exhaletarget
  matchwait  

EXHALETLOOT:
  gosub SEARCH
  pause 1
  goto EXHALETARGET  

BGATTACKP:
  pause  
BGATTACK:
  if %bgdone = 1 then return
  matchre BGATTACKP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre BGATTACK With a sharp overhand motion|With a casual flick of your wrists|You sweep your hands in
  #matchre BGNEWTARGET I don't think so.
  matchre RETURN You point at|I could not find what you were referring to.|you slap your|I do not understand what you mean.|I don't think so.
  matchre BGLOOT You wave to
  put %bggesture %bgmon
  matchwait
  
BGLOOT:
  if $SpellTimer.BlufmorGaraen.active = 1 then
  {
    gosub SEARCH
    goto BGATTACK
  }
  else return
  
BGNEWTARGET:
  if $monstercount < 1 then
  {
    var goodtarget 0
    var shockcritter 1
    var currentcritter 0
    return
  }
  gosub MONSTERARRAY
  goto BGATTACK
  
MABRUBP:
  pause
MABRUB:	
	matchre MABRUBP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN generates is focused only where it is facing\.|well enough to overcome the strength of its magnetic field\.|Rub what?
  matchre MABRUB generates flares up with every single shot.
  put rub ballista
  matchwait
  
#BARDIC_LORE
WHISTLEPIERCEP:
  pause
WHISTLEPIERCE:
  matchre WHISTLEPIERCEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You take a deep breath, then exhale strongly over the tip of your curved tongue\.|Your throat feels too strained to perform another piercing whistle right now\.|You can't seem to summon the strength to perform a piercing whistle right now\.
  put whistle piercing
  matchwait
  
SCREAMDEFIANCEP:
  pause
SCREAMDEFIANCE:
  matchre SCREAMDEFIANCEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You are unable to gather the will to overcome your stunned condition.|You scream out!|You gather your will and overcome your stunned condition.|Building inspiration from tales of|Your defiant will subsides.|You strain to muster an even greater defiant decry.
  put scream defiance
  matchwait
  
#SUMMONING
PATHCHECKP:
  pause
PATHCHECK:
  match NOPATH With a moment of reflection, you realize you aren't investing any energy into manipulating the aether.
  match HASPATH You focus your magical senses on the aethereal landscape around you.
	matchre PATHCHECKP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  put pathway check
  matchwait
  
PATHSENSEP:
  pause
PATHSENSE:
  matchre PATHSENSEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  match RETURN You turn your perceptions inward
  put pathway sense
  matchwait
  
NOPATH:
  var pathwayactive 0
  return

HASPATH:
  var pathwayactive 1
  return
	
PATHSTARTP:
  pause
PATHSTART:
  var pathway 1
  matchre RETURN You focus on|You are already manipulating the aether to your benefit.
  matchre PATHSTARTBAD You lack the necessary charge
  matchre PATHSTARTP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  put pathway focus %summpath
  matchwait

PATHSTARTBAD:
  var pathway 0
  return

PATHSTOPP:
  pause
PATHSTOP:
  var pathway 0
  matchre RETURN You aren't focusing on any of the aethereal pathways.
  matchre RETURN You gently relax your mind and release your hold on the aethereal pathways.
  matchre PATHSTOPP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  put pathway stop
  matchwait

DOMAINSTARTP:
  pause  
DOMAINSTART:
  matchre DOMAINSTARTGOOD The strands anchor themselves to the ground,|The new lines of power are in conflict with the existing domain!  With a subtle show of power,
  matchre DOMAINSTARTBAD As the ritual winds toward its climax|The new lines of power are small compared to the existing ones, leaving the domain unaffected.
  matchre DOMAINSTARTP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  put summon %domaintype domain 
  #100
  matchwait
 
DOMAINSTARTGOOD:
  var domainactive 1
  var domainactivetype %domaintype
  return

DOMAINSTARTBAD:
  var domainactive 0
  return

SUMMONP:
	pause
SUMMON:
  if %summfull = 1 then var summarg impedance
  else var summarg admittance
  matchre RETURN you feel that you can still gather|you feel that you have reached your limit|You align yourself to it, briefly decreasing|You continue meditating
  matchre SUMMFULL You so heavily embody the Elemental Plane
  matchre SUMMEMPTY Try though you might
  matchre SUMMONP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  put summon %summarg
	matchwait

SUMMEMPTY:
  var summfull 0
  return

SUMMFULL:
  var summfull 1
  return

SUMMONWEAPONP:
  pause
SUMMONWEAPON:
  matchre SUMMONWEAPONP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN Roundtime|You lack the elemental charge to summon a weapon\.
  put summon weapon
  matchwait

BREAKWEAPONP:
  pause
BREAKWEAPON:
  matchre BREAKWEAPONP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN Focusing your will\, you rip the .* asunder, returning it to the Elemental planes\.|Break what\?|You can't break that\.
  put break my %summweaponname
  matchwait

MOONCHECK:
  var moonsout 0
  if $Time.isKatambaUp = 1 then var moonsout 1
  if $Time.isXibarUp = 1 then var moonsout 1
  if $Time.isYavashUp = 1 then var moonsout 1
  return
  
SHIFTMOONP:
  pause
SHIFTMOON:
  matchre RETURN You are unable to see your target clearly enough for that.
  matchre SHIFTMOONGOOD You sense your moonbeam
  put gesture %smmoon %smtarget
  matchwait

SHIFTMOONGOOD:
  var smgood 1
  return

INVOKESHADOWP:
  pause
INVOKESHADOW:
  matchre INVOKESHADOWP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You gesture, adjusting the pattern|Invoke what?|You're not sure what would happen
  put invoke shadowling
  matchwait

PERCP:
	pause
PERC:
	if ((%guild = "Barbarian") || (%guild = "Thief")) then return
  matchre RETURN Roundtime:|You are a bit too busy performing to do that.|You aren't trained in the ways of magic.
  matchre PERCP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  put perceive
	matchwait

MMPERC:
	if ((%guild = "Barbarian") || (%guild = "Thief")) then return
  matchre RETURN Roundtime:|You are a bit too busy performing to do that.
  matchre PERCP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  put perceive mana 
	matchwait


PERC2P:
	pause
PERC2:
	if ((%guild = "Barbarian") || (%guild = "Thief")) then return
  matchre RETURN Roundtime:|You are a bit too busy performing to do that.
  matchre PERC2P \.\.\.wait|type ahead|stunned|while entangled in a web\.
	if (%guild = "Moon Mage") then
	{
	  put perceive mana 
	}
	else
	{
    put perceive all
	}
	matchwait

COMMANDWARRIORP:
  pause
COMMANDWARRIOR:
  matchre COMMANDWARRIORP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN Roundtime|EXAMPLES\:|Command who to do what\?|A .* ignores your command\.
  put command warrior to %warriorcommand
  matchwait

MANIPULATEP:
  pause
MANIPULATE:
  matchre MANIPULATEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN Roundtime|You're already manipulating|Manipulate what?|You attempt to empathically|You strain, but|seem to be beyond your ken. 
  put manipulate friendship %manipadj %maniptarget
  matchwait

PERCHEALTHP:
  pause
PERCHEALTH:
  matchre PERCHEALTHP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN Roundtime|You fail to sense anything, however.|You close your eyes, drawing all your thoughts inward
  put perceive health
  matchwait

ICUTUTOUCHINGP:
  pause
ICUTUTOUCHING:
  var nextiztouch %t
  math nextiztouch add %iztimer
  matchre ICUTUTOUCHINGP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  match ICUTUADV You aren't close enough to attack.
  match RETURN A good positive attitude never hurts.
  match RETURN Roundtime
  #You stab your curled ashen fingers at a sinuous ice adder.
  #The spell pattern collapses at the last moment due to the undead state of a sinuous ice adder.
  put touch
  put yes
  matchwait

ICUTUADv:
  gosub ADV
  goto ICUTUTOUCHING

GAZESANOWRETP:
  pause
GAZESANOWRET:
  var sanowretready 0
  matchre GAZESANOWRETP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You gaze intently into your|You need to be wearing or holding that first.
  put gaze %sanowretitem
  matchwait

#ARMOR	
ARMORSET:
  math testcount add 1
  if %testcount > 4 then return
  gosub ARMORSETRUN
  goto ARMORSET
  
ARMORSETRUNP:
  pause
ARMORSETRUN:
  if %%armortypearmor%testcountworn = 0 then
  {
    if %%armorotypearmor%testcount != "none" then
    {
      gosub REMITEM %%armorotypearmor%testcount
      var %armorotypearmor%testcountworn 0
      var stowitemname %%armorotypearmor%testcount
      gosub STOWITEM
    }
    if %%armortypearmor%testcount != "none" then
    {
      gosub GETITEM %%armortypearmor%testcount
      var wearitemname %%armortypearmor%testcount
      var %armortypearmor%testcountworn 1
      gosub WEARITEM
    }
  }
  return

NEWARMORFIND:
  action (armor) on
  action (armor) var shieldworn 1 when %shielddesc
  action (armor) var armor1worn 1 when %armor1desc
  action (armor) var armor2worn 1 when %armor2desc
  action (armor) var armor3worn 1 when %armor3desc
  action (armor) var armor4worn 1 when %armor4desc
  gosub INVARMOR
  pause 1
  action (armor) off
  return

INVARMOR:
  matchre RETURN [Type INVENTORY HELP for more options]|You aren't wearing anything like that.
  put inv armor
  matchwait


###HEALTH###
BURDENCHECKP:
  pause
BURDENCHECK:
  matchre BURDENCHECKP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  match RETURN Encumbrance :
  put encumbrance
  matchwait

HEALTHCHECKP:
  pause
HEALTHCHECK:
  var healthcheckgood 0
  matchre HEALTHCHECKP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre HEALTHCHECKCLEAN You have no significant injuries.
  matchre RETURN A good positive attitude never hurts.
  put health
  put yes
  matchwait

HEALTHCHECKCLEAN:
  var healthcheckgood 1
  return
  
BLEEDCHECKP:
  pause
BLEEDCHECK:
  var nextbleed %t
  math nextbleed add 90
  gosub BLEEDCLEAN
  matchre BLEEDCHECKP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre BLEEDING ^Bleeding$
  matchre RETURN A good positive attitude never hurts.
  put health
  put yes
  matchwait
  
BLEEDING:
  if %head = 1 then gosub tend head
  if %neck = 1 then gosub tend neck
  if %chest = 1 then gosub tend chest
  if %abdomen = 1 then gosub tend abdomen
  if %back = 1 then gosub tend back
  if %tail = 1 then gosub tend tail
  if %rightarm = 1 then gosub tend right arm
  if %leftarm = 1 then gosub tend left arm
  if %righthand = 1 then gosub tend right hand
  if %lefthand = 1 then gosub tend left hand
  if %rightleg = 1 then gosub tend right leg
  if %leftleg = 1 then gosub tend left leg
  if %righteye = 1 then gosub tend right eye
  if %lefteye = 1 then gosub tend left eye
  return

TENDP:
  pause
TEND:
  if %0 = "stunned" then
  {
    var nextbleed %t
    return
  }
  matchre TENDP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN ^You work|^That area|^Look again|^Your .+ too injured|TEND {MY|<character>} {area}|You are a bit too busy performing to do that.|^You fumble
  put tend my $0
  matchwait
  
BLEEDCLEAN:
  var head 0
  var neck 0
  var chest 0
  var abdomen 0
  var back 0
  var tail 0
  var rightarm 0
  var leftarm 0
  var righthand 0
  var lefthand 0
  var rightleg 0
  var leftleg 0
  var righteye 0
  var lefteye 0
  return
  
HEALTHCHECK2:
  if $guild = "Empath" then 
  {
    gosub HEALTHRESET
    gosub HEALTHPERC
    gosub HEALTHOUTPUT
  }
  else
  {
    gosub HEALTHRESET
    gosub HEALTHVERB
    gosub HEALTHOUTPUT
  }
  exit

HEALTHPERC:
  action var TEMP $1_$2 when ^Wounds to the (LEFT|RIGHT) (\w+):$
  action var TEMP $1 when ^Wounds to the (\w+):$
  action var %TEMP_MYW_E 1 when Fresh External:.*?\-\-\s+insignificant$
  action var %TEMP_MYW_I 1 when Fresh Internal:.*?\-\-\s+insignificant$
  action var %TEMP_MYS_E 1 when Scars External:.*?\-\-\s+insignificant$
  action var %TEMP_MYS_I 1 when Scars Internal:.*?\-\-\s+insignificant$
  action var %TEMP_MYW_E 2 when Fresh External:.*?\-\-\s+negligible$
  action var %TEMP_MYW_I 2 when Fresh Internal:.*?\-\-\s+negligible$
  action var %TEMP_MYS_E 2 when Scars External:.*?\-\-\s+negligible$
  action var %TEMP_MYS_I 2 when Scars Internal:.*?\-\-\s+negligible$
  action var %TEMP_MYW_E 3 when Fresh External:.*?\-\-\s+minor$
  action var %TEMP_MYW_I 3 when Fresh Internal:.*?\-\-\s+minor$
  action var %TEMP_MYS_E 3 when Scars External:.*?\-\-\s+minor$
  action var %TEMP_MYS_I 3 when Scars Internal:.*?\-\-\s+minor$
  action var %TEMP_MYW_E 4 when Fresh External:.*?\-\-\s+more than minor$
  action var %TEMP_MYW_I 4 when Fresh Internal:.*?\-\-\s+more than minor$
  action var %TEMP_MYS_E 4 when Scars External:.*?\-\-\s+more than minor$
  action var %TEMP_MYS_I 4 when Scars Internal:.*?\-\-\s+more than minor$
  action var %TEMP_MYW_E 5 when Fresh External:.*?\-\-\s+harmful$
  action var %TEMP_MYW_I 5 when Fresh Internal:.*?\-\-\s+harmful$
  action var %TEMP_MYS_E 5 when Scars External:.*?\-\-\s+harmful$
  action var %TEMP_MYS_I 5 when Scars Internal:.*?\-\-\s+harmful$
  action var %TEMP_MYW_E 6 when Fresh External:.*?\-\-\s+very harmful$
  action var %TEMP_MYW_I 6 when Fresh Internal:.*?\-\-\s+very harmful$
  action var %TEMP_MYS_E 6 when Scars External:.*?\-\-\s+very harmful$
  action var %TEMP_MYS_I 6 when Scars Internal:.*?\-\-\s+very harmful$
  action var %TEMP_MYW_E 7 when Fresh External:.*?\-\-\s+damaging$
  action var %TEMP_MYW_I 7 when Fresh Internal:.*?\-\-\s+damaging$
  action var %TEMP_MYS_E 7 when Scars External:.*?\-\-\s+damaging$
  action var %TEMP_MYS_I 7 when Scars Internal:.*?\-\-\s+damaging$
  action var %TEMP_MYW_E 8 when Fresh External:.*?\-\-\s+very damaging$
  action var %TEMP_MYW_I 8 when Fresh Internal:.*?\-\-\s+very damaging$
  action var %TEMP_MYS_E 8 when Scars External:.*?\-\-\s+very damaging$
  action var %TEMP_MYS_I 8 when Scars Internal:.*?\-\-\s+very damaging$
  action var %TEMP_MYW_E 9 when Fresh External:.*?\-\-\s+severe$
  action var %TEMP_MYW_I 9 when Fresh Internal:.*?\-\-\s+severe$
  action var %TEMP_MYS_E 9 when Scars External:.*?\-\-\s+severe$
  action var %TEMP_MYS_I 9 when Scars Internal:.*?\-\-\s+severe$
  action var %TEMP_MYW_E 10 when Fresh External:.*?\-\-\s+very severe$
  action var %TEMP_MYW_I 10 when Fresh Internal:.*?\-\-\s+very severe$
  action var %TEMP_MYS_E 10 when Scars External:.*?\-\-\s+very severe$
  action var %TEMP_MYS_I 10 when Scars Internal:.*?\-\-\s+very severe$
  action var %TEMP_MYW_E 11 when Fresh External:.*?\-\-\s+devastating$
  action var %TEMP_MYW_I 11 when Fresh Internal:.*?\-\-\s+devastating$
  action var %TEMP_MYS_E 11 when Scars External:.*?\-\-\s+devastating$
  action var %TEMP_MYS_I 11 when Scars Internal:.*?\-\-\s+devastating$
  action var %TEMP_MYW_E 12 when Fresh External:.*?\-\-\s+very devastating$
  action var %TEMP_MYW_I 12 when Fresh Internal:.*?\-\-\s+very devastating$
  action var %TEMP_MYS_E 12 when Scars External:.*?\-\-\s+very devastating$
  action var %TEMP_MYS_I 12 when Scars Internal:.*?\-\-\s+very devastating$
  action var %TEMP_MYW_E 13 when Fresh External:.*?\-\-\s+useless$
  action var %TEMP_MYW_I 13 when Fresh Internal:.*?\-\-\s+useless$
  action var %TEMP_MYS_E 13 when Scars External:.*?\-\-\s+useless$
  action var %TEMP_MYS_I 13 when Scars Internal:.*?\-\-\s+useless$
  send perceive health self
  waitforre ^You .+ vitality
  return

HEALTHVERB:
  put health
  return

HEALTHRESET:
  var ABDOMEN_MYW_E 0
  var ABDOMEN_MYW_I 0
  var ABDOMEN_MYS_E 0
  var ABDOMEN_MYS_I 0
  var BACK_MYW_E 0
  var BACK_MYW_I 0
  var BACK_MYS_E 0
  var BACK_MYS_I 0
  var CHEST_MYW_E 0
  var CHEST_MYW_I 0
  var CHEST_MYS_E 0
  var CHEST_MYS_I 0
  var HEAD_MYW_E 0
  var HEAD_MYW_I 0
  var HEAD_MYS_E 0
  var HEAD_MYS_I 0
  var LEFT_ARM_MYW_E 0
  var LEFT_ARM_MYW_I 0
  var LEFT_ARM_MYS_E 0
  var LEFT_ARM_MYS_I 0
  var LEFT_EYE_MYW 0
  var LEFT_EYE_MYW 0
  var LEFT_EYE_MYS 0
  var LEFT_EYE_MYS 0
  var LEFT_HAND_MYW_E 0
  var LEFT_HAND_MYW_I 0
  var LEFT_HAND_MYS_E 0
  var LEFT_HAND_MYS_I 0
  var LEFT_LEG_MYW_E 0
  var LEFT_LEG_MYW_I 0
  var LEFT_LEG_MYS_E 0
  var LEFT_LEG_MYS_I 0
  var NECK_MYW_E 0
  var NECK_MYW_I 0
  var NECK_MYS_E 0
  var NECK_MYS_I 0
  var RIGHT_ARM_MYW_E 0
  var RIGHT_ARM_MYW_I 0
  var RIGHT_ARM_MYS_E 0
  var RIGHT_ARM_MYS_I 0
  var RIGHT_EYE_MYW_E 0
  var RIGHT_EYE_MYW_I 0
  var RIGHT_EYE_MYS_E 0
  var RIGHT_EYE_MYS_I 0
  var RIGHT_HAND_MYW_E 0
  var RIGHT_HAND_MYW_I 0
  var RIGHT_HAND_MYS_E 0
  var RIGHT_HAND_MYS_I 0
  var RIGHT_LEG_MYW_E 0
  var RIGHT_LEG_MYW_I 0
  var RIGHT_LEG_MYS_E 0
  var RIGHT_LEG_MYS_I 0
  var SKIN_MYW_E 0
  var SKIN_MYW_I 0
  var SKIN_MYS_E 0
  var SKIN_MYS_I 0
  var TAIL_MYW_E 0
  var TAIL_MYW_I 0
  var TAIL_MYS_E 0
  var TAIL_MYS_I 0
  return

HEALTHOUTPUT:
  echo ABDOMEN_MYW_E %ABDOMEN_MYW_E
  echo ABDOMEN_MYW_I %ABDOMEN_MYW_I
  echo ABDOMEN_MYS_E %ABDOMEN_MYS_E
  echo ABDOMEN_MYS_I %ABDOMEN_MYS_I
  echo BACK_MYW %BACK_MYW
  echo BACK_MYW %BACK_MYW
  echo BACK_MYS %BACK_MYS
  echo BACK_MYS %BACK_MYS
  echo CHEST_MYW_E %CHEST_MYW_E
  echo CHEST_MYW_I %CHEST_MYW_I
  echo CHEST_MYS_E %CHEST_MYS_E
  echo CHEST_MYS_I %CHEST_MYS_I
  echo HEAD_MYW_E %HEAD_MYW_E
  echo HEAD_MYW_I %HEAD_MYW_I
  echo HEAD_MYS_E %HEAD_MYS_E
  echo HEAD_MYS_I %HEAD_MYS_I
  echo LEFT_ARM_MYW_E %LEFT_ARM_MYW_E
  echo LEFT_ARM_MYW_I %LEFT_ARM_MYW_I
  echo LEFT_ARM_MYS_E %LEFT_ARM_MYS_E
  echo LEFT_ARM_MYS_I %LEFT_ARM_MYS_I
  echo LEFT_EYE_MYW_E %LEFT_EYE_MYW_E
  echo LEFT_EYE_MYW_I %LEFT_EYE_MYW_I
  echo LEFT_EYE_MYS_E %LEFT_EYE_MYS_E
  echo LEFT_EYE_MYS_I %LEFT_EYE_MYS_I
  echo LEFT_HAND_MYW_E %LEFT_HAND_MYW_E
  echo LEFT_HAND_MYW_I %LEFT_HAND_MYW_I
  echo LEFT_HAND_MYS_E %LEFT_HAND_MYS_E
  echo LEFT_HAND_MYS_I %LEFT_HAND_MYS_I
  echo LEFT_LEG_MYW_E %LEFT_LEG_MYW_E
  echo LEFT_LEG_MYW_I %LEFT_LEG_MYW_I
  echo LEFT_LEG_MYS_E %LEFT_LEG_MYS_E
  echo LEFT_LEG_MYS_I %LEFT_LEG_MYS_I
  echo NECK_MYW_E %NECK_MYW_E
  echo NECK_MYW_I %NECK_MYW_I
  echo NECK_MYS_E %NECK_MYS_E
  echo NECK_MYS_I %NECK_MYS_I
  echo RIGHT_ARM_MYW_E %RIGHT_ARM_MYW_E
  echo RIGHT_ARM_MYW_I %RIGHT_ARM_MYW_I
  echo RIGHT_ARM_MYS_E %RIGHT_ARM_MYS_E
  echo RIGHT_ARM_MYS_I %RIGHT_ARM_MYS_I
  echo RIGHT_EYE_MYW_E %RIGHT_EYE_MYW_E
  echo RIGHT_EYE_MYW_I %RIGHT_EYE_MYW_I
  echo RIGHT_EYE_MYS_E %RIGHT_EYE_MYS_E
  echo RIGHT_EYE_MYS_I %RIGHT_EYE_MYS_I
  echo RIGHT_HAND_MYW_E %RIGHT_HAND_MYW_E
  echo RIGHT_HAND_MYW_I %RIGHT_HAND_MYW_I
  echo RIGHT_HAND_MYS_E %RIGHT_HAND_MYS_E
  echo RIGHT_HAND_MYS_I %RIGHT_HAND_MYS_I
  echo RIGHT_LEG_MYW_E %RIGHT_LEG_MYW_E
  echo RIGHT_LEG_MYW_I %RIGHT_LEG_MYW_I
  echo RIGHT_LEG_MYW_E %RIGHT_LEG_MYW_E
  echo RIGHT_LEG_MYS_I %RIGHT_LEG_MYS_I
  echo SKIN_MYW_E %SKIN_MYW_E
  echo SKIN_MYW_I %SKIN_MYW_I
  echo SKIN_MYS_E %SKIN_MYS_E
  echo SKIN_MYS_I %SKIN_MYS_I  
  echo TAIL_MYW_E %TAIL_MYW_E
  echo TAIL_MYW_I %TAIL_MYW_I
  echo TAIL_MYS_E %TAIL_MYS_E
  echo TAIL_MYS_I %TAIL_MYS_I
  return
  
###COLLECTING###
COLLECTP:
	pause
COLLECT:
	matchre COLLECTP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	matchre RETURN /You manage to collect|The room is too cluttered to find anything here!|You find something dead and lifeless, is this what you were looking for?|Searching and searching, you fail to find anything./
	match COLLECTR You cannot collect anything while in combat!
	matchre RETURN /You forage around|You wander around and|You begin to forage/
	matchre RETURN /You are sure you knew what you were looking for|You are certain you could find what you were looking for/
	match BADCOLLECT You survey the area and realize that any collecting efforts would be futile.
	match FULLHANDS You really need to have at least one hand free to properly collect something.
	put collect %collectitem
	matchwait

FULLHANDS:
  gosub STOWALL
  goto COLLECT

BADCOLLECT:
  var outdoor NO
  return

COLLECTR:
  gosub RETREAT
  goto COLLECT
  
KICKP:
	pause
KICK:
  if $standing != 1 then gosub STAND
  if matchre ("$roomobjs", "a pile of rocks") then
  {
	  matchre KICKP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	  match KICK You take a step back
    matchre KICKS You can't do that from your position.|You can't quite manage
	  matchre RETURN I could not find|Now what did the|You lean back and kick your feet|Now THAT would be a trick!
	  put kick rock
	  matchwait
	}
	if matchre ("$roomobjs", "a pile of dust bunnies") then
  {
	  matchre KICKP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	  match KICK You take a step back
    matchre KICKS You can't do that from your position.|You can't quite manage
	  matchre RETURN I could not find|Now what did the|You lean back and kick your feet|Now THAT would be a trick!
	  put kick bunnies
	  matchwait
	}
	return

KICKS:
  gosub STAND
  goto KICK
  
###HUNTING###
HUNTP:
	pause
HUNT:
  match NOHUNT You find yourself unable to hunt in this area.
	match RETURN Roundtime:
	matchre HUNTP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	put hunt
	matchwait

NOHUNT:
  var %hunt NO
  return

JUSTICECHECKP:
  pause
JUSTICECHECK:
  matchre JUSTICECHECKP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You're fairly certain this area is lawless and unsafe.|After assessing the area, you think local law enforcement keeps an eye on what's going on here.|After assessing the area, you believe there is some kind of unusual law enforcement in this area.
  put justice
  matchwait

###MUSIC###
ASSESSINSTRUMENTP:
  pause
ASSESSINSTRUMENT:
  matchre ASSESSINSTRUMENTP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  match RETURN Roundtime:
  put assess my %instrument
  matchwait

PLAYP:
  pause
PLAY:
  matchre PLAYP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre PLAYSUCCESS You're already playing a song!|You begin a|You effortlessly begin|You fumble slightly|You struggle to begin
  put play %songtype on %instrument
  matchwait

PLAYSTOPP:
  pause
PLAYSTOP:
  var playing 0
  var humming 0
  matchre PLAYSTOPP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You stop playing your song.|In the name of love?
  put stop play
  matchwait

PLAYSUCCESS:
  var playing 1
  return

HUMP:
  pause
HUM:
  matchre HUMP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre HUMSUCCESS You're already humming a song!|You begin a|You effortlessly begin|You fumble slightly|You struggle to begin
  put hum %humsong
  matchwait

HUMSUCCESS:
  var playing 1
  var humming 1
  return

INSTMAINTAIN:
  if matchre ("$lefthand", "%instrument") then gosub SWAP
  if matchre ("$righthand", "%instrument") then
  else
  {
    gosub GETITEM %instrument
  }
  if matchre ("$lefthand", "%instrument") then gosub SWAP
  if $lefthand != "Empty" then
  {
    var stowhand left
    gosub STOW
  }
  gosub GETITEM %instcleancloth
  gosub INSTDRY
  gosub INSTCLEAN
  var stowitemname %instcleancloth
  gosub STOWITEM
  return

INSTCLEANP:
  pause
INSTCLEAN:
  matchre INSTCLEANP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN Roundtime|(is|are) not in need of cleaning.
  matchre INSTCLEANGET You must be holding
  matchre INSTDRY Maybe you should dry (it|them) off before attempting to clean (it|them).
  put clean %instrument with %instcleancloth
  matchwait
  
INSTCLEANGET:
  var stowhand right
  gosub STOW
  gosub GETITEM %instrument
  goto INSTCLEAN
  
INSTDRYP:
  pause
INSTDRY:
  matchre INSTDRYP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN is not in need of drying.
  matchre INSTWRING Your cloth absorbs the water without too much trouble, but remains very wet afterwards.|Using your cloth, you expertly drain|You stare at your
  put wipe my %instrument with %instcleancloth
  matchwait

INSTWRINGP:
  pause
INSTWRING:
  matchre INSTWRINGP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre INSTCLEAN squeezing out the last bit of water.
  matchre INSTWRING water dribbling down your hands to splash at your feet.|water pouring out to splash at your feet.
  put wring my %instcleancloth
  matchwait 

AWAKEP:
  pause
AWAKE:
  matchre AWAKEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You awaken from your reverie and begin to take in the world around you|But you are not sleeping!
  put awake
  matchwait

DEEPSLEEPP:
  pause
DEEPSLEEP:
  matchre DEEPSLEEPP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre DEEPSLEEP You relax and allow your mind to enter a state of rest.|You stir yourself from the depths of relaxation and prepare for another night.|You stir yourself from the depths of relaxation and prepare for another day.
  matchre RETURN You draw deeper into rest, trying to destress from a hard (day's|night's) adventuring.
  put sleep
  matchwait

RPATOGGLEP:
  pause
RPATOGGLE:
  matchre RPATOGGLEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RPAPAUSE You pause your roleplaying award.
  matchre RPAACTIVE You unpause your
  matchre RPATIMER You need to wait a few minutes before doing that again.
  matchre RPABAD But you don't have an active roleplaying award to pause!
  put rpa toggle
  matchwait

RPATIMER:
  return

RPAACTIVE:
  var rpastatus 1
  return

RPAPAUSE:
  var rpastatus 0
  return

RPABAD:
  var rpastatus -1
  return

STUDYALMANACP:
	pause
STUDYALMANAC:
  matchre STUDYALMANACP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre ALMANACRETURN Roundtime:
  matchre BADALMANAC You've gleaned all the insight you can from
  put study my %almanacitem
  matchwait
  
ALMANACRETURN:
  var nextalmanac %t
  math nextalmanac add 610
  return

BADALMANAC:
  var nextalmanac %t
  math nextalmanac add 120
  return   

WRITEJOURNALP:
  pause
WRITEJOURNAL:
  matchre WRITEJOURNALP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre WRITEJOURNALGOOD Flipping to a blank page, you pluck the|As you open your
  matchre WRITEJOURNALBAD Having recently written in
  put write %ejournalitem
  matchwait

WRITEJOURNALGOOD:
  var ejournalused 1
  return

WRITEJOURNALBAD:
  var ejournalused 0
  return

TARANTULATURNP:
  pause
TARANTULATURN:
  var turngood 0
  matchre TARANTULATURNP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  match TTURNGOOD With a *click*, your changes snap into place. 
  match RETURN However, your changes fail to lock into place.
  match TARANTULATURNBAD What skill did you want to attune
  put turn %tarantulaitem to %tarantulaskill%tskill
  matchwait

TTURNGOOD:
  var turngood 1
  return

TARANTULATURNBAD:
  put #echo %alertwindow Could not turn tarantula to the %tarantulaskill%tskill.  Please investigate.  Turning off tarantula use.
  var tarantula NO
  return

TARANTULARUBP:
  pause
TARANTULARUB:
  matchre TARANTULARUBP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  match TRUBGOOD It is mere moments afterward that you feel an itching, tingling, and crawling sensation all across the inside of your skull.
  matchre RETURN You try, but the|But you currently aren't learning any
  put rub %tarantulaitem
  matchwait
  
TRUBGOOD:
  #put #echo %alertwindow Used tarantula on %tarantulaskill%tskill.
  return
  
STUDYP:
	pause
STUDY:
  match TURN Why do you need to study this chart again?
  match RETURN Roundtime:
  match RETURN You need to be holding your compendium to study it.
  matchre STUDYP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  put study my compendium
  matchwait  

STUDYTEXTP:
	pause
STUDYTEXT:
  matchre TEXTNEXT In a sudden moment of clarity, the information
  matchre TEXTNEXTBAD Why do you need to study this chart again?
  matchre RETURN /Roundtime: \d+/
  matchre STUDYTEXTP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  put study my %textbookitem
  matchwait
  
TEXTNEXTBAD:
  var textlist%textpositionnext %t
  math textlist%textpositionnext add 1200
  var textagain 1
  var nexttext 0
  return
  
TEXTNEXT:
  var textlist%textpositionnext %t
  math textlist%textpositionnext add 1200
  #echo Page is done!  textlist%textpositionnext: %textlist%textpositionnext
  return

TURNTEXTP:
  pause
TURNTEXT:
  matchre TURNTEXTP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You turn to the section on
  matchre BADTEXT That section does not exist within your
  put turn my %textbookitem to %textmonster
  matchwait

BADTEXT:
  var badtextturn 1
  return

TEACHP:
  pause
TEACH:
  eval tempteach tolower("$roomplayers")
  if matchre ("%tempteach", "%teachtarget") then
  {
    matchre TEACHP \.\.\.wait|type ahead|stunned|while entangled in a web\.
    matchre RETURN You begin to lecture|I don't understand which skill you wish to teach.|is already listening to you|I don't understand which skill you wish to teach.|You have already offered|I could not find who you were referring to.|That person is too busy teaching their own students to listen to your lesson.
    put teach %teachskill to %teachtarget 
    matchwait
  }
  else return

TEACHSTOPP:
  pause
TEACHSTOP:
  matchre TEACHSTOPP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN But you aren't teaching anyone.|You stop teaching.
  put stop teach
  matchwait

TEACHASSESSP:
  pause
TEACHASSESS:
  matchre TEACHASSESSP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN Roundtime: 
  put assess teach
  matchwait
  return

TURNP:
  pause
TURN:
  math turncount add 1
  if %turncount = 1 then
  {
    put turn compendium
    match STUDY You turn to the section
    matchre TURNP \.\.\.wait|type ahead|stunned|while entangled in a web\.
    matchwait
  }
  else
  {
    math nextstudy add 1200
    var stowhand left
    gosub STOW
    return
  }
  
PICKBOXP:
  pause
PICKBOX:
  matchre PICKBOXP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre LOCKBOX You set about picking your training box.  With a faint \*CLICK\* it opens.|But the training box isn't locked!|It's not even locked, why bother?
  matchre RETURN You set about picking the training box, but it quickly becomes apparent you are not making any progress.|Pick what?
  matchre BADLOCK The lock feels warm, as if worked too often recently, so you stop your attempt to pick it.
  put pick training box
  matchwait

BADLOCK:
  var picksleft 0
  return

LOCKBOXP:
  pause
LOCKBOX:
  matchre LOCKBOXP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You quickly lock the training box and pocket the key.|The training box is already locked.
  put lock training box
  matchwait
  
WINDCHECKP:
  return
WINDCHECK:
  matchre WINDCHECKP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre YESWIND You're already riding on something.
  matchre NOWIND You need to be holding the|You cannot really do anything on
  put mount windboard
  matchwait

YESWIND:
  var windmounted 1
  return
  
NOWIND:
  var windmounted 0
  return

WINDCHARGEP:
  pause
WINDCHARGE:
  matchre WINDCFULL The windboard is already fully charged, so there's no need to charge it more.
  matchre WINDCHARGEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You strain, but lack the mental stamina to charge the windboard this much.
  match WINDCSUCC Roundtime:
  put charge windboard 50
  matchwait

WINDCFULL:
  var windboardcharge 50
  put #var windboardcharge %windboardcharge
  return

WINDCSUCC:
  math windboardcharge add 10
  if %windboardcharge > 49 then var windboardcharge 50
  put #var windboardcharge %windboardcharge
  if %windboardcharge = 50 then return
  else goto WINDCHARGE

WINDMOUNTP:
  pause
WINDMOUNT:
  math windboardcharge subtract 1
  put #var windboardcharge %windboardcharge
  matchre WINDMOUNTP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  match WINDMRET You cannot really do anything on your windboard while in combat.
  match RETURN You put your
  put mount windboard
  matchwait

WINDMRET:
  gosub RETREAT
  goto WINDMOUNT

WINDDISMOUNTP:
  pause
WINDDISMOUNT:
  matchre WINDDISMOUNTP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You step off your|You're not riding around on
  put dismount windboard
  matchwait
  
WINDTRICKP:
  pause
WINDTRICK:  
  matchre WINDTRICKP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  match RETURN Roundtime:
  match WINDTRET You cannot really do anything on your windboard while in combat.
  put %windboardtrick windboard
  matchwait

WINDTRET:
  gosub RETREAT
  goto WINDTRICK
  
APPRAISEP:
  pause
APPRAISE:
  matchre APPRAISEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  match APPRET You cannot appraise that when you are in combat!
  matchre RETURN Roundtime:|Appraise what?|You need to be either holding it or wearing it.|You try to sneak out of combat
  if %appsaveitem != "none" then put appraise %appsaveitem bundle quick
  else put appraise bundle quick
  matchwait
  
APPRET:
  gosub RETREAT
  goto APPRAISE
  
APPRAISECREATUREP:
  pause
APPRAISECREATURE:
  gosub MONSTERARRAY
  eval monsterarray element("%monsterarray", 0)
  eval monsterarray replace("%monsterarray", " ", "|")
  eval arraylen count("%monsterarray", "|")
  eval appraisemon element("%monsterarray", %arraylen)
  #echo AppraiseMon: %appraisemon
  #echo ArrayLen: %arraylen
  if %arraylen = 0 then
  {  
    var nextrecall %t
    return
  }
  matchre APPRAISECREATUREP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN Roundtime:|You cannot appraise that when you are in combat!|You don't see anything of interest in that direction\.
  put appraise %appraisemon
  matchwait 
 
RECALLP:
  pause
RECALL:
  gosub MONSTERARRAY
  eval monsterarray element("%monsterarray", 0)
  eval monsterarray replace("%monsterarray", " ", "|")
  eval arraylen count("%monsterarray", "|")
  eval recallmon element("%monsterarray", %arraylen)
  if %arraylen = 0 then
  {  
    var nextrecall %t
    return
  }
  matchre RECALLP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN Roundtime:|You are far too occupied by present matters|You search your mind
  put recall %recallmon
  matchwait 
  
MONSTERARRAY:
  var monsterarray $monsterlist
  eval monsterarray replace("%monsterarray", ", ", "|")
  eval monsterarray replacere("%monsterarray", " that appears stunned", "")
  eval monsterarray replacere("%monsterarray", " that appears to be sleeping", "")
  eval monsterarray replacere("%monsterarray", " that is surrounded by a shimmering shield", "")
  eval monsterarray replacere("%monsterarray", " that is flying around", "")
  eval monsterarray replacere("%monsterarray", " that appears immobilized", "")
  eval monsterarray replacere("%monsterarray", " that is sleeping", "")  
  return
  
###BRAIDING###
FORAGEP:
	pause
FORAGE:
	matchre FORAGEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	match RETURN You manage to find
	match FORAGEFULL You really need to have at least one hand free to forage properly.
	match FORAGE Roundtime:
	put forage %forageitem
	matchwait

FORAGEFULL:
  if matchre ("$righthand", "%braidtarget") then
  else
  {
    var stowhand right
    gosub STOW
  }
  if matchre ("$lefthand", "%braidtarget") then
  else
  {
    var stowhand left
    gosub STOW
  }
  goto FORAGE
  
BRAID:
  if matchre ("$righthand", "%braidobjects") then gosub BRAIDING
  else
  { 
    if matchre ("$lefthand", "%braidobjects") then
    {
      gosub BRAIDING
    }
    else
    { 
      var forageitem %braidtarget
      gosub FORAGE
      goto BRAID
    }
  }
  return

BRAIDINGP:
	pause
BRAIDING:
	matchre BRAIDINGP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	matchre BRAIDFORAGE You need to have more material|You need to be holding that first.|Braid what?
	match BRAIDPULL mistake
	match BRAIDDUMP wasted effort.
	match RETURN Roundtime:
	matchre BRAIDSTOW You need both hands to do that.
	put braid my %braidtarget
	matchwait

BRAIDSTOW:
  if matchre ("$righthand", "%braidtarget") then
  else
  {
    var stowhand right
    gosub STOW
  }
  if matchre ("$lefthand", "%braidtarget") then
  else
  {
    var stowhand left
    gosub STOW
  }
  goto BRAIDING
  
  
BRAIDDUMP:
  var dumpitemname %braidtarget
  gosub DUMPITEM
  return

BRAIDDUMP2:
  var dumpitemname $righthandnoun
  gosub DUMPITEM
  return

BRAIDFORAGE:
  var forageitem %braidtarget
  gosub FORAGE
  goto BRAIDING
 
BRAIDPULLP:
	pause
BRAIDPULL:
	matchre BRAIDPULLP \.\.\.wait|type ahead|stunned|while entangled in a web\.
	matchre BRAIDDUMP2 /rope|testing it thoroughly./
	put pull my %braidtarget
	matchwait

CLIMBPRACTICEP:
  pause
CLIMBPRACTICE:
  matchre CLIMBPRACTICEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre CLIMBNOPLAY Tossing one end of the rope over your shoulder, you mime a convincing climb while pulling the rope hand over hand.
  matchre RETURN The rope's will quickly fades away|You finish practicing your climbing skill|Your focus diverts away from the rope
  matchre CLIMBTOOHARD This climb is too difficult, so you stop practicing\.|This climb is no challenge at all
  matchre CLIMBSTAND You should probably be standing to attempt this.
  if %climbingrope = "YES" then put climb %climbobject
  else put climb practice %climbobject
  matchwait

CLIMBTOOHARD:
  var climbing NO
  return

CLIMBSTAND:
  gosub STAND
  goto CLIMBPRACTICE

CLIMBNOPLAY:
  var playing 0
  var humming 0
  return

BADCLIMB:
  var climbing NO
  goto PERFORMLOOP

	
#CLERICSTUFF

COMMSENSEP:
  pause
COMMSENSE:
  var mercomup 0
  var tamcomup
  var tamsinegood 1
  var meraudgood 1
  var elunedgood 1
  matchre COMMSENSEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  match RETURN Roundtime: 
  put commune sense
  matchwait

COMMUNEP:
  pause
COMMUNE:
  matchre COMMUNEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  match COMMUNEBAD You stop as you realize that you have attempted a commune too recently in the past.
  matchre RETURN Roundtime|You grind some dirt in your fist|You feel warmth spread throughout your body
  put commune %commune
  matchwait
  
COMMUNEBAD:
  var communegood 0
  return

UNROLLMATP:
  pause
UNROLLMAT:
  matchre UNROLLMATP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You reverently lay|You need to be holding that first!
  put unroll %prayermatitem
  matchwait

ROLLMATP:
  pause
ROLLMAT:
  matchre ROLLMATP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You carefully gather up|It is already rolled up!
  put roll mat
  matchwait

KNEELLMATP:
  pause
KNEELMAT:
  matchre KNEELMATP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You humbly kneel
  put kneel mat
  matchwait

KISSMATP:
  pause
KISSMAT:
  matchre KISSMATP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You bend forward to kiss|You get a sense that you have
  put kiss mat
  matchwait

POURWINEP:
  pause
POURWINE:
  matchre POURWINEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You quietly pour some 
  put pour wine on mat
  matchwait

DIRTRUMMAGEP:
  pause
DIRTRUMMAGE:
  var dirtfull 0
  matchre DIRTRUMMAGEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN determining it has a little dirt in it\.|determining that it is over a quarter full\.|determining that it is over half full\.| determining that it is over three quarters full\.|determining that it is almost full of dirt\!
  match RUMMAGEDIRTGOOD determining that it is full of dirt!
  put rummage %dirtstackeritem
  matchwait

RUMMAGEDIRTGOOD:
  var dirtfull 1
  return

DIRTPUSHP:
  pause
DIRTPUSH:
  matchre DIRTPUSHP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You push the release catch on your
  put push %dirtstackeritem
  matchwait

DRAGONLIGHTP:
  pause
DRAGONLIGHT:
  matchre DRAGONLIGHTP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You quickly flick
  put point %lighteritem at incense
  matchwait

WAVEINCP:
  pause
WAVEINC:
  matchre WAVEINCP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN I do not understand what you mean.|You wave your|You wave some
  put wave incense at %wavetarget
  matchwait
  
SPRINKLEP:
  pause
SPRINKLE:
  var goodsprinkle 1
  matchre SPRINKLEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN I do not understand what you mean.|You sprinkle
  match SPRINKLEBAD Sprinkle that?  I don't think so.
  match RETURN USAGE: SPRINKLE (item) on (person|creature|item|ROOM)
  put sprinkle %sprinkleitem on %sprinkletarget
  matchwait

SPRINKLEBAD:
  var goodsprinkle 0
  return

SNUFFINCP:
  pause
SNUFFINC:
  matchre SNUFFINCP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN I do not understand what you mean.|You snuff out|What were you referring to?|But that isn't
  put snuff incense
  matchwait

DANCEP:
  pause
DANCE:
  matchre DANCEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre DANCE Conclusion, but|You begin to dance,|Your actions grow in intensity|but you falter, destroying
  matchre RETURN Your dance reaches its conclusion|In your condition?|USAGE: DANCE
  #|You feel that your gods have smiled
  put dance %dancetarget
  matchwait

RECITE:
  put recite %recitation
  return

PRAYBADGEP:
  pause
PRAYBADGE:
  matchre PRAYBADGEP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  match RETURN Roundtime:
  put pray %pilgrimbadgeitem
  matchwait

PRAYGODP:
  pause
PRAYGOD:
  matchre PRAYGODP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You glance heavenward|You throw your head back and howl|Praying for|You raise your hands lightly|Bristling up against a sudden sense of evil|You slowly square your shoulders|You tap the center of your forehead|You whisper your prayer into the wind|With a pat you double-check
  put pray %praydeity
  matchwait

LOOKPINP:
  pause
LOOKPIN:
  matchre LOOKPINP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre GOODPIN A thin layer of dust|Traces of the anloral's|The characteristic soft blue hue|Unsightly fingers of dirt have conquered
  match RETURN It is clean,
  put look my %anloralpinitem
  matchwait

GOODPIN:
  var pindirty 1
  return
  
CLEANPINP:
  pause
CLEANPIN:
  matchre LOOKPINP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN You pour some holy water from|The immaculate anloral
  matchre NOWATER That doesn't appear to be something you can clean.
  put clean %anloralpinitem with my water
  matchwait

NOWATER:
  return

STAYIN:
  put look
  pause 20
  return

TARGETSELECT:
  put look
  pause 1
  var shockcritter 1
  if $SpellTimer.Absolution.active != 1 then var noshockcritters %normnoshockcritters
  else var noshockcritters %absnoshockcritters
  gosub MONSTERARRAY
  if matchre("%monsterarray", "%noshockcritters") then
  {
    eval tslength count("%monsterarray", "|")
    var tsloop 0
    var critternum 1
    var targetlist %noshockcritters
    var faceadj first
    var goodtarget 0 
    gosub TARGETSELECTLOOP
    if %goodtarget = 1 then
    {
      #echo MonsterArray: %monsterarray 
      #echo Element: %tsloop
      if %facebrawlfail = 1 then var faceadj next
      else var faceadj first
      var facenoun %montest
      var currentcritter %montest
      var shockcritter 0
      gosub FACETARGET
      gosub TACTICSRESET
    }
  }
  else
  {
    if %justmanipulated = 1 then
    {
      if %manipcount < 1 then
      {
        var goodtarget 0
        var currentcritter 0
        var shockcritter 1
        return
      }
      if %mlcounter <= %malength then math mlcounter add 1
      eval facemon element("%monsterarray", %mlcounter)
      eval facemon replace("%facemon", " ", "|")
      eval arraylen count("%facemon", "|")
      eval facemon element("%facemon", %arraylen)
      var facenum 0
      if %facemon = %mon1 then math facenum add 1
      if %manipcount > 1 then
      {
        if %facemon = %mon2 then math facenum add 1
      }
      if %facenum = 0 then var faceadj first
      if %facenum = 1 then var faceadj second
      if %facenum = 2 then var faceadj third
      var goodtarget 1
      var justmanipulated 0
      var shockcritter 1
      var currentcritter %facemon
      var facenoun %facemon
      gosub FACETARGET

    }
    else
    {
      var targetlist %critters 
      var goodtarget 0
      gosub TARGETSELECTLOOP
      if %goodtarget = 1 then
      {
        var faceadj first
        var facenoun %montest
        gosub FACETARGET
        var currentcritter %montest
      }
      var shockcritter 1
    }
  }
  return
   
TARGETSELECTLOOP:
  if %tsloop > %tslength then return
  eval montest element("%monsterarray", %tsloop)
  if matchre ("%montest", "%targetlist") then
  {
    eval montest replace("%montest", " ", "|")
    eval arraylen count("%montest", "|")
    eval montest element("%montest", %arraylen)
    var goodtarget 1
    return
  }
  math tsloop add 1
  goto TARGETSELECTLOOP

Base.ListExtract:
  var Base.ListVar $1
  var Base.NounListVar $2
  var Base.ItemCountVar $3

  eval %Base.ListVar replace("%%Base.ListVar", ", ", "|")
  eval %Base.ListVar replacere("%%Base.ListVar", "( and )(?:a |an |some )(?!.*and (a |an |some ))","|")
  var %Base.ListVar |%%Base.ListVar
  eval %Base.ItemCountVar count("%%Base.ListVar", "|")
  var %Base.NounListVar %%Base.ListVar
Base.ListExtract.Loop.Trim:
  eval %Base.NounListVar replacere ("%%Base.NounListVar", "\|[\w'-]+ ", "|")
  if contains("%%Base.NounListVar", " ") then goto Base.ListExtract.Loop.Trim
	return

PREMIUMRINGGOP:
  pause
PREMIUMRINGGO:
  matchre PREMIUMRINGGOP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre PREMIUMRINGGOOD The world grows blurry and indistinct for a moment.  You look around and find yourself at...
  matchre PREMIUMRINGBAD cannot do that again yet.
  match PREMIUMRINGRETREAT You need to get out of combat, first!
  #[You may do that about an hour from now.]
  put push %premiumringitem
  matchwait

PREMIUMRINGRETREAT:
  gosub RETREAT
  goto PREMIUMRINGGO

PREMIUMRINGGOOD:
  var goodring 1
  return
  
PREMIUMRINGBAD:
  var goodring 0
  return

PREMIUMRINGBACKP:
  pause
PREMIUMRINGBACK:
  matchre PREMIUMRINGBACKP \.\.\.wait|type ahead|stunned|while entangled in a web\.
  matchre RETURN The world grows blurry and indistinct for a moment.  You look around and find yourself at...
  match RETURN You need to be in Fang Cove to do that!
  matchre PREMBADRETURN cannot do that again yet\.
  put pull %premiumringitem
  matchwait

PREMBADRETURN:
  put #echo %alertwindow Yellow [UPKEEP]: Unable to return yet due to premium ring timer.  Waiting and retrying.
  pause 60
  goto PREMIUMRINGBACK

LIBEND: