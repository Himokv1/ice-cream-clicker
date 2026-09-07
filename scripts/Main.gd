extends Control

const SAVE_PATH := "user://clicker_ultimate_save.json"
const LEGACY_SAVE_PATH := "res://clicker_ultimate_save.json"
const COMBO_TIMEOUT := 1.0
const CLICK_CPS_LIFETIME := 1.0
const CPS_SMOOTH_SPEED := 8.0
const DAILY_SECONDS := 86400.0
const DAILY_REWARD_GEMS := 25
const PRESTIGE_BOSSES_NEEDED := 5
const PRESTIGE_GEMS_REWARD := 50
const ITEM_MAX_LEVEL := 50
const ITEM_POWER_PER_LEVEL := 0.03
const ITEM_XP_PER_SECOND := 1.0
const ROOT_MARGIN := 10
const LEFT_PANEL_WIDTH := 310
const RIGHT_PANEL_WIDTH := 380
const TOP_BAR_HEIGHT := 74

const COLORS := {
	"bg": "#08111f",
	"panel": "#101b2d",
	"card": "#17243a",
	"card_hover": "#253756",
	"border": "#4f7aa8",
	"text": "#fbfdff",
	"muted": "#c3cedf",
	"ice": "#0ea5e9",
	"ice_light": "#7dd3fc",
	"gold": "#f59e0b",
	"purple": "#8b5cf6",
	"pink": "#ec4899",
	"green": "#10b981",
	"red": "#ef4444",
	"orange": "#f97316"
}

const SLOT_KEYS := ["Czapka", "Narzedzie", "Buty", "Rekawice", "Pierscien"]
const SLOT_LABELS := {
	"Czapka": "Hat",
	"Narzedzie": "Tool",
	"Buty": "Boots",
	"Rekawice": "Gloves",
	"Pierscien": "Ring"
}
const SLOT_ALIASES := {
	"Czapka": "Czapka",
	"Narz\u0119dzie": "Narzedzie",
	"NarzÄ™dzie": "Narzedzie",
	"Narzedzie": "Narzedzie",
	"Buty": "Buty",
	"R\u0119kawice": "Rekawice",
	"RÄ™kawice": "Rekawice",
	"Rekawice": "Rekawice",
	"Pier\u015bcie\u0144": "Pierscien",
	"PierĹ›cieĹ„": "Pierscien",
	"Pierscien": "Pierscien"
}

const BUILDING_DEFS := {
	"b1": {"name": "Chill Drill", "blurb": "Cream turns into cold profit.", "level": 0, "base_cost": 15, "cost": 15, "cps": 1.5},
	"b2": {"name": "Whip Wizard", "blurb": "Better texture, better margin.", "level": 0, "base_cost": 120, "cost": 120, "cps": 8.0},
	"b3": {"name": "Sprinkle Storm", "blurb": "Toppings make every scoop louder.", "level": 0, "base_cost": 1500, "cost": 1500, "cps": 60.0},
	"b4": {"name": "Flavor Bomb", "blurb": "Wild syrup pulls picky customers.", "level": 0, "base_cost": 25000, "cost": 25000, "cps": 400.0},
	"b5": {"name": "Scoop Sealer", "blurb": "Cups and cones at factory speed.", "level": 0, "base_cost": 500000, "cost": 500000, "cps": 3000.0},
	"b6": {"name": "Hype Horn", "blurb": "The whole district hears the truck.", "level": 0, "base_cost": 25000000, "cost": 25000000, "cps": 25000.0},
	"b7": {"name": "Storm Sundae Factory", "blurb": "A factory line that never melts.", "level": 0, "base_cost": 800000000, "cost": 800000000, "cps": 400000.0},
	"b8": {"name": "Aurora Creamery", "blurb": "Skies made of soft serve.", "level": 0, "base_cost": 20000000000, "cost": 20000000000, "cps": 6000000.0}
}

const ACQUISITION_DEFS := {
	"ice_van": {"name": "Melody Van", "base_cost": 200, "cost": 200, "level": 0, "arrival_per_lv": 1.15, "desc": "More customers per second."},
	"playground": {"name": "Magnet Playground", "base_cost": 950, "cost": 950, "level": 0, "arrival_per_lv": 0.75, "desc": "Customers stay happier for longer."},
	"cartoon_slot": {"name": "Cartoon Ads", "base_cost": 4800, "cost": 4800, "level": 0, "arrival_per_lv": 0.55, "desc": "A steady stream of tiny fans."}
}

const AUTO_CLICK_RATES := [0.0, 0.2, 0.5, 1.0, 1.8, 3.0]
const AUTO_CLICK_COSTS := [0, 650, 3200, 15500, 72000, 340000]

const BOSS_TEMPLATES := [
	{"name": "Blizzard Witch", "color": "#6d28d9"},
	{"name": "Frostbite Drake", "color": "#b91c1c"},
	{"name": "Snow Golem Supreme", "color": "#1d4ed8"},
	{"name": "Polar Menace", "color": "#475569"},
	{"name": "Deep Freeze Titan", "color": "#57534e"},
	{"name": "Blizzard Wolf", "color": "#4338ca"},
	{"name": "Ice Cube Phoenix", "color": "#c2410c"},
	{"name": "Crystal Shield Knight", "color": "#0f766e"},
	{"name": "Lord of the Freezer", "color": "#b45309"},
	{"name": "Syrup Leviathan", "color": "#0369a1"}
]

const BOSS_RARITIES := {
	"common": {"name": "Common", "color": "#9ca3af", "reward_mult": 1.0, "weight": 70},
	"rare": {"name": "Rare", "color": "#3b82f6", "reward_mult": 1.2, "weight": 18},
	"epic": {"name": "Epic", "color": "#a855f7", "reward_mult": 1.5, "weight": 8},
	"legendary": {"name": "Legendary", "color": "#fbbf24", "reward_mult": 2.0, "weight": 3},
	"mythic": {"name": "Mythic", "color": "#ef4444", "reward_mult": 3.0, "weight": 1}
}

const BOSS_MUTATIONS := {
	"berserk": {"name": "Berserk", "color": "#dc2626", "hp_mult": 1.5, "damage_mult": 1.25, "coin_mult": 1.5, "gem_mult": 1.0, "speed_mult": 1.0, "combo_decay_mult": 1.0},
	"frenzy": {"name": "Frenzy", "color": "#f59e0b", "hp_mult": 1.0, "damage_mult": 1.35, "coin_mult": 2.0, "gem_mult": 1.25, "speed_mult": 1.35, "combo_decay_mult": 1.0},
	"frozen": {"name": "Frozen", "color": "#38bdf8", "hp_mult": 2.0, "damage_mult": 0.85, "coin_mult": 1.0, "gem_mult": 1.5, "speed_mult": 0.72, "combo_decay_mult": 1.0},
	"toxic": {"name": "Toxic", "color": "#22c55e", "hp_mult": 1.0, "damage_mult": 1.0, "coin_mult": 2.5, "gem_mult": 1.5, "speed_mult": 1.0, "combo_decay_mult": 1.7},
	"crystal": {"name": "Crystal", "color": "#67e8f9", "hp_mult": 3.0, "damage_mult": 1.0, "coin_mult": 1.0, "gem_mult": 4.0, "speed_mult": 0.9, "combo_decay_mult": 1.0},
	"elite": {"name": "Elite", "color": "#fbbf24", "hp_mult": 4.0, "damage_mult": 1.35, "coin_mult": 4.0, "gem_mult": 4.0, "speed_mult": 1.2, "combo_decay_mult": 1.0}
}

const ITEM_POOLS := {
	"Czapka": [
		{"id": "straw_hat", "name": "Strawberry Cap", "power": 1.3, "rarity": "common"},
		{"id": "ice_crown", "name": "Ice Crown", "power": 1.8, "rarity": "uncommon"},
		{"id": "snow_tiara", "name": "Snow Tiara", "power": 2.5, "rarity": "rare"},
		{"id": "frost_helm", "name": "Frost Helm", "power": 3.5, "rarity": "epic"},
		{"id": "ice_lord_crown", "name": "Ice Lord Crown", "power": 5.0, "rarity": "legendary"}
	],
	"Narzedzie": [
		{"id": "choco_spoon", "name": "Chocolate Spoon", "power": 1.4, "rarity": "common"},
		{"id": "ice_hammer", "name": "Ice Hammer", "power": 2.0, "rarity": "uncommon"},
		{"id": "frost_blade", "name": "Frost Blade", "power": 3.0, "rarity": "rare"},
		{"id": "winter_staff", "name": "Winter Staff", "power": 4.0, "rarity": "epic"},
		{"id": "eternal_staff", "name": "Staff of Eternal Frost", "power": 6.0, "rarity": "legendary"}
	],
	"Buty": [
		{"id": "snow_boots", "name": "Snow Boots", "power": 1.2, "rarity": "common"},
		{"id": "ice_skates", "name": "Ice Skates", "power": 1.6, "rarity": "uncommon"},
		{"id": "polar_boots", "name": "Polar Boots", "power": 2.2, "rarity": "rare"},
		{"id": "frost_sandals", "name": "Frost Sandals", "power": 3.0, "rarity": "epic"},
		{"id": "ice_god_boots", "name": "Ice God Boots", "power": 4.5, "rarity": "legendary"}
	],
	"Rekawice": [
		{"id": "vanilla_gloves", "name": "Vanilla Gloves", "power": 1.25, "rarity": "common"},
		{"id": "ice_claws", "name": "Ice Claws", "power": 1.7, "rarity": "uncommon"},
		{"id": "yeti_gloves", "name": "Yeti Gloves", "power": 2.4, "rarity": "rare"},
		{"id": "crystal_claws", "name": "Crystal Claws", "power": 3.2, "rarity": "epic"},
		{"id": "zero_gloves", "name": "Absolute Zero Gloves", "power": 5.0, "rarity": "legendary"}
	],
	"Pierscien": [
		{"id": "snow_ring", "name": "Snow Ring", "power": 1.15, "rarity": "common"},
		{"id": "ice_signet", "name": "Ice Signet", "power": 1.5, "rarity": "uncommon"},
		{"id": "mist_ring", "name": "Frost Mist Ring", "power": 2.0, "rarity": "rare"},
		{"id": "arctic_crystal", "name": "Arctic Crystal", "power": 2.8, "rarity": "epic"},
		{"id": "winter_ring", "name": "Ring of Eternal Winter", "power": 4.0, "rarity": "legendary"}
	]
}

const MYTHIC_ITEMS := [
	{"id": "mythic_crown", "name": "Crown of the Ice God", "slot": "Czapka", "power": 9.5, "rarity": "mythic"},
	{"id": "mythic_scepter", "name": "Scepter of Eternal Winter", "slot": "Narzedzie", "power": 10.0, "rarity": "mythic"},
	{"id": "mythic_crystal", "name": "Crystal of Absolute Zero", "slot": "Pierscien", "power": 8.5, "rarity": "mythic"}
]

const RARITY_COLORS := {
	"common": "#9ca3af",
	"uncommon": "#9ca3af",
	"rare": "#3b82f6",
	"epic": "#a855f7",
	"legendary": "#fbbf24",
	"mythic": "#ef4444"
}

const SET_BONUS_MULTS := {
	"common": 1.1,
	"uncommon": 1.15,
	"rare": 1.25,
	"epic": 1.4,
	"legendary": 1.6,
	"mythic": 2.0
}

const RAINBOW_COLORS := ["#ef4444", "#f97316", "#f59e0b", "#facc15", "#22c55e", "#0ea5e9", "#6366f1", "#a855f7", "#ec4899"]
const RAINBOW_EVENT_CHANCE := 0.3
const RAINBOW_EVENT_DURATION := 18.0
const BOSS_WIN_THRESHOLD := 165.0

const CONSUMABLES := {
	"double_coins": {"name": "x2 Coins", "duration": 60.0, "effect": "coins_x2", "color": "#fbbf24"},
	"double_cps": {"name": "x2 CPS", "duration": 60.0, "effect": "cps_x2", "color": "#22c55e"},
	"instant_cash": {"name": "Instant 10K", "duration": 0.0, "effect": "instant_10k", "color": "#10b981"},
	"gem_boost": {"name": "+50 Gems", "duration": 0.0, "effect": "gems_50", "color": "#8b5cf6"},
	"mega_click": {"name": "Mega Click x10", "duration": 30.0, "effect": "click_x10", "color": "#ef4444"},
	"cartoon_blitz": {"name": "Cartoon Ad Blitz", "duration": 22.0, "effect": "mega_arrival", "color": "#38bdf8"},
	"kids_rush": {"name": "Post-Ad Rush", "duration": 0.0, "effect": "kids_rush", "color": "#f472b6", "amount": 70}
}

const CLICK_LOOT_POOL := ["double_coins", "double_cps", "mega_click"]

const CRATE_DEFS := {
	"common": {"name": "Common Crate", "color": "#9ca3af"},
	"rare": {"name": "Rare Crate", "color": "#3b82f6"},
	"epic": {"name": "Epic Crate", "color": "#a855f7"},
	"legendary": {"name": "Legendary Crate", "color": "#fbbf24"}
}

const CRATE_RARITY_WEIGHTS := [
	["common", 0.70],
	["rare", 0.20],
	["epic", 0.08],
	["legendary", 0.02]
]

const GEM_SHOP := {
	"golden_boost": {"name": "Golden Boost x3", "cost": 100, "effect": "coins_x3", "duration": 120.0, "desc": "x3 to coins and CPS for 2 minutes."},
	"auto_clicker": {"name": "Auto Clicker", "cost": 250, "effect": "auto_click", "duration": 60.0, "desc": "Fast bonus tapping for 60 seconds."},
	"boss_skip": {"name": "Skip Boss", "cost": 150, "effect": "skip_boss", "duration": 0.0, "desc": "Instantly defeat the current boss."},
	"lucky_drop": {"name": "Lucky Drop", "cost": 200, "effect": "lucky", "duration": 180.0, "desc": "Better boss drops for 3 minutes."},
	"prestige_boost": {"name": "Prestige Boost", "cost": 500, "effect": "prestige_x2", "duration": 0.0, "desc": "+1 Prestige Point instantly."}
}

const GEM_PERKS := {
	"crit_x3": {"name": "Blade x3", "cost_base": 45, "max": 12, "desc": "+0.35% crit x3 chance per level."},
	"crit_x5": {"name": "Hammer x5", "cost_base": 75, "max": 8, "desc": "+0.12% crit x5 chance per level."},
	"click_loot": {"name": "Lucky Tap", "cost_base": 55, "max": 15, "desc": "+0.1% tap bonus chance per level."}
}

const PRESTIGE_UPGRADES := {
	"start_coins": {"name": "Fat Wallet", "desc": "+1000 starting coins per level", "cost": 1, "max": 10},
	"click_power": {"name": "Titanium Thumb", "desc": "+50% click power per level", "cost": 2, "max": 5},
	"cps_boost": {"name": "Night Shift", "desc": "+25% CPS per level", "cost": 2, "max": 5},
	"boss_damage": {"name": "Boss Buster", "desc": "+30% boss damage per level", "cost": 3, "max": 5},
	"gem_luck": {"name": "Gem Sniffer", "desc": "+20% boss gems per level", "cost": 3, "max": 5},
	"drop_luck": {"name": "Loot Magnet", "desc": "Better boss drops", "cost": 4, "max": 3}
}

