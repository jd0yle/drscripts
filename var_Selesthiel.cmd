###############################
###      APPRAISE
###############################
put #tvar char.appraise.item gem pouch
put #tvar char.inv.container.appraise portal


###############################
###      ARMOR
###############################
put #tvar char.armor demonscale shield|pugilist's armguard|moonsilk pants|moonsilk shirt|chain gloves|lamellar helm|plate mask
put #tvar char.armor.light demonscale shield|pugilist's armguard|moonsilk pants|moonsilk shirt|moonsilk gloves|moonsilk hood|moonsilk mask
put #tvar char.armor.wyvern demonscale shield|pugilist's armguard|moonsilk pants|moonsilk shirt|chain gloves|moonsilk hood|moonsilk mask


###############################
###      ASTRAL
###############################
put #tvar char.astral.manaPerHarness 75
put #tvar char.astral.timesToHarness 2
put #tvar char.astral.useBc 0


###############################
###      BUFFS
###############################
put #tvar char.buffs.spells shadowling|seer|col|tksh|sr|suf|psy|cv|shadows
put #tvar char.buffs.spellNames Shadowling|SeersSense|CageofLight|TelekineticShield|SentinelsResolve|SureFooting|PsychicShield|ClearVision|Shadows


###############################
###      BURGLE
###############################
put #tvar char.burgle.cooldown null


###############################
###      CAMBRINTH
###############################
put #tvar char.cambrinth mammoth calf
put #tvar char.inv.container.focus steelsilk backpack
put #tvar char.ritualFocus inauri plush
put #tvar char.wornCambrinth 1
put #tvar char.wornFocus 0


###############################
###      CAST
###############################
put #tvar char.cast.invokeSpell 1

put #tvar char.cast.default.prep 30
put #tvar char.cast.default.charge 70
put #tvar char.cast.default.harness 0
put #tvar char.cast.default.chargeTimes 1

put #tvar char.cast.art.minPrepTime 12
put #tvar char.cast.aus.minPrepTime 12
put #tvar char.cast.col.minPrepTime 15
put #tvar char.cast.cv.minPrepTime 12
put #tvar char.cast.fm.minPrepTime 12
put #tvar char.cast.imbue.minPrepTime 12
put #tvar char.cast.lgv.minPrepTime 15
put #tvar char.cast.maf.minPrepTime 8
put #tvar char.cast.moonblade.minPrepTime 8
put #tvar char.cast.mt.minPrepTime 8
put #tvar char.cast.pg.minPrepTime 12
put #tvar char.cast.psy.minPrepTime 8
put #tvar char.cast.rf.minPrepTime 0
put #tvar char.cast.seer.minPrepTime 15
put #tvar char.cast.shadowling.minPrepTime 15
put #tvar char.cast.shadows.minPrepTime 8
put #tvar char.cast.shear.minPrepTime 5
put #tvar char.cast.tksh.minPrepTime 15
put #tvar char.cast.ts.minPrepTime 8
put #tvar char.cast.unleash.minPrepTime 15

put #tvar char.cast.rev.prep 20
put #tvar char.cast.rev.charge 0

put #tvar char.cast.rf.prep 5
put #tvar char.cast.rf.charge 0

put #tvar char.cast.rs.prep 40
put #tvar char.cast.rs.charge 80

put #tvar char.cast.shw.prep 31
put #tvar char.cast.shw.charge 0
put #tvar char.cast.shw.minPrepTime 8

put #tvar char.cast.sls.prep 33
put #tvar char.cast.sls.charge 0
put #tvar char.cast.sls.minPrepTime 10

put #tvar char.cast.suf.prep 100
put #tvar char.cast.suf.charge 0

put #tvar char.cast.sr.prep 100
put #tvar char.cast.sr.charge 0

put #tvar char.cast.ts.prep 30
put #tvar char.cast.ts.charge 70
put #tvar char.cast.ts.chargeTimes 1

put #tvar char.cast.bc.prep 700
put #tvar char.cast.dc.prep 600
put #tvar char.cast.iots.prep 800
put #tvar char.cast.rtr.prep 800

put #tvar char.cast.tattoo.spellName rev


###############################
###      COMPENDIUM
###############################
put #tvar char.compendium third compendium
put #tvar char.compendiums 0
put #tvar char.compendium.forceTurn 1

put #tvar char.inv.container.compendium thigh bag


###############################
###      CRAFT/ENCHANTING
###############################
put #tvar char.inv.craft.container white haversack


