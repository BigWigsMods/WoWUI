function SafeGetExpansionData(dataTable, expansionLevel)
	local entry = dataTable[expansionLevel];
	if not entry and expansionLevel > 1 then
		return SafeGetExpansionData(dataTable, expansionLevel - 1);
	end

	return entry;
end

--Login Screen Ambience
EXPANSION_GLUE_AMBIENCE = {
	[LE_EXPANSION_BURNING_CRUSADE]			= SOUNDKIT.GLUESCREEN_INTRO,
	[LE_EXPANSION_WRATH_OF_THE_LICH_KING]	= SOUNDKIT.GLUESCREEN_INTRO,
	[LE_EXPANSION_CATACLYSM]				= SOUNDKIT.GLUESCREEN_INTRO,
	[LE_EXPANSION_MISTS_OF_PANDARIA]		= SOUNDKIT.GLUESCREEN_INTRO,
	[LE_EXPANSION_WARLORDS_OF_DRAENOR]		= SOUNDKIT.AMB_GLUESCREEN_WARLORDS_OF_DRAENOR,
	[LE_EXPANSION_LEGION]					= SOUNDKIT.AMB_GLUESCREEN_LEGION,
	[LE_EXPANSION_BATTLE_FOR_AZEROTH]		= SOUNDKIT.AMB_GLUESCREEN_BATTLE_FOR_AZEROTH,
	[LE_EXPANSION_SHADOWLANDS]				= SOUNDKIT.AMB_GLUESCREEN_SHADOWLANDS,
	[LE_EXPANSION_DRAGONFLIGHT]				= SOUNDKIT.AMB_GLUESCREEN_DRAGONFLIGHT,
	[LE_EXPANSION_WAR_WITHIN]				= SOUNDKIT.AMB_GLUESCREEN_WAR_WITHIN,
};

--Music
EXPANSION_GLUE_MUSIC = {
	[LE_EXPANSION_BURNING_CRUSADE]			= SOUNDKIT.MUS_1_0_MAINTITLE_ORIGINAL,
	[LE_EXPANSION_WRATH_OF_THE_LICH_KING]	= SOUNDKIT.GS_LICH_KING,
	[LE_EXPANSION_CATACLYSM]				= SOUNDKIT.GS_CATACLYSM,
	[LE_EXPANSION_MISTS_OF_PANDARIA]		= SOUNDKIT.MUS_50_HEART_OF_PANDARIA_MAINTITLE,
	[LE_EXPANSION_WARLORDS_OF_DRAENOR]		= SOUNDKIT.MUS_60_MAIN_TITLE,
	[LE_EXPANSION_LEGION]					= SOUNDKIT.MUS_70_MAIN_TITLE,
	[LE_EXPANSION_BATTLE_FOR_AZEROTH]		= SOUNDKIT.MUS_80_MAIN_TITLE,
	[LE_EXPANSION_SHADOWLANDS]				= SOUNDKIT.MUS_90_MAIN_TITLE,
	[LE_EXPANSION_DRAGONFLIGHT]				= SOUNDKIT.MUS_100_MAIN_TITLE,
	[LE_EXPANSION_WAR_WITHIN]				= SOUNDKIT.MUS_110_MAIN_TITLE,
};

GLUE_AMBIENCE_TRACKS = {
	["HUMAN"]					= SOUNDKIT.AMB_GLUESCREEN_HUMAN,
	["ORC"]						= SOUNDKIT.AMB_GLUESCREEN_ORC,
	["TROLL"]					= SOUNDKIT.AMB_GLUESCREEN_TROLL,
	["DWARF"]					= SOUNDKIT.AMB_GLUESCREEN_DWARF,
	["GNOME"]					= SOUNDKIT.AMB_GLUESCREEN_GNOME,
	["TAUREN"]					= SOUNDKIT.AMB_GLUESCREEN_TAUREN,
	["SCOURGE"]					= SOUNDKIT.AMB_GLUESCREEN_UNDEAD,
	["NIGHTELF"]				= SOUNDKIT.AMB_GLUESCREEN_NIGHTELF,
	["DRAENEI"]					= SOUNDKIT.AMB_GLUESCREEN_DRAENEI,
	["BLOODELF"]				= SOUNDKIT.AMB_GLUESCREEN_BLOODELF,
	["GOBLIN"]					= SOUNDKIT.AMB_GLUESCREEN_GOBLIN,
	["WORGEN"]					= SOUNDKIT.AMB_GLUESCREEN_WORGEN,
	["VOIDELF"]					= SOUNDKIT.AMB_GLUESCREEN_VOIDELF,
	["LIGHTFORGEDDRAENEI"]		= SOUNDKIT.AMB_GLUESCREEN_LIGHTFORGEDDRAENEI,
	["NIGHTBORNE"]				= SOUNDKIT.AMB_GLUESCREEN_NIGHTBORNE,
	["HIGHMOUNTAINTAUREN"]		= SOUNDKIT.AMB_GLUESCREEN_HIGHMOUNTAINTAUREN,
	["DEATHKNIGHT"]				= SOUNDKIT.AMB_GLUESCREEN_DEATHKNIGHT,
	["CHARACTERSELECT"]			= SOUNDKIT.GLUESCREEN_INTRO,
	["PANDAREN"]				= SOUNDKIT.AMB_GLUESCREEN_PANDAREN,
	["HORDE"]					= SOUNDKIT.AMB_50_GLUESCREEN_HORDE,
	["ALLIANCE"]				= SOUNDKIT.AMB_50_GLUESCREEN_ALLIANCE,
	["NEUTRAL"]					= SOUNDKIT.AMB_50_GLUESCREEN_PANDAREN_NEUTRAL,
	["PANDARENCHARACTERSELECT"]	= SOUNDKIT.AMB_50_GLUESCREEN_PANDAREN_NEUTRAL,
	["DEMONHUNTER"]				= SOUNDKIT.AMB_GLUESCREEN_DEMONHUNTER,
	["DARKIRONDWARF"] 			= SOUNDKIT.AMB_GLUESCREEN_DARKIRONDWARF,
	["MAGHARORC"] 				= SOUNDKIT.AMB_GLUESCREEN_MAGHARORC,
	["ZANDALARITROLL"] 			= SOUNDKIT.AMB_GLUESCREEN_AR_ZANDALARITROLL,
	["KULTIRAN"] 				= SOUNDKIT.AMB_GLUESCREEN_AR_KULTIRAN,
	["MECHAGNOME"] 				= SOUNDKIT.AMB_GLUESCREEN_AR_MECHAGNOME,
	["VULPERA"] 				= SOUNDKIT.AMB_GLUESCREEN_AR_VULPERA,
	["DRACTHYR"] 				= SOUNDKIT.AMB_GLUESCREEN_DRACTHYR,
	["EARTHENDWARF"] 			= SOUNDKIT.AMB_GLUESCREEN_EARTHENDWARF,
	["WARBANDS_MAPSCENE"] 		= SOUNDKIT.AMB_GLUESCREEN_WARBANDS_SCENE,
};