const ACHIEVEMENTS := [
	{"id": "first_click", "title": "First Scoop", "desc": "Land your first tap.", "gems": 2, "kind": "clicks", "target": 1},
	{"id": "clicks_1k", "title": "Sore Fingers", "desc": "Reach 1,000 taps.", "gems": 5, "kind": "clicks", "target": 1000},
	{"id": "clicks_10k", "title": "Tap Titan", "desc": "Reach 10,000 taps.", "gems": 15, "kind": "clicks", "target": 10000},
	{"id": "clicks_100k", "title": "Human Auto-Clicker", "desc": "Reach 100,000 taps.", "gems": 40, "kind": "clicks", "target": 100000},
	{"id": "first_boss", "title": "Boss Down", "desc": "Beat the first boss.", "gems": 10, "kind": "bosses", "target": 1},
	{"id": "bosses_10", "title": "Boss Hunter", "desc": "Beat 10 bosses.", "gems": 25, "kind": "bosses", "target": 10},
	{"id": "bosses_50", "title": "Arena Legend", "desc": "Beat 50 bosses.", "gems": 50, "kind": "bosses", "target": 50},
	{"id": "combo_25", "title": "In the Groove", "desc": "Reach combo 25.", "gems": 8, "kind": "combo", "target": 25},
	{"id": "combo_75", "title": "Flow State", "desc": "Reach combo 75.", "gems": 20, "kind": "combo", "target": 75},
	{"id": "rich_100k", "title": "Money Stacks", "desc": "Earn 100K coins total.", "gems": 10, "kind": "earned", "target": 100000},
	{"id": "rich_10m", "title": "Scoop Mogul", "desc": "Earn 10M coins total.", "gems": 35, "kind": "earned", "target": 10000000},
	{"id": "rebirth_once", "title": "Born Again", "desc": "Do one rebirth.", "gems": 20, "kind": "rebirths", "target": 1},
	{"id": "spire_owner", "title": "Hype Machine", "desc": "Buy one Hype Horn level.", "gems": 30, "kind": "building_b6", "target": 1},
	{"id": "legendary_drop", "title": "Legendary Flex", "desc": "Own a legendary item.", "gems": 25, "kind": "rarity", "target": "legendary"},
	{"id": "mythic_drop", "title": "Mythic Relic", "desc": "Own a mythic item.", "gems": 80, "kind": "rarity", "target": "mythic"},
	{"id": "codex_half", "title": "Arena Scholar", "desc": "Unlock half the codex.", "gems": 30, "kind": "codex", "target": 5},
	{"id": "codex_full", "title": "Boss Encyclopedia", "desc": "Unlock the full codex.", "gems": 60, "kind": "codex", "target": 10},
	{"id": "prestige_holder", "title": "Rising Star", "desc": "Earn one Prestige Point.", "gems": 15, "kind": "prestige", "target": 1},
	{"id": "prestige_5", "title": "Prestige Circle", "desc": "Earn 5 Prestige Points.", "gems": 40, "kind": "prestige", "target": 5},
	{"id": "crates_10", "title": "Crate Cracker", "desc": "Open 10 crates.", "gems": 15, "kind": "crates_opened", "target": 10},
	{"id": "crates_50", "title": "Crate Connoisseur", "desc": "Open 50 crates.", "gems": 35, "kind": "crates_opened", "target": 50},
	{"id": "consumables_25", "title": "Bottoms Up", "desc": "Use 25 consumables.", "gems": 20, "kind": "consumables_used", "target": 25},
	{"id": "top_floor", "title": "Aurora Achieved", "desc": "Buy one Aurora Creamery level.", "gems": 45, "kind": "building_b8", "target": 1},
	{"id": "full_set", "title": "Matching Fit", "desc": "Equip a full set of the same rarity.", "gems": 30, "kind": "full_set", "target": 1}
]

const LANGUAGE_OPTIONS := {
	"EN": "English",
	"PL": "Polski"
}

const EFFECT_LABELS := {
	"coins_x2": "x2 Coins",
	"coins_x3": "x3 Coins",
	"cps_x2": "x2 CPS",
	"instant_10k": "Instant 10K",
	"gems_50": "+50 Gems",
	"click_x10": "Mega Click x10",
	"mega_arrival": "Cartoon Ad Blitz",
	"kids_rush": "Post-Ad Rush",
	"lucky": "Lucky Drop",
	"skip_boss": "Skip Boss",
	"prestige_x2": "Prestige Boost"
}

const ABILITY_LABELS := {
	"shield": "Shield",
	"regeneration": "Regeneration",
	"rage": "Rage",
	"crystal_armor": "Crystal Armor",
	"frozen_curse": "Frozen Curse"
}

const TRANSLATIONS := {
	"PL": {
		"Scoop Empire": "Imperium Gałek",
		"Ice Cream Tycoon - Godot": "Lodziarski Tycoon - Godot",
		"Tap the scoop": "Klikaj loda",
		"Machine Floor": "Hala Maszyn",
		"Coins": "Monety",
		"CPS": "CPS",
		"Click": "Klik",
		"Combo": "Kombo",
		"Gems": "Klejnoty",
		"Prestige": "Prestiż",
		"Mult": "Mnoż.",
		"Boss": "Boss",
		"Inv": "Eq",
		"Crates": "Skrzynie",
		"Goals": "Cele",
		"Settings": "Ustawienia",
		"BUY": "KUP",
		"MAX": "MAX",
		"Lv.": "Poz.",
		"clicks/s": "kliknięć/s",
		"Finger Fury": "Furia Palca",
		"Auto Lab": "Auto Lab",
		"Auto Clicker Rig": "Zestaw Auto-Klikacza",
		"Customer Flow": "Napływ Klientów",
		"Boss Arena": "Arena Bossów",
		"Inventory": "Ekwipunek",
		"Loot Crates": "Skrzynie z Łupem",
		"Gem Shop": "Sklep za Klejnoty",
		"Achievements": "Osiągnięcia",
		"Chill Drill": "Chłodna Wiertarka",
		"Cream turns into cold profit.": "Śmietanka zamienia się w zimny zysk.",
		"Whip Wizard": "Mistrz Ubijania",
		"Better texture, better margin.": "Lepsza konsystencja, lepsza marża.",
		"Sprinkle Storm": "Burza Posypek",
		"Toppings make every scoop louder.": "Dodatki sprawiają, że każda gałka robi hałas.",
		"Flavor Bomb": "Bomba Smaku",
		"Wild syrup pulls picky customers.": "Dziki syrop przyciąga wybrednych klientów.",
		"Scoop Sealer": "Zamykacz Gałek",
		"Cups and cones at factory speed.": "Kubki i rożki w fabrycznym tempie.",
		"Hype Horn": "Róg Reklamowy",
		"The whole district hears the truck.": "Cała dzielnica słyszy furgonetkę.",
		"Storm Sundae Factory": "Fabryka Sztormowych Deserów",
		"A factory line that never melts.": "Linia produkcyjna, która nigdy nie topnieje.",
		"Aurora Creamery": "Mleczarnia Zorzy Polarnej",
		"Skies made of soft serve.": "Niebo z lodów śmietankowych.",
		"Melody Van": "Muzyczna Furgonetka",
		"More customers per second.": "Więcej klientów na sekundę.",
		"Magnet Playground": "Magnetyczny Plac Zabaw",
		"Customers stay happier for longer.": "Klienci są szczęśliwsi przez dłużej.",
		"Cartoon Ads": "Reklamy z Kreskówek",
		"A steady stream of tiny fans.": "Stały strumień małych fanów.",
		"Blizzard Witch": "Wiedźma Zamieci",
		"Frostbite Drake": "Smok Odmrożeń",
		"Snow Golem Supreme": "Najwyższy Śnieżny Golem",
		"Polar Menace": "Polarne Zagrożenie",
		"Deep Freeze Titan": "Tytan Głębokiego Mrozu",
		"Blizzard Wolf": "Wilk Zamieci",
		"Ice Cube Phoenix": "Feniks z Kostki Lodu",
		"Crystal Shield Knight": "Rycerz Kryształowej Tarczy",
		"Lord of the Freezer": "Władca Zamrażarki",
		"Syrup Leviathan": "Syropowy Lewiatan",
		"Common": "Pospolity",
		"Rare": "Rzadki",
		"Epic": "Epicki",
		"Legendary": "Legendarny",
		"Mythic": "Mityczny",
		"common": "pospolity",
		"uncommon": "niepospolity",
		"rare": "rzadki",
		"epic": "epicki",
		"legendary": "legendarny",
		"mythic": "mityczny",
		"Berserk": "Berserk",
		"Frenzy": "Szał",
		"Frozen": "Zmrożony",
		"Toxic": "Toksyczny",
		"Crystal": "Kryształowy",
		"Elite": "Elitarny",
		"Hat": "Czapka",
		"Tool": "Narzędzie",
		"Boots": "Buty",
		"Gloves": "Rękawice",
		"Ring": "Pierścień",
		"Strawberry Cap": "Truskawkowa Czapka",
		"Ice Crown": "Lodowa Korona",
		"Snow Tiara": "Śnieżna Tiara",
		"Frost Helm": "Hełm Mrozu",
		"Ice Lord Crown": "Korona Władcy Lodu",
		"Chocolate Spoon": "Czekoladowa Łyżka",
		"Ice Hammer": "Lodowy Młot",
		"Frost Blade": "Ostrze Mrozu",
		"Winter Staff": "Zimowa Laska",
		"Staff of Eternal Frost": "Laska Wiecznego Mrozu",
		"Snow Boots": "Śnieżne Buty",
		"Ice Skates": "Łyżwy",
		"Polar Boots": "Polarowe Buty",
		"Frost Sandals": "Sandały Mrozu",
		"Ice God Boots": "Buty Boga Lodu",
		"Vanilla Gloves": "Waniliowe Rękawice",
		"Ice Claws": "Lodowe Pazury",
		"Yeti Gloves": "Rękawice Yeti",
		"Crystal Claws": "Kryształowe Pazury",
		"Absolute Zero Gloves": "Rękawice Zera Absolutnego",
		"Snow Ring": "Śnieżny Pierścień",
		"Ice Signet": "Lodowy Sygnet",
		"Frost Mist Ring": "Pierścień Mroźnej Mgły",
		"Arctic Crystal": "Arktyczny Kryształ",
		"Ring of Eternal Winter": "Pierścień Wiecznej Zimy",
		"Crown of the Ice God": "Korona Boga Lodu",
		"Scepter of Eternal Winter": "Berło Wiecznej Zimy",
		"Crystal of Absolute Zero": "Kryształ Zera Absolutnego",
		"x2 Coins": "x2 Monety",
		"x3 Coins": "x3 Monety",
		"x2 CPS": "x2 CPS",
		"Instant 10K": "Natychmiastowe 10K",
		"+50 Gems": "+50 Klejnotów",
		"Mega Click x10": "Mega Klik x10",
		"Cartoon Ad Blitz": "Kreskówkowy Szturm Reklam",
		"Post-Ad Rush": "Rush po Reklamie",
		"Common Crate": "Pospolita Skrzynia",
		"Rare Crate": "Rzadka Skrzynia",
		"Epic Crate": "Epicka Skrzynia",
		"Legendary Crate": "Legendarna Skrzynia",
		"Golden Boost x3": "Złote Wzmocnienie x3",
		"x3 to coins and CPS for 2 minutes.": "x3 do monet i CPS przez 2 minuty.",
		"Auto Clicker": "Auto-Klikacz",
		"Fast bonus tapping for 60 seconds.": "Szybkie bonusowe klikanie przez 60 sekund.",
		"Skip Boss": "Pomiń Bossa",
		"Instantly defeat the current boss.": "Natychmiast pokonuje obecnego bossa.",
		"Lucky Drop": "Szczęśliwy Drop",
		"Better boss drops for 3 minutes.": "Lepsze dropy z bossów przez 3 minuty.",
		"Prestige Boost": "Wzmocnienie Prestiżu",
		"+1 Prestige Point instantly.": "+1 Punkt Prestiżu natychmiast.",
		"Blade x3": "Ostrze x3",
		"+0.35% crit x3 chance per level.": "+0,35% szansy na kryt x3 za poziom.",
		"Hammer x5": "Młot x5",
		"+0.12% crit x5 chance per level.": "+0,12% szansy na kryt x5 za poziom.",
		"Lucky Tap": "Szczęśliwe Kliknięcie",
		"+0.1% tap bonus chance per level.": "+0,1% szansy na bonus z kliknięcia za poziom.",
		"Fat Wallet": "Gruby Portfel",
		"+1000 starting coins per level": "+1000 monet startowych za poziom",
		"Titanium Thumb": "Tytanowy Kciuk",
		"+50% click power per level": "+50% siły kliknięcia za poziom",
		"Night Shift": "Nocna Zmiana",
		"+25% CPS per level": "+25% CPS za poziom",
		"Boss Buster": "Pogromca Bossów",
		"+30% boss damage per level": "+30% obrażeń bossom za poziom",
		"Gem Sniffer": "Łowca Klejnotów",
		"+20% boss gems per level": "+20% klejnotów z bossów za poziom",
		"Loot Magnet": "Magnes na Łup",
		"Better boss drops": "Lepsze dropy z bossów",
		"First Scoop": "Pierwsza Gałka",
		"Land your first tap.": "Wykonaj pierwsze kliknięcie.",
		"Sore Fingers": "Obolałe Palce",
		"Reach 1,000 taps.": "Osiągnij 1 000 kliknięć.",
		"Tap Titan": "Tytan Klikania",
		"Reach 10,000 taps.": "Osiągnij 10 000 kliknięć.",
		"Human Auto-Clicker": "Ludzki Auto-Klikacz",
		"Reach 100,000 taps.": "Osiągnij 100 000 kliknięć.",
		"Boss Down": "Boss Pokonany",
		"Beat the first boss.": "Pokonaj pierwszego bossa.",
		"Boss Hunter": "Łowca Bossów",
		"Beat 10 bosses.": "Pokonaj 10 bossów.",
		"Arena Legend": "Legenda Areny",
		"Beat 50 bosses.": "Pokonaj 50 bossów.",
		"In the Groove": "W Rytmie",
		"Reach combo 25.": "Osiągnij kombo 25.",
		"Flow State": "Stan Flow",
		"Reach combo 75.": "Osiągnij kombo 75.",
		"Money Stacks": "Stosy Monet",
		"Earn 100K coins total.": "Zarób łącznie 100K monet.",
		"Scoop Mogul": "Magnat Gałek",
		"Earn 10M coins total.": "Zarób łącznie 10M monet.",
		"Born Again": "Nowy Start",
		"Do one rebirth.": "Wykonaj jeden rebirth.",
		"Hype Machine": "Maszyna Rozgłosu",
		"Buy one Hype Horn level.": "Kup jeden poziom Rogu Reklamowego.",
		"Legendary Flex": "Legendarny Popis",
		"Own a legendary item.": "Posiadaj legendarny przedmiot.",
		"Mythic Relic": "Mityczny Relikt",
		"Own a mythic item.": "Posiadaj mityczny przedmiot.",
		"Arena Scholar": "Znawca Areny",
		"Unlock half the codex.": "Odblokuj połowę kodeksu.",
		"Boss Encyclopedia": "Encyklopedia Bossów",
		"Unlock the full codex.": "Odblokuj cały kodeks.",
		"Prestige Circle": "Krąg Prestiżu",
		"Earn 5 Prestige Points.": "Zdobądź 5 Punktów Prestiżu.",
		"Crate Cracker": "Łamacz Skrzynek",
		"Open 10 crates.": "Otwórz 10 skrzynek.",
		"Crate Connoisseur": "Koneser Skrzynek",
		"Open 50 crates.": "Otwórz 50 skrzynek.",
		"Bottoms Up": "Do Dna",
		"Use 25 consumables.": "Użyj 25 przedmiotów zużywalnych.",
		"Aurora Achieved": "Zorza Osiągnięta",
		"Buy one Aurora Creamery level.": "Kup jeden poziom Mleczarni Zorzy Polarnej.",
		"Matching Fit": "Komplet Pasuje",
		"Equip a full set of the same rarity.": "Załóż pełny komplet tej samej rzadkości.",
		"Rising Star": "Wschodząca Gwiazda",
		"Earn one Prestige Point.": "Zdobądź jeden Punkt Prestiżu.",
		"Level %s - %s\nPower: %s | Gems: ~%s | Coins: %s\nRequires total earned %s and click Lv %s": "Poziom %s - %s\nMoc: %s | Klejnoty: ~%s | Monety: %s\nWymaga łącznie zarobionych %s i kliku poz. %s",
		"Start Fight": "Rozpocznij Walkę",
		"Push the bar to 100 before the boss pushes it to 0.": "Dopchnij pasek do 100, zanim boss zepchnie go do 0.",
		"Fight": "Walcz",
		"Locked": "Zablokowane",
		"Battle Momentum": "Przewaga w Walce",
		"Ice Shield": "Lodowa Tarcza",
		"Abilities: %s": "Zdolności: %s",
		"Attack": "Atak",
		"Flee": "Uciekaj",
		"Codex": "Kodeks",
		"Boss Codex": "Kodeks Bossów",
		"%s/%s discovered": "Odkryto %s/%s",
		"Equipped - multiplier x%.2f": "Założone - mnożnik x%.2f",
		"Set Bonus Active": "Bonus za Komplet Aktywny",
		"Full %s set: x%.2f to all equipment power.": "Pełny komplet %s: x%.2f do mocy całego ekwipunku.",
		"Set Bonus": "Bonus za Komplet",
		"Equip 5 items of the same rarity for a bonus multiplier.": "Załóż 5 przedmiotów tej samej rzadkości, aby otrzymać bonusowy mnożnik.",
		"Empty": "Puste",
		"Backpack": "Plecak",
		"Beat bosses and open crates to find gear.": "Pokonuj bossów i otwieraj skrzynie, żeby zdobywać ekwipunek.",
		"%s slot - x%.2f power - Lv %s": "Slot: %s - moc x%.2f - poz. %s",
		"Equip": "Załóż",
		"Consumables": "Przedmioty zużywalne",
		"Consumables drop from bosses, crates and daily rewards.": "Przedmioty zużywalne wypadają z bossów, skrzyń i nagród dziennych.",
		"Effect: %s | Duration: %ss": "Efekt: %s | Czas: %ss",
		"Use": "Użyj",
		"Owned: %s": "Posiadane: %s",
		"Open": "Otwórz",
		"Gem Wallet": "Portfel Klejnotów",
		"%s gems available": "Dostępne klejnoty: %s",
		"Boosts": "Wzmocnienia",
		"Permanent Perks": "Stałe Perki",
		"%s gems": "%s klejnotów",
		"Lv %s/%s - %s": "Poz. %s/%s - %s",
		"Prestige Points": "Punkty Prestiżu",
		"%s points | bosses %s/%s": "%s punktów | bossowie %s/%s",
		"Prestige Now": "Prestiż Teraz",
		"Reset coins, machines and current run. Keep gems, perks, achievements and gain +1 Prestige Point + %s gems.": "Resetuje monety, maszyny i obecny run. Zachowujesz klejnoty, perki, osiągnięcia i zyskujesz +1 Punkt Prestiżu oraz %s klejnotów.",
		"Rebirth": "Odrodzenie",
		"Soft reset machines for a permanent +50% multiplier. Current rebirths: %s": "Miękki reset maszyn za stały mnożnik +50%. Obecne odrodzenia: %s",
		"%s coins": "%s monet",
		"Prestige Upgrades": "Ulepszenia Prestiżu",
		"%s PP": "%s PP",
		"Progress": "Postęp",
		"%s/%s completed": "Ukończono %s/%s",
		"%s - done": "%s - ukończone",
		"Reward: %s gems": "Nagroda: %s klejnotów",
		"Language": "Język",
		"Volume": "Głośność",
		"Master": "Ogólna",
		"Music": "Muzyka",
		"Sound Effects": "Efekty dźwiękowe",
		"Choose the game language.": "Wybierz język gry.",
		"Fullscreen": "Pełny ekran",
		"Starts fullscreen. Press F11 to toggle, Esc to leave fullscreen.": "Uruchamia pełny ekran. F11 przełącza, Esc wychodzi z pełnego ekranu.",
		"Toggle": "Przełącz",
		"Save Game": "Zapisz Grę",
		"Writes your current run to user://.": "Zapisuje obecny run do user://.",
		"Save": "Zapisz",
		"Import Legacy Save": "Importuj Stary Zapis",
		"If the Python save is bundled in the project, load it again.": "Jeśli zapis z Pythona jest w projekcie, wczyta go ponownie.",
		"Import": "Importuj",
		"Reset Run": "Reset Runu",
		"Deletes local Godot save and restarts from defaults.": "Usuwa lokalny zapis Godota i zaczyna od domyślnych danych.",
		"Reset": "Reset",
		"Save Path": "Ścieżka Zapisu",
		"English": "Angielski",
		"Polski": "Polski",
		"Shield": "Tarcza",
		"Regeneration": "Regeneracja",
		"Rage": "Szał",
		"Crystal Armor": "Kryształowy Pancerz",
		"Frozen Curse": "Mroźna Klątwa",
		"Godot port ready. Save is loaded automatically.": "Port Godot gotowy. Zapis wczytuje się automatycznie.",
		"Windowed mode.": "Tryb okienkowy.",
		"Fullscreen on.": "Pełny ekran włączony.",
		"Saved.": "Zapisano.",
		"Legacy save imported.": "Stary zapis zaimportowany.",
		"Run reset.": "Run zresetowany.",
		"Language changed to %s.": "Zmieniono język na %s.",
		"You fled the arena.": "Uciekasz z areny.",
		"Frozen curse slowed your attacks.": "Mroźna klątwa spowolniła twoje ataki.",
		"Victory! +%s gems, +%s coins": "Zwycięstwo! +%s klejnotów, +%s monet",
		"RAINBOW RUSH! Clicks x2!": "TĘCZOWY SZAŁ! Kliknięcia x2!",
		"RAINBOW RUSH! Coins x2 for %ss!": "TĘCZOWY SZAŁ! Monety x2 przez %ss!",
		"Rainbow Rush faded.": "Tęczowy Szał wygasł.",
		"Defeat. Upgrade and try again.": "Porażka. Ulepsz się i spróbuj ponownie.",
		"MYTHIC drop: %s": "MITYCZNY drop: %s",
		"Drop: %s [%s]": "Drop: %s [%s]",
		"Bonus: %s": "Bonus: %s",
		"Crate opened: +%s gems": "Skrzynia otwarta: +%s klejnotów",
		"Crate opened: +%s coins": "Skrzynia otwarta: +%s monet",
		"Crate opened: %s": "Skrzynia otwarta: %s",
		"Crate item: %s": "Przedmiot ze skrzyni: %s",
		"Finger Fury upgraded.": "Furia Palca ulepszona.",
		"%s upgraded.": "%s ulepszono.",
		"Auto Lab upgraded.": "Auto Lab ulepszony.",
		"Lucky tap: %s": "Szczęśliwe kliknięcie: %s",
		"This boss is still locked.": "Ten boss jest nadal zablokowany.",
		"Fight started: %s": "Walka rozpoczęta: %s",
		"Equipped item leveled up.": "Założony przedmiot awansował.",
		"Equipped %s.": "Założono %s.",
		"Consumable": "Przedmiot zużywalny",
		"Used %s.": "Użyto %s.",
		"consumable": "przedmiot zużywalny",
		"Boss skipped: +%s gems": "Boss pominięty: +%s klejnotów",
		"%s bought.": "Kupiono %s.",
		"%s perk upgraded.": "Perk %s ulepszony.",
		"Prestige complete: +1 PP and +%s gems.": "Prestiż ukończony: +1 PP i +%s klejnotów.",
		"Rebirth complete. Multiplier boosted.": "Odrodzenie ukończone. Mnożnik zwiększony.",
		"Daily reward: +%s gems and a consumable.": "Nagroda dzienna: +%s klejnotów i przedmiot zużywalny.",
		"Achievement: %s": "Osiągnięcie: %s",
		"Gift": "Prezent",
		"Airdrop incoming.": "Nadchodzi zrzut.",
		"Airdrop: +%s coins": "Zrzut: +%s monet",
		"Airdrop: +%s gems": "Zrzut: +%s klejnotów",
		"Airdrop: %s": "Zrzut: %s",
		"Airdrop boost: %s": "Wzmocnienie ze zrzutu: %s",
		"Rare airdrop: %s": "Rzadki zrzut: %s",
		" CRIT x%s": " KRYT x%s",
		"Item": "Przedmiot"
	}
}

