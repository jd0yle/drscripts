###############################
###      APPRAISE
###############################
put #tvar char.appraise.container canvas backpack
put #tvar char.appraise.item diamondique hhr'ata


###############################
###      ARMOR
###############################
#put #tvar char.armor ash leathers|ash gloves|ash cowl|demonscale shield|parry stick
put #tvar char.armor chain balaclava|chain gloves|moonsilk shirt|moonsilk pants|demonscale shield|parry stick

###############################
###      BURGLE
###############################
put #tvar char.burgle.cooldown null


###############################
###      CAMBRINTH
###############################
put #tvar char.cambrinth cambrinth armband
put #tvar char.focusContainer canvas backpack
put #tvar char.ritualFocus dove totem
put #tvar char.wornCambrinth 0
put #tvar char.wornFocus 0


###############################
###      CAST
###############################
put #tvar char.cast.invokeSpell 0

put #tvar char.cast.default.prep 1
put #tvar char.cast.default.charge 12
put #tvar char.cast.default.harness 0

put #tvar char.cast.pom.prep 160

put #tvar char.cast.sol.prep 15
put #tvar char.cast.sol.charge 1
put #tvar char.cast.sol.harness 0

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
put #tvar char.fight.ammo.Crossbow bolt
put #tvar char.fight.ammo.Bow arrow
put #tvar char.fight.ammo.Slings rock

put #tvar char.fight.wornCrossbow 0

#***** ARRANGE *****
put #tvar char.fight.arrangeForPart 0
put #tvar char.fight.arrangeFull 1

#***** DEBLITATION *****
put #tvar char.fight.debil.use 1

# The debilitation spell to use
put #tvar char.fight.debil.spell sick

# The amount of mana to prep debilitation at
put #tvar char.fight.debil.prepAt 1

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
put #tvar char.fight.tmSpell horn

#Amount to prep tm spell at
# (NOTE: tm defaults to waiting 5 seconds after targeting to cast!)
put #tvar char.fight.tmPrep 3

# How long to pause before casting.
put #tvar char.fight.tmPause 5

#***** WEAPONS *****
put #tvar char.fight.weapons.items blood-red scythe|Empty|Empty|dragonwood crossbow|diamondique hhr'ata|triple-weighted bola|white nightstick|blue sling|bastard sword|bastard sword
put #tvar char.fight.weapons.skills Polearms|Targeted_Magic|Brawling|Crossbow|Heavy_Thrown|Light_Thrown|Staves|Slings|Large_Edged|Twohanded_Edged

#***** ARMOR *****
put #tvar char.fight.armor.skills Chain_Armor|Brigandine|Plate_Armor
put #tvar char.fight.armor.items ring greaves|scale greaves|light greaves
put #tvar char.fight.useArmor 0

#***** USE *****
# Use vars are all "Do this thing or not"
# All default to 0
put #tvar char.fight.useAlmanac 0
put #tvar char.fight.useAppraise 1
put #tvar char.fight.useBuffs 1
put #tvar char.fight.useHunt 1
put #tvar char.fight.usePerc 1
put #tvar char.fight.useSanowret 1
put #tvar char.fight.useSkin 1
put #tvar char.fight.useStealth 0

#***** AP *****
put #tvar char.fight.useMaf 1

#***** CLERIC *****
put #tvar char.fight.usePray 1
put #tvar char.fight.prayTarget Huldah

put #tvar char.fight.useMapp 1
put #tvar char.fight.useMpp 1
put #tvar char.fight.useSol 1

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
put #tvar char.fight.necroRitual null

put #tvar char.fight.avoidDivineOutrage 0

put #tvar char.fight.useCh 0
put #tvar char.fight.useIvm 0
put #tvar char.fight.usePhp 0
put #tvar char.fight.useQe 0
put #tvar char.fight.useUsol 0

#***** RANGER *****
put #tvar char.fight.useInst 0
put #tvar char.fight.useStw 0



###############################
###      FRIENDS
###############################
var friends Inauri|Qizhmur|Selesthiel|Khurnaarti
var enemies null
var super.enemies null


###############################
###      LOOT
###############################
put #tvar char.inv.emptyGemPouchContainer canvas backpack
put #tvar char.inv.fullGemPouchContainer thigh bag
put #tvar char.inv.tempContainer canvas backpack
put #tvar char.inv.defaultContainer canvas backpack
put #tvar char.loot.boxes 0


###############################
###      MAGIC
###############################
put #tvar char.magic.train.minimumConcentration 30
put #tvar char.magic.train.useAlmanac 0
put #tvar char.magic.train.usePom 1
put #tvar char.magic.train.useShadowling 0
put #tvar char.magic.train.useSymbiosis 0
put #tvar char.magic.train.useInvokeSpell 0

