###############################
###      CAST
###############################
put #tvar char.cambrinth cambrinth calf
put #tvar char.cast.default.charge 20
put #tvar char.cast.default.harness 40
put #tvar char.cast.default.prep 60
put #tvar char.focusContainer gryphon skull
put #tvar char.ritualFocus null
put #tvar char.wornCambrinth 1
put #tvar char.wornFocus 0

put #tvar char.cast.invokeSpell 0

put #tvar char.cast.default.prep 60
put #tvar char.cast.default.charge 20
put #tvar char.cast.default.harness 40

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
###      FRIENDS
###############################
var friends Inauri|Asherasa|Sorhhn|Xenris|Xomfor|Fostisch
var enemies null
var super.enemies null


###############################
###      MAGIC
###############################
put #tvar char.magic.train.almanacItem almanac
put #tvar char.magic.train.almanacContainer skull
put #tvar char.magic.train.useAlmanac 1
put #tvar char.magic.train.useSymbiosis 1
put #tvar char.magic.train.wornSanowret 1

put #tvar char.magic.train.spell.Augmentation obf
put #tvar char.magic.train.prep.Augmentation 1
put #tvar char.magic.train.charge.Augmentation 8
put #tvar char.magic.train.harness.Augmentation 5

put #tvar char.magic.train.spell.Utility eotb
put #tvar char.magic.train.prep.Utility 1
put #tvar char.magic.train.charge.Utility 6
put #tvar char.magic.train.harness.Utility 6

put #tvar char.magic.train.spell.Warding maf
put #tvar char.magic.train.prep.Warding 1
put #tvar char.magic.train.charge.Warding 7
put #tvar char.magic.train.harness.Warding 6


###############################
###      RESEARCH
###############################
put #tvar char.compendium 0
put #tvar char.research.interrupt.cast 1
put #tvar char.research.interrupt.study 0
put #tvar char.research.useSanowret 1


pause .2
put #parse CHARVARS DONE
exit