var rng := RandomNumberGenerator.new()
var data: Dictionary = {}
var active_panel := "boss"
var combo := 0
var combo_timer := 0.0
var click_cps_bursts: Array = []
var displayed_cps := 0.0
var ui_timer := 0.0
var save_timer := 0.0
var item_timer := 0.0
var airdrop_timer := 0.0
var airdrop_button: Button
var airdrop_life := 0.0
var is_fighting := false
var fight_state: Dictionary = {}

var shop_list: VBoxContainer
var panel_list: VBoxContainer
var panel_title: Label
var big_coin_label: Label
var coin_label: Label
var cps_label: Label
var click_power_label: Label
var combo_label: Label
var gem_label: Label
var pp_label: Label
var mult_label: Label
var notice_label: Label
var combo_bar: ProgressBar
var fight_bar: ProgressBar
var shield_bar: ProgressBar
var attack_button: Button
var airdrop_slot: CenterContainer
var click_fx_layer: Control
var fx_overlay: Control
var ice_button_ref: TextureButton
var nav_buttons: Dictionary = {}
var audio_players: Dictionary = {}
var rainbow_timer := 0.0
var rainbow_spawn_timer := 0.0
var rainbow_banner: Label


func _ready() -> void:
	rng.randomize()
	_set_fullscreen(true)
	data = _default_data()
	_setup_audio()
	_load_game()
	_ensure_data_integrity()
	_apply_volume_settings()
	_build_ui()
	_schedule_airdrop()
	_check_daily_reward()
	_check_achievements()
	_refresh_everything()
	_show_notice(_t("Godot port ready. Save is loaded automatically."))


func _process(delta: float) -> void:
	if data.is_empty():
		return
	data["stats"]["play_time"] = float(data["stats"].get("play_time", 0.0)) + delta
	_update_effects()
	_update_combo(delta)
	_update_income(delta)
	_update_fight(delta)
	_update_airdrop(delta)
	_update_item_growth(delta)
	_update_smooth_status(delta)
	if rainbow_timer > 0.0:
		rainbow_timer = max(0.0, rainbow_timer - delta)
		_update_rainbow_visuals(delta)
		if rainbow_timer <= 0.0:
			_end_rainbow_event()
	ui_timer -= delta
	if ui_timer <= 0.0:
		ui_timer = 0.18
		_refresh_status()
	save_timer += delta
	if save_timer >= 10.0:
		save_timer = 0.0
		_save_game()


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		_save_game()


func _unhandled_input(event: InputEvent) -> void:
	var key_event: InputEventKey = event as InputEventKey
	if key_event == null or not key_event.pressed or key_event.echo:
		return
	if key_event.keycode == KEY_F11:
		_toggle_fullscreen()
		get_viewport().set_input_as_handled()
	elif key_event.keycode == KEY_ESCAPE and _is_fullscreen():
		_set_fullscreen(false)
		_show_notice(_t("Windowed mode."))
		get_viewport().set_input_as_handled()


func _exit_tree() -> void:
	if not data.is_empty():
		_save_game()
	for player in audio_players.values():
		if player != null and is_instance_valid(player):
			player.stop()


func _setup_audio() -> void:
	var files := {
		"click": "res://assets/sounds/click.mp3",
		"cash": "res://assets/sounds/cash_register.mp3",
		"success": "res://assets/sounds/success.mp3",
		"music": "res://assets/sounds/music.mp3"
	}
	for key in files.keys():
		var stream = load(files[key])
		if stream == null:
			continue
		var player := AudioStreamPlayer.new()
		player.stream = stream
		if key == "music":
			player.volume_db = -20.0
		add_child(player)
		audio_players[key] = player
	if audio_players.has("music"):
		audio_players["music"].play()


func _play_sound(key: String) -> void:
	if audio_players.has(key):
		audio_players[key].play()


func _apply_volume_settings() -> void:
	var settings: Dictionary = data.get("settings", {})
	var master: float = clamp(float(settings.get("master_volume", 1.0)), 0.0, 1.0)
	var music_vol: float = clamp(float(settings.get("music_volume", 1.0)), 0.0, 1.0)
	var sfx_vol: float = clamp(float(settings.get("sfx_volume", 1.0)), 0.0, 1.0)
	for key in audio_players.keys():
		var player: AudioStreamPlayer = audio_players[key]
		if player == null or not is_instance_valid(player):
			continue
		var is_music: bool = (key == "music")
		var category_vol := music_vol if is_music else sfx_vol
		var linear: float = master * category_vol
		var base_db := -20.0 if is_music else 0.0
		if linear <= 0.0005:
			player.volume_db = -80.0
		else:
			player.volume_db = base_db + linear_to_db(linear)


func _set_master_volume(value: float) -> void:
	data["settings"]["master_volume"] = clamp(value, 0.0, 1.0)
	_apply_volume_settings()
	_save_game()


func _set_music_volume(value: float) -> void:
	data["settings"]["music_volume"] = clamp(value, 0.0, 1.0)
	_apply_volume_settings()
	_save_game()


func _set_sfx_volume(value: float) -> void:
	data["settings"]["sfx_volume"] = clamp(value, 0.0, 1.0)
	_apply_volume_settings()
	_save_game()
	_play_sound("click")