###############################
###      FIGHT
###############################
#***** AMMO *****
put #tvar char.fight.ammo.Crossbow matte sphere
put #tvar char.fight.ammo.Bow arrow
put #tvar char.fight.ammo.Slings matte sphere

put #tvar char.fight.wornCrossbow 0

#***** ARRANGE *****
put #tvar char.fight.arrangeForPart 0
put #tvar char.fight.arrangeFull 0

#***** DEBLITATION *****
put #tvar char.fight.debil.use 1

# The debilitation spell to use
put #tvar char.fight.debil.spell mb

# The amount of mana to prep debilitation at
put #tvar char.fight.debil.prepAt 30

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
put #tvar char.fight.tmPrep 40

# How long to pause before casting.
put #tvar char.fight.tmPause 5

#***** WEAPONS *****
#put #tvar char.fight.weapons.items Empty|Empty|hunting bola|haralun scimitar|smokewood pelletbow|Imperial spear|ka'hurst hhr'ata|flamewood riste|iron greatsword
#put #tvar char.fight.weapons.skills Targeted_Magic|Brawling|Light_Thrown|Small_Edged|Crossbow|Polearms|Heavy_Thrown|Twohanded_Blunt|Twohanded_Edged

put #tvar char.fight.weapons.items Empty|Empty|hunting bola|haralun scimitar|smokewood pelletbow|Imperial spear|ka'hurst hhr'ata
put #tvar char.fight.weapons.skills Targeted_Magic|Brawling|Light_Thrown|Small_Edged|Crossbow|Polearms|Heavy_Thrown

put #tvar char.backtrain.items Empty|competition shortbow|diamondwood nightstick|blue sling|ka'hurst hhr'ata|hunting bola|iron greatsword|Imperial spear|flamewood riste|darkstone longsword
put #tvar char.backtrain.skills Outdoorsmanship|Bow|Staves|Slings|Large_Blunt|Small_Blunt|Twohanded_Edged|Polearms|Twohanded_Blunt|Large_Edged

#put #tvar char.fight.weapons.items Empty|Imperial Spear
#put #tvar char.fight.weapons.skills Outdoorsmanship|Polearms

put #tvar char.fight.trainOffhand 1

put #tvar char.fight.aimPauseMin 7

#***** ARMOR *****
put #tvar char.fight.useArmor 0

put #tvar char.fight.armor.skill.0 Light_Armor
put #tvar char.fight.armor.items.0 moonsilk pants|moonsilk hood|moonsilk mask|moonsilk shirt|moonsilk gloves

put #tvar char.fight.armor.skill.1 Chain_Armor
put #tvar char.fight.armor.items.1 ka'hurst hauberk|ka'hurst gloves|ka'hurst balaclava

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

put #tvar char.fight.useTarantula 1

#***** MOON MAGE *****
put #tvar char.fight.useCol 1
put #tvar char.fight.useMaf 0
put #tvar char.fight.useObserve 1
put #tvar char.fight.useRevSorcery 1
put #tvar char.fight.useSeer 1
put #tvar char.fight.useShadowling 1
put #tvar char.fight.useShadows 0
put #tvar char.fight.useShw 1
put #tvar char.fight.useSls 1
put #tvar char.fight.useTksh 1
put #tvar char.fight.useTs 1

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

#***** PALADIN *****
put #tvar char.fight.useSr 0

#***** TRADER *****
put #tvar char.fight.useLgv 0

#***** WARRIOR MAGE *****
put #tvar char.fight.useSuf 1


if ($char.fight.backtrain = 1) then {
    put #tvar char.fight.useSls 0
	put #tvar char.fight.weapons.items Empty|Empty|competition shortbow|diamondwood nightstick|blue sling|ka'hurst hhr'ata|hunting bola|iron greatsword|Imperial spear|flamewood riste|darkstone longsword
	put #tvar char.fight.weapons.skills First_Aid|Outdoorsmanship|Bow|Staves|Slings|Large_Blunt|Small_Blunt|Twohanded_Edged|Polearms|Twohanded_Blunt|Large_Edged

	put #tvar char.fight.arrangeForPart 0
    put #tvar char.fight.debil.use 0
    put #tvar char.fight.useShw 0
    put #tvar char.fight.useDissect 1
    put #tvar char.fight.useHunt 1
    put #tvar char.fight.useShadows 0
    put #tvar char.fight.useStealth 0
    put #tvar char.fight.useTs 0
}


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
put #tvar char.instrument.noun ocarina
put #tvar char.instrument.tap indurium ocarina
put #tvar char.inv.container.instrument thigh bag

