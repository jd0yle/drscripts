###############################
###      APPRAISE
###############################
put #tvar char.appraise.container 0
put #tvar char.appraise.item my pouch


###############################
###      ARMOR
###############################
put #tvar char.armor ka'hurst balaclava|ka'hurst gloves|moonsilk shirt|moonsilk pants|demonscale shield|knee spikes|elbow spikes|steelsilk footwraps|steelsilk handwraps|kelp wrap


###############################
###      ASTRAL
###############################
put #tvar char.astral.manaPerHarness 30
put #tvar char.astral.timesToHarness 2


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
put #tvar char.burgle.entryMethod TOGGLE
put #tvar char.burgle.lockpickRingType lockpick ring
put #tvar char.burgle.ropeType heavy rope
put #tvar char.burgle.ropeWorn NULL

# ------ LOOT HANDLING ------
# pawn:  NO/NULL, YES/ON
# keepThisList:  NULL or array
# trashAllExceptKeep:  NO/NULL, YES/ON
# trashThisList:  NULL or array
put #tvar char.burgle.pawnAll YES
put #tvar char.burgle.keepThisList keepsake box|memory orb|jewelry box
put #tvar char.burgle.trashAllExceptKeep NO
put #tvar char.burgle.trashThisList basket|kaleidoscope|sieve|stick|diary|top|rat|mouse

# ------ STORAGE HANDLING ------
# container: pack, rucksack, portal, shadows, backpack, satchel, etc.
put #tvar char.burgle.container purse


###############################
###      CAMBRINTH
###############################
put #tvar char.cambrinth snakelet
put #tvar char.focusContainer shadows
put #tvar char.ritualFocus puzzle rings
put #tvar char.wornCambrinth 1
put #tvar char.wornFocus 1


###############################
###      CAST
###############################
put #tvar char.cast.invokeSpell 0
put #tvar char.cast.tattoo.spellName rev

# Defaults
put #tvar char.cast.default.charge 20
put #tvar char.cast.default.chargeTimes 1
put #tvar char.cast.default.harness 0
put #tvar char.cast.default.prep 30
put #tvar char.cast.default.minPrepTime 30

# Predictions and Observation
put #tvar char.cast.bc.prep 150
put #tvar char.cast.dc.prep 50

# Debilitation
put #tvar char.cast.calm.prep 5
put #tvar char.cast.calm.charge 0
put #tvar char.cast.calm.chargeTimes 0
put #tvar char.cast.shw.prep 5
put #tvar char.cast.shw.charge 10
put #tvar char.cast.shw.chargeTimes 1

# Buffs
put #tvar char.cast.col.prep 30
put #tvar char.cast.col.charge 20
put #tvar char.cast.col.chargeTimes 2
put #tvar char.cast.iots.prep 300
put #tvar char.cast.iots.charge 0
put #tvar char.cast.maf.prep 30
put #tvar char.cast.maf.charge 40
put #tvar char.cast.maf.chargeTimes 1
put #tvar char.cast.seer.prep 30
put #tvar char.cast.seer.charge 20
put #tvar char.cast.seer.chargeTimes 2
put #tvar char.cast.shadowling.prep 30
put #tvar char.cast.shadowling.charge 20
put #tvar char.cast.shadowling.chargeTimes 1
put #tvar char.cast.sls.prep 15
put #tvar char.cast.sls.charge 0
put #tvar char.cast.sls.chargeTimes 1
put #tvar char.cast.sls.constellation spider


###############################
###      FIGHT
###############################
# ------ AMMO ------
put #tvar char.fight.ammo.Crossbow bolt
put #tvar char.fight.ammo.Bow 0
put #tvar char.fight.ammo.Slings button
#put #tvar char.fight.ammo.Slings sphere

# ------ ARMOR ------
put #tvar char.fight.armor.skills Chain_Armor|Light_Armor
put #tvar char.fight.armor.items 0
put #tvar char.fight.useArmor 0

