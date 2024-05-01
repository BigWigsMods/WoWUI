--Center Menu Frames
UIPanelWindows["GameMenuFrame"] =				{ area = "center",		pushable = 0,	whileDead = 1 };
UIPanelWindows["VideoOptionsFrame"] =			{ area = "center",		pushable = 0,	whileDead = 1 };
UIPanelWindows["AudioOptionsFrame"] =			{ area = "center",		pushable = 0,	whileDead = 1 };
UIPanelWindows["InterfaceOptionsFrame"] =		{ area = "center",		pushable = 0,	whileDead = 1 };
UIPanelWindows["HelpFrame"] =					{ area = "center",		pushable = 0,	whileDead = 1 };

-- Frames using the new Templates
UIPanelWindows["PVPUIFrame"] =					{ area = "left",			pushable = 0,	whileDead = 1, width = 563};
UIPanelWindows["PVPBannerFrame"] =				{ area = "left",			pushable = 1};
UIPanelWindows["PetStableFrame"] =				{ area = "left",			pushable = 0};
UIPanelWindows["PVEFrame"] =					{ area = "left",			pushable = 1, 	whileDead = 1 };
UIPanelWindows["EncounterJournal"] =			{ area = "left",			pushable = 0, 	whileDead = 1, width = 830};
UIPanelWindows["CollectionsJournal"] =			{ area = "left",			pushable = 0, 	whileDead = 1, width = 733};
UIPanelWindows["TradeFrame"] =					{ area = "left",			pushable = 1};
UIPanelWindows["LootFrame"] =					{ area = "left",			pushable = 7};
UIPanelWindows["MerchantFrame"] =				{ area = "left",			pushable = 0};
UIPanelWindows["TabardFrame"] =					{ area = "left",			pushable = 0};
UIPanelWindows["PVPBannerFrame"] =				{ area = "left",			pushable = 1};
UIPanelWindows["MailFrame"] =					{ area = "left",			pushable = 0};
UIPanelWindows["QuestLogPopupDetailFrame"] =	{ area = "left",			pushable = 0,	whileDead = 1 };
UIPanelWindows["DressUpFrame"] =				{ area = "left",			pushable = 2};
UIPanelWindows["PetitionFrame"] =				{ area = "left",			pushable = 0};
UIPanelWindows["ItemTextFrame"] =				{ area = "left",			pushable = 0};
UIPanelWindows["FriendsFrame"] =				{ area = "left",			pushable = 0,	whileDead = 1 };
UIPanelWindows["RaidParentFrame"] =				{ area = "left",			pushable = 1,	whileDead = 1 };
UIPanelWindows["RaidBrowserFrame"] =			{ area = "left",			pushable = 1,	};
UIPanelWindows["DeathRecapFrame"] =				{ area = "center",			pushable = 0,	whileDead = 1, allowOtherPanels = 1};
UIPanelWindows["WardrobeFrame"] =				{ area = "left",			pushable = 0,	width = 965 };
UIPanelWindows["AlliedRacesFrame"] =			{ area = "left",			pushable = 1,	whileDead = 1 };
UIPanelWindows["GuildControlUI"] =				{ area = "left",			pushable = 1,	whileDead = 1,		yoffset = 4, };
UIPanelWindows["CommunitiesFrame"] =			{ area = "left",			pushable = 1,	whileDead = 1 };
UIPanelWindows["CommunitiesGuildLogFrame"] =	{ area = "left",			pushable = 1,	whileDead = 1, 		yoffset = 4, };
UIPanelWindows["CommunitiesGuildTextEditFrame"] = 			{ area = "left",			pushable = 1,	whileDead = 1 };
UIPanelWindows["CommunitiesGuildRecruitmentFrame"] =		{ area = "left",			pushable = 1,	whileDead = 1 };
UIPanelWindows["CommunitiesGuildNewsFiltersFrame"] =		{ area = "left",			pushable = 1,	whileDead = 1 };
UIPanelWindows["SpellBookFrame"] =				{ area = "left",			pushable = 0,	whileDead = 1, width = 575,	height = 545};
UIPanelWindows["CharacterFrame"] =				{ area = "left",			pushable = 3,		whileDead = 1 };

