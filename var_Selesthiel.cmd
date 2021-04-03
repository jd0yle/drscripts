###############################
###      CAMBRINTH
###############################
put #tvar char.cambrinth mammoth calf
put #tvar char.focusContainer steelsilk backpack
put #tvar char.ritualFocus inauri plush
put #tvar char.wornCambrinth 1
put #tvar char.wornFocus 0


###############################
###      CAST
###############################
put #tvar char.cast.invokeSpell 0

put #tvar char.cast.default.charge 60
put #tvar char.cast.default.harness 40
put #tvar char.cast.default.prep 40

put #tvar char.cast.bc.prep 700
put #tvar char.cast.dc.prep 600


###############################
###      FRIENDS
###############################
var friends Inauri|Asherasa|Sorhhn|Xenris|Xomfor|Fostisch
var enemies null
var super.enemies null


###############################
###      MAGIC
###############################
put #tvar char.magic.train.almanacItem almanac
put #tvar char.magic.train.almanacContainer thigh bag
put #tvar char.magic.train.useAlmanac 1
put #tvar char.magic.train.useSymbiosis 1
put #tvar char.magic.train.wornSanowret 1

put #tvar char.magic.train.spell.Augmentation cv
put #tvar char.magic.train.prep.Augmentation 10
if (!($char.magic.train.charge.Augmentation > -1)) then put #tvar char.magic.train.charge.Augmentation 70

put #tvar char.magic.train.spell.Utility sm
put #tvar char.magic.train.prep.Utility 20
if (!($char.magic.train.charge.Utility > -1)) then put #tvar char.magic.train.charge.Utility 35

put #tvar char.magic.train.spell.Warding maf
put #tvar char.magic.train.prep.Warding 10
if (!($char.magic.train.charge.Warding > -1)) then put #tvar char.magic.train.charge.Warding 70



###############################
###      OBSERVE & PREDICT
###############################
put #tvar char.predict.tool divination bones
put #tvar char.predict.tool.container telescope case

put #tvar char.observe.telescope clockwork telescope
put #tvar char.observe.telescope.container telescope case

put #tvar char.observe.defense Merewalda|Dawgolesh|Penhetia|Giant|Katamba
put #tvar char.observe.lore forge|Amlothi|Verena|Phoenix|Xibar
put #tvar char.observe.magic Ismenia|Durgaulda|Dawgolesh|Toad|Yavash
put #tvar char.observe.offense Estrilda|Szeldia|forge|Spider
put #tvar char.observe.survival Morleena|Yoakena|Er'qutra|Ram

put #tvar char.observe.predict 0


###############################
###      RESEARCH
###############################
put #tvar char.compendium third compendium
put #tvar char.research.interrupt.cast 1
put #tvar char.research.interrupt.study 0
put #tvar char.research.useSanowret 1


pause .2
put #parse CHARVARS DONE
exit
