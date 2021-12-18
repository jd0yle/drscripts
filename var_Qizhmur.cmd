###############################
###      APPRAISE
###############################
put #tvar char.appraise.container portal
put #tvar char.appraise.item my gem pouch


###############################
###      ARMOR
###############################
#put #tvar char.armor demonscale leathers|demonscale gloves|demonscale shield|demonscale helm|demonscale mask|calcified femur
#put #tvar char.armor demonscale leathers|ka'hurst gloves|demonscale shield|ka'hurst balaclava|calcified femur

#put #tvar char.armor demonscale leathers|chain gloves|demonscale shield|chain balaclava|calcified femur
put #tvar char.armor demonscale leathers|plate gauntlets|demonscale shield|scale helm|ring mask|calcified femur


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

put #tvar char.cast.default.prep 20
put #tvar char.cast.default.charge 20
put #tvar char.cast.default.harness 0
put #tvar char.cast.default.chargeTimes 4

put #tvar char.cast.devour.prep 30
put #tvar char.cast.devour.charge 40
put #tvar char.cast.devour.chargeTimes 1

put #tvar char.cast.eotb.prep 5
put #tvar char.cast.eotb.charge 0
put #tvar char.cast.eotb.chargeTimes 0
put #tvar char.cast.eotb.minPrepTime 0

put #tvar char.cast.nr.prep 20
put #tvar char.cast.nr.charge 19
put #tvar char.cast.nr.chargeTimes 4

put #tvar char.cast.php.prep 20
put #tvar char.cast.php.charge 20
put #tvar char.cast.php.chargeTimes 4

put #tvar char.cast.roc.prep 25
put #tvar char.cast.roc.charge 0
put #tvar char.cast.roc.chargeTimes 0

put #tvar char.cast.rog.prep 25
put #tvar char.cast.rog.charge 0
put #tvar char.cast.rog.chargeTimes 0

put #tvar char.cast.usol.prep 12
put #tvar char.cast.usol.charge 0
put #tvar char.cast.usol.chargeTimes 0


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
put #tvar char.fight.arrangeForPart 1
put #tvar char.fight.arrangeFull 0

#***** DEBLITATION *****
put #tvar char.fight.debil.use 1

# The debilitation spell to use
#put #tvar char.fight.debil.spell pv
put #tvar char.fight.debil.spell ip
put #tvar char.fight.debilPauseTime 6

# The amount of mana to prep debilitation at
put #tvar char.fight.debil.prepAt 23

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

# How long to pause before casting.
put #tvar char.fight.tmPause 5

#***** WEAPONS *****
#put #tvar char.fight.weapons.items Empty|Empty|ka'hurst hhr'ata|assassin's blade|frying pan|diamondwood nightstick|spiritwood lockbow|kertig maul|leather sling|iron greatsword
#put #tvar char.fight.weapons.skills Targeted_Magic|Brawling|Heavy_Thrown|Small_Edged|Light_Thrown|Staves|Crossbow|Twohanded_Blunt|Slings|Twohanded_Edged

put #tvar char.fight.weapons.items Empty|Empty|ka'hurst hhr'ata|assassin's blade|frying pan|diamondwood nightstick|spiritwood lockbow|kertig maul|leather sling|iron greatsword|glaes halberd|competition shortbow|frying pan|ka'hurst hhr'ata|haralun broadsword
put #tvar char.fight.weapons.skills Targeted_Magic|Brawling|Heavy_Thrown|Small_Edged|Light_Thrown|Staves|Crossbow|Twohanded_Blunt|Slings|Twohanded_Edged|Polearms|Bow|Small_Blunt|Large_Blunt|Large_Edged

put #tvar char.fight.trainOffhand 1

put #tvar char.fight.aimPauseMin 1

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
put #tvar char.fight.useDissect 0
put #tvar char.fight.useHunt 1
put #tvar char.fight.usePerc 1
put #tvar char.fight.useSanowret 1
put #tvar char.fight.useSkin 1
put #tvar char.fight.useStealth 0

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
###      INSTRUMENT
###############################
put #tvar char.instrument.cloth chamois cloth
put #tvar char.instrument.noun zills
put #tvar char.instrument.tap thin-edged zills
put #tvar char.instrument.container skull


###############################
###      INVENTORY
###############################
put #tvar char.inv.anythingContainer hip pouch
put #tvar char.inv.autolootContainer 0
put #tvar char.inv.defaultContainer wyvern skull
put #tvar char.inv.emptyGemPouchContainer $char.inv.defaultContainer
put #tvar char.inv.fullGemPouchContainer portal
put #tvar char.inv.memoryOrbContainer 0
put #tvar char.inv.secondaryContainer shadows
put #tvar char.inv.tempContainer shadows
put #tvar char.inv.tertiaryContainer 0

# Loot
put #tvar char.loot.boxes 0


