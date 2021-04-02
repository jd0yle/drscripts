put #tvar char.cambrinth armband
put #tvar char.wornCambrinth 1
put #tvar char.ritualFocus kingsnake totem

###############################
###      MAGIC
###############################
put #tvar char.magic.train.useSymbiosis 0

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
###      RESEARCH
###############################
put #tvar char.compendium compendium
put #tvar char.research.interrupt.cast 0
put #tvar char.research.interrupt.study 0
put #tvar char.research.useSanowret 1

pause .2
put #parse CHARVARS DONE
exit
