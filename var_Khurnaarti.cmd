###############################
###      APPRAISE
###############################
put #tvar char.appraise.item pouch
put #tvar char.inv.container.appraise 0


###############################
###      ARMOR
###############################
put #tvar char.armor ka'hurst balaclava|ka'hurst gloves|moonsilk shirt|moonsilk pants|demonscale shield|knee spikes|elbow spikes|steelsilk footwraps|hand claws|kelp wrap


###############################
###      ASTRAL
###############################
put #tvar char.astral.manaPerHarness 30
put #tvar char.astral.timesToHarness 2


###############################
###      BUFFS
###############################
put #tvar char.buffs.spells shadowling|seer|col|tksh|psy
put #tvar char.buffs.spellNames Shadowling|SeersSense|CageofLight|TelekineticShield|PsychicShield


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
put #tvar char.inv.container.burgle $char.inv.container.secondary


###############################
###      CAMBRINTH
###############################
put #tvar char.cambrinth snakelet
put #tvar char.ritualFocus puzzle rings
put #tvar char.tmFocus ka'hurst sun
put #tvar char.wornCambrinth 1
put #tvar char.wornFocus 1

put #tvar char.inv.container.focus $char.inv.container.default


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
# Mental Blast
put #tvar char.cast.mb.prep 30
put #tvar char.cast.mb.charge 0
put #tvar char.cast.mb.chargeTimes 0
# Stun Foe
put #tvar char.cast.sf.prep 15
put #tvar char.cast.sf.charge 0
put #tvar char.cast.sf.chargeTimes 0
# Shadow Web
put #tvar char.cast.shw.prep 5
put #tvar char.cast.shw.charge 10
put #tvar char.cast.shw.chargeTimes 1

# Buffs
put #tvar char.cast.col.prep 30
put #tvar char.cast.col.charge 20
put #tvar char.cast.col.chargeTimes 2
put #tvar char.cast.cv.prep 30
put #tvar char.cast.cv.charge 20
put #tvar char.cast.cv.chargeTimes 2
put #tvar char.cast.iots.prep 300
put #tvar char.cast.iots.charge 0
put #tvar char.cast.maf.prep 30
put #tvar char.cast.maf.charge 40
put #tvar char.cast.maf.chargeTimes 1
put #tvar char.cast.moonblade.prep 15
put #tvar char.cast.moonblade.charge 0
put #tvar char.cast.moonblade.chargeTimes 0
put #tvar char.cast.psy.prep 30
put #tvar char.cast.psy.charge 20
put #tvar char.cast.psy.chargeTimes 2
put #tvar char.cast.seer.prep 30
put #tvar char.cast.seer.charge 20
put #tvar char.cast.seer.chargeTimes 2
put #tvar char.cast.shadowling.prep 30
put #tvar char.cast.shadowling.charge 20
put #tvar char.cast.shadowling.chargeTimes 1
put #tvar char.cast.shear.prep 30
put #tvar char.cast.shear.charge 20
put #tvar char.cast.shear.chargeTimes 1
put #tvar char.cast.sls.prep 15
put #tvar char.cast.sls.charge 0
put #tvar char.cast.sls.chargeTimes 1
put #tvar char.cast.sls.constellation spider
put #tvar char.cast.tksh.prep 30
put #tvar char.cast.tksh.charge 20
put #tvar char.cast.tksh.chargeTimes 2

#Utility
put #tvar char.cast.ss.prep 30
put #tvar char.cast.ss.charge 0
put #tvar char.cast.ss.chargeTimes 0
put #tvar char.cast.ss.minPrepTime 10


###############################
###      COMPENDIUM
###############################
put #tvar char.compendium textbook
put #tvar char.compendiums 0
put #tvar char.compendium.forceTurn 1

put #tvar char.inv.container.compendium $char.inv.container.default

###############################
###      EMPTY
###############################
put #tvar char.empty.armor balaclava|claws|footwraps|gloves|pants|shield|shirt|spikes|wrap
put #tvar char.empty.weapon arrow|arrows|blade|broad-axe|broadsword|bolt|bolts|button|buttons|hhr-ata|nightstick|pan|pelletbow|rock|rocks|riste|skefne|sling|sphere
put #tvar char.empty.container backpack|bag|bottle|case|clouds|eddy|folio|pocket|pouch|purse|rucksack|saddlebag|shadows|poke|pack|shadows|saddlebag|sack|vial
put #tvar char.empty.boxContainer box|caddy|casket|chest|coffer|crate|skippet|strongbox|trunk
put #tvar char.empty.wornInven circlet|cloak|crystal|belt|blade|blouse|bucket|gamantang|garter|horns|pants|pilonu|ring|rings|robe|robes|sandals|silk|snakelet|stars|trews
put #tvar char.empty.misc almanac|bead|book|brush|caracal|card|cloth|compendium|demonbones|gwethdesuan|kit|mirror|priest|refill|rope|skates|spider|sun|telescope|towel|triangle|water|yardstick
put #tvar char.empty.whitelist $char.empty.armor|$char.empty.weapon|$char.empty.container|$char.empty.boxContainer|$char.empty.wornInven|$char.empty.misc
if ("$empty.whitelist" <> "$char.empty.whitelist") then {
    put #var empty.whitelist $char.empty.whitelist
    echo Updated empty.whitelist.
}