put #tvar char.play.useAlmanac 1


###############################
###      INVENTORY
###############################
put #tvar char.inv.container.almanac thigh bag
put #tvar char.inv.container.autoloot 0
put #tvar char.inv.container.default steelsilk backpack
put #tvar char.inv.container.emptyGemPouch steelsilk backpack
put #tvar char.inv.container.fullGemPouch portal
put #tvar char.inv.container.gemPouch gem pouch
put #tvar char.inv.container.holdAnything firesilk rucksack
put #tvar char.inv.container.memoryOrb portal
put #tvar char.inv.container.scroll steelsilk backpack
put #tvar char.inv.container.scrollStackers shadows
put #tvar char.inv.container.scrollTemp duffel
put #tvar char.inv.container.secondary shadows
put #tvar char.inv.container.sellGemBag 0
put #tvar char.inv.container.servantDescription mischievous Shadow Servant composed of fractured shadows
put #tvar char.inv.container.temp shadows
put #tvar char.inv.container.tertiary 0
put #tvar char.inv.container.trash backpack

# Loot
put #tvar char.loot.boxes 0
put #tvar char.loot.nuggetBars 0
if (!($char.loot.untiedGemPouch >0)) then put #tvar char.loot.untiedGemPouch 0


###############################
###      MAGIC
###############################
put #tvar char.magic.train.minimumConcentration 30
put #tvar char.magic.train.useAlmanac 1
put #tvar char.magic.train.useShadowling 1
put #tvar char.magic.train.useSymbiosis 1
put #tvar char.magic.train.useInvokeSpell 1

put #tvar char.magic.train.revSorcery 1

var tmp.charge.Augmentation 80
put #tvar char.magic.train.spell.Augmentation cv
put #tvar char.magic.train.prep.Augmentation 20
put #tvar char.magic.train.minPrepTime.Augmentation 15
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



var tmp.charge.Utility 75
put #tvar char.magic.train.spell.Utility sm
put #tvar char.magic.train.prep.Utility 20
put #tvar char.magic.train.minPrepTime.Utility 15
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
var tmp.charge.Warding 50
put #tvar char.magic.train.spell.Warding shear
put #tvar char.magic.train.prep.Warding 10
put #tvar char.magic.train.minPrepTime.Warding 8
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
###      OBSERVE & PREDICT
###############################
put #tvar char.predict.tool divination bones
put #tvar char.inv.container.predictTool telescope case

put #tvar char.predict.useAus 0
put #tvar char.predict.useDc 0

put #tvar char.predict.preferred.skillset survival
put #tvar char.predict.preferred.skill First Aid

put #tvar char.observe.telescope clockwork telescope
put #tvar char.inv.container.telescope telescope case

put #tvar char.observe.defense Merewalda|Dawgolesh|Penhetia|Giant|Katamba
put #tvar char.observe.lore forge|Amlothi|Verena|Phoenix|Xibar
put #tvar char.observe.magic Ismenia|Durgaulda|Dawgolesh|Toad|Yavash
put #tvar char.observe.offense Estrilda|Szeldia|forge|Spider
put #tvar char.observe.survival Morleena|Yoakena|Er'qutra|Ram

put #tvar char.observe.predict 0


###############################
###      PAWN
###############################
put #tvar char.inv.container.pawn watersilk bag


###############################
###      REPAIR
###############################
put #tvar char.repair.forceFangCove true
put #tvar char.repair.money 50
put #tvar char.repair.waitRoomId 50
#put #tvar char.repair.list moonsilk pants|moonsilk hood|moonsilk mask|moonsilk shirt|moonsilk gloves|steelsilk handwraps|steelsilk footwraps|demonscale shield|$char.fight.weapons.items|parry stick|greaves
put #tvar char.repair.list $char.armor|$char.fight.weapons.items|$char.armor.light


###############################
###      RESEARCH
###############################
put #tvar char.research.interrupt.cast 1
put #tvar char.research.interrupt.study 0
put #tvar char.research.useSanowret 1


###############################
###      TARANTULA
###############################
put #tvar char.tarantula.item harvester spider
put #tvar char.inv.container.tarantula steelsilk backpack

put #tvar char.tarantula.skillsetOrder Magic|Weapon|Armor|Survival|Lore


###############################
###      TRAINER
###############################
put #tvar char.trainer.almanac almanac
put #tvar char.trainer.firstaid 0

pause .2
put #parse CHARVARS DONE
exit