# ------ ARRANGE ------
put #tvar char.fight.arrangeForPart 0
put #tvar char.fight.arrangeFull 0

# ------ DEBILITATION ------
put #tvar char.fight.debil.use 1
put #tvar char.fight.debil.spell calm
put #tvar char.fight.debil.prepAt 3
put #tvar char.fight.forceDebil 0

# ------ STANCE ------
# Force always using stance shield, never stance parry
put #tvar char.fight.forceShield 0

# ------ LOOT ------
# all|treasure|gems whatever the loot options are
put #tvar char.fight.lootType treasure

# ------ STANCE ------
# Force always using stance shield, never stance parry
put #tvar char.fight.forceShield 0

# DEPRECATED Script-specific options (ex: 'backtrain')
put #tvar char.fight.opts null

# ------ TM ------
put #tvar char.fight.tmSpell do
put #tvar char.fight.tmPrep 7
put #tvar char.fight.tmPause 7

# ------ USE ------
# Use vars are all "Do this thing or not"
# All default to 0
put #tvar char.fight.trainOffhand 1
put #tvar char.fight.useAlmanac 0
put #tvar char.fight.useAppraise 1
put #tvar char.fight.useBuffs 1
put #tvar char.fight.useDissect 1
put #tvar char.fight.useHunt 1
put #tvar char.fight.useMaf 1
put #tvar char.fight.usePerc 1
put #tvar char.fight.useSanowret 1
put #tvar char.fight.useSkin 1
put #tvar char.fight.useStealth 0

# ------ WEAPONS ------
# Everything
#put #tvar char.fight.weapons.items Empty|Empty|ka'hurst hhr'ata|frying pan|smokewood latchbow|diamondwood nightstick|assassin's blade|flamewood riste|blue sling|executioner's broad-axe|duraka skefne|haralun broadsword
#put #tvar char.fight.weapons.skills Targeted_Magic|Brawling|Heavy_Thrown|Light_Thrown|Crossbow|Staves|Small_Edged|Twohanded_Blunt|Slings|Twohanded_Edged|Polearm|Large_Edged

# No Targeted Magic
# put #tvar char.fight.weapons.items Empty|ka'hurst hhr'ata|frying pan|smokewood latchbow|diamondwood nightstick|assassin's blade|flamewood riste|blue sling|executioner's broad-axe|duraka skefne|haralun broadsword
# put #tvar char.fight.weapons.skills Brawling|Heavy_Thrown|Light_Thrown|Crossbow|Staves|Small_Edged|Twohanded_Blunt|Slings|Twohanded_Edged|Polearm|Large_Edged

# Main Weapons Only
put #tvar char.fight.weapons.items Empty|ka'hurst hhr'ata|frying pan|smokewood latchbow|diamondwood nightstick|assassin's blade
put #tvar char.fight.weapons.skills Brawling|Heavy_Thrown|Light_Thrown|Crossbow|Staves|Small_Edged|

put #tvar char.fight.wornCrossbow 0

# ------ MOON MAGE ------
put #tvar char.fight.useCol 1
put #tvar char.fight.useObserve 0
put #tvar char.fight.useRevSorcery 0
put #tvar char.fight.useSeer 1
put #tvar char.fight.useShadowling 0
put #tvar char.fight.useShadows 0
put #tvar char.fight.useShw 0
put #tvar char.fight.useSls 0


###############################
###      FRIENDS
###############################
put #tvar friends Inauri|Qizhmur|Selesthiel|Izqhhrzu
put #tvar enemies Nemy|Ponni|Sothios|Kethrai
put #tvar super.enemies null


###############################
###      INSTRUMENT
###############################
put #tvar char.instrument.song tango
put #tvar char.instrument.container shadows
put #tvar char.instrument.noun triangle
put #tvar char.instrument.tap asini-wrapped electrum triangle


