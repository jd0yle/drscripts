###############################
###      STORAGE
###############################
put #tvar char.storage.default wyvern skull

put #tvar char.storage.holyWater witch jar
put #tvar char.storage.incense $char.storage.default


###############################
###      APPRAISE
###############################
put #tvar char.appraise.item gem pouch
put #tvar char.inv.container.appraise portal


###############################
###      ARMOR
###############################
# Just light and chain
#put #tvar char.armor demonscale shield|parry stick|ka'hurst hauberk|demonscale gloves|ka'hurst balaclava

# Light, Chain, Brig, Plate
put #tvar char.armor demonscale shield|parry stick|ka'hurst hauberk|demonscale gloves|scale helm|plate mask

put #tvar char.armor.chain demonscale shield|parry stick|ka'hurst hauberk|ka'hurst gloves|ka'hurst balaclava


###############################
###      BUFFS
###############################
put #tvar char.buffs.spells pom|mf|benediction|mapp|mpp|sol|centering|auspice|gg
put #tvar char.buffs.spellNames KuraSilma|ButchersEye|IvoryMask|PhilosophersPreservation


###############################
###      BURGLE
###############################
put #tvar char.burgle.cooldown null


###############################
###      CAMBRINTH
###############################
put #tvar char.cambrinth cambrinth spiderling
put #tvar char.inv.container.focus $char.storage.default
put #tvar char.wornCambrinth 1

#put #tvar char.ritualFocus ouroboros ring
put #tvar char.ritualFocus sigil-laced skull
put #tvar char.wornFocus 0


###############################
###      CAST
###############################
put #tvar char.cast.invokeSpell 1

put #tvar char.cast.default.prep 20
put #tvar char.cast.default.charge 20
put #tvar char.cast.default.harness 0
put #tvar char.cast.default.chargeTimes 4

put #tvar char.cast.useOm 1
put #tvar char.cast.omSpells auspice|benediction|centering|dr|gg|mapp|mpp|sol|sos|pfe|mf|pom

put #tvar char.cast.benediction.prep 20
put #tvar char.cast.benediction.charge 25
put #tvar char.cast.benediction.harness 0
put #tvar char.cast.benediction.chargeTimes 3

put #tvar char.cast.centering.prep 20
put #tvar char.cast.centering.charge 20
put #tvar char.cast.centering.chargeTimes 4

put #tvar char.cast.ghs.prep 25
put #tvar char.cast.ghs.charge 0
put #tvar char.cast.ghs.harness 0

put #tvar char.cast.halo.prep 30
put #tvar char.cast.halo.charge 20
put #tvar char.cast.halo.chargeTimes 2

put #tvar char.cast.hyh.prep 23
put #tvar char.cast.hyh.charge 0
put #tvar char.cast.hyh.harness 0

put #tvar char.cast.mapp.prep 20
put #tvar char.cast.mapp.charge 20
put #tvar char.cast.mapp.harness 0
put #tvar char.cast.mapp.chargeTimes 4

put #tvar char.cast.mpp.prep 20
put #tvar char.cast.mpp.charge 20
put #tvar char.cast.mpp.harness 0
put #tvar char.cast.mpp.chargeTimes 4

put #tvar char.cast.mf.prep 800

put #tvar char.cast.om.prep 70
put #tvar char.cast.om.charge 20
put #tvar char.cast.om.chargeTimes 4

put #tvar char.cast.pom.prep 700

put #tvar char.cast.rejuv.prep 5
put #tvar char.cast.rejuv.charge 25
put #tvar char.cast.rejuv.harness 20
put #tvar char.cast.rejuv.chargeTimes 3

put #tvar char.cast.rev.prep 25
put #tvar char.cast.rev.charge 0
put #tvar char.cast.rev.harness 0

put #tvar char.cast.sol.prep 20
put #tvar char.cast.sol.charge 20
put #tvar char.cast.sol.harness 0
put #tvar char.cast.sol.chargeTimes 4

put #tvar char.cast.sl.prep 20
put #tvar char.cast.sl.charge 15
put #tvar char.cast.sl.harness 0
put #tvar char.cast.sl.chargeTimes 2

put #tvar char.cast.pfe.prep 10
put #tvar char.cast.pfe.charge 30
put #tvar char.cast.pfe.harness 0
put #tvar char.cast.pfe.chargeTimes 2


###############################
###      CRAFTING
###############################
#put #tvar char.inv.container.craft $char.inv.container.default
put #tvar char.inv.container.craft alchemist kit
put #tvar char.inv.container.craftTool alchemist kit
put #tvar char.craft.workorder.item burin
#put #tvar char.craft.item burin


###############################
###      COMPENDIUM
###############################
put #tvar char.compendium 0
put #tvar char.compendiums black compendium|bloodstained compendium|pale compendium
put #tvar char.compendium.forceTurn 1