func _build_ui() -> void:
	var bg := ColorRect.new()
	bg.name = "Background"
	bg.color = _color(COLORS["bg"])
	bg.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(bg)

	var root := Control.new()
	root.name = "Root"
	root.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(root)

	var root_margin := MarginContainer.new()
	root_margin.set_anchors_preset(Control.PRESET_FULL_RECT)
	root_margin.add_theme_constant_override("margin_left", ROOT_MARGIN)
	root_margin.add_theme_constant_override("margin_right", ROOT_MARGIN)
	root_margin.add_theme_constant_override("margin_top", ROOT_MARGIN)
	root_margin.add_theme_constant_override("margin_bottom", ROOT_MARGIN)
	root.add_child(root_margin)

	var main := VBoxContainer.new()
	main.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	main.size_flags_vertical = Control.SIZE_EXPAND_FILL
	main.add_theme_constant_override("separation", 8)
	root_margin.add_child(main)

	var top := _panel(COLORS["panel"], COLORS["border"], 8)
	top.custom_minimum_size = Vector2(0, TOP_BAR_HEIGHT)
	top.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	main.add_child(top)
	var top_margin := _margin(8)
	top.add_child(top_margin)
	var top_row := HBoxContainer.new()
	top_row.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	top_row.add_theme_constant_override("separation", 8)
	top_margin.add_child(top_row)

	var title_box := VBoxContainer.new()
	title_box.custom_minimum_size = Vector2(180, 0)
	top_row.add_child(title_box)
	var title := _label(_t("Scoop Empire"), 24, COLORS["text"], true)
	title_box.add_child(title)
	var subtitle := _label(_t("Ice Cream Tycoon - Godot"), 13, COLORS["muted"], false)
	title_box.add_child(subtitle)

	coin_label = _stat_box(top_row, _t("Coins"), COLORS["gold"])
	cps_label = _stat_box(top_row, _t("CPS"), COLORS["green"])
	click_power_label = _stat_box(top_row, _t("Click"), COLORS["ice_light"])
	combo_label = _stat_box(top_row, _t("Combo"), COLORS["purple"])
	gem_label = _stat_box(top_row, _t("Gems"), COLORS["purple"])
	pp_label = _stat_box(top_row, _t("Prestige"), COLORS["orange"])
	mult_label = _stat_box(top_row, _t("Mult"), COLORS["pink"])

	var body := HBoxContainer.new()
	body.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	body.size_flags_vertical = Control.SIZE_EXPAND_FILL
	body.add_theme_constant_override("separation", 8)
	main.add_child(body)

	var left := _panel(COLORS["panel"], COLORS["border"], 8)
	left.custom_minimum_size = Vector2(LEFT_PANEL_WIDTH, 0)
	left.size_flags_horizontal = Control.SIZE_FILL
	left.size_flags_vertical = Control.SIZE_EXPAND_FILL
	body.add_child(left)
	var left_margin := _margin(10)
	left.add_child(left_margin)
	var left_v := VBoxContainer.new()
	left_v.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	left_v.size_flags_vertical = Control.SIZE_EXPAND_FILL
	left_v.add_theme_constant_override("separation", 8)
	left_margin.add_child(left_v)
	left_v.add_child(_label(_t("Machine Floor"), 20, COLORS["text"], true))
	var shop_scroll := ScrollContainer.new()
	shop_scroll.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	shop_scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	left_v.add_child(shop_scroll)
	shop_list = VBoxContainer.new()
	shop_list.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	shop_list.add_theme_constant_override("separation", 8)
	shop_scroll.add_child(shop_list)

	var center := _panel(COLORS["panel"], COLORS["border"], 8)
	center.custom_minimum_size = Vector2(340, 0)
	center.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	center.size_flags_vertical = Control.SIZE_EXPAND_FILL
	body.add_child(center)
	var center_margin := _margin(12)
	center.add_child(center_margin)
	var center_v := VBoxContainer.new()
	center_v.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	center_v.size_flags_vertical = Control.SIZE_EXPAND_FILL
	center_v.alignment = BoxContainer.ALIGNMENT_CENTER
	center_v.add_theme_constant_override("separation", 12)
	center_margin.add_child(center_v)

	var coin_title := _label(_t("Tap the scoop"), 20, COLORS["muted"], true)
	coin_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	center_v.add_child(coin_title)
	big_coin_label = _label("", 48, COLORS["gold"], true)
	big_coin_label.name = "BigCoinLabel"
	big_coin_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	center_v.add_child(big_coin_label)

	var click_stage := Control.new()
	click_stage.custom_minimum_size = Vector2(0, 360)
	click_stage.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	click_stage.size_flags_vertical = Control.SIZE_EXPAND_FILL
	center_v.add_child(click_stage)

	var click_center := CenterContainer.new()
	click_center.set_anchors_preset(Control.PRESET_FULL_RECT)
	click_stage.add_child(click_center)

	var ice_texture: Texture2D = load("res://assets/ice_clean.png")
	ice_button_ref = TextureButton.new()
	ice_button_ref.custom_minimum_size = Vector2(320, 260)
	ice_button_ref.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	ice_button_ref.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	ice_button_ref.texture_normal = ice_texture
	ice_button_ref.texture_hover = ice_texture
	ice_button_ref.texture_pressed = ice_texture
	ice_button_ref.ignore_texture_size = true
	ice_button_ref.stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
	ice_button_ref.texture_click_mask = _make_texture_click_mask(ice_texture)
	ice_button_ref.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS
	ice_button_ref.focus_mode = Control.FOCUS_NONE
	ice_button_ref.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	ice_button_ref.pressed.connect(_on_click)
	click_center.add_child(ice_button_ref)

	click_fx_layer = Control.new()
	click_fx_layer.set_anchors_preset(Control.PRESET_FULL_RECT)
	click_fx_layer.mouse_filter = Control.MOUSE_FILTER_IGNORE
	click_stage.add_child(click_fx_layer)

	combo_bar = ProgressBar.new()
	combo_bar.max_value = 1.0
	combo_bar.show_percentage = false
	combo_bar.custom_minimum_size = Vector2(0, 16)
	center_v.add_child(combo_bar)

	notice_label = _label("", 15, COLORS["ice_light"], true)
	notice_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	notice_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	center_v.add_child(notice_label)

	rainbow_banner = _label(_t("RAINBOW RUSH! Clicks x2!"), 18, COLORS["gold"], true)
	rainbow_banner.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	rainbow_banner.visible = false
	center_v.add_child(rainbow_banner)

	airdrop_slot = CenterContainer.new()
	airdrop_slot.custom_minimum_size = Vector2(0, 48)
	airdrop_slot.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	center_v.add_child(airdrop_slot)

	var right := _panel(COLORS["panel"], COLORS["border"], 8)
	right.custom_minimum_size = Vector2(RIGHT_PANEL_WIDTH, 0)
	right.size_flags_horizontal = Control.SIZE_FILL
	right.size_flags_vertical = Control.SIZE_EXPAND_FILL
	body.add_child(right)
	var right_margin := _margin(10)
	right.add_child(right_margin)
	var right_v := VBoxContainer.new()
	right_v.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	right_v.size_flags_vertical = Control.SIZE_EXPAND_FILL
	right_v.add_theme_constant_override("separation", 8)
	right_margin.add_child(right_v)

	var nav := GridContainer.new()
	nav.columns = 4
	nav.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	nav.add_theme_constant_override("separation", 6)
	right_v.add_child(nav)
	for row in [
		["boss", _t("Boss")],
		["inventory", _t("Inv")],
		["crates", _t("Crates")],
		["gems", _t("Gems")],
		["prestige", _t("Prestige")],
		["achievements", _t("Goals")],
		["settings", _t("Settings")]
	]:
		var nav_btn := _button(row[1], COLORS["card"], 12)
		nav_btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		nav_btn.pressed.connect(_open_panel.bind(row[0]))
		nav.add_child(nav_btn)
		nav_buttons[row[0]] = nav_btn

	panel_title = _label("", 20, COLORS["text"], true)
	right_v.add_child(panel_title)
	var panel_scroll := ScrollContainer.new()
	panel_scroll.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	panel_scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	right_v.add_child(panel_scroll)
	panel_list = VBoxContainer.new()
	panel_list.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	panel_list.add_theme_constant_override("separation", 8)
	panel_scroll.add_child(panel_list)

	fx_overlay = Control.new()
	fx_overlay.name = "FxOverlay"
	fx_overlay.set_anchors_preset(Control.PRESET_FULL_RECT)
	fx_overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(fx_overlay)


func _stat_box(parent: Control, title: String, color: String) -> Label:
	var box := _panel(COLORS["card"], COLORS["border"], 8)
	box.custom_minimum_size = Vector2(92, 0)
	box.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	parent.add_child(box)
	var m := _margin(8)
	box.add_child(m)
	var v := VBoxContainer.new()
	m.add_child(v)
	var t := _label(title, 11, COLORS["muted"], true)
	t.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	v.add_child(t)
	var val := _label("0", 18, color, true)
	val.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	v.add_child(val)
	return val


func _build_shop() -> void:
	_clear(shop_list)
	shop_list.add_child(_shop_card(
		_t("Finger Fury"),
		"%s %s" % [_t("Lv."), int(data["click_level"])],
		_format_num(data["click_cost"]),
		COLORS["purple"],
		float(data["coins"]) >= float(data["click_cost"]),
		_upgrade_click
	))
	for key in BUILDING_DEFS.keys():
		var b: Dictionary = data["buildings"][key]
		shop_list.add_child(_shop_card(
			_t(str(BUILDING_DEFS[key]["name"])),
			"%s %s - +%s/s" % [_t("Lv."), int(b["level"]), _format_num(b["cps"])],
			_format_num(b["cost"]),
			COLORS["green"],
			float(data["coins"]) >= float(b["cost"]),
			_buy_building.bind(key),
			"res://assets/icons/building_%s.png" % key
	))
	shop_list.add_child(_section_label(_t("Auto Lab")))
	var auto_level := _get_auto_lab_level()
	var auto_cost: int = int(AUTO_CLICK_COSTS[min(auto_level + 1, AUTO_CLICK_COSTS.size() - 1)])
	shop_list.add_child(_shop_card(
		_t("Auto Clicker Rig"),
		"%s %s - %.1f %s" % [_t("Lv."), auto_level, _get_auto_click_rate(), _t("clicks/s")],
		_t("MAX") if auto_level >= AUTO_CLICK_RATES.size() - 1 else _format_num(auto_cost),
		COLORS["ice"],
		auto_level < AUTO_CLICK_RATES.size() - 1 and float(data["coins"]) >= auto_cost,
		_buy_auto_lab
	))
	shop_list.add_child(_section_label(_t("Customer Flow")))
	for key in ACQUISITION_DEFS.keys():
		var acq: Dictionary = data["acquisition"][key]
		shop_list.add_child(_shop_card(
			_t(str(ACQUISITION_DEFS[key]["name"])),
			"%s %s" % [_t("Lv."), int(acq["level"])],
			_format_num(acq["cost"]),
			COLORS["orange"],
			float(data["coins"]) >= float(acq["cost"]),
			_buy_acquisition.bind(key)
		))


func _open_panel(panel: String) -> void:
	active_panel = panel
	for key in nav_buttons.keys():
		_style_button(nav_buttons[key], COLORS["ice"] if key == panel else COLORS["card"], COLORS["card_hover"], COLORS["ice"])
	_clear(panel_list)
	match panel:
		"boss":
			panel_title.text = _t("Boss Arena")
			_build_boss_panel()
		"inventory":
			panel_title.text = _t("Inventory")
			_build_inventory_panel()
		"crates":
			panel_title.text = _t("Loot Crates")
			_build_crates_panel()
		"gems":
			panel_title.text = _t("Gem Shop")
			_build_gem_panel()
		"prestige":
			panel_title.text = _t("Prestige")
			_build_prestige_panel()
		"achievements":
			panel_title.text = _t("Achievements")
			_build_achievements_panel()
		"settings":
			panel_title.text = _t("Settings")
			_build_settings_panel()


func _build_boss_panel() -> void:
	var boss := _get_current_boss()
	panel_list.add_child(_info_card(
		boss["name"],
		_t("Level %s - %s\nPower: %s | Gems: ~%s | Coins: %s\nRequires total earned %s and click Lv %s") % [
			int(boss["level"]),
			boss["rarity_name"],
			_format_num(boss["strength"]),
			_format_num(boss["reward"]),
			_format_num(boss["coin_reward"]),
			_format_num(boss["min_total"]),
			int(boss["min_click_level"])
		],
		boss["color"]
	))
	var can_fight := float(data["total_earned"]) >= float(boss["min_total"]) and int(data["click_level"]) >= int(boss["min_click_level"])
	if not is_fighting:
		panel_list.add_child(_action_card(
			_t("Start Fight"),
			_t("Push the bar to 100 before the boss pushes it to 0."),
			_t("Fight") if can_fight else _t("Locked"),
			COLORS["red"],
			can_fight,
			_start_fight
		))
	else:
		var fight_box := _panel(COLORS["card"], COLORS["border"], 8)
		panel_list.add_child(fight_box)
		var m := _margin(10)
		fight_box.add_child(m)
		var v := VBoxContainer.new()
		v.add_theme_constant_override("separation", 8)
		m.add_child(v)
		v.add_child(_label(_t("Battle Momentum"), 15, COLORS["text"], true))
		fight_bar = ProgressBar.new()
		fight_bar.max_value = BOSS_WIN_THRESHOLD
		fight_bar.value = float(fight_state.get("tug", 50.0))
		fight_bar.show_percentage = false
		fight_bar.custom_minimum_size = Vector2(0, 22)
		v.add_child(fight_bar)
		if float(fight_state.get("shield_max", 0.0)) > 0.0:
			v.add_child(_label(_t("Ice Shield"), 13, COLORS["muted"], true))
			shield_bar = ProgressBar.new()
			shield_bar.max_value = 100.0
			shield_bar.value = 100.0 * float(fight_state.get("shield", 0.0)) / max(1.0, float(fight_state.get("shield_max", 1.0)))
			shield_bar.show_percentage = false
			shield_bar.custom_minimum_size = Vector2(0, 14)
			v.add_child(shield_bar)
		var abilities: Array = fight_state.get("abilities", [])
		if not abilities.is_empty():
			v.add_child(_label(_t("Abilities: %s") % _ability_list_text(abilities), 13, COLORS["muted"], false))
		var attack := _button(_t("Attack"), COLORS["red"], 18)
		attack.custom_minimum_size = Vector2(0, 52)
		attack.pressed.connect(_attack_boss)
		attack_button = attack
		v.add_child(attack)
		var flee := _button(_t("Flee"), COLORS["card_hover"], 13)
		flee.pressed.connect(func() -> void:
			is_fighting = false
			fight_state = {}
			_show_notice(_t("You fled the arena."))
			_open_panel("boss")
		)
		v.add_child(flee)
	panel_list.add_child(_section_label(_t("Codex")))
	var unlocked: int = data.get("codex", {}).size()
	panel_list.add_child(_info_card(_t("Boss Codex"), _t("%s/%s discovered") % [unlocked, BOSS_TEMPLATES.size()], COLORS["ice"]))


func _build_inventory_panel() -> void:
	panel_list.add_child(_section_label(_t("Equipped - multiplier x%.2f") % _get_equipment_multiplier()))
	var set_rarity := _full_set_rarity()
	if set_rarity != "":
		panel_list.add_child(_info_card(
			_t("Set Bonus Active"),
			_t("Full %s set: x%.2f to all equipment power.") % [_rarity_label(set_rarity), SET_BONUS_MULTS.get(set_rarity, 1.0)],
			RARITY_COLORS.get(set_rarity, COLORS["gold"])
		))
	else:
		panel_list.add_child(_info_card(
			_t("Set Bonus"),
			_t("Equip 5 items of the same rarity for a bonus multiplier."),
			COLORS["muted"]
		))
	for slot in SLOT_KEYS:
		var item = data["equipped"].get(slot)
		var text := _t("Empty")
		if item != null:
			text = "%s x%.2f (%s %s)" % [_item_display_name(item), _item_effective_power(item), _t("Lv."), int(item.get("item_level", 1))]
		panel_list.add_child(_info_card(_slot_label(slot), text, COLORS["ice"]))
	panel_list.add_child(_section_label(_t("Backpack")))
	if data["inventory"].is_empty():
		panel_list.add_child(_info_card(_t("Empty"), _t("Beat bosses and open crates to find gear."), COLORS["muted"]))
	for item in data["inventory"]:
		_ensure_item_fields(item)
		panel_list.add_child(_action_card(
			"%s [%s]" % [_item_display_name(item), _rarity_label(str(item["rarity"]))],
			_t("%s slot - x%.2f power - Lv %s") % [_slot_label(str(item["slot"])), _item_effective_power(item), int(item.get("item_level", 1))],
			_t("Equip"),
			RARITY_COLORS.get(item["rarity"], COLORS["ice"]),
			true,
			_equip_item.bind(str(item["item_uid"]))
		))
	panel_list.add_child(_section_label(_t("Consumables")))
	if data["consumables"].is_empty():
		panel_list.add_child(_info_card(_t("Empty"), _t("Consumables drop from bosses, crates and daily rewards."), COLORS["muted"]))
	for i in range(data["consumables"].size()):
		var cons: Dictionary = data["consumables"][i]
		panel_list.add_child(_action_card(
			_consumable_display_name(cons),
			_t("Effect: %s | Duration: %ss") % [_effect_label(str(cons.get("effect", "?"))), int(cons.get("duration", 0))],
			_t("Use"),
			cons.get("color", COLORS["purple"]),
			true,
			_use_consumable.bind(i)
		))


func _build_crates_panel() -> void:
	for tier in CRATE_DEFS.keys():
		var count := int(data["crates"].get(tier, 0))
		var meta: Dictionary = CRATE_DEFS[tier]
		panel_list.add_child(_action_card(
			_t(str(meta["name"])),
			_t("Owned: %s") % count,
			_t("Open"),
			meta["color"],
			count > 0,
			_open_crate.bind(tier)
		))


func _build_gem_panel() -> void:
	panel_list.add_child(_info_card(_t("Gem Wallet"), _t("%s gems available") % int(data["gems"]), COLORS["purple"]))
	panel_list.add_child(_section_label(_t("Boosts")))
	for key in GEM_SHOP.keys():
		var item: Dictionary = GEM_SHOP[key]
		panel_list.add_child(_action_card(
			_t(str(item["name"])),
			_t(str(item["desc"])),
			_t("%s gems") % item["cost"],
			COLORS["purple"],
			int(data["gems"]) >= int(item["cost"]),
			_buy_gem_item.bind(key)
		))
	panel_list.add_child(_section_label(_t("Permanent Perks")))
	for key in GEM_PERKS.keys():
		var perk: Dictionary = GEM_PERKS[key]
		var lv := int(data["gem_perks"].get(key, 0))
		var cost := _gem_perk_cost(key)
		panel_list.add_child(_action_card(
			_t(str(perk["name"])),
			_t("Lv %s/%s - %s") % [lv, int(perk["max"]), _t(str(perk["desc"]))],
			_t("MAX") if lv >= int(perk["max"]) else _t("%s gems") % cost,
			COLORS["gold"],
			lv < int(perk["max"]) and int(data["gems"]) >= cost,
			_buy_gem_perk.bind(key)
		))


