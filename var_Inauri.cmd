###############################
###      APPRAISE
###############################
put #tvar char.appraise.item $char.inv.container.gemPouch
put #tvar char.inv.container.appraise 0


###############################
###      ARMOR
###############################
put #tvar char.armor chain balaclava|chain gloves|moonsilk shirt|moonsilk pants|demonscale shield|knee spikes|elbow spikes|knuckles|footwraps|armguard


###############################
###      BURGLE
###############################
# ------ ATTEMPT HANDLING ------
# hideBefore: NO/NULL|YES/ON
# maxGrabs: 0-7
# skipRoom: (kitchen|bedroom|workroom|sanctum|armory|library)
# travel: location roomid  ie: knife 450
put #tvar char.burgle.hideBefore NULL
put #tvar char.burgle.maxGrabs 5
put #tvar char.burgle.skipRoom NULL
put #tvar char.burgle.travel NULL

# ------ ENTRY HANDLING ------
# entyMethod: LOCKPICK, ROPE, RING, or TOGGLE.
# lockpickRingType: lockpick ring, lockpick case, lockpick ankle-cuff, golden key.
# ropeType: heavy rope, braided rope
# ropeWorn: NO/NULL, YES/ON
put #tvar char.burgle.entryMethod ROPE
put #tvar char.burgle.lockpickRingType lockpick ring
put #tvar char.burgle.ropeType braided rope
put #tvar char.burgle.ropeWorn NULL

# ------ LOOT HANDLING ------
# pawn:  NO/NULL, YES/ON
# keepThisList:  NULL or array
# trashAllExceptKeep:  NO/NULL, YES/ON
# trashThisList:  NULL or array
put #tvar char.burgle.pawnAll YES
put #tvar char.burgle.keepThisList scimitar|keepsake box|arrow|memory orb|jewelry box
put #tvar char.burgle.trashAllExceptKeep NO
put #tvar char.burgle.trashThisList basket|kaleidoscope|sieve|stick|diary|top|rat|mouse|ball|guide|manual

# ------ STORAGE HANDLING ------
# container: pack, rucksack, portal, shadows, backpack, satchel, etc.
put #tvar char.inv.container.burgle rucksack


###############################
###      CAMBRINTH
###############################
put #tvar char.cambrinth viper
put #tvar char.inv.container.focus poke
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
###      COMMON
###############################
put #tvar char.common.scripts burgle|caracal|compendium|deposit|engbolt|engineer|forage|magic|pawn|repair|research|workorder


###############################
###      COMPENDIUM
###############################
put #tvar char.compendium compendium


###############################
###      CRAFTING
###############################
put #tvar char.craft.count 5
put #tvar char.craft.design 0
put #tvar char.craft.item crown
put #tvar char.craft.workorder.item crown
put #tvar char.inv.container.craft workbag
put #tvar char.inv.container.craftTool workbag


###############################
###      FRIENDS
###############################
put #tvar friends Asherasa|Enthien|Izqhhrzu|Khurnaarti|Qihhth|Qizhmur|Selesthiel|Sorhhn|Xomfor|Yraggahh
put #tvar enemies Nideya|Psaero
put #tvar super.enemies Akriana|Azurinna|Cote|Dasheek|Elonda|Enfermo|Erzo|Fahijeck|Kaldean|Kattena|Meiline|Mitkiahn|Rarnel|Redxwrex|Rhadyn|Ruea|Shanelo|Simmish|Squabbles|Talu|Tartarean|Tenteth|Zehira|Zeteivek


###############################
###      INVENTORY
###############################
put #tvar char.inv.container.almanac satchel
put #tvar char.inv.container.autoloot 0
put #tvar char.inv.container.craft workbag
put #tvar char.inv.container.default satchel
put #tvar char.inv.container.eddy 0
put #tvar char.inv.container.emptyGemPouch 0
put #tvar char.inv.container.fullGemPouch satchel
put #tvar char.inv.container.gemPouch blue pouch
put #tvar char.inv.container.holdAnything poke
put #tvar char.inv.container.memoryOrb satchel
put #tvar char.inv.container.secondary rucksack
put #tvar char.inv.container.temp rucksack
put #tvar char.inv.container.tertiary poke
put #tvar char.inv.container.trash 0

# Loot
put #tvar char.loot.boxes 1
put #tvar char.loot.nuggetBars 1
if (!($char.loot.untiedGemPouch >0)) then put #tvar char.loot.untiedGemPouch 0

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
put #tvar char.magic.train.charge.Augmentation 12
put #tvar char.magic.train.harness.Augmentation 0

put #tvar char.magic.train.spell.Utility awaken
put #tvar char.magic.train.prep.Utility 10
put #tvar char.magic.train.charge.Utility 12
put #tvar char.magic.train.harness.Utility 0

put #tvar char.magic.train.spell.Warding tranquil
put #tvar char.magic.train.prep.Warding 7
put #tvar char.magic.train.charge.Warding 12
put #tvar char.magic.train.harness.Warding 0


###############################
###      PAWN
###############################
put #tvar char.inv.container.pawn rucksack


###############################
###      REPAIR
###############################
put #tvar char.repair.forceFangCove true
put #tvar char.repair.money 10
put #tvar char.repair.list demonscale shield|jagged scythe|wood shaper|tapered rasp|carving knife|metal drawknife|basic stamp


###############################
###      RESEARCH
###############################
put #tvar char.research.interrupt.cast 1
put #tvar char.research.interrupt.study 1
put #tvar char.research.useSanowret 1


###############################
###      TRAINER
###############################
put #tvar char.trainer.almanac chronicle
put #tvar char.trainer.firstaid caracal

pause .2
put #parse CHARVARS DONE
exit
