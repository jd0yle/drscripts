##Monster Variables
var monsters1 ashu hhinvi|atik'et|bloodvine|bucca|cabalist|\bcrag\b|creeper|cutthroat
var monsters2 Dragon Priest (assassin|crone|fanatic|imperial warden|intercessor|juggernaut|purifier|sentinel|zealot)|Dragon Priest|Dragon Priestess|blood dryad|dummy|dusk ogre|dyrachis|eviscerator|faenrae assassin|fendryad|fire maiden|folsi immola
var monsters3 footpad|frostweaver|gam chaga|\bgeni\b|gidii|goblin shaman|graverobber|guardian|gypsy marauder|\bimp\b|juggernaut
var monsters4 kelpie|kra'hei|kra'hei hatchling|intercessor|lipopod|lun'shele hunter|madman|malchata|mountain giant|nipoh oshu|\bnyad\b|orc bandit
var monsters5 orc clan chief|orc raider|orc reiver|orc scout|pile of rubble|pirate|puddle|river sprite|ruffian|scavenger troll|scout ogre|screamer
var monsters6 sentinel|shadow master|shadoweaver|sky giant|sleazy lout|sprite|swain|swamp troll|telga moradu|\bthug\b|trekhalo
var monsters7 umbramagii|velver|\bvine\b|vykathi builder|vykathi excavator|wind hound|wood troll|Xala'shar (archer|archmage|conjurer|lookout|magus|overseer|shredder|slayer|thrall|vanquisher|vindicator)|young ogre|zealot

var undead1 boggle|emaciated umbramagus|deadwood dryad|fiend|gargantuan bone golem|blue ghast|olensari mihmanan|plague wraith
var undead2 revivified mutt|blightwater nyad|shylvic|sinister maelshyvean heirophant|skeletal peon|skeletal sailor|skeleton
var undead3 skeletal kobold headhunter|skeletal kobold savage|snaer hafwa|soul|spectral pirate|spectral sailor
var undead4 tress|spirit|ur hhrki'izh|telga orek|wir dinego|zombie(?!\s)|zombie (head-splitter|mauler|nomad|stomper)

var skinnablemonsters1 angiswaerd hatchling|wyvern|antelope|arbelog|armadillo|armored warklin|arzumo|asaren celpeze|badger|barghest|basilisk|\bbear\b|beisswurm|bison|black ape|blademaster
var skinnablemonsters2 blight ogre|blood warrior|\bboa\b|\bboar\b|bobcat|boobrie|brocket deer|burrower|caiman|caracal|carcal|cave troll
var skinnablemonsters3 cinder beast|cougar|\bcrab\b|crayfish|crocodile|\bdeer\b|dobek moruryn|faenrae stalker|firecat|\bfrog\b|giant blight bat
var skinnablemonsters4 goblin|grass eel|\bgrub\b|gryphon|Isundjen conjurer|jackal|kartais|kashika serpent|kobold|la'heke|larva|la'tami|leucro
var skinnablemonsters5 marbled angiswaerd|merrows|\bmoda\b|\bmoth\b|mottled westanuryn|musk hog|\bpard\b|peccary|piruati serpent|pivuh|poloh'izh|pothanit|prereni|\bram\b
var skinnablemonsters6 \brat\b|retan dolomar|rock troll|scaly seordmaor|shadow beast|shadow mage|shalswar|silverfish|sinuous elsralael|skunk|S'lai scout

# commented for spirit dancer change
#var skinnablemonsters7 sleek hele'la|sluagh|snowbeast|sorcerer|\bsow\b|spider|spirit dancer|storm bull|trollkin|\bunyn\b|viper|vulture|vykathi harvester
var skinnablemonsters7 sleek hele'la|sluagh|snowbeast|sorcerer|\bsow\b|spider|dancer|storm bull|trollkin|\bunyn\b|viper|vulture|vykathi harvester

var skinnablemonsters8 vykathi soldier|warcat|warklin mauler|\bwasp\b|\bwolf\b|\bworm\b|juvenile wyvern|adult wyvern|young wyvern

var specialmanipulate tress

var skinnableundead1 ice adder|adder skeleton|enraged tusky|fell hog|ghoul|ghoul crow|gremlin|grendel|lach|mastiff|mey|misshapen germish'din
var skinnableundead2 mutant togball|reaver|shadow hound|squirrel|steed|zombie kobold headhunter|zombie kobold savage

var construct ashu hhinvi|boggle|bone amalgam|clay archer|clay mage|clay soldier|clockwork assistant|gam chaga|glass construct|granite gargoyle|lachmate|lava drake|marble gargoyle|origami \S+|quartz gargoyle|(alabaster|andesite|breccia|dolomite|marble|obsidian|quartzite|rock) guardian|rough-hewn doll
var skinnableconstruct Endrus serpent|granite gargoyle|lava drake|marble gargoyle|quartz gargoyle

var invasioncritters bone amalgam|bone warrior|brine shark|cloud eel|Drogorian stormrider|Elpalzi (bowyer|deadeye|dissident|fomenter|hunter|incendiary|instigator|malcontent|malcontent|partisan|rebel|sharpshooter|toxophilite)|flea-ridden beast|putrefying shambler|revivified mutt|shambling horror|skeletal peon|thunder eel|transmogrified oaf|Asketian harbinger|giant adder|wind wretch|wind hag|North Wind banshee|blight locust|murder crow|mantrap|clockwork monstrosity|rafflesia|Black Fang watcher

var skinnablecritters %skinnablemonsters1|%skinnablemonsters2|%skinnablemonsters3|%skinnablemonsters4|%skinnablemonsters5|%skinnablemonsters6|%skinnablemonsters7|%skinnablemonsters8|%skinnableundead1|%skinnableundead2|%skinnableconstruct
var nonskinnablecritters %monsters1|%monsters2|%monsters3|%monsters4|%monsters5|%monsters6|%monsters7|%undead1|%undead2|%undead3|%undead4|construct

var ritualcritters %monsters1|%monsters2|%monsters3|%monsters4|%monsters5|%monsters6|%monsters7|%skinnablemonsters1|%skinnablemonsters2|%skinnablemonsters3|%skinnablemonsters4|%skinnablemonsters5|%skinnablemonsters6|%skinnablemonsters7|%skinnablemonsters8|%specialmanipulate|gremlin
var normnoshockcritters %construct|%skinnableconstruct
var absnoshockcritters %construct|%skinnableconstruct|%undead1|%undead2|%undead3|%undead4|%skinnableundead1|%skinnableundead2
var allundead %undead1|%undead2|%undead3|%undead4|%skinnableundead1|%skinnableundead2
var allconstruct %construct|%skinnableconstruct

var critters %skinnablecritters|%nonskinnablecritters|%invasioncritters|%allconstruct|%allundead