func _build_prestige_panel() -> void:
	panel_list.add_child(_info_card(_t("Prestige Points"), _t("%s points | bosses %s/%s") % [int(data["prestige_points"]), int(data["bosses_defeated"]), PRESTIGE_BOSSES_NEEDED], COLORS["orange"]))
	panel_list.add_child(_action_card(
		_t("Prestige Now"),
		_t("Reset coins, machines and current run. Keep gems, perks, achievements and gain +1 Prestige Point + %s gems.") % PRESTIGE_GEMS_REWARD,
		_t("Prestige") if int(data["bosses_defeated"]) >= PRESTIGE_BOSSES_NEEDED else _t("Locked"),
		COLORS["orange"],
		int(data["bosses_defeated"]) >= PRESTIGE_BOSSES_NEEDED,
		_do_prestige
	))
	var rebirth_cost := (int(data["rebirths"]) + 1) * 100000
	panel_list.add_child(_action_card(
		_t("Rebirth"),
		_t("Soft reset machines for a permanent +50% multiplier. Current rebirths: %s") % int(data["rebirths"]),
		_t("%s coins") % _format_num(rebirth_cost),
		COLORS["pink"],
		float(data["coins"]) >= rebirth_cost,
		_do_rebirth
	))
	panel_list.add_child(_section_label(_t("Prestige Upgrades")))
	for key in PRESTIGE_UPGRADES.keys():
		var up: Dictionary = PRESTIGE_UPGRADES[key]
		var lv := int(data["prestige_upgrades"].get(key, 0))
		panel_list.add_child(_action_card(
			_t(str(up["name"])),
			_t("Lv %s/%s - %s") % [lv, int(up["max"]), _t(str(up["desc"]))],
			_t("MAX") if lv >= int(up["max"]) else _t("%s PP") % int(up["cost"]),
			COLORS["orange"],
			lv < int(up["max"]) and int(data["prestige_points"]) >= int(up["cost"]),
			_buy_prestige_upgrade.bind(key)
		))


func _build_achievements_panel() -> void:
	var done: Array = data["achievements_completed"]
	panel_list.add_child(_info_card(_t("Progress"), _t("%s/%s completed") % [done.size(), ACHIEVEMENTS.size()], COLORS["green"]))
	for ach in ACHIEVEMENTS:
		var completed: bool = done.has(ach["id"])
		panel_list.add_child(_info_card(
			(_t("%s - done") if completed else "%s") % _t(str(ach["title"])),
			"%s\n%s" % [_t(str(ach["desc"])), _t("Reward: %s gems") % int(ach["gems"])],
			COLORS["green"] if completed else COLORS["card_hover"]
		))


func _build_settings_panel() -> void:
	panel_list.add_child(_volume_card())
	panel_list.add_child(_language_card())
	panel_list.add_child(_action_card(_t("Fullscreen"), _t("Starts fullscreen. Press F11 to toggle, Esc to leave fullscreen."), _t("Toggle"), COLORS["ice"], true, _toggle_fullscreen))
	panel_list.add_child(_action_card(_t("Save Game"), _t("Writes your current run to user://."), _t("Save"), COLORS["green"], true, func() -> void:
		_save_game()
		_show_notice(_t("Saved."))
	))
	panel_list.add_child(_action_card(_t("Import Legacy Save"), _t("If the Python save is bundled in the project, load it again."), _t("Import"), COLORS["ice"], FileAccess.file_exists(LEGACY_SAVE_PATH), func() -> void:
		_load_from_path(LEGACY_SAVE_PATH)
		_ensure_data_integrity()
		_refresh_everything()
		_save_game()
		_show_notice(_t("Legacy save imported."))
	))
	panel_list.add_child(_action_card(_t("Reset Run"), _t("Deletes local Godot save and restarts from defaults."), _t("Reset"), COLORS["red"], true, func() -> void:
		var keep_lang := _current_lang()
		data = _default_data()
		data["lang"] = keep_lang
		_ensure_data_integrity()
		_save_game()
		_refresh_everything()
		_show_notice(_t("Run reset."))
	))
	panel_list.add_child(_info_card(_t("Save Path"), SAVE_PATH, COLORS["muted"]))


func _volume_card() -> Control:
	var card := _panel(COLORS["card"], COLORS["ice"], 8)
	var m := _margin(10)
	card.add_child(m)
	var v := VBoxContainer.new()
	v.add_theme_constant_override("separation", 10)
	m.add_child(v)
	v.add_child(_label(_t("Volume"), 15, COLORS["text"], true))
	v.add_child(_volume_slider_row(_t("Master"), float(data["settings"].get("master_volume", 1.0)), _set_master_volume))
	v.add_child(_volume_slider_row(_t("Music"), float(data["settings"].get("music_volume", 1.0)), _set_music_volume))
	v.add_child(_volume_slider_row(_t("Sound Effects"), float(data["settings"].get("sfx_volume", 1.0)), _set_sfx_volume))
	return card


func _volume_slider_row(label_text: String, value: float, on_change: Callable) -> Control:
	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 10)
	var lbl := _label(label_text, 13, COLORS["muted"], false)
	lbl.custom_minimum_size = Vector2(140, 0)
	row.add_child(lbl)
	var slider := HSlider.new()
	slider.min_value = 0.0
	slider.max_value = 1.0
	slider.step = 0.01
	slider.value = value
	slider.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	slider.custom_minimum_size = Vector2(120, 24)
	slider.focus_mode = Control.FOCUS_NONE
	row.add_child(slider)
	var pct_label := _label("%d%%" % int(round(value * 100.0)), 13, COLORS["text"], false)
	pct_label.custom_minimum_size = Vector2(42, 0)
	row.add_child(pct_label)
	slider.value_changed.connect(func(new_value: float) -> void:
		pct_label.text = "%d%%" % int(round(new_value * 100.0))
		on_change.call(new_value)
	)
	return row


func _language_card() -> Control:
	var card := _panel(COLORS["card"], COLORS["ice"], 8)
	var m := _margin(10)
	card.add_child(m)
	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 10)
	m.add_child(row)
	var texts := VBoxContainer.new()
	texts.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	row.add_child(texts)
	texts.add_child(_label(_t("Language"), 15, COLORS["text"], true))
	texts.add_child(_label(_t("Choose the game language."), 12, COLORS["muted"], false))
	var options := OptionButton.new()
	options.custom_minimum_size = Vector2(150, 40)
	options.focus_mode = Control.FOCUS_NONE
	var selected_idx := 0
	var idx := 0
	for code in LANGUAGE_OPTIONS.keys():
		options.add_item(_t(str(LANGUAGE_OPTIONS[code])), idx)
		options.set_item_metadata(idx, code)
		if code == _current_lang():
			selected_idx = idx
		idx += 1
	options.select(selected_idx)
	options.item_selected.connect(func(index: int) -> void:
		_set_language(str(options.get_item_metadata(index)))
	)
	row.add_child(options)
	return card


func _refresh_everything() -> void:
	_build_shop()
	_open_panel(active_panel)
	_refresh_status()


func _refresh_status() -> void:
	if big_coin_label != null and is_instance_valid(big_coin_label):
		big_coin_label.text = _format_num(data["coins"])
	coin_label.text = _format_num(data["coins"])
	if displayed_cps <= 0.0:
		displayed_cps = _get_display_cps()
	cps_label.text = "%s/s" % _format_num(displayed_cps)
	click_power_label.text = "+%s" % _format_num(_get_click_power())
	combo_label.text = "x%s" % combo
	gem_label.text = str(int(data["gems"]))
	pp_label.text = str(int(data["prestige_points"]))
	mult_label.text = "x%.2f" % _get_multiplier()
	combo_bar.value = clamp(combo_timer / COMBO_TIMEOUT, 0.0, 1.0)
	if fight_bar != null and is_instance_valid(fight_bar) and is_fighting:
		fight_bar.value = float(fight_state.get("tug", 50.0))
	if shield_bar != null and is_instance_valid(shield_bar) and is_fighting and float(fight_state.get("shield_max", 0.0)) > 0.0:
		shield_bar.value = 100.0 * float(fight_state.get("shield", 0.0)) / max(1.0, float(fight_state.get("shield_max", 1.0)))


func _on_click() -> void:
	_register_combo_hit()
	var amount := _get_click_power()
	var crit := 1
	var p := rng.randf()
	var crit_probs := _get_crit_probabilities()
	if p < crit_probs[1]:
		crit = 5
	elif p < crit_probs[1] + crit_probs[0]:
		crit = 3
	amount *= crit
	data["coins"] = float(data["coins"]) + amount
	data["total_earned"] = float(data["total_earned"]) + amount
	data["clicks"] = int(data["clicks"]) + 1
	data["stats"]["total_clicks"] = int(data["stats"].get("total_clicks", 0)) + 1
	_register_click_income(amount)
	_roll_click_loot()
	_play_sound("click")
	_animate_ice_click()
	if crit > 1 and ice_button_ref != null and is_instance_valid(ice_button_ref):
		_spawn_purchase_particles(ice_button_ref.get_global_rect().get_center(), COLORS["gold"] if crit == 3 else COLORS["pink"])
	_float_text("+%s%s" % [_format_num(amount), _t(" CRIT x%s") % crit if crit > 1 else ""], COLORS["gold"])
	_check_achievements()
	_refresh_status()


func _animate_ice_click() -> void:
	if ice_button_ref == null or not is_instance_valid(ice_button_ref):
		return
	ice_button_ref.pivot_offset = ice_button_ref.size * 0.5
	ice_button_ref.scale = Vector2.ONE
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(ice_button_ref, "scale", Vector2(0.94, 0.94), 0.07)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(ice_button_ref, "scale", Vector2(1.03, 1.03), 0.08)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(ice_button_ref, "scale", Vector2.ONE, 0.10)


func _register_combo_hit() -> void:
	combo += 1
	combo_timer = COMBO_TIMEOUT
	data["stats"]["highest_combo"] = max(int(data["stats"].get("highest_combo", 0)), combo)


func _update_combo(delta: float) -> void:
	if combo <= 0:
		return
	var decay_mult := 1.0
	if is_fighting:
		decay_mult = float(_get_current_boss().get("combo_decay_mult", 1.0))
	combo_timer -= delta * decay_mult
	if combo_timer <= 0.0:
		combo = 0
		combo_timer = 0.0


func _register_click_income(amount: float) -> void:
	click_cps_bursts.append({
		"amount": amount,
		"time_left": CLICK_CPS_LIFETIME,
	})


func _update_income(delta: float) -> void:
	var income := (_get_cps() + _get_auto_click_income_per_second()) * delta
	data["coins"] = float(data["coins"]) + income
	data["total_earned"] = float(data["total_earned"]) + income
	for i in range(click_cps_bursts.size() - 1, -1, -1):
		var burst: Dictionary = click_cps_bursts[i]
		burst["time_left"] = float(burst.get("time_left", 0.0)) - delta
		if float(burst["time_left"]) <= 0.0:
			click_cps_bursts.remove_at(i)
		else:
			click_cps_bursts[i] = burst


func _update_smooth_status(delta: float) -> void:
	var target := _get_display_cps()
	var response := 1.0 - exp(-CPS_SMOOTH_SPEED * delta)
	displayed_cps = lerp(displayed_cps, target, response)
	if combo_bar != null and is_instance_valid(combo_bar):
		combo_bar.value = clamp(combo_timer / COMBO_TIMEOUT, 0.0, 1.0)


func _update_effects() -> void:
	var now := _now()
	for key in data["active_effects"].keys().duplicate():
		if float(data["active_effects"][key]) <= now:
			data["active_effects"].erase(key)


func _upgrade_click() -> void:
	if float(data["coins"]) < float(data["click_cost"]):
		return
	data["coins"] = float(data["coins"]) - float(data["click_cost"])
	data["click_level"] = int(data["click_level"]) + 1
	data["click_cost"] = int(float(data["click_cost"]) * 1.6)
	_after_purchase(_t("Finger Fury upgraded."))


func _buy_building(key: String) -> void:
	var b: Dictionary = data["buildings"][key]
	if float(data["coins"]) < float(b["cost"]):
		return
	data["coins"] = float(data["coins"]) - float(b["cost"])
	b["level"] = int(b["level"]) + 1
	b["cost"] = int(float(b["cost"]) * 1.22)
	_after_purchase(_t("%s upgraded.") % _t(str(BUILDING_DEFS[key]["name"])))


func _buy_auto_lab() -> void:
	var lv := _get_auto_lab_level()
	if lv >= AUTO_CLICK_RATES.size() - 1:
		return
	var cost: int = int(AUTO_CLICK_COSTS[lv + 1])
	if float(data["coins"]) < cost:
		return
	data["coins"] = float(data["coins"]) - cost
	data["auto_lab"]["level"] = lv + 1
	_after_purchase(_t("Auto Lab upgraded."))


func _buy_acquisition(key: String) -> void:
	var acq: Dictionary = data["acquisition"][key]
	if float(data["coins"]) < float(acq["cost"]):
		return
	data["coins"] = float(data["coins"]) - float(acq["cost"])
	acq["level"] = int(acq["level"]) + 1
	acq["cost"] = int(float(acq["cost"]) * 1.32)
	_after_purchase(_t("%s upgraded.") % _t(str(ACQUISITION_DEFS[key]["name"])))


func _after_purchase(message: String) -> void:
	_play_sound("cash")
	_show_notice(message)
	_check_achievements()
	_save_game()
	_refresh_everything()


func _get_rebirth_multiplier() -> float:
	return 1.0 + int(data["rebirths"]) * 0.5


func _get_equipment_multiplier() -> float:
	var mult := 1.0
	for item in data["equipped"].values():
		if item != null:
			mult *= _item_effective_power(item)
	mult *= _get_set_bonus_multiplier()
	return mult


func _get_set_bonus_multiplier() -> float:
	var rarity := _full_set_rarity()
	if rarity == "":
		return 1.0
	return float(SET_BONUS_MULTS.get(rarity, 1.0))


func _has_full_equipment_set() -> bool:
	return _full_set_rarity() != ""


func _full_set_rarity() -> String:
	var found_rarity := ""
	for slot in SLOT_KEYS:
		var item = data["equipped"].get(slot, null)
		if item == null or not (item is Dictionary):
			return ""
		var r := str(item.get("rarity", ""))
		if found_rarity == "":
			found_rarity = r
		elif r != found_rarity:
			return ""
	return found_rarity


func _get_active_coin_multiplier() -> float:
	var mult := 1.0
	if _effect_active("coins_x2"):
		mult *= 2.0
	if _effect_active("coins_x3"):
		mult *= 3.0
	return mult


func _get_active_cps_multiplier() -> float:
	var mult := 1.0
	if _effect_active("cps_x2"):
		mult *= 2.0
	if _effect_active("coins_x3"):
		mult *= 3.0
	return mult


func _get_base_production_multiplier() -> float:
	var mult := _get_rebirth_multiplier() * _get_equipment_multiplier()
	mult *= 1.0 + int(data["prestige_upgrades"].get("cps_boost", 0)) * 0.25
	return mult


func _get_raw_cps() -> float:
	var machine := 0.0
	for b in data["buildings"].values():
		machine += int(b["level"]) * float(b["cps"])
	var customer_bonus := 1.0 + _get_arrival_per_second() * 0.015
	return (0.55 + machine) * customer_bonus * _get_base_production_multiplier() * _get_active_cps_multiplier()


func _get_cps() -> float:
	return _get_raw_cps() * _get_active_coin_multiplier()


func _get_multiplier() -> float:
	return _get_base_production_multiplier() * _get_active_cps_multiplier() * _get_active_coin_multiplier()


