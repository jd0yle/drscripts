###############################
###      APPRAISE
###############################
put #tvar char.appraise.container 0
put #tvar char.appraise.item my gem pouch


###############################
###      ARMOR
###############################
put #tvar char.armor chain balaclava|chain gloves|moonsilk shirt|moonsilk pants|demonscale shield|knee spikes|elbow spikes|knuckles|footwraps|armguard


###############################
###      BURGLE
###############################
put #tvar char.burgle.cooldown null


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
put #tvar char.craft.item burin
put #tvar char.craft.tool.container workbag
put #tvar char.craft.workorder.item burin


###############################
###      FRIENDS
###############################
var friends (Asherasa|Qihhth|Qizhmur|Selesthiel|Sorhhn|Xomfor|Yraggahh)
var enemies (Kattena|Nideya|Psaero|Zehira)
var super.enemies (Akriana|Azurinna|Cote|Dasheek|Elonda|Enfermo|Erzo|Fahijeck|Kaldean|Meiline|Mitkiahn|Rarnel|Redxwrex|Rhadyn|Ruea|Shanelo|Simmish|Squabbles|Talu|Tartarean|Tenteth|Zehira|Zeteivek)


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
put #tvar guild Empath
put #tvar char.magic.train.minimumConcentration 50
put #tvar char.magic.train.useAlmanac 1
put #tvar char.magic.train.useSymbiosis 1
put #tvar char.magic.train.useInvokeSpell 1

put #tvar char.magic.train.spell.Augmentation vigor
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
###      REPAIR
###############################
put #tvar char.repair.forceFangCove true
put #tvar char.repair.money 10
put #tvar char.repair.leather moonsilk shirt|moonsilk pants|demonscale shield
put #tvar char.repair.metal jagged scythe|assassin's blade|ka'hurst hhr'ata|frying pan|chain balaclava|chain gloves|wood shaper|tapered rasp|carving knife|metal drawknife


###############################
###      RESEARCH
###############################
put #tvar char.compendium compendium
put #tvar char.research.interrupt.cast 1
put #tvar char.research.interrupt.study 1
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
