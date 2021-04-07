###############################
###      APPRAISE
###############################
put #tvar char.appraise.container portal
put #tvar char.appraise.item my gem pouch


###############################
###      BURGLE
###############################
put #tvar char.burgle.cooldown 0


###############################
###      CAMBRINTH
###############################
put #tvar char.cambrinth cambrinth calf
put #tvar char.focusContainer gryphon skull
put #tvar char.ritualFocus null
put #tvar char.wornCambrinth 1
put #tvar char.wornFocus 0


###############################
###      CAST
###############################
put #tvar char.cast.invokeSpell 0

put #tvar char.cast.default.prep 20
put #tvar char.cast.default.charge 40
put #tvar char.cast.default.harness 0

put #tvar char.cast.obf.prep 40
put #tvar char.cast.obf.charge 50
put #tvar char.cast.obf.chargeTimes 1
put #tvar char.cast.obf.harness 0

put #tvar char.cast.maf.prep 40
put #tvar char.cast.maf.charge 50
put #tvar char.cast.maf.chargeTimes 1

put #tvar char.cast.devour.prep 30
put #tvar char.cast.devour.charge 10

put #tvar char.cast.eotb.prep 20
put #tvar char.cast.eotb.charge 40
put #tvar char.cast.eotb.chargeTimes 1

put #tvar char.cast.gaf.prep 40
put #tvar char.cast.gaf.charge 40
put #tvar char.cast.gaf.chargeTimes 1


###############################
###      COMBAT
###############################
put #tvar char.combat.spell.Debilitation 0
put #tvar char.combat.prep.Debilitation 0
put #tvar char.combat.charge.Debilitation 0
put #tvar char.combat.harness.Debilitation 0

put #tvar char.combat.spell.Targeted_Magic 0
put #tvar char.combat.prep.Targeted_Magic 0
put #tvar char.combat.charge.Targeted_Magic 0
put #tvar char.combat.harness.Targeted_Magic 0


###############################
###      FRIENDS
###############################
var friends Inauri|Asherasa|Sorhhn|Xenris|Xomfor|Fostisch
var enemies null
var super.enemies null


###############################
###      MAGIC
###############################
put #tvar char.magic.train.minimumConcentration 30
put #tvar char.magic.train.useAlmanac 1
put #tvar char.magic.train.useSymbiosis 1
put #tvar char.magic.train.useInvokeSpell 0

put #tvar char.magic.train.spell.Augmentation obf
put #tvar char.magic.train.prep.Augmentation 1
if (!($char.magic.train.charge.Augmentation > -1)) then put #tvar char.magic.train.charge.Augmentation 10
put #tvar char.magic.train.harness.Augmentation 8

put #tvar char.magic.train.spell.Utility eotb
put #tvar char.magic.train.prep.Utility 1
if (!($char.magic.train.charge.Utility > -1)) then put #tvar char.magic.train.charge.Utility 10
put #tvar char.magic.train.harness.Utility 8

put #tvar char.magic.train.spell.Warding maf
put #tvar char.magic.train.prep.Warding 1
if (!($char.magic.train.charge.Warding > -1)) then put #tvar char.magic.train.charge.Warding 10
put #tvar char.magic.train.harness.Warding 8


###############################
###      RESEARCH
###############################
put #tvar char.compendium 0
put #tvar char.research.interrupt.cast 1
put #tvar char.research.interrupt.study 0
put #tvar char.research.useSanowret 1


###############################
###      TRAINER
###############################
put #tvar char.trainer.almanacContainer skull
put #tvar char.trainer.almanacItem almanac
put #tvar char.trainer.firstaid 0


pause .2
put #parse CHARVARS DONE
exit