func _get_click_power() -> float:
	var base := int(data["click_level"]) * 1.5
	var mult := _get_rebirth_multiplier() * _get_equipment_multiplier()
	mult *= 1.0 + int(data["prestige_upgrades"].get("click_power", 0)) * 0.5
	mult *= _get_active_coin_multiplier()
	if _effect_active("click_x10"):
		mult *= 10.0
	var combo_mult: float = 1.0 + min(combo, 50) * 0.02
	return base * mult * combo_mult


func _get_display_cps() -> float:
	var click_burst_total := 0.0
	for burst in click_cps_bursts:
		click_burst_total += float((burst as Dictionary).get("amount", 0.0))
	return _get_cps() + _get_auto_click_income_per_second() + click_burst_total


func _get_auto_lab_level() -> int:
	return clamp(int(data.get("auto_lab", {}).get("level", 0)), 0, AUTO_CLICK_RATES.size() - 1)


func _get_auto_click_rate() -> float:
	return AUTO_CLICK_RATES[_get_auto_lab_level()]


func _get_auto_click_income_per_second() -> float:
	return _get_auto_click_rate() * _get_click_power() * 0.35


func _get_arrival_per_second() -> float:
	var amount := 0.0
	for key in data["acquisition"].keys():
		var acq: Dictionary = data["acquisition"][key]
		amount += int(acq.get("level", 0)) * float(ACQUISITION_DEFS[key].get("arrival_per_lv", 0.0))
	if _effect_active("mega_arrival"):
		amount *= 2.5
	return amount


func _get_crit_probabilities() -> Array:
	var p3 := 0.05 + int(data["gem_perks"].get("crit_x3", 0)) * 0.0035
	var p5 := 0.01 + int(data["gem_perks"].get("crit_x5", 0)) * 0.0012
	return [p3, p5]


func _get_click_loot_chance() -> float:
	return 0.002 + int(data["gem_perks"].get("click_loot", 0)) * 0.001


func _roll_click_loot() -> void:
	if rng.randf() > _get_click_loot_chance():
		return
	var key: String = str(_random_from_array(CLICK_LOOT_POOL))
	data["consumables"].append(_make_consumable(key))
	_show_notice(_t("Lucky tap: %s") % _t(str(CONSUMABLES[key]["name"])))


func _effect_active(effect: String) -> bool:
	return float(data["active_effects"].get(effect, 0.0)) > _now()


func _start_fight() -> void:
	var boss := _get_current_boss()
	if float(data["total_earned"]) < float(boss["min_total"]) or int(data["click_level"]) < int(boss["min_click_level"]):
		_show_notice(_t("This boss is still locked."))
		return
	var abilities: Array = []
	if int(boss["level"]) > 1:
		var pool: Array = ["shield", "regeneration", "rage", "crystal_armor", "frozen_curse"]
		var count := 1 if int(boss["level"]) < 5 else rng.randi_range(1, 2)
		while abilities.size() < count:
			var ability: String = str(_random_from_array(pool))
			if not abilities.has(ability):
				abilities.append(ability)
	var shield := 0.0
	if abilities.has("shield"):
		shield = float(boss["strength"]) * (5.5 + int(boss["level"]) * 0.35)
	fight_state = {
		"boss": boss,
		"tug": max(20.0, 34.0 - int(boss["level"]) * 1.1),
		"abilities": abilities,
		"shield": shield,
		"shield_max": shield,
		"regen_clock": 0.0,
		"curse_clock": rng.randf_range(2.5, 4.5),
		"frozen_left": 0.0
	}
	is_fighting = true
	_show_notice(_t("Fight started: %s") % boss["name"])
	_open_panel("boss")


func _attack_boss() -> void:
	if not is_fighting:
		return
	if attack_button != null and is_instance_valid(attack_button):
		_spawn_purchase_particles(attack_button.get_global_rect().get_center(), COLORS["red"])
	var push := _player_push_amount()
	if float(fight_state.get("shield", 0.0)) > 0.0:
		var new_shield := float(fight_state["shield"]) - push
		if new_shield < 0.0:
			fight_state["shield"] = 0.0
			fight_state["tug"] = float(fight_state["tug"]) + abs(new_shield)
		else:
			fight_state["shield"] = new_shield
	else:
		fight_state["tug"] = float(fight_state["tug"]) + push
	if float(fight_state["tug"]) >= BOSS_WIN_THRESHOLD:
		_end_fight(true)
	_refresh_status()


func _player_push_amount() -> float:
	var boss := _get_current_boss()
	var level := int(boss["level"])
	var push := 0.65 + _get_click_power() * (0.009 + level * 0.0006) + _get_raw_cps() * 0.016 + int(data["rebirths"]) * 0.15
	push *= 1.0 + int(data["prestige_upgrades"].get("boss_damage", 0)) * 0.3
	push *= max(0.15, 1.0 - (level - 1) * 0.045)
	if fight_state.get("abilities", []).has("crystal_armor"):
		push *= 0.6
	if float(fight_state.get("frozen_left", 0.0)) > 0.0:
		push *= 0.4
	return push


func _update_fight(delta: float) -> void:
	if not is_fighting:
		return
	var boss := _get_current_boss()
	var abilities: Array = fight_state.get("abilities", [])
	if float(fight_state.get("frozen_left", 0.0)) > 0.0:
		fight_state["frozen_left"] = max(0.0, float(fight_state["frozen_left"]) - delta)
	if abilities.has("frozen_curse"):
		fight_state["curse_clock"] = float(fight_state["curse_clock"]) - delta
		if float(fight_state["curse_clock"]) <= 0.0:
			fight_state["frozen_left"] = 1.6
			fight_state["curse_clock"] = rng.randf_range(3.0, 5.0)
			_show_notice(_t("Frozen curse slowed your attacks."))
	if abilities.has("regeneration"):
		fight_state["regen_clock"] = float(fight_state["regen_clock"]) + delta
		if float(fight_state["regen_clock"]) >= 1.0:
			fight_state["regen_clock"] = 0.0
			fight_state["tug"] = float(fight_state["tug"]) - float(boss["strength"]) * (0.16 + int(boss["level"]) * 0.008)
	var boss_hp_pct := 1.0 - float(fight_state["tug"]) / BOSS_WIN_THRESHOLD
	var rage_mult := 1.9 if abilities.has("rage") and boss_hp_pct <= 0.22 else 1.0
	var pressure := float(boss["strength"]) * 0.58 * float(boss["damage_mult"]) * float(boss["speed_mult"]) * rage_mult
	pressure /= 3.8 - min(1.2, int(boss["level"]) * 0.08)
	fight_state["tug"] = float(fight_state["tug"]) - pressure * delta
	if float(fight_state["tug"]) <= 0.0:
		_end_fight(false)


func _end_fight(won: bool) -> void:
	if not is_fighting:
		return
	is_fighting = false
	if won:
		var victory_origin := Vector2.ZERO
		if attack_button != null and is_instance_valid(attack_button):
			victory_origin = attack_button.get_global_rect().get_center()
		if victory_origin != Vector2.ZERO:
			for color_hex in [COLORS["gold"], COLORS["purple"], COLORS["ice_light"]]:
				_spawn_purchase_particles(victory_origin, color_hex)
		var boss := _get_current_boss()
		_unlock_codex_entry(boss)
		var gem_luck := int(data["prestige_upgrades"].get("gem_luck", 0))
		var gems := int(float(boss["reward"]) * (1.0 + gem_luck * 0.2)) + rng.randi_range(0, max(0, int(boss["level"]) * 3))
		data["gems"] = int(data["gems"]) + gems
		data["coins"] = float(data["coins"]) + float(boss["coin_reward"])
		data["total_earned"] = float(data["total_earned"]) + float(boss["coin_reward"])
		data["bosses_defeated"] = int(data["bosses_defeated"]) + 1
		data["stats"]["total_bosses"] = int(data["stats"].get("total_bosses", 0)) + 1
		_grant_boss_drop()
		var crate := _roll_boss_crate()
		if crate != "":
			data["crates"][crate] = int(data["crates"].get(crate, 0)) + 1
		data["boss_level"] = int(data["boss_level"]) + 1
		data["boss_modifiers"] = {}
		_play_sound("success")
		_show_notice(_t("Victory! +%s gems, +%s coins") % [gems, _format_num(boss["coin_reward"])])
		_maybe_trigger_rainbow_event()
	else:
		_show_notice(_t("Defeat. Upgrade and try again."))
	fight_state = {}
	_check_achievements()
	_save_game()
	_refresh_everything()


func _get_current_boss() -> Dictionary:
	return _get_boss_at_level(int(data["boss_level"]))


func _get_boss_at_level(level: int) -> Dictionary:
	var template_idx := (level - 1) % BOSS_TEMPLATES.size()
	var template: Dictionary = BOSS_TEMPLATES[template_idx]
	var tier := int((level - 1) / BOSS_TEMPLATES.size()) + 1
	var modifier := _get_or_create_boss_modifier(level)
	var mutation_key = modifier.get("mutation")
	var rarity_key := str(modifier.get("rarity", "common"))
	var mutation = BOSS_MUTATIONS.get(mutation_key) if mutation_key != null else null
	var rarity: Dictionary = BOSS_RARITIES.get(rarity_key, BOSS_RARITIES["common"])
	var strength := 14.0 + pow(level, 1.65) * pow(1.38, tier - 1)
	if level == 1:
		strength *= 0.6
	if mutation != null:
		strength *= float(mutation["hp_mult"])
	var reward := 30 + level * 25 + tier * 50
	var gem_reward := int(reward * float(rarity["reward_mult"]) * (float(mutation["gem_mult"]) if mutation != null else 1.0))
	var coin_reward := int((500 + level * 250 + reward * 12) * float(rarity["reward_mult"]) * (float(mutation["coin_mult"]) if mutation != null else 1.0))
	var name := _t(str(template["name"]))
	if tier > 1:
		name += " %s" % _roman(tier)
	if mutation != null:
		name = "%s %s" % [_t(str(mutation["name"])), name]
	return {
		"name": name,
		"base_name": _t(str(template["name"])),
		"color": mutation["color"] if mutation != null else rarity["color"],
		"rarity": rarity_key,
		"rarity_name": _t(str(rarity["name"])),
		"mutation": mutation_key,
		"damage_mult": float(mutation["damage_mult"]) if mutation != null else 1.0,
		"speed_mult": float(mutation["speed_mult"]) if mutation != null else 1.0,
		"combo_decay_mult": float(mutation["combo_decay_mult"]) if mutation != null else 1.0,
		"strength": strength,
		"reward": gem_reward,
		"coin_reward": coin_reward,
		"min_total": max(0, pow(level - 1, 2) * 2500),
		"min_click_level": 10 + (level - 1) * 3,
		"level": level,
		"tier": tier
	}


func _get_or_create_boss_modifier(level: int) -> Dictionary:
	var key := str(level)
	var mods: Dictionary = data.get("boss_modifiers", {})
	if mods.has(key) and mods[key] is Dictionary:
		var old: Dictionary = mods[key]
		if BOSS_RARITIES.has(old.get("rarity", "common")):
			return old
	var mutation = null
	if rng.randf() < 0.01:
		mutation = "elite"
	elif rng.randf() < 0.25:
		var possible := BOSS_MUTATIONS.keys()
		possible.erase("elite")
		mutation = _random_from_array(possible)
	var mod := {"mutation": mutation, "rarity": _roll_boss_rarity()}
	data["boss_modifiers"] = {}
	data["boss_modifiers"][key] = mod
	return mod


func _roll_boss_rarity() -> String:
	var rows := []
	for key in BOSS_RARITIES.keys():
		rows.append([key, float(BOSS_RARITIES[key]["weight"])])
	return _roll_weighted(rows)


func _roman(n: int) -> String:
	var vals := [[10, "X"], [9, "IX"], [5, "V"], [4, "IV"], [1, "I"]]
	var result := ""
	for row in vals:
		while n >= int(row[0]):
			result += row[1]
			n -= int(row[0])
	return result


func _unlock_codex_entry(boss: Dictionary) -> void:
	var idx := str((int(boss["level"]) - 1) % BOSS_TEMPLATES.size())
	var entry: Dictionary = data["codex"].get(idx, {})
	entry["unlocked"] = true
	entry["best_level"] = max(int(entry.get("best_level", 0)), int(boss["level"]))
	entry["name"] = BOSS_TEMPLATES[int(idx)]["name"]
	data["codex"][idx] = entry


func _grant_boss_drop() -> void:
	var drop_luck := int(data["prestige_upgrades"].get("drop_luck", 0))
	var lucky := _effect_active("lucky")
	var level := int(data["boss_level"])
	var mythic_chance := 0.001 + drop_luck * 0.00015 + (0.0005 if lucky else 0.0)
	if rng.randf() < mythic_chance:
		var mythic: Dictionary = _make_item(_random_from_array(MYTHIC_ITEMS), level)
		data["inventory"].append(mythic)
		_show_notice(_t("MYTHIC drop: %s") % _item_display_name(mythic))
		return
	var item_chance := 0.65 + drop_luck * 0.05 + (0.1 if lucky else 0.0)
	if rng.randf() < item_chance:
		var slot: String = str(_random_from_array(SLOT_KEYS))
		var items: Array = ITEM_POOLS[slot]
		var max_tier: int = min(int(level / 5) + drop_luck + (2 if lucky else 0), items.size() - 1)
		var template: Dictionary = items[rng.randi_range(0, max_tier)]
		var item: Dictionary = _make_item(template, level, slot)
		data["inventory"].append(item)
		_show_notice(_t("Drop: %s [%s]") % [_item_display_name(item), _rarity_label(str(item["rarity"]))])
	else:
		var cons := _random_consumable()
		data["consumables"].append(cons)
		_show_notice(_t("Bonus: %s") % _consumable_display_name(cons))


func _roll_boss_crate() -> String:
	if rng.randf() > 0.42:
		return ""
	return _roll_weighted(CRATE_RARITY_WEIGHTS)


func _open_crate(tier: String) -> void:
	if int(data["crates"].get(tier, 0)) <= 0:
		return
	data["crates"][tier] = int(data["crates"].get(tier, 0)) - 1
	data["stats"]["crates_opened"] = int(data["stats"].get("crates_opened", 0)) + 1
	var roll := rng.randf()
	if roll < 0.32:
		var gems: int = int({"common": 8, "rare": 20, "epic": 45, "legendary": 110}.get(tier, 8))
		data["gems"] = int(data["gems"]) + gems
		_show_notice(_t("Crate opened: +%s gems") % gems)
	elif roll < 0.58:
		var coins := int(max(1000.0, _get_cps() * 90.0, float(data["total_earned"]) * {"common": 0.01, "rare": 0.025, "epic": 0.06, "legendary": 0.14}.get(tier, 0.01)))
		data["coins"] = float(data["coins"]) + coins
		data["total_earned"] = float(data["total_earned"]) + coins
		_show_notice(_t("Crate opened: +%s coins") % _format_num(coins))
	elif roll < 0.78:
		var cons := _random_consumable()
		data["consumables"].append(cons)
		_show_notice(_t("Crate opened: %s") % _consumable_display_name(cons))
	else:
		var slot: String = str(_random_from_array(SLOT_KEYS))
		var items: Array = ITEM_POOLS[slot]
		var bonus: int = int({"common": 0, "rare": 1, "epic": 2, "legendary": 4}.get(tier, 0))
		var max_tier: int = min(items.size() - 1, int(data["boss_level"] / 4) + bonus)
		var item: Dictionary = _make_item(items[rng.randi_range(0, max_tier)], int(data["boss_level"]), slot)
		data["inventory"].append(item)
		_show_notice(_t("Crate item: %s") % _item_display_name(item))
	_play_sound("success")
	_check_achievements()
	_save_game()
	_refresh_everything()


