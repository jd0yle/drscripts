###############################
###      APPRAISE
###############################
put #tvar char.appraise.container 0
put #tvar char.appraise.item my pouch


###############################
###      ARMOR
###############################
put #tvar char.armor ka'hurst balaclava|ka'hurst gloves|quilted hauberk|demonscale shield|demonscale armguard|knee spikes|elbow spikes|steelsilk footwraps|steelsilk handwraps


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
put #tvar char.cambrinth armband
put #tvar char.focusContainer shadows
put #tvar char.ritualFocus ouroboros ring
put #tvar char.wornCambrinth 1
put #tvar char.wornFocus 1


###############################
###      CAST
###############################
put #tvar char.cast.invokeSpell 0

put #tvar char.cast.default.charge 20
put #tvar char.cast.default.harness 0
put #tvar char.cast.default.prep 10

put #tvar char.cast.bc.prep 150
put #tvar char.cast.dc.prep 50


###############################
###      COMMON
###############################
put #tvar char.common.container shadows
put #tvar char.common.container.extra purse
put #tvar char.common.scripts deposit|pawn|burgle|caracal|compendium|deposit|forage|magic|pawn|repair|research


###############################
###      FIGHT
###############################
# ------ AMMO ------
put #tvar char.fight.ammo.Crossbow bolt
put #tvar char.fight.ammo.Bow 0
put #tvar char.fight.ammo.Slings 0

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

# DEPRECATED Script-specific options (ex: 'backtrain')
put #tvar char.fight.opts null


# ------ TM ------
put #tvar char.fight.tmSpell do
put #tvar char.fight.tmPrep 7
put #tvar char.fight.tmPause 7


# ------ WEAPONS ------
#Slings
#blue sling
put #tvar char.fight.weapons.items Empty|Empty|ka'hurst hhr'ata|frying pan|smokewood latchbow|diamondwood nightstick|assassin's blade|assassin's blade|flamewood riste
put #tvar char.fight.weapons.skills Targeted_Magic|Brawling|Heavy_Thrown|Light_Thrown|Crossbow|Staves|Small_Edged|Small_Edged|Twohanded_Blunt
#put #tvar char.fight.weapons.items Empty|Empty|ka'hurst hhr'ata|frying pan|smokewood latchbow|diamondwood nightstick
#put #tvar char.fight.weapons.skills Targeted_Magic|Brawling|Heavy_Thrown|Light_Thrown|Crossbow|Staves
put #tvar char.fight.wornCrossbow 0

# ------ ARMOR ------
put #tvar char.fight.armor.skills Chain_Armor|Light_Armor
put #tvar char.fight.armor.items 0
put #tvar char.fight.useArmor 0

# ------ USE ------
# Use vars are all "Do this thing or not"
# All default to 0
put #tvar char.fight.trainOffhand 1
put #tvar char.fight.useAlmanac 0
put #tvar char.fight.useAppraise 1
put #tvar char.fight.useBuffs 1
put #tvar char.fight.useHunt 1
put #tvar char.fight.usePerc 1
put #tvar char.fight.useSanowret 1
put #tvar char.fight.useSkin 1
put #tvar char.fight.useStealth 0

# ------ GENERAL ------
put #tvar char.fight.useMaf 1

# ------ MOON MAGE ------
put #tvar char.fight.useCol 1
put #tvar char.fight.useObserve 0
put #tvar char.fight.useSeer 1
put #tvar char.fight.useShadowling 0
put #tvar char.fight.useShadows 0
put #tvar char.fight.useShw 1
put #tvar char.fight.useSls 0


###############################
###      FRIENDS
###############################
put #tvar friends Inauri|Qizhmur|Selesthiel|Izqhhrzu
put #tvar enemies Nemy|Ponni|Sothios|Kethrai
put #tvar super.enemies null


###############################
###      LOCKSMITHING
###############################
put #tvar char.locks.boxTypes jewelry box|keepsake box
put #tvar char.locks.boxType box
put #tvar char.locks.lockpickType ring
put #tvar char.locks.boxContainer shadows


###############################
###      LOOT
###############################
put #tvar char.inv.emptyGemPouchContainer purse
put #tvar char.inv.fullGemPouchContainer shadows
put #tvar char.inv.tempContainer purse
put #tvar char.inv.defaultContainer shadows
put #tvar char.loot.boxes 1


###############################
###      MAGIC
###############################
put #tvar guild Moon Mage
put #tvar char.magic.train.almanacItem 0
put #tvar char.magic.train.almanacContainer 0
put #tvar char.magic.train.minimumConcentration 50
put #tvar char.magic.train.useAlmanac 0
put #tvar char.magic.train.useShadowling 1
put #tvar char.magic.train.useSymbiosis 1
put #tvar char.magic.train.useInvokeSpell 0

put #tvar char.magic.train.spell.Augmentation seer
put #tvar char.magic.train.prep.Augmentation 15
put #tvar char.magic.train.charge.Augmentation 7
put #tvar char.magic.train.harness.Augmentation 0

put #tvar char.magic.train.spell.Utility seer
put #tvar char.magic.train.prep.Utility 15
put #tvar char.magic.train.charge.Utility 7
put #tvar char.magic.train.harness.Utility 0

put #tvar char.magic.train.spell.Warding psy
put #tvar char.magic.train.prep.Warding 5
put #tvar char.magic.train.charge.Warding 7
put #tvar char.magic.train.harness.Warding 0


###############################
###      OBSERVE & PREDICT
###############################
put #tvar char.predict.tool chalky demonbones
put #tvar char.predict.tool.container shadows

put #tvar char.observe.telescope powdery telescope
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
###      PERFORMANCE
###############################
put #tvar char.performance.instrument rattle
put #tvar char.performance.song serenade
put #tvar char.performance.mood quiet


###############################
###      REPAIR
###############################
put #tvar char.repair.forceFangCove true
put #tvar char.repair.money 10
put #tvar char.repair.leather demonscale armguard|demonscale shield|quilted hauberk
put #tvar char.repair.metal diamondwood nightstick|smokewood latchbow|frying pan|ka'hurst hhr'ata|demonbone armguard|elbow spikes|knee spikes|steelsilk footwraps|steelsilk handwraps|ka'hurst balaclava|ka'hurst gloves|flamewood riste|assassin's blade


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
put #tvar char.trainer.almanacContainer shadow
put #tvar char.trainer.almanacItem almanac
put #tvar char.trainer.firstaid caracal


pause .2
put #parse CHARVARS DONE
exit