###############################
###      INVENTORY
###############################
put #tvar char.inv.boxContainer shadows
put #tvar char.inv.defaultContainer shadows
put #tvar char.inv.emptyGemPouchContainer watersilk bag
put #tvar char.inv.fullGemPouchContainer shadows
put #tvar char.inv.memoryOrbContainer shadows
put #tvar char.inv.secondaryContainer leather purse
put #tvar char.inv.servant.bags pack|saddlebag|pouch|rucksack|backpack|poke
put #tvar char.inv.servant.description cantankerous Shadow Servant
put #tvar char.inv.tempContainer leather purse
put #tvar char.inv.tertiaryContainer indigo backpack
put #tvar char.inv.eddyContainer writhing eddy

# Loot
put #tvar char.loot.boxes 1


###############################
###      LOCKSMITHING
###############################
put #tvar char.locks.bucket bucket
put #tvar char.locks.lockpickType ring


###############################
###      MAGIC
###############################
put #tvar guild Moon Mage
put #tvar char.magic.train.almanacItem almanac
put #tvar char.magic.train.almanacContainer shadows
put #tvar char.magic.train.minimumConcentration 50
put #tvar char.magic.train.useAlmanac 1
put #tvar char.magic.train.useShadowling 1
put #tvar char.magic.train.useSymbiosis 1
put #tvar char.magic.train.useInvokeSpell 0

put #tvar char.magic.train.spell.Augmentation seer
put #tvar char.magic.train.prep.Augmentation 15
put #tvar char.magic.train.charge.Augmentation 15
put #tvar char.magic.train.harness.Augmentation 0

put #tvar char.magic.train.spell.Utility seer
put #tvar char.magic.train.prep.Utility 15
put #tvar char.magic.train.charge.Utility 15
put #tvar char.magic.train.harness.Utility 0

put #tvar char.magic.train.spell.Warding shear
put #tvar char.magic.train.prep.Warding 30
put #tvar char.magic.train.charge.Warding 5
put #tvar char.magic.train.harness.Warding 0

put #tvar char.magic.train.revSorcery 0


###############################
###      OBSERVE & PREDICT
###############################
put #tvar char.predict.tool chalky demonbones
put #tvar char.predict.tool.container shadows

put #tvar char.observe.telescope midnight-blue telescope
put #tvar char.observe.telescope.container khor'vela case

put #tvar char.observe.defense Katamba|Magpie|Giant|Penhetia|Merewalda|Morleena|Dawgolesh|forge
put #tvar char.observe.lore Xibar|Raven|Phoenix|Ismenia|Amlothi|forge
put #tvar char.observe.magic Yavash|Wolf|Toad|Ismenia|Amlothi|Dawgolesh
put #tvar char.observe.offense Cat|Viper|Spider|Estrilda|Szeldia|Merewalda|Er'qutra|forge
put #tvar char.observe.survival Ram|Yoakena|Szeldia|Morleena|Er'qutra
#magic/lore/off/def/surv 125 eye
put #tvar char.observe.predict 1


###############################
###      PAWN
###############################
put #tvar char.pawn.container purse


###############################
###      REPAIR
###############################
put #tvar char.repair.forceFangCove true
put #tvar char.repair.money 10
put #tvar char.repair.list kelp wrap|demonscale shield|moonsilk shirt|moonsilk pants|diamondwood nightstick|smokewood latchbow|frying pan|ka'hurst hhr'ata|demonbone armguard|elbow spikes|knee spikes|steelsilk footwraps|steelsilk handwraps|ka'hurst balaclava|ka'hurst gloves|flamewood riste|assassin's blade|executioner's broad-axe|duraka skefne


###############################
###      RESEARCH
###############################
put #tvar char.compendiums black compendium|crimson-scaled compendium|pale compendium
put #tvar char.compendium.forceTurn 1
put #tvar char.research.interrupt.cast 0
put #tvar char.research.interrupt.study 0
put #tvar char.research.useSanowret 1


###############################
###      TRAINER
###############################
put #tvar char.trainer.almanacContainer shadow
put #tvar char.trainer.almanacItem almanac
put #tvar char.trainer.firstaid caracal


pause .2
put #parse CHARVARS DONE
exit
