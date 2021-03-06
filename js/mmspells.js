/**
 *
 * Created by jdoyle on 6/10/2020.
 */
var spells = {
    cleric: {

    },
    moonmage: {
        art: {
            name: "Artificer's Eye",
            type: "standard",
            skill: "augmentation",
            prepMin: 5,
            prepMax: 100,
            rankMin: 10,
            rankMax: 600,
            durationMin: 10,
            durationMax: 40,
            slots: 2,
            manaType: "Lunar magic"
        },
        aus: {
            name: "Aura Sight",
            type: "standard",
            skill: "augmentation",
            prepMin: 5,
            prepMax: 100,
            rankMin: 10,
            rankMax: 600,
            durationMin: 10,
            durationMax: 40,
            slots: 2,
            manaType: "Lunar magic"
        },
        bc: {
            name: "Braun's Conjecture",
            type: "ritual",
            skill: "utility",
            prepMin: 150,
            prepMax: 700,
            rankMin: 80,
            rankMax: 800,
            durationMin: 30,
            durationMax: 90,
            slots: 2,
            manaType: "Lunar magic"
        },
        burn: {
            name: "Burn",
            type: "battle",
            skill: "targeted, shield ignoring",
            prepMin: 7,
            prepMax: 50,
            rankMin: 80,
            rankMax: 800,
            duration: "Instant",
            slots: 2,
            manaType: "Lunar magic"
        },
        col: {
            name: "Cage of Light",
            type: "standard",
            skill: "warding",
            prepMin: 15,
            prepMax: 100,
            rankMin: 80,
            rankMax: 800,
            durationMin: 10,
            durationMax: 40,
            slots: 3,
            manaType: "Lunar magic"
        },
        calm: {
            name: "Calm",
            type: "battle",
            skill: "debilitation",
            contest: "charm \ willpower",
            prepMin: 1,
            prepMax: 33,
            rankMin: 0,
            rankMax: 400,
            duration: "Instant",
            slots: 1,
            manaType: "Lunar magic"
        },
        cv: {
            name: "Clear Vision",
            type: "standard",
            skill: "augmentation",
            prepMin: 1,
            prepMax: 100,
            rankMin: 0,
            rankMax: 400,
            durationMin: 10,
            durationMax: 40,
            slots: 1,
            manaType: "Lunar magic"
        },
        contingency: {
            name: "Contingency",
            type: "standard",
            skill: "utility",
            prepMin: 15,
            prepMax: 100,
            rankMin: 80,
            rankMax: 800,
            durationMin: 30,
            durationMax: 90,
            slots: 3,
            manaType: "Lunar magic"
        },
        dazzle: {
            name: "Dazzle",
            type: "battle",
            skill: "debilitation",
            contest: "magic \ fortitude",
            prepMin: 1,
            prepMax: 33,
            rankMin: 10,
            rankMax: 600,
            duration: "Instant",
            slots: 2,
            manaType: "Lunar magic"
        },
        dc: {
            name: "Destiny Cipher",
            type: "ritual",
            skill: "utility",
            prepMin: 50,
            prepMax: 600,
            rankMin: 10,
            rankMax: 600,
            durationMin: 30,
            durationMax: 90,
            slots: 2,
            manaType: "Lunar magic"
        },
        dor: {
            name: "Dinazen Olkar",
            type: "battle",
            skill: "targeted",
            prepMin: 2,
            prepMax: 50,
            rankMin: 10,
            rankMax: 600,
            duration: "Instant",
            slots: 1,
            manaType: "Lunar magic"
        },
        dg: {
            name: "Distant Gaze",
            type: "standard",
            skill: "utility",
            prepMin: 15,
            prepMax: 100,
            rankMin: 80,
            rankMax: 800,
            durationMin: 60,
            durationMax: 180,
            slots: 1,
            manaType: "Lunar magic"
        },
        emmo: {
            name: "Empower Moonblade",
            type: "metamagic",
            skill: "",
            prep: "",
            rank: "",
            duration: "",
            slots: 2,
            manaType: "Lunar magic"
        },
        fm: {
            name: "FM",
            type: "Create anchor for other spells",
            skill: "standard",
            contest: "utility",
            prep: "",
            rankMin: 1,
            rankMax: 100,
            durationMin: 0,
            durationMax: 400,
            slots: 45 - 210,
            manaType: "0"
        },
        hypnotize: {
            name: "Hypnotize",
            type: "metamagic",
            skill: "",
            prep: "",
            rank: "",
            duration: "",
            slots: 1,
            manaType: "Lunar magic"
        },
        iots: {
            name: "Invocation of the Spheres",
            type: "ritual",
            skill: "augmentation",
            prepMin: 300,
            prepMax: 800,
            rankMin: 250,
            rankMax: 1000,
            durationMin: 30,
            durationMax: 90,
            slots: 2,
            manaType: "Lunar magic"
        },
        ifl: {
            name: "Iyqaromos Fire-Lens",
            type: "metamagic",
            skill: "",
            prep: "",
            rank: "",
            duration: "",
            slots: 1,
            manaType: "Lunar Magic"
        },
        locate: {
            name: "Locate",
            type: "standard",
            skill: "utility",
            prepMin: 15,
            prepMax: 100,
            rankMin: 80,
            rankMax: 800,
            duration: "Instant",
            slots: 1,
            manaType: "Lunar magic"
        },
        mt: {
            name: "Machinist's Touch",
            type: "standard",
            skill: "augmentation",
            prepMin: 15,
            prepMax: 100,
            rankMin: 80,
            rankMax: 800,
            durationMin: 10,
            durationMax: 40,
            slots: 2,
            manaType: "Lunar magic"
        },
        mb: {
            name: "Mental Blast",
            type: "battle",
            skill: "debilitation",
            contest: "mind \ willpower",
            prepMin: 20,
            prepMax: 66,
            rankMin: 250,
            rankMax: 1000,
            duration: "Instant",
            slots: 3,
            manaType: "Lunar magic"
        },
        ms: {
            name: "Mind Shout",
            type: "battle",
            skill: "debilitation, area of effect, heavy offensive",
            contest: "mind \ willpower",
            prepMin: 20,
            prepMax: 66,
            rankMin: 250,
            rankMax: 1000,
            duration: "Instant",
            slots: 3,
            manaType: "Lunar magic"
        },
        moonblade: {
            name: "Moonblade",
            type: "battle",
            skill: "utility",
            prepMin: 15,
            prepMax: 100,
            rankMin: 80,
            rankMax: 800,
            durationMin: 12,
            durationMax: 41,
            slots: 1,
            manaType: "Lunar magic"
        },
        mg: {
            name: "Moongate",
            type: "cyclic",
            skill: "utility",
            prepMin: 5,
            prepMax: 25,
            rankMin: 80,
            rankMax: 800,
            duration: "Indefinite",
            slots: 1,
            manaType: "Lunar magic"
        },
        pd: {
            name: "Partial Displacement",
            type: "battle",
            skill: "targeted, armor piercing",
            prepMin: 2,
            prepMax: 50,
            rankMin: 10,
            rankMax: 600,
            duration: "Instant",
            slots: 2,
            manaType: "Lunar magic"
        },
        pg: {
            name: "Piercing Gaze",
            type: "standard",
            skill: "utility",
            prepMin: 5,
            prepMax: 100,
            rankMin: 10,
            rankMax: 600,
            durationMin: 10,
            durationMax: 40,
            slots: 1,
            manaType: "Lunar magic"
        },
        psy: {
            name: "PSY",
            type: "Ablative ward against vs. will contested abilities.",
            skill: "battle",
            contest: "warding",
            prep: "",
            rankMin: 5,
            rankMax: 100,
            durationMin: 10,
            durationMax: 600,
            slots: 10 - 40,
            manaType: "1"
        },
        rtr: {
            name: "Read the Ripples",
            type: "ritual",
            skill: "utility",
            prepMin: 300,
            prepMax: 800,
            rankMin: 250,
            rankMax: 1000,
            durationMin: 2,
            durationMax: 10,
            slots: 2,
            manaType: "Lunar magic"
        },
        rf: {
            name: "Refractive Field",
            type: "standard",
            skill: "utility",
            prepMin: 5,
            prepMax: 100,
            rankMin: 10,
            rankMax: 600,
            durationMin: 10,
            durationMax: 40,
            slots: 2,
            manaType: "Lunar magic"
        },
        rend: {
            name: "Rend",
            type: "battle",
            skill: "debilitation, utility",
            contest: "mind \ willpower",
            prepMin: 5,
            prepMax: 100,
            rankMin: 10,
            rankMax: 600,
            duration: "Instant",
            slots: 2,
            manaType: "Lunar magic"
        },
        rs: {
            name: "Riftal Summons",
            type: "standard",
            skill: "utility",
            prepMin: 40,
            prepMax: 120,
            rankMin: 400,
            rankMax: 1250,
            duration: "Instant",
            slots: 2,
            manaType: "Lunar magic"
        },
        sco: {
            name: "Saesordian Compass",
            type: "standard",
            skill: "augmentation",
            prepMin: 30,
            prepMax: 100,
            rankMin: 250,
            rankMax: 1000,
            durationMin: 6,
            durationMax: 19,
            slots: 2,
            manaType: "Lunar Magic"
        },
        seer: {
            name: "Seer's Sense",
            type: "standard",
            skill: "augmentation, utility",
            prepMin: 15,
            prepMax: 100,
            rankMin: 80,
            rankMax: 800,
            durationMin: 10,
            durationMax: 40,
            slots: 2,
            manaType: "Lunar magic"
        },
        set: {
            name: "Sever Thread",
            type: "standard",
            skill: "debilitation",
            prepMin: 3,
            prepMax: 66,
            rankMin: 10,
            rankMax: 600,
            duration: "Instant",
            slots: 2,
            manaType: "Lunar magic"
        },
        shm: {
            name: "Shadewatch Mirror",
            type: "standard",
            skill: "utility",
            prepMin: 30,
            prepMax: 100,
            rankMin: 250,
            rankMax: 1000,
            duration: "Indefinite",
            slots: 1,
            manaType: "Lunar magic"
        },
        ss: {
            name: "Shadow Servant",
            type: "standard",
            skill: "utility",
            prepMin: 30,
            prepMax: 100,
            rankMin: 250,
            rankMax: 1000,
            duration: "Indefinite",
            slots: 3,
            manaType: "Lunar magic"
        },
        shadowling: {
            name: "Shadowling",
            type: "standard",
            skill: "utility, area of effect",
            prepMin: 15,
            prepMax: 100,
            rankMin: 80,
            rankMax: 800,
            duration: "Indefinite",
            slots: 2,
            manaType: "Lunar magic"
        },
        shadows: {
            name: "Shadows",
            type: "standard",
            skill: "augmentation",
            prepMin: 1,
            prepMax: 100,
            rankMin: 0,
            rankMax: 400,
            durationMin: 10,
            durationMax: 40,
            slots: 1,
            manaType: "Lunar magic"
        },
        shmo: {
            name: "Shape Moonblade",
            type: "metamagic",
            skill: "",
            prep: "",
            rank: "",
            duration: "",
            slots: 1,
            manaType: "Lunar magic"
        },
        shear: {
            name: "Shear",
            type: "battle",
            skill: "warding",
            prepMin: 30,
            prepMax: 100,
            rankMin: 250,
            rankMax: 1000,
            durationMin: 10,
            durationMax: 40,
            slots: 3,
            manaType: "Lunar magic"
        },
        sm: {
            name: "Shift Moonbeam",
            type: "standard",
            skill: "utility",
            prepMin: 15,
            prepMax: 100,
            rankMin: 80,
            rankMax: 800,
            durationMin: 2,
            durationMax: 10,
            slots: 2,
            manaType: "Lunar magic"
        },
        sleep: {
            name: "Sleep",
            type: "battle",
            skill: "debilitation",
            contest: "mind \ willpower",
            prepMin: 1,
            prepMax: 33,
            rankMin: 10,
            rankMax: 600,
            duration: "Instant",
            slots: 2,
            manaType: "Lunar magic"
        },
        sod: {
            name: "Sovereign Destiny",
            type: "battle",
            skill: "debilitation",
            contest: "spirit \ willpower",
            prepMin: 5,
            prepMax: 33,
            rankMin: 80,
            rankMax: 800,
            duration: "Instant",
            slots: 2,
            manaType: "Lunar magic"
        },
        sls: {
            name: "Starlight Sphere",
            type: "cyclic, battle",
            skill: "targeted",
            prepMin: 6,
            prepMax: 33,
            rankMin: 100,
            rankMax: 1000,
            duration: "Indefinite",
            slots: 1,
            manaType: "Lunar magic"
        },
        sov: {
            name: "Steps of Vuan",
            type: "cyclic",
            skill: "utility, pulse to group",
            prepMin: 5,
            prepMax: 25,
            rankMin: 80,
            rankMax: 800,
            duration: "Indefinite",
            slots: 1,
            manaType: "Lunar magic"
        },
        tf: {
            name: "Tangled Fate",
            type: "standard",
            skill: "debilitation, utility",
            prepMin: 5,
            prepMax: 100,
            rankMin: 10,
            rankMax: 600,
            durationMin: 10,
            durationMax: 40,
            slots: 2,
            manaType: "Lunar magic"
        },
        tks: {
            name: "Telekinetic Storm",
            type: "battle",
            skill: "targeted, area of effect, multistrike",
            prepMin: 15,
            prepMax: 100,
            rankMin: 80,
            rankMax: 800,
            duration: "Instant",
            slots: 1,
            manaType: "Lunar magic"
        },
        tkt: {
            name: "Telekinetic Throw",
            type: "battle",
            skill: "targeted, multistrike",
            prepMin: 1,
            prepMax: 50,
            rankMin: 0,
            rankMax: 400,
            duration: "Instant",
            slots: 1,
            manaType: "Lunar magic"
        },
        teleport: {
            name: "Teleport",
            type: "standard",
            skill: "utility",
            prepMin: 5,
            prepMax: 100,
            rankMin: 10,
            rankMax: 600,
            duration: "Instant",
            slots: 2,
            manaType: "Lunar magic"
        },
        ts: {
            name: "Tenebrous Sense",
            type: "standard",
            skill: "augmentation",
            prepMin: 5,
            prepMax: 100,
            rankMin: 10,
            rankMax: 600,
            durationMin: 10,
            durationMax: 40,
            slots: 1,
            manaType: "Lunar magic"
        },
        tv: {
            name: "Tezirah's Veil",
            type: "battle",
            skill: "augmentation, debilitation",
            contest: "spirit \ willpower",
            prepMin: 15,
            prepMax: 100,
            rankMin: 80,
            rankMax: 800,
            duration: "Instant",
            slots: 2,
            manaType: "Lunar magic"
        },
        th: {
            name: "Thoughtcast",
            type: "standard",
            skill: "utility",
            prepMin: 15,
            prepMax: 100,
            rankMin: 80,
            rankMax: 800,
            durationMin: 30,
            durationMax: 90,
            slots: 2,
            manaType: "Lunar magic"
        },
        unleash: {
            name: "Unleash",
            type: "standard",
            skill: "utility",
            prepMin: 15,
            prepMax: 100,
            rankMin: 80,
            rankMax: 800,
            duration: "Instant",
            slots: 1,
            manaType: "Lunar magic"
        },
        wd: {
            name: "Whole Displacement",
            type: "battle",
            skill: "warding",
            prepMin: 6,
            prepMax: 100,
            rankMin: 0,
            rankMax: 600,
            durationMin: 2,
            durationMax: 10,
            slots: 2,
            manaType: "Lunar magic"
        }
    }

};

function getSpellMinPrep(spellName) {

    return spells.moonmage[spellName].prepMin;

}

function getGuildBuffs(guildName) {
    var buffNames = [];
    for (var prop in spells[guildName]) {
        if (spells[guildName][prop].type === "standard" &&
                (spells[guildName][prop].skill === "augmentation" || spells[guildName][prop].skill === "warding") ) {
            buffNames.push(prop);
        }
    }

    return buffNames.join("|");
};

