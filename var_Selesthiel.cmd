###############################
###      CAST
###############################
put #tvar char.cambrinth mammoth calf
put #tvar char.wornCambrinth 1
put #tvar char.ritualFocus inauri plush
put #tvar char.wornFocus 0
put #tvar char.focusContainer steelsilk backpack


###############################
###      MAGIC
###############################
put #tvar char.magic.train.useSymbiosis 1

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
###      RESEARCH
###############################
put #tvar char.compendium third compendium
put #tvar char.research.interrupt.cast 1
put #tvar char.research.interrupt.study 0
put #tvar char.research.useSanowret 1


pause .2
put #parse CHARVARS DONE
exit