###############################
###      FIGHT
###############################
# ------ AMMO ------
put #tvar char.fight.ammo.Crossbow matte sphere
put #tvar char.fight.ammo.Bow 0
put #tvar char.fight.ammo.Slings matte sphere
#put #tvar char.fight.ammo.Slings button


# ------ ARMOR ------
put #tvar char.fight.armor.skills Chain_Armor|Light_Armor
put #tvar char.fight.armor.items 0
put #tvar char.fight.useArmor 0

# ------ ARRANGE ------
put #tvar char.fight.arrangeForPart 0
put #tvar char.fight.arrangeFull 0

# ------ DEBILITATION ------
put #tvar char.fight.debil.use 1
put #tvar char.fight.debil.spell sf
put #tvar char.fight.debil.prepAt 25
put #tvar char.fight.debilPauseTime 12
put #tvar char.fight.forceDebil 0

# ------ STANCE ------
# Force always using stance shield, never stance parry
put #tvar char.fight.forceShield 0

# ------ LOOT ------
# all|treasure|gems whatever the loot options are
put #tvar char.fight.lootType goods

# ------ STANCE ------
# Force always using stance shield, never stance parry
put #tvar char.fight.forceShield 0

# DEPRECATED Script-specific options (ex: 'backtrain')
put #tvar char.fight.opts null

# ------ TM ------
put #tvar char.fight.tmSpell pd
put #tvar char.fight.tmPrep 10
put #tvar char.fight.tmPause 7

# ------ USE ------
# Use vars are all "Do this thing or not"
# All default to 0
put #tvar char.fight.trainOffhand 1
put #tvar char.fight.useAlmanac 1
put #tvar char.fight.useAppraise 1
put #tvar char.fight.useBuffs 1
put #tvar char.fight.useDissect 1
put #tvar char.fight.useHunt 1
put #tvar char.fight.useMaf 0
put #tvar char.fight.usePerc 1
put #tvar char.fight.useSanowret 1
put #tvar char.fight.useSkin 1
put #tvar char.fight.useStealth 0
put #tvar char.fight.useTarantula 1

# ------ WEAPONS ------
# Everything
#put #tvar char.fight.weapons.items Empty|Empty|ka'hurst hhr'ata|frying pan|smokewood pelletbow|diamondwood nightstick|assassin's blade|flamewood riste|blue sling|executioner's broad-axe|duraka skefne|haralun broadsword
#put #tvar char.fight.weapons.skills Targeted_Magic|Brawling|Heavy_Thrown|Light_Thrown|Crossbow|Staves|Small_Edged|Twohanded_Blunt|Slings|Twohanded_Edged|Polearm|Large_Edged

# No Targeted Magic
#put #tvar char.fight.weapons.items Empty|ka'hurst hhr'ata|frying pan|smokewood pelletbow|diamondwood nightstick|assassin's blade|flamewood riste|blue sling|executioner's broad-axe|duraka skefne|haralun broadsword
#put #tvar char.fight.weapons.skills Brawling|Heavy_Thrown|Light_Thrown|Crossbow|Staves|Small_Edged|Twohanded_Blunt|Slings|Twohanded_Edged|Polearm|Large_Edged

# Main Weapons Only
put #tvar char.fight.weapons.items Empty|Empty|ka'hurst hhr'ata|frying pan|smokewood pelletbow|diamondwood nightstick|assassin's blade
put #tvar char.fight.weapons.skills Targeted_Magic|Brawling|Heavy_Thrown|Light_Thrown|Crossbow|Staves|Small_Edged

put #tvar char.fight.wornCrossbow 0

# ------ MOON MAGE ------
put #tvar char.fight.useCol 1
put #tvar char.fight.useObserve 0
put #tvar char.fight.useRevSorcery 0
put #tvar char.fight.useSeer 1
put #tvar char.fight.useShadowling 1
put #tvar char.fight.useShadows 0
put #tvar char.fight.useShw 0
put #tvar char.fight.useSls 0
put #tvar char.fight.useTksh 1


###############################
###      FRIENDS
###############################
put #tvar friends Inauri|Qizhmur|Selesthiel|Izqhhrzu
put #tvar enemies Nemy|Ponni|Kethrai
put #tvar super.enemies null


###############################
###      INSTRUMENT
###############################
put #tvar char.instrument.cloth colored cloth
put #tvar char.instrument.song tango
put #tvar char.instrument.noun triangle
put #tvar char.instrument.tap asini-wrapped electrum triangle

put #tvar char.inv.container.instrument $char.inv.container.default


