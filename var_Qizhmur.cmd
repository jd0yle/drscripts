###############################
###      APPRAISE
###############################
put #tvar char.appraise.container portal
put #tvar char.appraise.item my gem pouch


###############################
###      ARMOR
###############################
put #tvar char.armor demonscale leathers|demonscale gloves|gladiator's shield|demonscale helm|demonscale mask|calcified femur


###############################
###      BURGLE
###############################
put #tvar char.burgle.cooldown null


###############################
###      CAMBRINTH
###############################
put #tvar char.cambrinth cambrinth calf
put #tvar char.focusContainer gryphon skull
put #tvar char.ritualFocus null
put #tvar char.wornCambrinth 1
put #tvar char.wornFocus 0


###############################
###      CAST
###############################
put #tvar char.cast.invokeSpell 1

put #tvar char.cast.default.prep 40
put #tvar char.cast.default.charge 40
put #tvar char.cast.default.harness 0

put #tvar char.cast.ch.prep 20
put #tvar char.cast.ch.charge 40

put #tvar char.cast.devour.prep 30
put #tvar char.cast.devour.charge 30

put #tvar char.cast.eotb.prep 20
put #tvar char.cast.eotb.charge 40
put #tvar char.cast.eotb.chargeTimes 1

put #tvar char.cast.gaf.prep 40
put #tvar char.cast.gaf.charge 40
put #tvar char.cast.gaf.chargeTimes 1

put #tvar char.cast.maf.prep 40
put #tvar char.cast.maf.charge 50
put #tvar char.cast.maf.chargeTimes 1

put #tvar char.cast.nr.prep 25
put #tvar char.cast.nr.charge 50
put #tvar char.cast.nr.chargeTimes 1

put #tvar char.cast.obf.prep 40
put #tvar char.cast.obf.charge 50
put #tvar char.cast.obf.chargeTimes 1
put #tvar char.cast.obf.harness 0

put #tvar char.cast.php.prep 40
put #tvar char.cast.php.charge 50
put #tvar char.cast.php.chargeTimes 1

put #tvar char.cast.qe.prep 35
put #tvar char.cast.qe.charge 60
put #tvar char.cast.qe.chargeTimes 1


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

#***** ARRANGE *****
put #tvar char.fight.arrangeForPart 0
put #tvar char.fight.arrangeFull 1

#***** DEBLITATION *****
put #tvar char.fight.debil.use 1

# The debilitation spell to use
put #tvar char.fight.debil.spell pv

# The amount of mana to prep debilitation at
put #tvar char.fight.debil.prepAt 3

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
put #tvar char.fight.tmSpell acs

#Amount to prep tm spell at
# (NOTE: tm defaults to waiting 5 seconds after targeting to cast!)
put #tvar char.fight.tmPrep 10

#***** WEAPONS *****
put #tvar char.fight.weapons.items Empty|Empty|assassin's blade|diamondique hhr'ata|frying pan|spiritwood lockbow|white nightstick
put #tvar char.fight.weapons.skills Targeted_Magic|Brawling|Small_Edged|Heavy_Thrown|Light_Thrown|Crossbow|Staves

#***** ARMOR *****
put #tvar char.fight.armor.skills Chain_Armor|Brigandine|Plate_Armor
put #tvar char.fight.armor.items ring greaves|scale greaves|light greaves
put #tvar char.fight.useArmor 0

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

#***** GENERAL *****
put #tvar char.fight.useMaf 1

#***** MOON MAGE *****
put #tvar char.fight.useCol 0
put #tvar char.fight.useObserve 0
put #tvar char.fight.useSeer 0
put #tvar char.fight.useShadowling 0
put #tvar char.fight.useShadows 0
put #tvar char.fight.useShw 0
put #tvar char.fight.useSls 0

#***** NECRO *****
# The necro ritual to use for training
# (Will still use harvest when low on material, consume for devour, etc.)
put #tvar char.fight.necroRitual dissection

put #tvar char.fight.avoidDivineOutrage 0

put #tvar char.fight.useCh 0
put #tvar char.fight.useIvm 0
put #tvar char.fight.usePhp 0
put #tvar char.fight.useQe 0
put #tvar char.fight.useUsol 1


###############################
###      FRIENDS
###############################
var friends Inauri|Qizhmur|Selesthiel|Khurnaarti
var enemies null
var super.enemies null


###############################
###      LOOT
###############################
put #tvar char.inv.emptyGemPouchContainer wyvern skull
put #tvar char.inv.fullGemPouchContainer portal
put #tvar char.inv.tempContainer wyvern skull
put #tvar char.inv.defaultContainer wyvern skull


###############################
###      MAGIC
###############################
put #tvar char.magic.train.minimumConcentration 30
put #tvar char.magic.train.useAlmanac 1
put #tvar char.magic.train.useSymbiosis 1
put #tvar char.magic.train.useInvokeSpell 1

put #tvar char.magic.train.spell.Augmentation obf
put #tvar char.magic.train.prep.Augmentation 1
if (!($char.magic.train.charge.Augmentation > -1)) then put #tvar char.magic.train.charge.Augmentation 9
put #tvar char.magic.train.harness.Augmentation 12

put #tvar char.magic.train.spell.Utility eotb
put #tvar char.magic.train.prep.Utility 1
if (!($char.magic.train.charge.Utility > -1)) then put #tvar char.magic.train.charge.Utility 10
put #tvar char.magic.train.harness.Utility 12

put #tvar char.magic.train.spell.Warding maf
put #tvar char.magic.train.prep.Warding 1
if (!($char.magic.train.charge.Warding > -1)) then put #tvar char.magic.train.charge.Warding 9
put #tvar char.magic.train.harness.Warding 12

put #tvar char.magic.train.cyclic.Utility 1
put #tvar char.magic.train.cyclic.spell.Utility roc
put #tvar char.magic.train.cyclic.spell.fullName RightofContrition
put #tvar char.magic.train.cyclic.prep.Utility 15


###############################
###      REPAIR
###############################
put #tvar char.repair.forceFangCove true
put #tvar char.repair.money 50
put #var char.repair.weapons.leather demonscale helm|demonscale mask|calcified femur|demonscale leathers|demonscale gloves
put #var char.repair.weapons.metal gladiator's shield


###############################
###      RESEARCH
###############################
put #tvar char.compendium 0
put #tvar char.research.interrupt.cast 1
put #tvar char.research.interrupt.study 0
put #tvar char.research.useSanowret 1


###############################
###      TRAINER
###############################
put #tvar char.trainer.almanacContainer skull
put #tvar char.trainer.almanacItem almanac
put #tvar char.trainer.firstaid 0


pause .2
put #parse CHARVARS DONE
exit
