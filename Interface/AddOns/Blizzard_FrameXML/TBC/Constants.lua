-- BIG PROBLEM HERE. NOT SAVING REFS
--
-- New constants should be added to this file and other constants
-- deprecated and moved to this file.
--

--
-- Expansion Info
--
MAX_PLAYER_LEVEL_TABLE = {};
MAX_PLAYER_LEVEL_TABLE[LE_EXPANSION_CLASSIC] = 60;
MAX_PLAYER_LEVEL_TABLE[LE_EXPANSION_BURNING_CRUSADE] = 70;
--MAX_PLAYER_LEVEL_TABLE[LE_EXPANSION_WRATH_OF_THE_LICH_KING] = 80;
--MAX_PLAYER_LEVEL_TABLE[LE_EXPANSION_CATACLYSM] = 85;
--MAX_PLAYER_LEVEL_TABLE[LE_EXPANSION_MISTS_OF_PANDARIA] = 90;
--MAX_PLAYER_LEVEL_TABLE[LE_EXPANSION_WARLORDS_OF_DRAENOR] = 100;
--MAX_PLAYER_LEVEL_TABLE[LE_EXPANSION_LEGION] = 110;
--MAX_PLAYER_LEVEL_TABLE[LE_EXPANSION_BATTLE_FOR_AZEROTH] = 120;
--MAX_PLAYER_LEVEL_TABLE[LE_EXPANSION_9_0] = 120;
--MAX_PLAYER_LEVEL_TABLE[LE_EXPANSION_10_0] = 120;
--MAX_PLAYER_LEVEL_TABLE[LE_EXPANSION_11_0] = 120;

NPE_TUTORIAL_COMPLETE_LEVEL = 10;


FACTION_BAR_COLORS = 
{
	FACTION_RED_COLOR,
	FACTION_RED_COLOR,
	FACTION_ORANGE_COLOR,
	FACTION_YELLOW_COLOR,
	FACTION_GREEN_COLOR,
	FACTION_GREEN_COLOR,
	FACTION_GREEN_COLOR,
	FACTION_GREEN_COLOR,
};



MATERIAL_TEXT_COLOR_TABLE = 
{
	["Default"] = DEFAULT_MATERIAL_TEXT_COLOR,
	["Stone"] = STONE_MATERIAL_TEXT_COLOR,
	["Parchment"] = PARCHMENT_MATERIAL_TEXT_COLOR,
	["Marble"] = MARBLE_MATERIAL_TEXT_COLOR,
	["Silver"] = SILVER_MATERIAL_TEXT_COLOR,
	["Bronze"] = BRONZE_MATERIAL_TEXT_COLOR,
	["ParchmentLarge"] = PARCHMENTLARGE_MATERIAL_TEXT_COLOR,
};

MATERIAL_TITLETEXT_COLOR_TABLE = 
{
	["Default"] = DEFAULT_MATERIAL_TITLETEXT_COLOR,
	["Stone"] = STONE_MATERIAL_TITLETEXT_COLOR,
	["Parchment"] = PARCHMENT_MATERIAL_TITLETEXT_COLOR,
	["Marble"] = MARBLE_MATERIAL_TITLETEXT_COLOR,
	["Silver"] = SILVER_MATERIAL_TITLETEXT_COLOR,
	["Bronze"] = BRONZE_MATERIAL_TITLETEXT_COLOR,
	["ParchmentLarge"] = PARCHMENTLARGE_MATERIAL_TITLETEXT_COLOR,
};


--
-- Class
--
CLASS_SORT_ORDER = {
	"WARRIOR",
	--"DEATHKNIGHT",
	"PALADIN",
	--"MONK",
	"PRIEST",
	"SHAMAN",
	"DRUID",
	"ROGUE",
	"MAGE",
	"WARLOCK",
	"HUNTER",
	--"DEMONHUNTER",
};
MAX_CLASSES = #CLASS_SORT_ORDER;

LOCALIZED_CLASS_NAMES_MALE = {};
LOCALIZED_CLASS_NAMES_FEMALE = {};
FillLocalizedClassList(LOCALIZED_CLASS_NAMES_MALE, false);
FillLocalizedClassList(LOCALIZED_CLASS_NAMES_FEMALE, true);





--
-- Inventory
--


BAG_ITEM_QUALITY_COLORS = 
{
	[LE_ITEM_QUALITY_COMMON] = COMMON_GRAY_COLOR,
	[LE_ITEM_QUALITY_UNCOMMON] = UNCOMMON_GREEN_COLOR,
	[LE_ITEM_QUALITY_RARE] = RARE_BLUE_COLOR,
	[LE_ITEM_QUALITY_EPIC] = EPIC_PURPLE_COLOR,
	[LE_ITEM_QUALITY_LEGENDARY] = LEGENDARY_ORANGE_COLOR,
	[LE_ITEM_QUALITY_ARTIFACT] = ARTIFACT_GOLD_COLOR,
	[LE_ITEM_QUALITY_HEIRLOOM] = HEIRLOOM_BLUE_COLOR,
	[LE_ITEM_QUALITY_WOW_TOKEN] = ITEM_WOW_TOKEN_COLOR,
};



-- faction
PLAYER_FACTION_COLORS = 
{ 
	[0] = PLAYER_FACTION_COLOR_HORDE, 
	[1] = PLAYER_FACTION_COLOR_ALLIANCE,
};

-- Guild
MAX_GUILDBANK_TABS = 6;
MAX_BUY_GUILDBANK_TABS = 6;
MAX_GOLD_WITHDRAW = 1000;
MAX_GOLD_WITHDRAW_DIGITS = 9;


-- Quest

MAX_QUESTS = 25;
MAX_OBJECTIVES = 20;
MAX_QUESTLOG_QUESTS = 25;
MAX_WATCHABLE_QUESTS = 5;

WOW_PROJECT_MAINLINE = 1;
WOW_PROJECT_CLASSIC = 2;
WOW_PROJECT_BURNING_CRUSADE_CLASSIC = 5;
WOW_PROJECT_WRATH_CLASSIC = 11;
WOW_PROJECT_CATACLYSM_CLASSIC = 14;
WOW_PROJECT_ID = WOW_PROJECT_BURNING_CRUSADE_CLASSIC;