###############################
###      FIGHT
###############################
#***** AMMO *****
#put #tvar char.fight.ammo.Crossbow bolt
#put #tvar char.fight.ammo.Bow arrow
#put #tvar char.fight.ammo.Slings rock

put #tvar char.fight.ammo.Crossbow matte sphere
put #tvar char.fight.ammo.Bow arrow
put #tvar char.fight.ammo.Slings matte sphere

put #tvar char.fight.wornCrossbow 0

#***** ARRANGE *****
put #tvar char.fight.arrangeForPart 0
put #tvar char.fight.arrangeFull 0

#***** DEBLITATION *****
put #tvar char.fight.debil.use 1
#put #tvar char.fight.debilPauseTime 5
put #tvar char.fight.debilPauseTime 4

# The debilitation spell to use
#put #tvar char.fight.debil.spell sick
put #tvar char.fight.debil.spell ps

# The amount of mana to prep debilitation at
put #tvar char.fight.debil.prepAt 13

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
put #tvar char.fight.tmSpell he
#put #tvar char.fight.tmSpell horn

#Amount to prep tm spell at
# (NOTE: tm defaults to waiting 5 seconds after targeting to cast!)
put #tvar char.fight.tmPrep 30

# How long to pause before casting.
put #tvar char.fight.tmPause 5

#***** WEAPONS *****

# smokewood pelletbow
#put #tvar char.fight.weapons.items Empty|blood-red scythe|Empty|smokewood pelletbow|ka'hurst hhr'ata|darkstone longsword|tyrium cuska|blue sling|ka'hurst hhr'ata|bastard sword|steel hanger|competition shortbow|white nightstick|tyrium cuska|kertig maul
#put #tvar char.fight.weapons.skills Targeted_Magic|Polearms|Brawling|Crossbow|Heavy_Thrown|Large_Edged|Light_Thrown|Slings|Large_Blunt|Twohanded_Edged|Small_Edged|Bow|Staves|Small_Blunt|Twohanded_Blunt

put #tvar char.fight.weapons.items Empty|blood-red scythe|Empty|smokewood pelletbow|ka'hurst hhr'ata|darkstone longsword|tyrium cuska|blue sling|ka'hurst hhr'ata
put #tvar char.fight.weapons.skills Targeted_Magic|Polearms|Brawling|Crossbow|Heavy_Thrown|Large_Edged|Light_Thrown|Slings|Large_Blunt

# Everything including backtrain stuff
#put #tvar char.fight.weapons.items Empty|blood-red scythe|Empty|smokewood pelletbow|ka'hurst hhr'ata|darkstone longsword|tyrium cuska|blue sling|ka'hurst hhr'ata|Empty|bastard sword|kertig maul|steel hanger|tyrium cuska|competition shortbow|white nightstick
#put #tvar char.fight.weapons.skills Targeted_Magic|Polearms|Brawling|Crossbow|Heavy_Thrown|Large_Edged|Light_Thrown|Slings|Large_Blunt|Outdoorsmanship|Twohanded_Edged|Twohanded_Blunt|Small_Edged|Small_Blunt|Bow|Staves


put #tvar char.fight.trainOffhand 1

put #tvar char.fight.aimPauseMin 4

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
put #tvar char.fight.useDissect 0
put #tvar char.fight.useHunt 1
put #tvar char.fight.usePerc 1
put #tvar char.fight.useSanowret 1
put #tvar char.fight.useSkin 1
put #tvar char.fight.useStealth 0

put #tvar char.fight.useTarantula 1

#***** AP *****
put #tvar char.fight.useMaf 0

#***** CLERIC *****
put #tvar char.fight.useCommuneMeraud 1

put #tvar char.fight.usePray 1
put #tvar char.fight.prayTarget Huldah

put #tvar char.fight.useAuspice 1
put #tvar char.fight.useBenediction 1
put #tvar char.fight.useBless 1
put #tvar char.fight.useCentering 1
put #tvar char.fight.useGg 0
put #tvar char.fight.useGhs 1
put #tvar char.fight.useHyh 1
put #tvar char.fight.useMapp 1
put #tvar char.fight.useMf 1
put #tvar char.fight.useMpp 1
put #tvar char.fight.useOm 1
put #tvar char.fight.usePfe 0
put #tvar char.fight.usePom 1
put #tvar char.fight.useRev 1
put #tvar char.fight.useSap 0
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
put #tvar char.fight.necroButchery 0
put #tvar char.fight.avoidDivineOutrage 0

put #tvar char.fight.useCh 0
put #tvar char.fight.useIvm 0
put #tvar char.fight.usePhp 0
put #tvar char.fight.useQe 0
put #tvar char.fight.useUsol 0