put #tvar char.magic.train.usePray 1
put #tvar char.magic.train.prayTarget Huldah

put #tvar char.magic.train.spell.Augmentation centering
put #tvar char.magic.train.prep.Augmentation 1
if (!($char.magic.train.charge.Augmentation > -1)) then put #tvar char.magic.train.charge.Augmentation 3

put #tvar char.magic.train.spell.Utility bless
put #tvar char.magic.train.prep.Utility 1
if (!($char.magic.train.charge.Utility > -1)) then put #tvar char.magic.train.charge.Utility 3

#put #tvar char.magic.train.spell.Warding maf
#put #tvar char.magic.train.prep.Warding 1
#if (!($char.magic.train.charge.Warding > -1)) then put #tvar char.magic.train.charge.Warding 3


var var.magic.Augmentation 12
put #tvar char.magic.train.spell.Augmentation centering
put #tvar char.magic.train.prep.Augmentation 1
if (!($char.magic.train.charge.Augmentation > -1)) then put #tvar char.magic.train.charge.Augmentation %var.magic.Augmentation

# Once enough time has passed since the last backfire for this skill, raise the charge amount by 1 without exceeding the original value
if (!($char.magic.train.lastBackfireGametime.Augmentation > -1)) then put #tvar char.magic.train.lastBackfireGametime.Augmentation 1
if (evalmath($gametime - $char.magic.train.lastBackfireGametime.Augmentation) > 3600) then {
    if (%var.magic.Augmentation > $char.magic.train.charge.Augmentation) then {
        evalmath tmp ($char.magic.train.charge.Augmentation + 1)
        put #tvar char.magic.train.charge.Augmentation %tmp
        put #tvar char.magic.train.lastBackfireGametime.Augmentation $gametime
        put #echo >Log [magic] Adjusting Augmentation charge amount +1 ($char.magic.train.charge.Augmentation)
        unvar tmp
    }
}
unvar var.magic.Augmentation



var var.magic.Utility 12
put #tvar char.magic.train.spell.Utility bless
put #tvar char.magic.train.prep.Utility 1
if (!($char.magic.train.charge.Utility > -1)) then put #tvar char.magic.train.charge.Utility %var.magic.Utility

# Once enough time has passed since the last backfire for this skill, raise the charge amount by 1 without exceeding the original value
if (!($char.magic.train.lastBackfireGametime.Utility > -1)) then put #tvar char.magic.train.lastBackfireGametime.Utility 1
if (evalmath($gametime - $char.magic.train.lastBackfireGametime.Utility) > 3600) then {
    if (%var.magic.Utility > $char.magic.train.charge.Utility) then {
        evalmath tmp ($char.magic.train.charge.Utility + 1)
        put #tvar char.magic.train.charge.Utility %tmp
        put #tvar char.magic.train.lastBackfireGametime.Utility $gametime
        put #echo >Log [magic] Adjusting Utility charge amount +1 ($char.magic.train.charge.Utility)
        unvar tmp
    }
}
unvar var.magic.Utility



# Temporary holding var so that we can "reset" long enough after a backfire
var var.magic.Warding 12
put #tvar char.magic.train.spell.Warding maf
put #tvar char.magic.train.prep.Warding 1
if (!($char.magic.train.charge.Warding > -1)) then put #tvar char.magic.train.charge.Warding %var.magic.Warding

# Once enough time has passed since the last backfire for this skill, raise the charge amount by 1 without exceeding the original value
if (!($char.magic.train.lastBackfireGametime.Warding > -1)) then put #tvar char.magic.train.lastBackfireGametime.Warding 1
if (evalmath($gametime - $char.magic.train.lastBackfireGametime.Warding) > 3600) then {
    if (%var.magic.Warding > $char.magic.train.charge.Warding) then {
        evalmath tmp ($char.magic.train.charge.Warding + 1)
        put #tvar char.magic.train.charge.Warding %tmp
        put #tvar char.magic.train.lastBackfireGametime.Warding $gametime
        put #echo >Log [magic] Adjusting Warding charge amount +1 ($char.magic.train.charge.Warding)
        unvar tmp
    }
}
unvar var.magic.Warding


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
put #tvar char.repair.forceFangCove true
put #tvar char.repair.money 50
put #tvar char.repair.waitRoomId 106
put #var char.repair.leather moonsilk pants|moonsilk hood|moonsilk mask|moonsilk shirt|moonsilk gloves|steelsilk handwraps|steelsilk footwraps|demonscale shield
put #var char.repair.metal $char.fight.weapons.items|parry stick|greaves


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