###############################
###      MAGIC
###############################
put #tvar char.magic.train.minimumConcentration 30
put #tvar char.magic.train.useAlmanac 1
put #tvar char.magic.train.useSymbiosis 1
put #tvar char.magic.train.useInvokeSpell 1

# CYCLIC
put #tvar char.magic.train.cyclic.Utility 0
put #tvar char.magic.train.cyclic.spell.Utility roc
put #tvar char.magic.train.cyclic.spell.fullName RiteofContrition
put #tvar char.magic.train.cyclic.prep.Utility 20
put #tvar char.magic.train.cyclic.useSymbiosis 1


var tmp.charge.Augmentation 47
put #tvar char.magic.train.spell.Augmentation obf
put #tvar char.magic.train.prep.Augmentation 30
if (!($char.magic.train.charge.Augmentation > -1)) then put #tvar char.magic.train.charge.Augmentation %tmp.charge.Augmentation

# Once enough time has passed since the last backfire for this skill, raise the charge amount by 1 without exceeding the original value
if (!($char.magic.train.lastBackfireGametime.Augmentation > -1)) then put #tvar char.magic.train.lastBackfireGametime.Augmentation 1
evalmath tmp.timeSinceLastBackfire ($gametime - $char.magic.train.lastBackfireGametime.Augmentation)
if (%tmp.timeSinceLastBackfire > 600) then {
    if (%tmp.charge.Augmentation > $char.magic.train.charge.Augmentation) then {
        evalmath tmp ($char.magic.train.charge.Augmentation + 1)
        put #tvar char.magic.train.charge.Augmentation %tmp
        put #tvar char.magic.train.lastBackfireGametime.Augmentation $gametime
        put #echo >Log [magic] Adjusting Augmentation charge amount +1 ($char.magic.train.charge.Augmentation)
        unvar tmp
    }
}
unvar tmp.timeSinceLastBackfire
unvar tmp.charge.Augmentation



var tmp.charge.Utility 47
put #tvar char.magic.train.spell.Utility gaf
put #tvar char.magic.train.prep.Utility 30
if (!($char.magic.train.charge.Utility > -1)) then put #tvar char.magic.train.charge.Utility %tmp.charge.Utility

# Once enough time has passed since the last backfire for this skill, raise the charge amount by 1 without exceeding the original value
if (!($char.magic.train.lastBackfireGametime.Utility > -1)) then put #tvar char.magic.train.lastBackfireGametime.Utility 1
evalmath tmp.timeSinceLastBackfire ($gametime - $char.magic.train.lastBackfireGametime.Utility)
if (%tmp.timeSinceLastBackfire > 600) then {
    if (%tmp.charge.Utility > $char.magic.train.charge.Utility) then {
        evalmath tmp ($char.magic.train.charge.Utility + 1)
        put #tvar char.magic.train.charge.Utility %tmp
        put #tvar char.magic.train.lastBackfireGametime.Utility $gametime
        put #echo >Log [magic] Adjusting Utility charge amount +1 ($char.magic.train.charge.Utility)
        unvar tmp
    }
}
unvar tmp.timeSinceLastBackfire
unvar tmp.charge.Utility


# Temporary holding var so that we can "reset" long enough after a backfire
var tmp.charge.Warding 46
put #tvar char.magic.train.spell.Warding maf
put #tvar char.magic.train.prep.Warding 30
if (!($char.magic.train.charge.Warding > -1)) then put #tvar char.magic.train.charge.Warding %tmp.charge.Warding

# Once enough time has passed since the last backfire for this skill, raise the charge amount by 1 without exceeding the original value
if (!($char.magic.train.lastBackfireGametime.Warding > -1)) then put #tvar char.magic.train.lastBackfireGametime.Warding 1
evalmath tmp.timeSinceLastBackfire ($gametime - $char.magic.train.lastBackfireGametime.Warding)
if (%tmp.timeSinceLastBackfire > 300) then {
    if (%tmp.charge.Warding > $char.magic.train.charge.Warding) then {
        evalmath tmp ($char.magic.train.charge.Warding + 1)
        put #tvar char.magic.train.charge.Warding %tmp
        put #tvar char.magic.train.lastBackfireGametime.Warding $gametime
        put #echo >Log [magic] Adjusting Warding charge amount +1 ($char.magic.train.charge.Warding)
        unvar tmp
    }
}
unvar tmp.timeSinceLastBackfire
unvar tmp.charge.Warding


###############################
###      PAWN
###############################
put #tvar char.pawn.container portal


###############################
###      REPAIR
###############################
put #tvar char.repair.forceFangCove true
put #tvar char.repair.money 50
put #tvar char.repair.waitRoomId 50
#put #tvar char.repair.list demonscale helm|demonscale mask|calcified femur|demonscale leathers|demonscale gloves|demonscale shield
put #tvar char.repair.list $char.armor|$char.fight.weapons.items|$char.armor.light

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
