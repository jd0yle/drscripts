###############################
###      APPRAISE
###############################
put #tvar char.appraise.container 0
put #tvar char.appraise.item my sail pouch


###############################
###      CAMBRINTH
###############################
put #tvar char.cambrinth armband
put #tvar char.focusContainer null
put #tvar char.ritualFocus kingsnake totem
put #tvar char.wornCambrinth 0
put #tvar char.wornFocus 0


###############################
###      CAST
###############################
put #tvar char.cast.invokeSpell 0

put #tvar char.cast.default.charge 3
put #tvar char.cast.default.harness 0
put #tvar char.cast.default.prep 10

put #tvar char.cast.dc.prep 50


###############################
###      FRIENDS
###############################
var friends (Inauri|Qizhmur|Selesthiel)
var enemies null
var super.enemies null


###############################
###      MAGIC
###############################
put #tvar char.magic.train.almanacItem 0
put #tvar char.magic.train.almanacContainer 0
put #tvar char.magic.train.useAlmanac 0
put #tvar char.magic.train.useSymbiosis 0
put #tvar char.magic.train.wornSanowret 0

put #tvar char.magic.train.spell.Augmentation cv
put #tvar char.magic.train.prep.Augmentation 10
put #tvar char.magic.train.charge.Augmentation 3
put #tvar char.magic.train.harness.Augmentation 0

put #tvar char.magic.train.spell.Utility pg
put #tvar char.magic.train.prep.Utility 10
put #tvar char.magic.train.charge.Utility 3
put #tvar char.magic.train.harness.Utility 0

put #tvar char.magic.train.spell.Warding psy
put #tvar char.magic.train.prep.Warding 10
put #tvar char.magic.train.charge.Warding 3
put #tvar char.magic.train.harness.Warding 0


###############################
###      OBSERVE & PREDICT
###############################
put #tvar char.predict.tool divination bones
put #tvar char.predict.tool.container rucksack

put #tvar char.observe.telescope alerce telescope
put #tvar char.observe.telescope.container khor'vela case

put #tvar char.observe.defense Katamba
put #tvar char.observe.lore Xibar|Raven
put #tvar char.observe.magic Yavash
put #tvar char.observe.offense Cat
put #tvar char.observe.survival Heart|Ram

put #tvar char.observe.predict 1


###############################
###      RESEARCH
###############################
put #tvar char.compendium compendium
put #tvar char.research.interrupt.cast 0
put #tvar char.research.interrupt.study 0
put #tvar char.research.useSanowret 1


pause .2
put #parse CHARVARS DONE
exit
