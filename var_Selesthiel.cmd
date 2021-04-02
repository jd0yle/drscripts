###############################
###      CAST
###############################
put #tvar char.cambrinth mammoth calf
put #tvar char.cast.default.charge 20
put #tvar char.cast.default.harness 40
put #tvar char.cast.default.prep 60
put #tvar char.cast.ritual.bc 700
put #tvar char.cast.ritual.dc 600
put #tvar char.focusContainer steelsilk backpack
put #tvar char.ritualFocus inauri plush
put #tvar char.wornCambrinth 1
put #tvar char.wornFocus 0


###############################
###      FRIENDS
###############################
var friends Inauri|Asherasa|Sorhhn|Xenris|Xomfor|Fostisch
var enemies null
var super.enemies null


###############################
###      MAGIC
###############################
put #tvar char.magic.train.useSymbiosis 1
put #tvar char.magic.train.wornSanowret 1

put #tvar char.magic.train.spell.Augmentation cv
put #tvar char.magic.train.prep.Augmentation 10
put #tvar char.magic.train.charge.Augmentation 70
put #tvar char.magic.train.harness.Augmentation 0

put #tvar char.magic.train.spell.Utility sm
put #tvar char.magic.train.prep.Utility 20
put #tvar char.magic.train.charge.Utility 30
put #tvar char.magic.train.harness.Utility 0

put #tvar char.magic.train.spell.Warding maf
put #tvar char.magic.train.prep.Warding 10
put #tvar char.magic.train.charge.Warding 70
put #tvar char.magic.train.harness.Warding 0


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
