###############################
###      APPRAISE
###############################
put #tvar char.appraise.container 0
put #tvar char.appraise.item my sail pouch


###############################
###      CAMBRINTH
###############################
put #tvar char.cambrinth shard
put #tvar char.focusContainer null
put #tvar char.ritualFocus kingsnake totem
put #tvar char.wornCambrinth 0
put #tvar char.wornFocus 0


###############################
###      CAST
###############################
put #tvar char.cast.invokeSpell 0

put #tvar char.cast.default.charge 3
put #tvar char.cast.default.harness 0
put #tvar char.cast.default.prep 10

put #tvar char.cast.dc.prep 50


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
###      FIGHT
###############################
# Ammo to use for crossbow
put #tvar char.fight.ammo.Crossbow null
put #tvar char.fight.ammo.Bow null
put #tvar char.fight.ammo.Sling null

put #tvar char.fight.arrangeForPart 0
put #tvar char.fight.arrangeFull 0

put #tvar char.fight.avoidDivineOutrage 0

# Whether to use a debilitation spell or not
put #tvar char.fight.debil.use 1

# The debilitation spell to use
put #tvar char.fight.debil.spell calm

# The amount of mana to prep debilitation at
put #tvar char.fight.debil.prepAt 5

# Setting to 1 will force casting a debilitation spell for every attack
# (Otherwise it only does it for learning)
put #tvar char.fight.forceDebil 0

# Force always using stance shield, never stance parry
put #tvar char.fight.forceShield 0

# all|treasure|gems whatever the loot options are
put #tvar char.fight.lootType treasure

# DEPRECATED Script-specifc options (ex: 'backtrain')
put #tvar char.fight.opts null

# Spell to use for TM
put #tvar char.fight.tmSpell pd

#Amount to prep tm spell at
# (NOTE: tm defaults to waiting 5 seconds after targeting to cast!)
put #tvar char.fight.tmPrep 4

# Weapons
put #tvar char.fight.weapons.items nightstick|Empty|naphtha|wand|Empty
put #tvar char.fight.weapons.skills Staves|Brawling|Light_Thrown|Heavy_Thrown|Targeted_Magic

# Use vars are all "Do this thing or not"
# All default to 0
put #tvar char.fight.useAlmanac 0
put #tvar char.fight.useAppraise 1
put #tvar char.fight.useBuffs 0
put #tvar char.fight.useHunt 1
put #tvar char.fight.usePerc 1
put #tvar char.fight.useSanowret 1
put #tvar char.fight.useSkin 1
put #tvar char.fight.useStealth 1

# Moon Mage
put #tvar char.fight.useCol 0
put #tvar char.fight.useMaf 1
put #tvar char.fight.useObserve 0
put #tvar char.fight.useSeer 0
put #tvar char.fight.useShadowling 0
put #tvar char.fight.useShadows 0
put #tvar char.fight.useShw 0
put #tvar char.fight.useSls 0



###############################
###      FRIENDS
###############################
var friends (Inauri|Qizhmur|Selesthiel)
var enemies null
var super.enemies null


###############################
###      MAGIC
###############################
put #tvar guild Moon Mage
put #tvar char.magic.train.almanacItem 0
put #tvar char.magic.train.almanacContainer 0
put #tvar char.magic.train.minimumConcentration 50
put #tvar char.magic.train.useAlmanac 0
put #tvar char.magic.train.useSymbiosis 0
put #tvar char.magic.train.useInvokeSpell 0

put #tvar char.magic.train.spell.Augmentation cv
put #tvar char.magic.train.prep.Augmentation 10
put #tvar char.magic.train.charge.Augmentation 10
put #tvar char.magic.train.harness.Augmentation 0

put #tvar char.magic.train.spell.Utility pg
put #tvar char.magic.train.prep.Utility 10
put #tvar char.magic.train.charge.Utility 5
put #tvar char.magic.train.harness.Utility 0

put #tvar char.magic.train.spell.Warding psy
put #tvar char.magic.train.prep.Warding 10
put #tvar char.magic.train.charge.Warding 5
put #tvar char.magic.train.harness.Warding 0


###############################
###      OBSERVE & PREDICT
###############################
put #tvar char.predict.tool divination bones
put #tvar char.predict.tool.container rucksack

put #tvar char.observe.telescope alerce telescope
put #tvar char.observe.telescope.container khor'vela case

put #tvar char.observe.defense Katamba|Magpie
put #tvar char.observe.lore Xibar|Raven
put #tvar char.observe.magic Yavash|Wolf
put #tvar char.observe.offense Cat
put #tvar char.observe.survival Heart|Ram

put #tvar char.observe.predict 1


###############################
###      PERFORMANCE
###############################
put #tvar char.performance.instrument guti'adar
put #tvar char.performance.song lullaby
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