-- Resurrected Classic Frames that don't use the new Templates.
-- The offset and width values help the Classic frames blend in with modern frames that use ButtonFrameTemplate.
UIPanelWindows["QuestLogFrame"] =				{ area = "doublewide",		pushable = 0,		xoffset = -16,		yoffset = 12,	bottomClampOverride = 140+12,	whileDead = 1 };
UIPanelWindows["QuestLogDetailFrame"] =			{ area = "left",			pushable = 1,																			whileDead = 1 };
UIPanelWindows["GossipFrame"] =					{ area = "left",			pushable = 0,		xoffset = -16,		yoffset = 12,	bottomClampOverride = 140+12,	width = 353,	height = 424,	whileDead = 1 };
UIPanelWindows["QuestFrame"] =					{ area = "left",			pushable = 0,		xoffset = -16,		yoffset = 12,	bottomClampOverride = 140+12,	width = 353,	height = 424,	whileDead = 1 };
UIPanelWindows["DressUpFrame"] =				{ area = "left",			pushable = 2,		xoffset = -16,		yoffset = 12,	bottomClampOverride = 140+12,	width = 353,	height = 424,	whileDead = 1 };
UIPanelWindows["InspectFrame"] =				{ area = "left",			pushable = 2,		xoffset = -16,		yoffset = 12,	bottomClampOverride = 140+12,	width = 353,	height = 424,	whileDead = 1 };
UIPanelWindows["ClassTrainerFrame"] =			{ area = "left",			pushable = 0,		xoffset = -16,		yoffset = 12,	bottomClampOverride = 140+12,	width = 353,	height = 424,	whileDead = 1 };
UIPanelWindows["TradeSkillFrame"] =				{ area = "left",			pushable = 3,		xoffset = -16,		yoffset = 12,	bottomClampOverride = 140+12,	width = 353,	height = 424,	whileDead = 1 };
UIPanelWindows["CraftFrame"] =					{ area = "left",			pushable = 4,		xoffset = -16,		yoffset = 12,	bottomClampOverride = 140+12,	width = 353,	height = 424,	whileDead = 1 };
UIPanelWindows["PetStableFrame"] =				{ area = "left",			pushable = 0,		xoffset = -16,		yoffset = 12,	bottomClampOverride = 140+12,	width = 353,	height = 424,	whileDead = 1 };
UIPanelWindows["BankFrame"] =					{ area = "left",			pushable = 6,		xoffset = -16,		yoffset = 12,	bottomClampOverride = 140+12,	width = 353,	height = 424,	whileDead = 1 };
UIPanelWindows["TabardFrame"] =					{ area = "left",			pushable = 0,		xoffset = -16,		yoffset = 12,	bottomClampOverride = 140+12,	width = 353,	height = 424,	whileDead = 1 };
UIPanelWindows["GuildRegistrarFrame"] =			{ area = "left",			pushable = 0,		xoffset = -16,		yoffset = 12,	bottomClampOverride = 140+12,	width = 353,	height = 424,	whileDead = 1 };
UIPanelWindows["ArenaRegistrarFrame"] =			{ area = "left",			pushable = 0,		xoffset = -16,		yoffset = 12,	bottomClampOverride = 140+12,	width = 353,	height = 424,	whileDead = 1 };
UIPanelWindows["PetitionFrame"] =				{ area = "left",			pushable = 0,		xoffset = -16,		yoffset = 12,	bottomClampOverride = 140+12,	width = 353,	height = 424,	whileDead = 1 };
UIPanelWindows["AuctionFrame"] =				{ area = "doublewide",		pushable = 0,		xoffset = -16,		yoffset = 12,	bottomClampOverride = 140+12,	width = 840 }
UIPanelWindows["TaxiFrame"] =					{ area = "left",			pushable = 0, 		xoffset = -16,		yoffset = 12,	bottomClampOverride = 140+12,	width = 353,	height = 424,	showFailedFunc = CloseTaxiMap };
UIPanelWindows["ItemTextFrame"] =				{ area = "left",			pushable = 0, 		xoffset = -16,		yoffset = 12,	bottomClampOverride = 140+12,	width = 353,	height = 424,	whileDead = 1 };
UIPanelWindows["ArenaFrame"] =					{ area = "left",			pushable = 0,		xoffset = -16,		yoffset = 12,	bottomClampOverride = 140+12,	width = 353,	height = 424,	whileDead = 1 };
UIPanelWindows["PVPParentFrame"] =				{ area = "left",			pushable = 0,		xoffset = -16,		yoffset = 12,	bottomClampOverride = 140+12,	width = 353,	height = 424,	whileDead = 1 };