CHAR_MODEL_FOG_INFO = {
	["SCOURGE"] = { r=0, g=0.22, b=0.22, far=18 };
	--[[
	["HUMAN"] = { r=0.8, g=0.65, b=0.73, far=222 };
	["ORC"] = { r=0.5, g=0.5, b=0.5, far=270 };
	["DWARF"] = { r=0.85, g=0.88, b=1.0, far=500 };
	["NIGHTELF"] = { r=0.25, g=0.22, b=0.55, far=611 };
	["TAUREN"] = { r=1.0, g=0.61, b=0.42, far=153 };
	["CHARACTERSELECT"] = { r=0.8, g=0.65, b=0.73, far=222 };
	]]
};

CHAR_MODEL_GLOW_INFO = {
	--[[
	["WORGEN"] = 0.0;
	["GOBLIN"] = 0.0;
	["HUMAN"] = 0.15;
	["DWARF"] = 0.15;
	["CHARACTERSELECT"] = 0.3;
	]]
};

--Credits titles
CREDITS_TITLES = {
	[LE_EXPANSION_CLASSIC] = CREDITS_WOW_CLASSIC,
	[LE_EXPANSION_BURNING_CRUSADE] = CREDITS_WOW_BC,
	[LE_EXPANSION_WRATH_OF_THE_LICH_KING] = CREDITS_WOW_LK,
	[LE_EXPANSION_CATACLYSM] = CREDITS_WOW_CC,
	[LE_EXPANSION_MISTS_OF_PANDARIA] = CREDITS_WOW_MOP,
	[LE_EXPANSION_WARLORDS_OF_DRAENOR] = CREDITS_WOW_WOD,
	[LE_EXPANSION_LEGION] = CREDITS_WOW_LEGION,
	[LE_EXPANSION_BATTLE_FOR_AZEROTH] = CREDITS_WOW_8_0,
};

--Tooltip
GLUE_BACKDROP_COLOR = CreateColor(0.09, 0.09, 0.09);
GLUE_BACKDROP_BORDER_COLOR = CreateColor(0.8, 0.8, 0.8);

--Credits
CREDITS_SCROLL_RATE_REWIND = -160;
CREDITS_SCROLL_RATE_PAUSE = 0;
CREDITS_SCROLL_RATE_PLAY = 40;
CREDITS_SCROLL_RATE_FASTFORWARD = 160;

CREDITS_SCROLL_RATE = 40;
CREDITS_FADE_RATE = 0.4;

NUM_CREDITS_ART_TEXTURES_WIDE = 4;
NUM_CREDITS_ART_TEXTURES_HIGH = 2;
CACHE_WAIT_TIME = 0.5;

GLUE_CREDITS_SOUND_KITS = {
	[LE_EXPANSION_CLASSIC]					= SOUNDKIT.MENU_CREDITS01,
	[LE_EXPANSION_BURNING_CRUSADE]			= SOUNDKIT.MENU_CREDITS02,
	[LE_EXPANSION_WRATH_OF_THE_LICH_KING]	= SOUNDKIT.MENU_CREDITS03,
	[LE_EXPANSION_CATACLYSM]				= SOUNDKIT.MENU_CREDITS04,
	[LE_EXPANSION_MISTS_OF_PANDARIA]		= SOUNDKIT.MENU_CREDITS05,
	[LE_EXPANSION_WARLORDS_OF_DRAENOR]		= SOUNDKIT.MENU_CREDITS06,
	[LE_EXPANSION_LEGION]					= SOUNDKIT.MENU_CREDITS07,
	[LE_EXPANSION_BATTLE_FOR_AZEROTH] 		= SOUNDKIT.MENU_CREDITS08,
	[LE_EXPANSION_SHADOWLANDS] 				= SOUNDKIT.MENU_CREDITS09,
	[LE_EXPANSION_DRAGONFLIGHT]				= SOUNDKIT.MENU_CREDITS10,
};

AUTO_LOGIN_WAIT_TIME = 1.75;

HTML_START = "<html><body><p>";
HTML_START_CENTERED = "<html><body><p align=\"center\">";
HTML_END = "</p></body></html>";