put #tvar char.cambrinth cambrinth calf
put #tvar char.wornCambrinth 1
put #tvar char.ritualFocus null

###############################
###      MAGIC
###############################
put #tvar char.magic.train.useSymbiosis 1

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
put #tvar $char.compendium 0
put #tvar $char.research.interrupt.cast 1
put #tvar $char.research.interrupt.study 0
put #tvar char.research.useSanowret 0

pause .2
put #parse CHARVARS DONE
exit