-- Frames NOT using the new Templates
UIPanelWindows["CinematicFrame"] =				{ area = "full",			pushable = 0, 		xoffset = -16, 		yoffset = 12,	whileDead = 1 };
UIPanelWindows["ChatConfigFrame"] =				{ area = "center",			pushable = 0, 		xoffset = -16, 		yoffset = 12,	whileDead = 1 };
UIPanelWindows["WorldStateScoreFrame"] =		{ area = "center",			pushable = 0, 		xoffset = -16, 		yoffset = 12,	whileDead = 1,	ignoreControlLost = true, };
UIPanelWindows["QuestChoiceFrame"] =			{ area = "center",			pushable = 0, 		xoffset = -16, 		yoffset = 12,	whileDead = 0, allowOtherPanels = 1 };
UIPanelWindows["WarboardQuestChoiceFrame"] =	{ area = "center",			pushable = 0, 		xoffset = -16, 		yoffset = 12,	whileDead = 0, allowOtherPanels = 1 };
UIPanelWindows["GarrisonBuildingFrame"] =		{ area = "center",			pushable = 0,		whileDead = 1, 		width = 1002, 	allowOtherPanels = 1};
UIPanelWindows["GarrisonMissionFrame"] =		{ area = "center",			pushable = 0,		whileDead = 1, 		checkFit = 1,	allowOtherPanels = 1, extraWidth = 20,	extraHeight = 100 };
UIPanelWindows["GarrisonShipyardFrame"] =		{ area = "center",			pushable = 0,		whileDead = 1, 		checkFit = 1,	allowOtherPanels = 1, extraWidth = 20,	extraHeight = 100 };
UIPanelWindows["GarrisonLandingPage"] =			{ area = "left",			pushable = 1,		whileDead = 1, 		width = 830, 	yoffset = 9,	allowOtherPanels = 1};
UIPanelWindows["GarrisonMonumentFrame"] =		{ area = "center",			pushable = 0,		whileDead = 1, 		width = 333, 	allowOtherPanels = 1};
UIPanelWindows["GarrisonRecruiterFrame"] =		{ area = "left",			pushable = 0};
UIPanelWindows["GarrisonRecruitSelectFrame"] =	{ area = "center",			pushable = 0};
UIPanelWindows["OrderHallMissionFrame"] =		{ area = "center",			pushable = 0,		whileDead = 1, 		checkFit = 1,	allowOtherPanels = 1, extraWidth = 20,	extraHeight = 100 };
UIPanelWindows["OrderHallTalentFrame"] =		{ area = "left",			pushable = 0,		xoffset = 16};
UIPanelWindows["ChallengesKeystoneFrame"] =		{ area = "center",			pushable = 0};
UIPanelWindows["BFAMissionFrame"] =				{ area = "center",			pushable = 0,		whileDead = 1, 		checkFit = 1,	allowOtherPanels = 1, extraWidth = 20,	extraHeight = 100 };

function FramePositionDelegate_Override_HandleExtraBars(self)
	-- HACK: we have too many bars in this game now...
	-- if the Stance bar is shown then hide the multi-cast bar
	-- we'll have to figure out what we should do in this case if it ever really becomes a problem
	-- HACK 2: if the possession bar is shown then hide the multi-cast bar
	-- yeah, way too many bars...
	if ( ( self.StanceBarFrame and self.StanceBarFrame:IsShown() ) or
		 ( self.PossessBarFrame and self.PossessBarFrame:IsShown() ) ) then
		self:HideMultiCastActionBar();
	elseif ( self.HasMultiCastActionBar and self:HasMultiCastActionBar() ) then
		self:ShowMultiCastActionBar();
	end
end

function FramePositionDelegate_Override_QuestTimerOffsets(self, anchorYStartValue)
	return anchorYStartValue;
end

function FramePositionDelegate_Override_VehicleSeatIndicatorOffsets(self, anchorYStartValue)
	local anchorY = anchorYStartValue;

	if ( self.VehicleSeatIndicator ) then
		if ( self.VehicleSeatIndicator and self.VehicleSeatIndicator:IsShown() ) then
			anchorY = anchorY - self.VehicleSeatIndicator:GetHeight() - 18;	--The -18 is there to give a small buffer for things like the QuestTimeFrame below the Seat Indicator
		end

		if ( SHOW_MULTI_ACTIONBAR_3 and SHOW_MULTI_ACTIONBAR_4 ) then
			self.VehicleSeatIndicator:SetPoint("TOPRIGHT", self.MinimapCluster, "BOTTOMRIGHT", -100, 0);
		elseif ( SHOW_MULTI_ACTIONBAR_3 ) then
			self.VehicleSeatIndicator:SetPoint("TOPRIGHT", self.MinimapCluster, "BOTTOMRIGHT", -62, 0);
		else
			self.VehicleSeatIndicator:SetPoint("TOPRIGHT", self.MinimapCluster, "BOTTOMRIGHT", 0, 0);
		end
	end

	return anchorY;
end

function FramePositionDelegate_Override_QuestWatchFrameOffsets(self, anchorYStartValue, rightActionBars, buffsAnchorY)
	local anchorY = anchorYStartValue;

	if (self.WatchFrame and (not (self.WatchFrame:IsUserPlaced()))) then
		local numArenaOpponents = self:GetNumArenaOpponents();
		if ( self.ArenaEnemyFrames and self.ArenaEnemyFrames:IsShown() and (numArenaOpponents > 0) ) then
			self.WatchFrame:ClearAllPoints();
			self.WatchFrame:SetPoint("TOPRIGHT", "ArenaEnemyFrame"..numArenaOpponents, "BOTTOMRIGHT", 2, -35);
		else -- We're using Simple Quest Tracking, automagically size and position!
			self.WatchFrame:ClearAllPoints();
			-- move up if only the minimap cluster is above, move down a little otherwise
			if ( anchorY == 0 ) then
				anchorY = 10;
			end
			self.WatchFrame:SetPoint("TOPRIGHT", "MinimapCluster", "BOTTOMRIGHT", -CONTAINER_OFFSET_X, anchorY);
			-- OnSizeChanged for WatchFrame handles its redraw
		end

		self.WatchFrame:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -CONTAINER_OFFSET_X, CONTAINER_OFFSET_Y);
	end

	return anchorY;
end