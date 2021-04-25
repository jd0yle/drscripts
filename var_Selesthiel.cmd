###############################
###      APPRAISE
###############################
put #tvar char.appraise.container portal
put #tvar char.appraise.item gem pouch


###############################
###      BURGLE
###############################
put #tvar char.burgle.cooldown null


###############################
###      CAMBRINTH
###############################
put #tvar char.cambrinth mammoth calf
put #tvar char.focusContainer steelsilk backpack
put #tvar char.ritualFocus inauri plush
put #tvar char.wornCambrinth 1
put #tvar char.wornFocus 0


###############################
###      CAST
###############################
put #tvar char.cast.invokeSpell 0

put #tvar char.cast.default.prep 30
put #tvar char.cast.default.charge 70
put #tvar char.cast.default.harness 0

put #tvar char.cast.bc.prep 700
put #tvar char.cast.dc.prep 600


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
###      FIGHT
###############################
#***** AMMO *****
put #tvar char.fight.ammo.Crossbow basilisk bolt
put #tvar char.fight.ammo.Bow basilisk arrow
put #tvar char.fight.ammo.Slings rock

put #tvar char.fight.wornCrossbow 0

#***** ARRANGE *****
put #tvar char.fight.arrangeForPart 0
put #tvar char.fight.arrangeFull 0

#***** DEBLITATION *****
put #tvar char.fight.debil.use 1

# The debilitation spell to use
put #tvar char.fight.debil.spell mb

# The amount of mana to prep debilitation at
put #tvar char.fight.debil.prepAt 20

# Setting to 1 will force casting a debilitation spell for every attack
# (Otherwise it only does it for learning)
put #tvar char.fight.forceDebil 0

#***** STANCE *****
# Force always using stance shield, never stance parry
put #tvar char.fight.forceShield 0

#***** LOOT *****
# all|treasure|gems whatever the loot options are
put #tvar char.fight.lootType treasure

# DEPRECATED Script-specifc options (ex: 'backtrain')
put #tvar char.fight.opts null

#***** TM *****
# Spell to use for TM
put #tvar char.fight.tmSpell pd

#Amount to prep tm spell at
# (NOTE: tm defaults to waiting 5 seconds after targeting to cast!)
put #tvar char.fight.tmPrep 30

#***** WEAPONS *****
put #tvar char.fight.weapons.items Empty|Empty|haralun scimitar|hunting bola|competition crossbow
put #tvar char.fight.weapons.skills Targeted_Magic|Brawling|Small_Edged|Light_Thrown|Crossbow

#***** ARMOR *****
put #tvar char.fight.armor.skills Chain_Armor|Brigandine|Plate_Armor
put #tvar char.fight.armor.items ring greaves|scale greaves|light greaves
put #tvar char.fight.useArmor 1

#***** USE *****
# Use vars are all "Do this thing or not"
# All default to 0
put #tvar char.fight.useAlmanac 1
put #tvar char.fight.useAppraise 1
put #tvar char.fight.useBuffs 1
put #tvar char.fight.useHunt 1
put #tvar char.fight.usePerc 1
put #tvar char.fight.useSanowret 1
put #tvar char.fight.useSkin 1
put #tvar char.fight.useStealth 1

#***** MOON MAGE *****
put #tvar char.fight.useCol 1
put #tvar char.fight.useMaf 1
put #tvar char.fight.useObserve 1
put #tvar char.fight.useSeer 1
put #tvar char.fight.useShadowling 1
put #tvar char.fight.useShadows 1
put #tvar char.fight.useShw 1
put #tvar char.fight.useSls 1

#***** NECRO *****
# The necro ritual to use for training
# (Will still use harvest when low on material, consume for devour, etc.)
put #tvar char.fight.necroRitual dissection

put #tvar char.fight.avoidDivineOutrage 0

put #tvar char.fight.useCh 0
put #tvar char.fight.useIvm 0
put #tvar char.fight.usePhp 0
put #tvar char.fight.useQe 0
put #tvar char.fight.useUsol 0


###############################
###      FRIENDS
###############################
var friends Inauri|Qizhmur|Selesthiel|Khurnaarti
var enemies null
var super.enemies null


###############################
###      LOOT
###############################
put #tvar char.inv.emptyGemPouchContainer steelsilk backpack
put #tvar char.inv.fullGemPouchContainer portal
put #tvar char.inv.tempContainer shadows
put #tvar char.inv.defaultContainer steelsilk backpack


###############################
###      MAGIC
###############################
put #tvar char.magic.train.minimumConcentration 30
put #tvar char.magic.train.useAlmanac 1
put #tvar char.magic.train.useShadowling 1
put #tvar char.magic.train.useSymbiosis 1
put #tvar char.magic.train.useInvokeSpell 0

put #tvar char.magic.train.spell.Augmentation cv
put #tvar char.magic.train.prep.Augmentation 10
if (!($char.magic.train.charge.Augmentation > -1)) then put #tvar char.magic.train.charge.Augmentation 60

put #tvar char.magic.train.spell.Utility sm
put #tvar char.magic.train.prep.Utility 20
if (!($char.magic.train.charge.Utility > -1)) then put #tvar char.magic.train.charge.Utility 35

put #tvar char.magic.train.spell.Warding maf
put #tvar char.magic.train.prep.Warding 10
if (!($char.magic.train.charge.Warding > -1)) then put #tvar char.magic.train.charge.Warding 60



###############################
###      OBSERVE & PREDICT
###############################
put #tvar char.predict.tool divination bones
put #tvar char.predict.tool.container telescope case

put #tvar char.observe.telescope clockwork telescope
put #tvar char.observe.telescope.container telescope case

put #tvar char.observe.defense Merewalda|Dawgolesh|Penhetia|Giant|Katamba
put #tvar char.observe.lore forge|Amlothi|Verena|Phoenix|Xibar
put #tvar char.observe.magic Ismenia|Durgaulda|Dawgolesh|Toad|Yavash
put #tvar char.observe.offense Estrilda|Szeldia|forge|Spider
put #tvar char.observe.survival Morleena|Yoakena|Er'qutra|Ram

put #tvar char.observe.predict 0


###############################
###      REPAIR
###############################
put #tvar char.repair.money 50
put #var char.repair.leather moonsilk pants|moonsilk hood|moonsilk mask|moonsilk shirt|moonsilk gloves|steelsilk handwraps|steelsilk footwraps|demonscale shield
put #var char.repair.metal $char.fight.weapons.items|stick|greaves


###############################
###      RESEARCH
###############################
put #tvar char.compendium third compendium
put #tvar char.research.interrupt.cast 1
put #tvar char.research.interrupt.study 0
put #tvar char.research.useSanowret 1


###############################
###      TRAINER
###############################
put #tvar char.trainer.almanacContainer thigh bag
put #tvar char.trainer.almanacItem almanac
put #tvar char.trainer.firstaid 0

pause .2
put #parse CHARVARS DONE
exit
