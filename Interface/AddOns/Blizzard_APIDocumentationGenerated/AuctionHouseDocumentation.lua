local AuctionHouse =
{
	Name = "AuctionHouse",
	Type = "System",
	Namespace = "C_AuctionHouse",

	Functions =
	{
	},

	Events =
	{
		{
			Name = "AuctionBidderListUpdate",
			Type = "Event",
			LiteralName = "AUCTION_BIDDER_LIST_UPDATE",
		},
		{
			Name = "AuctionHouseClosed",
			Type = "Event",
			LiteralName = "AUCTION_HOUSE_CLOSED",
		},
		{
			Name = "AuctionHouseDisabled",
			Type = "Event",
			LiteralName = "AUCTION_HOUSE_DISABLED",
		},
		{
			Name = "AuctionHousePostError",
			Type = "Event",
			LiteralName = "AUCTION_HOUSE_POST_ERROR",
		},
		{
			Name = "AuctionHousePostWarning",
			Type = "Event",
			LiteralName = "AUCTION_HOUSE_POST_WARNING",
		},
		{
			Name = "AuctionHouseScriptDeprecated",
			Type = "Event",
			LiteralName = "AUCTION_HOUSE_SCRIPT_DEPRECATED",
		},
		{
			Name = "AuctionHouseShow",
			Type = "Event",
			LiteralName = "AUCTION_HOUSE_SHOW",
		},
		{
			Name = "AuctionItemListUpdate",
			Type = "Event",
			LiteralName = "AUCTION_ITEM_LIST_UPDATE",
		},
		{
			Name = "AuctionMultisellFailure",
			Type = "Event",
			LiteralName = "AUCTION_MULTISELL_FAILURE",
		},
		{
			Name = "AuctionMultisellStart",
			Type = "Event",
			LiteralName = "AUCTION_MULTISELL_START",
			Payload =
			{
				{ Name = "numRepetitions", Type = "number", Nilable = false },
			},
		},
		{
			Name = "AuctionMultisellUpdate",
			Type = "Event",
			LiteralName = "AUCTION_MULTISELL_UPDATE",
			Payload =
			{
				{ Name = "createdCount", Type = "number", Nilable = false },
				{ Name = "totalToCreate", Type = "number", Nilable = false },
			},
		},
		{
			Name = "AuctionOwnedListUpdate",
			Type = "Event",
			LiteralName = "AUCTION_OWNED_LIST_UPDATE",
		},
		{
			Name = "NewAuctionUpdate",
			Type = "Event",
			LiteralName = "NEW_AUCTION_UPDATE",
		},
		{
			Name = "OwnedAuctionsUpdated",
			Type = "Event",
			LiteralName = "OWNED_AUCTIONS_UPDATED",
		},
	},

	Tables =
	{
		{
			Name = "AuctionStatus",
			Type = "Enumeration",
			NumValues = 2,
			MinValue = 0,
			MaxValue = 1,
			Fields =
			{
				{ Name = "Active", Type = "AuctionStatus", EnumValue = 0 },
				{ Name = "Sold", Type = "AuctionStatus", EnumValue = 1 },
			},
		},
		{
			Name = "ItemKey",
			Type = "Structure",
			Fields =
			{
				{ Name = "itemID", Type = "number", Nilable = false },
				{ Name = "itemLevel", Type = "number", Nilable = false, Default = 0 },
				{ Name = "itemSuffix", Type = "number", Nilable = false, Default = 0 },
				{ Name = "battlePetSpeciesID", Type = "number", Nilable = false, Default = 0 },
			},
		},
		{
			Name = "OwnedAuctionInfo",
			Type = "Structure",
			Fields =
			{
				{ Name = "auctionID", Type = "number", Nilable = false },
				{ Name = "itemKey", Type = "ItemKey", Nilable = false },
				{ Name = "itemLink", Type = "string", Nilable = true },
				{ Name = "status", Type = "AuctionStatus", Nilable = false },
				{ Name = "quantity", Type = "number", Nilable = false },
				{ Name = "timeLeftSeconds", Type = "number", Nilable = true },
				{ Name = "timeLeft", Type = "AuctionHouseTimeLeftBand", Nilable = true },
				{ Name = "bidAmount", Type = "BigUInteger", Nilable = true },
				{ Name = "buyoutAmount", Type = "BigUInteger", Nilable = true },
				{ Name = "bidder", Type = "string", Nilable = true },
			},
		},
	},
};

APIDocumentation:AddDocumentationTable(AuctionHouse);