###############################
###      INVENTORY
###############################
put #tvar char.inv.container.almanac $char.inv.container.default
put #tvar char.inv.container.autoloot silk pocket
put #tvar char.inv.container.default shadows
put #tvar char.inv.container.eddy writhing eddy
put #tvar char.inv.container.emptyGemPouch watersilk bag
put #tvar char.inv.container.fullGemPouch shadows
put #tvar char.inv.container.gemPouch black pouch
put #tvar char.inv.container.holdAnything poke
put #tvar char.inv.container.memoryOrb shadows
put #tvar char.inv.container.practicebox shadows
put #tvar char.inv.container.secondary leather purse
put #tvar char.inv.container.sellGemBag $char.inv.container.default
put #tvar char.inv.container.servantOptions pack|saddlebag|pouch|rucksack|backpack|poke
put #tvar char.inv.container.servantDescription emaciated Shadow Servant with hollow eyes
put #tvar char.inv.container.temp $char.inv.container.secondary
put #tvar char.inv.container.tertiary indigo backpack
put #tvar char.inv.container.trash $char.inv.container.secondary

# Loot
put #tvar char.loot.boxes 1
put #tvar char.loot.nuggetBars 1
if (!($char.loot.untiedGemPouch >0)) then put #tvar char.loot.untiedGemPouch 0


###############################
###      LOCKSMITHING
###############################
put #tvar char.locks.bucket bucket
put #tvar char.locks.lockpickType ring


###############################
###      MAGIC
###############################
put #tvar guild Moon Mage
put #tvar char.magic.train.almanac $char.trainer.almanac
put #tvar char.magic.train.minimumConcentration 50
put #tvar char.magic.train.useAlmanac 1
put #tvar char.magic.train.useServant 1
put #tvar char.magic.train.useShadowling 1
put #tvar char.magic.train.useSymbiosis 1
put #tvar char.magic.train.useInvokeSpell 0

put #tvar char.magic.train.spell.Augmentation seer
put #tvar char.magic.train.prep.Augmentation 15
put #tvar char.magic.train.charge.Augmentation 25
put #tvar char.magic.train.harness.Augmentation 0

put #tvar char.magic.train.spell.Utility seer
put #tvar char.magic.train.prep.Utility 15
put #tvar char.magic.train.charge.Utility 25
put #tvar char.magic.train.harness.Utility 0

put #tvar char.magic.train.spell.Warding tksh
put #tvar char.magic.train.prep.Warding 30
put #tvar char.magic.train.charge.Warding 10
put #tvar char.magic.train.harness.Warding 0

put #tvar char.magic.train.revSorcery 0


###############################
###      OBSERVE & PREDICT
###############################
put #tvar char.predict.tool chalky demonbones
put #tvar char.inv.container.predictTool shadows

put #tvar char.predict.useDc 1

put #tvar char.observe.telescope midnight-blue telescope
put #tvar char.inv.container.telescope telescope case

put #tvar char.observe.defense Katamba|Magpie|Giant|Penhetia|Merewalda|Morleena|Dawgolesh|forge|eye
put #tvar char.observe.lore Xibar|Raven|Phoenix|Ismenia|Amlothi|forge|eye
put #tvar char.observe.magic Yavash|Wolf|Toad|Ismenia|Amlothi|Dawgolesh|eye
put #tvar char.observe.offense Cat|Viper|Spider|Estrilda|Szeldia|Merewalda|Er'qutra|forge|eye
put #tvar char.observe.survival Ram|Yoakena|Szeldia|Morleena|Er'qutra|eye
put #tvar char.observe.predict 1


###############################
###      PAWN
###############################
put #tvar char.inv.container.pawn $char.inv.container.secondary
#put #tvar char.pawn.burglePawn bodice dagger|case|fabric|pot helm|recipe box|skillet|telescope


###############################
###      REPAIR
###############################
put #tvar char.repair.forceFangCove true
put #tvar char.repair.money 50
put #tvar char.repair.armor kelp wrap|demonscale shield|moonsilk shirt|moonsilk pants|ka'hurst balaclava|ka'hurst gloves
put #tvar char.repair.brawl elbow spikes|knee spikes|steelsilk footwraps|hand claws
put #tvar char.repair.weapon diamondwood nightstick|smokewood pelletbow|smokewhorl whip|meteor hammer|flamewood riste|assassin's blade
put #tvar char.repair.weapon2 executioner's broad-axe|duraka skefne|haralun broadsword|blue sling
put #tvar char.repair.list $char.repair.armor|$char.repair.brawl|$char.repair.weapon|$char.repair.weapon2


###############################
###      RESEARCH
###############################
put #tvar char.research.interrupt.cast 0
put #tvar char.research.interrupt.study 0
put #tvar char.research.useSanowret 1


###############################
###      TARANTULA
###############################
put #tvar char.tarantula.item harvester spider
put #tvar char.inv.container.tarantula shadows


###############################
###      TRAINER
###############################
put #tvar char.trainer.almanac almanac
put #tvar char.trainer.firstaid caracal


pause .2
put #parse CHARVARS DONE
exit
