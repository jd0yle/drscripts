###############################
###      CAST
###############################
put #tvar char.cambrinth viper
put #tvar char.wornCambrinth 0
put #tvar char.ritualFocus cameo
put #tvar char.wornFocus 0
put #tvar char.focusContainer poke


###############################
###      FRIENDS
###############################
var friends (Selesthiel|Asherasa|Sorhhn|Xomfor|Yraggahh|Qihhth|Diapsid|Qizhmur|Inauri)
enemies (Meiline|Nideya|Psaero)
var super.enemies (Meiline|Nideya|Psaero)


###############################
###      MAGIC
###############################
put #tvar char.magic.train.useSymbiosis 1
put #tvar char.magic.train.wornSanowret 0

put #tvar char.magic.train.spell.Augmentation ags
put #tvar char.magic.train.prep.Augmentation 10
put #tvar char.magic.train.charge.Augmentation 10
put #tvar char.magic.train.harness.Augmentation 0

put #tvar char.magic.train.spell.Utility awaken
put #tvar char.magic.train.prep.Utility 10
put #tvar char.magic.train.charge.Utility 10
put #tvar char.magic.train.harness.Utility 0

put #tvar char.magic.train.spell.Warding tranquil
put #tvar char.magic.train.prep.Warding 7
put #tvar char.magic.train.charge.Warding 10
put #tvar char.magic.train.harness.Warding 0


###############################
###      RESEARCH
###############################
put #tvar char.compendium compendium
put #tvar char.research.interrupt.cast 1
put #tvar char.research.interrupt.study 1
put #tvar char.research.useSanowret 0


pause .2
put #parse CHARVARS DONE
exit