func _make_item(template: Dictionary, level: int, forced_slot = null) -> Dictionary:
	var slot: String = _normalize_slot(str(template.get("slot", forced_slot if forced_slot != null else "Czapka")))
	var power: float = float(template["power"]) * (1.0 + level * 0.01)
	var item: Dictionary = {
		"item_id": template["id"],
		"name": template["name"],
		"slot": slot,
		"power": power,
		"base_power": power,
		"rarity": template.get("rarity", "common"),
		"boss_level": level,
		"item_level": 1,
		"item_xp": 0.0,
		"item_uid": "%s-%s-%s" % [template["id"], Time.get_ticks_msec(), rng.randi_range(1000, 9999)]
	}
	return item


func _ensure_item_fields(item: Dictionary) -> void:
	item["slot"] = _normalize_slot(str(item.get("slot", "Czapka")))
	if not item.has("item_uid"):
		item["item_uid"] = "%s-%s-%s" % [item.get("item_id", "item"), Time.get_ticks_msec(), rng.randi_range(1000, 9999)]
	if not item.has("base_power"):
		item["base_power"] = float(item.get("power", 1.0))
	if not item.has("item_level"):
		item["item_level"] = 1
	if not item.has("item_xp"):
		item["item_xp"] = 0.0
	if not item.has("name"):
		item["name"] = str(item.get("item_id", "Item"))


func _item_effective_power(item: Dictionary) -> float:
	_ensure_item_fields(item)
	return float(item.get("base_power", item.get("power", 1.0))) * (1.0 + (int(item.get("item_level", 1)) - 1) * ITEM_POWER_PER_LEVEL)


func _item_xp_needed(item: Dictionary) -> float:
	var lv := int(item.get("item_level", 1))
	var rarity_scale: float = float({"common": 1.0, "uncommon": 1.15, "rare": 1.35, "epic": 1.7, "legendary": 2.2, "mythic": 3.0}.get(item.get("rarity", "common"), 1.0))
	return 50.0 * pow(lv, 1.35) * rarity_scale


func _update_item_growth(delta: float) -> void:
	item_timer += delta
	if item_timer < 1.0:
		return
	item_timer = 0.0
	var leveled := false
	for item in data["equipped"].values():
		if item == null:
			continue
		_ensure_item_fields(item)
		if int(item["item_level"]) >= ITEM_MAX_LEVEL:
			continue
		item["item_xp"] = float(item["item_xp"]) + ITEM_XP_PER_SECOND
		while int(item["item_level"]) < ITEM_MAX_LEVEL and float(item["item_xp"]) >= _item_xp_needed(item):
			item["item_xp"] = float(item["item_xp"]) - _item_xp_needed(item)
			item["item_level"] = int(item["item_level"]) + 1
			leveled = true
	if leveled:
		_show_notice(_t("Equipped item leveled up."))
		_save_game()
		if active_panel == "inventory":
			_open_panel("inventory")


func _equip_item(uid: String) -> void:
	for i in range(data["inventory"].size()):
		var item: Dictionary = data["inventory"][i]
		if str(item.get("item_uid", "")) == uid:
			_ensure_item_fields(item)
			var slot := str(item["slot"])
			var old = data["equipped"].get(slot)
			data["equipped"][slot] = item
			data["inventory"].remove_at(i)
			if old != null:
				data["inventory"].append(old)
			_play_sound("success")
			_show_notice(_t("Equipped %s.") % _item_display_name(item))
			_check_achievements()
			_save_game()
			_refresh_everything()
			return


func _use_consumable(index: int) -> void:
	if index < 0 or index >= data["consumables"].size():
		return
	var cons: Dictionary = data["consumables"][index]
	data["consumables"].remove_at(index)
	data["stats"]["consumables_used"] = int(data["stats"].get("consumables_used", 0)) + 1
	var effect := str(cons.get("effect", ""))
	var duration := float(cons.get("duration", 0.0))
	if effect == "instant_10k":
		var bonus := 10000.0 * (1.0 + int(data["boss_level"]) * 0.1)
		data["coins"] = float(data["coins"]) + bonus
		data["total_earned"] = float(data["total_earned"]) + bonus
	elif effect == "gems_50":
		data["gems"] = int(data["gems"]) + 50
	elif effect == "kids_rush":
		data["queue_kids"] = float(data.get("queue_kids", 0.0)) + float(cons.get("amount", 70))
	elif duration > 0.0:
		data["active_effects"][effect] = _now() + duration
	_play_sound("success")
	_show_notice(_t("Used %s.") % _consumable_display_name(cons))
	_check_achievements()
	_save_game()
	_refresh_everything()


func _buy_gem_item(key: String) -> void:
	var item: Dictionary = GEM_SHOP[key]
	if int(data["gems"]) < int(item["cost"]):
		return
	data["gems"] = int(data["gems"]) - int(item["cost"])
	var effect := str(item["effect"])
	var duration := float(item.get("duration", 0.0))
	if effect == "skip_boss":
		var boss := _get_current_boss()
		var gems := int(boss["reward"] / 2)
		data["gems"] = int(data["gems"]) + gems
		data["bosses_defeated"] = int(data["bosses_defeated"]) + 1
		data["boss_level"] = int(data["boss_level"]) + 1
		data["boss_modifiers"] = {}
		_show_notice(_t("Boss skipped: +%s gems") % gems)
	elif effect == "prestige_x2":
		data["prestige_points"] = int(data["prestige_points"]) + 1
	else:
		data["active_effects"][effect] = _now() + duration
	_after_purchase(_t("%s bought.") % _t(str(item["name"])))


func _buy_gem_perk(key: String) -> void:
	var perk: Dictionary = GEM_PERKS[key]
	var lv := int(data["gem_perks"].get(key, 0))
	if lv >= int(perk["max"]):
		return
	var cost := _gem_perk_cost(key)
	if int(data["gems"]) < cost:
		return
	data["gems"] = int(data["gems"]) - cost
	data["gem_perks"][key] = lv + 1
	_after_purchase(_t("%s perk upgraded.") % _t(str(perk["name"])))


func _gem_perk_cost(key: String) -> int:
	var perk: Dictionary = GEM_PERKS[key]
	var lv := int(data["gem_perks"].get(key, 0))
	return int(int(perk["cost_base"]) * pow(1.45, lv))


func _buy_prestige_upgrade(key: String) -> void:
	var up: Dictionary = PRESTIGE_UPGRADES[key]
	var lv := int(data["prestige_upgrades"].get(key, 0))
	if lv >= int(up["max"]) or int(data["prestige_points"]) < int(up["cost"]):
		return
	data["prestige_points"] = int(data["prestige_points"]) - int(up["cost"])
	data["prestige_upgrades"][key] = lv + 1
	_after_purchase(_t("%s upgraded.") % _t(str(up["name"])))


func _do_prestige() -> void:
	if int(data["bosses_defeated"]) < PRESTIGE_BOSSES_NEEDED:
		return
	var keep := {
		"prestige_points": int(data["prestige_points"]) + 1,
		"prestige_upgrades": data["prestige_upgrades"].duplicate(true),
		"gems": int(data["gems"]) + PRESTIGE_GEMS_REWARD,
		"achievements_completed": data["achievements_completed"].duplicate(true),
		"last_daily_claim": data.get("last_daily_claim", 0.0),
		"gem_perks": data["gem_perks"].duplicate(true),
		"stats": data["stats"].duplicate(true)
	}
	data = _default_data()
	for key in keep.keys():
		data[key] = keep[key]
	data["coins"] = int(data["prestige_upgrades"].get("start_coins", 0)) * 1000.0
	_ensure_data_integrity()
	_play_sound("success")
	_show_notice(_t("Prestige complete: +1 PP and +%s gems.") % PRESTIGE_GEMS_REWARD)
	_check_achievements()
	_save_game()
	_refresh_everything()


func _do_rebirth() -> void:
	var cost := (int(data["rebirths"]) + 1) * 100000
	if float(data["coins"]) < cost:
		return
	data["coins"] = 0.0
	data["rebirths"] = int(data["rebirths"]) + 1
	data["click_level"] = 1
	data["click_cost"] = 50
	for key in data["buildings"].keys():
		data["buildings"][key]["level"] = 0
		data["buildings"][key]["cost"] = data["buildings"][key]["base_cost"]
	_play_sound("success")
	_show_notice(_t("Rebirth complete. Multiplier boosted."))
	_check_achievements()
	_save_game()
	_refresh_everything()


func _check_daily_reward() -> void:
	var now := _now()
	var last := float(data.get("last_daily_claim", 0.0))
	if last > 0.0 and now - last < DAILY_SECONDS:
		return
	data["last_daily_claim"] = now
	data["gems"] = int(data["gems"]) + DAILY_REWARD_GEMS
	data["consumables"].append(_random_consumable())
	_show_notice(_t("Daily reward: +%s gems and a consumable.") % DAILY_REWARD_GEMS)
	_save_game()


func _check_achievements() -> void:
	var done: Array = data["achievements_completed"]
	var newly := []
	for ach in ACHIEVEMENTS:
		if done.has(ach["id"]):
			continue
		if _achievement_done(ach):
			done.append(ach["id"])
			data["gems"] = int(data["gems"]) + int(ach["gems"])
			newly.append(ach["title"])
	if not newly.is_empty():
		_play_sound("success")
		var translated := []
		for title in newly:
			translated.append(_t(str(title)))
		_show_notice(_t("Achievement: %s") % ", ".join(translated))


func _achievement_done(ach: Dictionary) -> bool:
	match ach["kind"]:
		"clicks":
			return int(data["clicks"]) >= int(ach["target"])
		"bosses":
			return int(data["bosses_defeated"]) >= int(ach["target"])
		"combo":
			return int(data["stats"].get("highest_combo", 0)) >= int(ach["target"])
		"earned":
			return float(data["total_earned"]) >= float(ach["target"])
		"rebirths":
			return int(data["rebirths"]) >= int(ach["target"])
		"building_b6":
			return int(data["buildings"]["b6"].get("level", 0)) >= int(ach["target"])
		"rarity":
			return _has_rarity(str(ach["target"]))
		"codex":
			return data["codex"].size() >= int(ach["target"])
		"prestige":
			return int(data["prestige_points"]) >= int(ach["target"])
		"crates_opened":
			return int(data["stats"].get("crates_opened", 0)) >= int(ach["target"])
		"consumables_used":
			return int(data["stats"].get("consumables_used", 0)) >= int(ach["target"])
		"building_b8":
			return int(data["buildings"]["b8"].get("level", 0)) >= int(ach["target"])
		"full_set":
			return _has_full_equipment_set()
	return false


func _has_rarity(rarity: String) -> bool:
	for item in data["inventory"]:
		if item is Dictionary and item.get("rarity", "") == rarity:
			return true
	for item in data["equipped"].values():
		if item is Dictionary and item.get("rarity", "") == rarity:
			return true
	return false


func _schedule_airdrop() -> void:
	airdrop_timer = rng.randf_range(120.0, 300.0)


func _update_airdrop(delta: float) -> void:
	if airdrop_button != null and is_instance_valid(airdrop_button):
		airdrop_life -= delta
		if airdrop_life <= 0.0:
			airdrop_button.queue_free()
			airdrop_button = null
			_schedule_airdrop()
		return
	airdrop_timer -= delta
	if airdrop_timer <= 0.0:
		_spawn_airdrop()


func _spawn_airdrop() -> void:
	airdrop_button = _button(_t("Gift"), COLORS["gold"], 14)
	airdrop_button.custom_minimum_size = Vector2(74, 44)
	airdrop_button.pressed.connect(_claim_airdrop)
	if airdrop_slot != null and is_instance_valid(airdrop_slot):
		airdrop_slot.add_child(airdrop_button)
	else:
		add_child(airdrop_button)
	airdrop_life = 12.0
	_show_notice(_t("Airdrop incoming."))


func _claim_airdrop() -> void:
	if airdrop_button != null and is_instance_valid(airdrop_button):
		airdrop_button.queue_free()
	airdrop_button = null
	data["airdrop"]["claimed"] = int(data["airdrop"].get("claimed", 0)) + 1
	var roll := rng.randf()
	if roll < 0.44:
		var amount := int(max(500.0, _get_cps() * rng.randi_range(35, 75), float(data["total_earned"]) * 0.015))
		data["coins"] = float(data["coins"]) + amount
		data["total_earned"] = float(data["total_earned"]) + amount
		_show_notice(_t("Airdrop: +%s coins") % _format_num(amount))
	elif roll < 0.64:
		var gems := rng.randi_range(8, 24)
		data["gems"] = int(data["gems"]) + gems
		_show_notice(_t("Airdrop: +%s gems") % gems)
	elif roll < 0.82:
		var cons := _random_consumable()
		data["consumables"].append(cons)
		_show_notice(_t("Airdrop: %s") % _consumable_display_name(cons))
	elif roll < 0.95:
		var effects := ["coins_x2", "cps_x2", "lucky"]
		var effect: String = str(_random_from_array(effects))
		data["active_effects"][effect] = _now() + (60.0 if effect == "lucky" else 45.0)
		_show_notice(_t("Airdrop boost: %s") % _effect_label(effect))
	else:
		var slot: String = str(_random_from_array(SLOT_KEYS))
		var items: Array = ITEM_POOLS[slot]
		var item: Dictionary = _make_item(items[rng.randi_range(0, min(items.size() - 1, max(1, int(data["boss_level"] / 4))))], int(data["boss_level"]), slot)
		data["inventory"].append(item)
		_show_notice(_t("Rare airdrop: %s") % _item_display_name(item))
	_play_sound("success")
	_check_achievements()
	_save_game()
	_refresh_everything()
	_schedule_airdrop()


func _random_consumable() -> Dictionary:
	return _make_consumable(_random_from_array(CONSUMABLES.keys()))


func _make_consumable(key: String) -> Dictionary:
	var cons: Dictionary = CONSUMABLES[key].duplicate(true)
	cons["key"] = key
	return cons


func _default_data() -> Dictionary:
	var equipped := {}
	for slot in SLOT_KEYS:
		equipped[slot] = null
	var crates := {}
	for key in CRATE_DEFS.keys():
		crates[key] = 0
	return {
		"coins": 0.0,
		"gems": 0,
		"total_earned": 0.0,
		"clicks": 0,
		"click_level": 1,
		"click_cost": 50,
		"lang": "EN",
		"lang_chosen": true,
		"rebirths": 0,
		"boss_level": 1,
		"bosses_defeated": 0,
		"boss_modifiers": {},
		"prestige_points": 0,
		"prestige_upgrades": {},
		"inventory": [],
		"consumables": [],
		"equipped": equipped,
		"queue_kids": 42.0,
		"satisfaction": 90.0,
		"acquisition": ACQUISITION_DEFS.duplicate(true),
		"buildings": BUILDING_DEFS.duplicate(true),
		"active_effects": {},
		"achievements_completed": [],
		"last_daily_claim": 0.0,
		"gem_perks": {},
		"crates": crates,
		"codex": {},
		"auto_lab": {"level": 0},
		"airdrop": {"claimed": 0},
		"stats": {"total_clicks": 0, "total_bosses": 0, "highest_combo": 0, "play_time": 0.0, "crates_opened": 0, "consumables_used": 0},
		"settings": {"master_volume": 1.0, "music_volume": 1.0, "sfx_volume": 1.0},
		"godot_port_version": 1
	}


func _load_game() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		_load_from_path(SAVE_PATH)
	elif FileAccess.file_exists(LEGACY_SAVE_PATH):
		_load_from_path(LEGACY_SAVE_PATH)


func _load_from_path(path: String) -> void:
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		return
	var parsed = JSON.parse_string(file.get_as_text())
	if parsed is Dictionary:
		data = parsed


func _save_game() -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null:
		return
	file.store_string(JSON.stringify(data, "\t"))