#***** RANGER *****
put #tvar char.fight.useInst 0
put #tvar char.fight.useStw 0


if ($char.fight.backtrain = 1) then {
    put #tvar char.fight.useHyh 0
    put #tvar char.fight.weapons.items Empty|bastard sword|kertig maul|steel hanger|tyrium cuska|competition shortbow|white nightstick
    put #tvar char.fight.weapons.skills Outdoorsmanship|Twohanded_Edged|Twohanded_Blunt|Small_Edged|Small_Blunt|Bow|Staves

    put #tvar char.fight.debil.spell sick
    put #tvar char.fight.debil.prepAt 13
    put #tvar char.fight.debilPauseTime 8

    put #tvar char.fight.tmSpell horn
    put #tvar char.fight.tmPrep 25

    put #tvar char.fight.useBless 0

	put #tvar char.fight.arrangeForPart 0
    put #tvar char.fight.debil.use 0
    put #tvar char.fight.useDissect 1
    put #tvar char.fight.useHunt 1
    put #tvar char.fight.trainOffhand 0

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
put #tvar char.instrument.noun rattle
put #tvar char.instrument.tap voodoo priest's rattle
put #tvar char.inv.container.instrument thigh bag


###############################
###      INVENTORY
###############################
# char.inventory.numIncense
# char.inventory.numHolyWater

put #tvar char.inv.container.incense devotional bag
put #tvar char.inv.container.holyWater witch jar


###############################
###      LOOT
###############################
put #tvar char.inv.container.almanac thigh bag
put #tvar char.inv.container.autoloot 0
put #tvar char.inv.container.default wyvern skull
put #tvar char.inv.container.emptyGemPouch $char.inv.container.default
put #tvar char.inv.container.fullGemPouch portal
put #tvar char.inv.container.gemPouch gem pouch
put #tvar char.inv.container.holdAnything thornweave bag
put #tvar char.inv.container.memoryOrb 0
put #tvar char.inv.container.secondary canvas backpack
put #tvar char.inv.container.sellGemBag 0
put #tvar char.inv.container.temp alchemist's kit
put #tvar char.inv.container.tertiary 0
put #tvar char.inv.container.trash 0

# Loot
put #tvar char.loot.boxes 0
put #tvar char.loot.nuggetBars 0
if (!($char.loot.untiedGemPouch >0)) then put #tvar char.loot.untiedGemPouch 0


###############################
###      MAGIC
###############################
put #tvar char.magic.train.minimumConcentration 30
put #tvar char.magic.train.useAlmanac 0
put #tvar char.magic.train.usePom 1
put #tvar char.magic.train.useShadowling 0
put #tvar char.magic.train.useSymbiosis 0
put #tvar char.magic.train.useInvokeSpell 1

put #tvar char.magic.train.usePray 1
put #tvar char.magic.train.prayTarget Huldah

put #tvar char.magic.train.spell.Augmentation centering
put #tvar char.magic.train.prep.Augmentation 20
if (!($char.magic.train.charge.Augmentation > -1)) then put #tvar char.magic.train.charge.Augmentation 3

put #tvar char.magic.train.spell.Utility bless
put #tvar char.magic.train.prep.Utility 1
if (!($char.magic.train.charge.Utility > -1)) then put #tvar char.magic.train.charge.Utility 3

#put #tvar char.magic.train.spell.Warding maf
#put #tvar char.magic.train.prep.Warding 1
#if (!($char.magic.train.charge.Warding > -1)) then put #tvar char.magic.train.charge.Warding 3


var var.magic.Augmentation 20
put #tvar char.magic.train.spell.Augmentation centering
put #tvar char.magic.train.prep.Augmentation 20
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



var var.magic.Utility 10
put #tvar char.magic.train.spell.Utility bless
put #tvar char.magic.train.prep.Utility 30
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
var var.magic.Warding 30
put #tvar char.magic.train.spell.Warding mpp
put #tvar char.magic.train.prep.Warding 10
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
###      REPAIR
###############################
put #tvar char.repair.forceFangCove true
put #tvar char.repair.money 50
put #tvar char.repair.waitRoomId 50
put #tvar char.repair.list $char.armor|$char.armor.chain|$char.fight.weapons.items|great helm|moonsilk pants|moonsilk hood|moonsilk mask|moonsilk shirt|moonsilk gloves|steelsilk handwraps|steelsilk footwraps


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
put #tvar char.inv.container.tarantula wyvern skull

put #tvar char.tarantula.skillsetOrder Survival|Armor|Weapon|Magic|Lore


###############################
###      TRAINER
###############################
put #tvar char.trainer.almanac almanac
put #tvar char.trainer.compendium 0
put #tvar char.trainer.firstaid 0


pause .2
put #parse CHARVARS DONE
exit
