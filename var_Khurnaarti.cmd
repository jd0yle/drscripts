###############################
###      APPRAISE
###############################
put #tvar char.appraise.container 0
put #tvar char.appraise.item my sail pouch


###############################
###      CAMBRINTH
###############################
put #tvar char.cambrinth armband
put #tvar char.focusContainer rucksack
put #tvar char.ritualFocus kingsnake totem
put #tvar char.wornCambrinth 0
put #tvar char.wornFocus 0


###############################
###      CAST
###############################
put #tvar char.cast.invokeSpell 0

put #tvar char.cast.default.charge 5
put #tvar char.cast.default.harness 0
put #tvar char.cast.default.prep 10

put #tvar char.cast.dc.prep 50


###############################
###      FRIENDS
###############################
put #tvar char.inv.emptyGemPouchContainer rucksack
put #tvar char.inv.fullGemPouchContainer rucksack
put #tvar char.inv.tempContainer rucksack
put #tvar char.inv.default rucksack


###############################
###      COMBAT
###############################
put #tvar char.combat.spell.Debilitation calm
put #tvar char.combat.prep.Debilitation 5
put #tvar char.combat.charge.Debilitation 0
put #tvar char.combat.harness.Debilitation 0

put #tvar char.combat.spell.Targeted_Magic do
put #tvar char.combat.prep.Targeted_Magic 4
put #tvar char.combat.charge.Targeted_Magic 0
put #tvar char.combat.harness.Targeted_Magic 0


###############################
###      FRIENDS
###############################
var friends (Inauri|Qizhmur|Selesthiel)
var enemies null
var super.enemies null


###############################
###      LOCKSMITHING
###############################
put #tvar char.locks.boxType box
put #tvar char.locks.lockpickType ring
put #tvar char.locks.boxContainer rucksack


###############################
###      LOOT
###############################
put #tvar char.inv.emptyGemPouchContainer backpack
put #tvar char.inv.fullGemPouchContainer portal
put #tvar char.inv.tempContainer shadows
put #tvar char.inv.defaultContainer backpack


###############################
###      MAGIC
###############################
put #tvar guild Moon Mage
put #tvar char.magic.train.almanacItem 0
put #tvar char.magic.train.almanacContainer 0
put #tvar char.magic.train.minimumConcentration 50
put #tvar char.magic.train.useAlmanac 0
put #tvar char.magic.train.useShadowling 1
put #tvar char.magic.train.useSymbiosis 0
put #tvar char.magic.train.useInvokeSpell 0

put #tvar char.magic.train.spell.Augmentation seer
put #tvar char.magic.train.prep.Augmentation 15
put #tvar char.magic.train.charge.Augmentation 10
put #tvar char.magic.train.harness.Augmentation 0

put #tvar char.magic.train.spell.Utility seer
put #tvar char.magic.train.prep.Utility 15
put #tvar char.magic.train.charge.Utility 10
put #tvar char.magic.train.harness.Utility 0

put #tvar char.magic.train.spell.Warding col
put #tvar char.magic.train.prep.Warding 15
put #tvar char.magic.train.charge.Warding 10
put #tvar char.magic.train.harness.Warding 0


###############################
###      OBSERVE & PREDICT
###############################
put #tvar char.predict.tool divination bones
put #tvar char.predict.tool.container rucksack

put #tvar char.observe.telescope powdery telescope
put #tvar char.observe.telescope.container khor'vela case

put #tvar char.observe.defense Katamba|Magpie
put #tvar char.observe.lore Xibar|Raven|Phoenix
put #tvar char.observe.magic Yavash|Wolf
put #tvar char.observe.offense Cat|Viper
put #tvar char.observe.survival Heart|Ram

put #tvar char.observe.predict 1


###############################
###      PERFORMANCE
###############################
put #tvar char.performance.instrument guti'adar
put #tvar char.performance.song jig
put #tvar char.performance.mood quiet


###############################
###      RESEARCH
###############################
put #tvar char.compendium compendium
put #tvar char.research.interrupt.cast 0
put #tvar char.research.interrupt.study 0
put #tvar char.research.useSanowret 1


###############################
###      TRAINER
###############################
put #tvar char.trainer.almanacContainer satchel
put #tvar char.trainer.almanacItem chronicle
put #tvar char.trainer.firstaid caracal


pause .2
put #parse CHARVARS DONE
exit