func _ensure_data_integrity() -> void:
	var defaults := _default_data()
	_merge_missing(data, defaults)
	for key in BUILDING_DEFS.keys():
		if not data["buildings"].has(key) or not (data["buildings"][key] is Dictionary):
			data["buildings"][key] = BUILDING_DEFS[key].duplicate(true)
		else:
			_merge_missing(data["buildings"][key], BUILDING_DEFS[key])
	for key in ACQUISITION_DEFS.keys():
		if not data["acquisition"].has(key) or not (data["acquisition"][key] is Dictionary):
			data["acquisition"][key] = ACQUISITION_DEFS[key].duplicate(true)
		else:
			_merge_missing(data["acquisition"][key], ACQUISITION_DEFS[key])
	var new_equipped := {}
	for slot in SLOT_KEYS:
		new_equipped[slot] = null
	for key in data["equipped"].keys():
		var norm := _normalize_slot(str(key))
		var item = data["equipped"][key]
		if item is Dictionary:
			item["slot"] = norm
			_ensure_item_fields(item)
			new_equipped[norm] = item
	data["equipped"] = new_equipped
	for item in data["inventory"]:
		if item is Dictionary:
			_ensure_item_fields(item)
	for key in CRATE_DEFS.keys():
		if not data["crates"].has(key):
			data["crates"][key] = 0
	data["active_effects"] = data.get("active_effects", {})
	data["achievements_completed"] = data.get("achievements_completed", [])
	if not LANGUAGE_OPTIONS.has(str(data.get("lang", "EN")).to_upper()):
		data["lang"] = "EN"
	else:
		data["lang"] = str(data.get("lang", "EN")).to_upper()
	data["godot_port_version"] = 1


func _merge_missing(target: Dictionary, defaults: Dictionary) -> void:
	for key in defaults.keys():
		if not target.has(key):
			target[key] = defaults[key].duplicate(true) if defaults[key] is Dictionary or defaults[key] is Array else defaults[key]
		elif target[key] is Dictionary and defaults[key] is Dictionary:
			_merge_missing(target[key], defaults[key])


func _normalize_slot(slot: String) -> String:
	return SLOT_ALIASES.get(slot, slot if SLOT_KEYS.has(slot) else "Czapka")


func _shop_card(title: String, meta: String, button_text: String, accent: String, enabled: bool, action, icon_path: String = "") -> Control:
	var card := _panel(COLORS["card"], accent, 8)
	card.custom_minimum_size = Vector2(0, 88)
	var m := _margin(8)
	card.add_child(m)
	var col := VBoxContainer.new()
	col.add_theme_constant_override("separation", 6)
	m.add_child(col)
	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 8)
	col.add_child(row)
	if icon_path != "" and ResourceLoader.exists(icon_path):
		var icon := TextureRect.new()
		icon.texture = load(icon_path)
		icon.custom_minimum_size = Vector2(40, 40)
		icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		row.add_child(icon)
	var title_label := _label(title, 14, COLORS["text"], true)
	title_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	title_label.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
	title_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	row.add_child(title_label)
	var btn_text := _t("MAX") if button_text == _t("MAX") else "%s %s" % [_t("BUY"), button_text]
	var btn := _button(btn_text, accent, 13)
	btn.custom_minimum_size = Vector2(132, 40)
	btn.size_flags_horizontal = Control.SIZE_SHRINK_END
	btn.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	btn.disabled = not enabled
	if action != null:
		btn.pressed.connect(func() -> void:
			_spawn_purchase_particles(btn.get_global_rect().get_center(), accent)
			action.call()
		)
	row.add_child(btn)
	if meta != "":
		var meta_label := _label(meta, 12, accent, true)
		meta_label.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
		col.add_child(meta_label)
	return card


func _action_card(title: String, detail: String, button_text: String, accent: String, enabled: bool, action) -> Control:
	var card := _panel(COLORS["card"], accent, 8)
	var m := _margin(10)
	card.add_child(m)
	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 10)
	m.add_child(row)
	var texts := VBoxContainer.new()
	texts.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	row.add_child(texts)
	texts.add_child(_label(title, 15, COLORS["text"], true))
	var detail_label := _label(detail, 12, COLORS["muted"], false)
	detail_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	texts.add_child(detail_label)
	var btn := _button(button_text, accent, 13)
	btn.custom_minimum_size = Vector2(110, 40)
	btn.disabled = not enabled
	if action != null:
		btn.pressed.connect(func() -> void:
			_spawn_purchase_particles(btn.get_global_rect().get_center(), accent)
			action.call()
		)
	row.add_child(btn)
	return card


func _info_card(title: String, detail: String, accent: String) -> Control:
	var card := _panel(COLORS["card"], accent, 8)
	var m := _margin(10)
	card.add_child(m)
	var v := VBoxContainer.new()
	v.add_theme_constant_override("separation", 4)
	m.add_child(v)
	v.add_child(_label(title, 15, COLORS["text"], true))
	var detail_label := _label(detail, 12, COLORS["muted"], false)
	detail_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	v.add_child(detail_label)
	return card


func _section_label(text: String) -> Label:
	var label := _label(text, 13, COLORS["ice_light"], true)
	label.custom_minimum_size = Vector2(0, 28)
	label.vertical_alignment = VERTICAL_ALIGNMENT_BOTTOM
	return label


func _label(text: String, size_px: int, color_hex: String, bold: bool) -> Label:
	var label := Label.new()
	label.text = text
	label.add_theme_font_size_override("font_size", size_px)
	label.add_theme_color_override("font_color", _color(color_hex))
	if bold:
		label.add_theme_color_override("font_shadow_color", Color(0, 0, 0, 0.35))
		label.add_theme_constant_override("shadow_offset_x", 1)
		label.add_theme_constant_override("shadow_offset_y", 1)
		label.add_theme_color_override("font_outline_color", Color(0, 0, 0, 0.55))
		label.add_theme_constant_override("outline_size", 1)
	return label


func _button(text: String, color_hex: String, size_px: int) -> Button:
	var btn := Button.new()
	btn.text = text
	btn.add_theme_font_size_override("font_size", size_px)
	btn.focus_mode = Control.FOCUS_NONE
	btn.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	_style_button(btn, color_hex, COLORS["card_hover"], color_hex)
	return btn


func _make_texture_click_mask(texture: Texture2D) -> BitMap:
	var image := texture.get_image() if texture != null else null
	var click_mask := BitMap.new()
	if image != null:
		click_mask.create_from_image_alpha(image, 0.1)
	return click_mask


func _style_button(btn: Button, color_hex: String, hover_hex: String, border_hex: String) -> void:
	btn.add_theme_stylebox_override("normal", _style(color_hex, border_hex, 7))
	btn.add_theme_stylebox_override("hover", _style(hover_hex, border_hex, 7))
	btn.add_theme_stylebox_override("pressed", _style(COLORS["ice"], border_hex, 7))
	btn.add_theme_stylebox_override("disabled", _style("#1a2233", COLORS["border"], 7))
	btn.add_theme_color_override("font_color", _color(COLORS["text"]))
	btn.add_theme_color_override("font_disabled_color", _color(COLORS["muted"]))


func _panel(bg_hex: String, border_hex: String, radius: int) -> PanelContainer:
	var panel := PanelContainer.new()
	panel.add_theme_stylebox_override("panel", _style(bg_hex, border_hex, radius))
	return panel


func _style(bg_hex: String, border_hex: String, radius: int) -> StyleBoxFlat:
	var sb := StyleBoxFlat.new()
	sb.bg_color = _color(bg_hex)
	sb.border_color = _color(border_hex)
	sb.set_border_width_all(2)
	sb.set_corner_radius_all(radius)
	sb.content_margin_left = 6
	sb.content_margin_right = 6
	sb.content_margin_top = 6
	sb.content_margin_bottom = 6
	return sb


func _margin(amount: int) -> MarginContainer:
	var m := MarginContainer.new()
	m.add_theme_constant_override("margin_left", amount)
	m.add_theme_constant_override("margin_right", amount)
	m.add_theme_constant_override("margin_top", amount)
	m.add_theme_constant_override("margin_bottom", amount)
	return m


func _clear(node: Node) -> void:
	for child in node.get_children():
		node.remove_child(child)
		child.queue_free()


func _color(hex: String) -> Color:
	return Color.html(hex)


func _current_lang() -> String:
	var lang := str(data.get("lang", "EN")).to_upper()
	return lang if LANGUAGE_OPTIONS.has(lang) else "EN"


func _t(text: String) -> String:
	var lang := _current_lang()
	if TRANSLATIONS.has(lang):
		return str(TRANSLATIONS[lang].get(text, text))
	return text


func _set_language(lang: String) -> void:
	lang = lang.to_upper()
	if not LANGUAGE_OPTIONS.has(lang) or lang == _current_lang():
		return
	data["lang"] = lang
	_save_game()
	_rebuild_ui()
	_show_notice(_t("Language changed to %s.") % _t(str(LANGUAGE_OPTIONS[lang])))


func _rebuild_ui() -> void:
	for node_name in ["Background", "Root", "FxOverlay"]:
		var node := get_node_or_null(node_name)
		if node != null:
			remove_child(node)
			node.queue_free()
	nav_buttons.clear()
	_build_ui()
	_refresh_everything()


func _slot_label(slot: String) -> String:
	return _t(str(SLOT_LABELS.get(slot, slot)))


func _item_display_name(item: Dictionary) -> String:
	return _t(str(item.get("name", item.get("item_id", "Item"))))


func _consumable_display_name(cons: Dictionary) -> String:
	return _t(str(cons.get("name", "Consumable")))


func _rarity_label(rarity: String) -> String:
	return _t(rarity)


func _effect_label(effect: String) -> String:
	return _t(str(EFFECT_LABELS.get(effect, effect)))


func _ability_list_text(abilities: Array) -> String:
	var labels := []
	for ability in abilities:
		labels.append(_t(str(ABILITY_LABELS.get(str(ability), str(ability)))))
	return ", ".join(labels)


func _float_text(text: String, color_hex: String) -> void:
	if click_fx_layer == null or not is_instance_valid(click_fx_layer):
		return
	var label := _label(text, 22, color_hex, true)
	label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.pivot_offset = Vector2(0, 0)
	click_fx_layer.add_child(label)
	var origin := Vector2(
		click_fx_layer.size.x * 0.58 + rng.randf_range(-28.0, 28.0),
		click_fx_layer.size.y * 0.52 + rng.randf_range(-14.0, 14.0)
	)
	label.position = origin
	label.modulate = Color(1, 1, 1, 1)
	var tween := create_tween()
	tween.set_parallel(true)
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(label, "position", origin + Vector2(rng.randf_range(-18.0, 18.0), -72.0), 0.55)
	tween.tween_property(label, "modulate:a", 0.0, 0.55)
	tween.tween_property(label, "scale", Vector2(1.12, 1.12), 0.16)
	tween.chain().tween_callback(label.queue_free)


func _maybe_trigger_rainbow_event() -> void:
	if rng.randf() > RAINBOW_EVENT_CHANCE:
		return
	_start_rainbow_event()


func _start_rainbow_event() -> void:
	rainbow_timer = RAINBOW_EVENT_DURATION
	rainbow_spawn_timer = 0.0
	var existing := float(data["active_effects"].get("coins_x2", 0.0))
	data["active_effects"]["coins_x2"] = max(existing, _now() + RAINBOW_EVENT_DURATION)
	_play_sound("success")
	_show_notice(_t("RAINBOW RUSH! Coins x2 for %ss!") % int(RAINBOW_EVENT_DURATION))
	if attack_button != null and is_instance_valid(attack_button):
		var origin := attack_button.get_global_rect().get_center()
		for color_hex in RAINBOW_COLORS:
			_spawn_purchase_particles(origin, color_hex)


func _update_rainbow_visuals(delta: float) -> void:
	if rainbow_banner != null and is_instance_valid(rainbow_banner):
		rainbow_banner.visible = true
		var hue := fmod(_now() * 0.6, 1.0)
		rainbow_banner.add_theme_color_override("font_color", Color.from_hsv(hue, 0.85, 1.0))
	rainbow_spawn_timer -= delta
	if rainbow_spawn_timer <= 0.0:
		rainbow_spawn_timer = 0.12
		_spawn_rainbow_sparkle()


func _spawn_rainbow_sparkle() -> void:
	if fx_overlay == null or not is_instance_valid(fx_overlay):
		return
	var viewport_size := get_viewport_rect().size
	var origin := Vector2(rng.randf_range(0.0, viewport_size.x), rng.randf_range(0.0, viewport_size.y * 0.7))
	var color_hex: String = RAINBOW_COLORS[rng.randi_range(0, RAINBOW_COLORS.size() - 1)]
	_spawn_purchase_particles(origin, color_hex)


func _end_rainbow_event() -> void:
	rainbow_timer = 0.0
	if rainbow_banner != null and is_instance_valid(rainbow_banner):
		rainbow_banner.visible = false
	_show_notice(_t("Rainbow Rush faded."))


func _spawn_purchase_particles(origin: Vector2, accent_hex: String) -> void:
	if fx_overlay == null or not is_instance_valid(fx_overlay):
		return
	var palette := [accent_hex, COLORS["gold"], COLORS["ice_light"], COLORS["text"]]
	var count := 14
	for i in range(count):
		var size := rng.randf_range(5.0, 11.0)
		var particle := Panel.new()
		particle.size = Vector2(size, size)
		particle.mouse_filter = Control.MOUSE_FILTER_IGNORE
		var sb := StyleBoxFlat.new()
		sb.bg_color = _color(str(palette[rng.randi_range(0, palette.size() - 1)]))
		sb.set_corner_radius_all(int(size))
		sb.set_border_width_all(0)
		sb.content_margin_left = 0
		sb.content_margin_right = 0
		sb.content_margin_top = 0
		sb.content_margin_bottom = 0
		particle.add_theme_stylebox_override("panel", sb)
		particle.pivot_offset = Vector2(size, size) * 0.5
		particle.position = origin - particle.pivot_offset
		particle.modulate = Color(1, 1, 1, 1)
		fx_overlay.add_child(particle)

		var angle := rng.randf_range(0.0, TAU)
		var distance := rng.randf_range(46.0, 118.0)
		var target := particle.position + Vector2(cos(angle), sin(angle)) * distance
		var duration := rng.randf_range(0.45, 0.8)

		var tween := create_tween()
		tween.set_parallel(true)
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(particle, "position", target, duration)
		tween.tween_property(particle, "modulate:a", 0.0, duration)
		tween.tween_property(particle, "rotation", rng.randf_range(-PI, PI), duration)
		tween.tween_property(particle, "scale", Vector2(0.4, 0.4), duration)
		tween.chain().tween_callback(particle.queue_free)


func _show_notice(text: String) -> void:
	if notice_label != null and is_instance_valid(notice_label):
		notice_label.text = text
		notice_label.add_theme_color_override("font_color", _color(COLORS["ice_light"]))


func _format_num(value) -> String:
	var n := float(value)
	if n >= 1000000000000.0:
		return "%.1fT" % (n / 1000000000000.0)
	if n >= 1000000000.0:
		return "%.1fB" % (n / 1000000000.0)
	if n >= 1000000.0:
		return "%.1fM" % (n / 1000000.0)
	if n >= 1000.0:
		return "%.1fK" % (n / 1000.0)
	return str(int(n))


func _roll_weighted(rows: Array) -> String:
	var total := 0.0
	for row in rows:
		total += float(row[1])
	var roll := rng.randf_range(0.0, total)
	var acc := 0.0
	for row in rows:
		acc += float(row[1])
		if roll <= acc:
			return str(row[0])
	return str(rows[0][0])


func _random_from_array(arr: Array):
	return arr[rng.randi_range(0, arr.size() - 1)]


func _now() -> float:
	return Time.get_unix_time_from_system()


func _toggle_fullscreen() -> void:
	_set_fullscreen(not _is_fullscreen())
	_show_notice(_t("Fullscreen on.") if _is_fullscreen() else _t("Windowed mode."))


func _set_fullscreen(enabled: bool) -> void:
	if DisplayServer.get_name().to_lower() == "headless":
		return
	var mode := DisplayServer.WINDOW_MODE_FULLSCREEN if enabled else DisplayServer.WINDOW_MODE_WINDOWED
	DisplayServer.window_set_mode(mode)


func _is_fullscreen() -> bool:
	if DisplayServer.get_name().to_lower() == "headless":
		return false
	var mode := DisplayServer.window_get_mode()
	return mode == DisplayServer.WINDOW_MODE_FULLSCREEN or mode == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN
