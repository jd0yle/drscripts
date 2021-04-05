###############################
###      APPRAISE
###############################
put #tvar char.appraise.container 0
put #tvar char.appraise.item my gem pouch


###############################
###      CAMBRINTH
###############################
put #tvar char.cambrinth viper
put #tvar char.focusContainer poke
put #tvar char.ritualFocus cameo
put #tvar char.wornCambrinth 1
put #tvar char.wornFocus 0


###############################
###      CAST
###############################
put #tvar char.cast.invokeSpell 1

put #tvar char.cast.default.charge 20
put #tvar char.cast.default.harness 0
put #tvar char.cast.default.prep 10

put #tvar char.cast.pop.prep 300
put #tvar char.cast.pop.charge 30
put #tvar char.cast.pop.chargeTimes 1
put #tvar char.cast.pop.harness 0


###############################
###      CRAFTING
###############################
put #tvar char.craft.container workbag
put #tvar char.craft.default.container satchel
put #tvar char.craft.tool.container workbag
put #tvar char.craft.workorder.item tiara


###############################
###      COMBAT
###############################
put #tvar char.combat.spell.Debilitation lethargy
put #tvar char.combat.prep.Debilitation 5
put #tvar char.combat.charge.Debilitation 0
put #tvar char.combat.harness.Debilitation 0

put #tvar char.combat.spell.Targeted_Magic paralysis
put #tvar char.combat.prep.Targeted_Magic 7
put #tvar char.combat.charge.Targeted_Magic 0
put #tvar char.combat.harness.Targeted_Magic 0


###############################
###      FRIENDS
###############################
var friends (Asherasa|Qihhth|Qizhmur|Selesthiel|Sorhhn|Xomfor|Yraggahh)
var enemies (Meiline|Nideya|Psaero)
var super.enemies (Meiline|Nideya|Psaero)


###############################
###      MAGIC
###############################
put #tvar char.magic.train.useAlmanac 1
put #tvar char.magic.train.useSymbiosis 1

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


###############################
###      TRAINER
###############################
put #tvar char.trainer.almanacContainer satchel
put #tvar char.trainer.almanacItem chronicle
put #tvar char.trainer.firstaid caracal

pause .2
put #parse CHARVARS DONE
exit
