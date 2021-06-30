
-- Utility for laying out regions in a loosely grid-like structure. A list of regions is grouped into sections,
-- and then into cross section groups, each of which is composed of subgroups. For illustration, consider a grid
-- of frames (potentially different sizes) that are grouped into rows and columns. For this utility, each column might
-- contain multiple elements from each row, or even different number of elements from each different row, i.e. two small
-- elements might be grouped into the same column.
--
-- [  1  2  3  ]
-- [  4  5  6  ]
-- [  7  8  9  ]
-- sections: { 1, 2, 3 }, { 4, 5, 6 }, { 7, 8, 9 }
-- crossSections: [ { 1 }, { 4 }, { 7 } ], [ { 2 }, { 5 }, { 8 } ], [ { 3 }, { 6 }, { 9 } ]
-- (each cross section considers groups of elements, even if there is only a single element present in each).
--
-- [ 1 2   3    4  ]
-- [  5    6    7  ]
-- [ 8 9   a   b c ]
-- sections: { 1, 2, 3, 4 }, { 5, 6, 7 }, { 8, 9, a, b, c }
-- crossSections: [ { 1, 2 }, { 5 }, { 8, 9 } ], [ { 3 }, { 6 }, { a } ], [ { 4 }, { 7 }, { b, c } ]
--
-- Groupings and measurings are axis-agnostic so the primary grouping might be horizontally based on rows and widths,
-- or vertically based on columns and heights.
-- 
-- GridLayoutManagerMixin is used to house all the different specifications required to described different layouts.
--
-- The primary elements of GridLayoutManagerMixin are:
--  primarySizeCalculator: how to measure regions. Typically GetWidth or GetHeight.
--  secondarySizeCalculator: how to measure regions. Typically GetWidth or GetHeight.
--  direction: a table of primaryMultiplier and secondaryMultiplier to be used when applying offsets. Typically 1 or -1.
--  primarySizePadding: padding between elements in sections.
--  secondarySizePadding: padding between sections.
--  isHeightPrimary: by default, width is primary. Set to switch to height as primary.
--
--  sectionStrategy: how elements are grouped into sections.
--  crossSectionStrategy: how elements are grouped into crossSections based on the given sections.
--  Notes: For example, sub-divide regions based on count. Or group by width with a fixed rowSize, and subdivide into
--         crossSections where multiple smaller elements may be grouped together.
--
--  primaryPaddingStrategy: resolution between different sized regions/groupings, applied based on crossSections.
--  secondaryPaddingStrategy: resolution between different size regions in a section.
--  Notes: "leading" space is referred to as padding, and "trailing" space is referred to as spacing. This is all relative to direction though.
--
-- GridLayoutManagerMixin:ApplyToRegions:ApplyToRegions is the engine that runs at the heart of the system. The algorithm is:
-- 1. Group regions into sections.
-- 2. Based on sections, generate cross sections.
-- 3. Add extra padding along the primary axis based on cross sections.
-- 4. Add extra padding along the secondary axis based on sections.
-- 5. Apply the initial anchor to each frame, with offsets for each based driection and the sizes and spacings calculated for sections and regions.


GridLayoutUtil = {};

-- First pass at a compatilibity layer to interface with the AnchorUtil version of this stuff.
function GridLayoutUtil.GridLayoutRegions(regions, initialAnchor, layout)
	if #regions == 0 then
		return;
	end

	local isColumnBased = layout.isColumnBased;
	local primarySizeCalculator = isColumnBased and regions[1].GetHeight or regions[1].GetWidth;
	local secondarySizeCalculator = isColumnBased and regions[1].GetWidth or regions[1].GetHeight;
	local primarySizePadding = isColumnBased and layout.paddingY or layout.paddingX;
	local secondarySizePadding = isColumnBased and layout.paddingX or layout.paddingY;
	local primaryMultiplier = isColumnBased and layout.direction.y or layout.direction.x;
	local secondaryMultiplier = isColumnBased and layout.direction.x or layout.direction.y;
	local direction = { primaryMultiplier = primaryMultiplier, secondaryMultiplier = secondaryMultiplier };
	local layoutManager = CreateAndInitFromMixin(GridLayoutManagerMixin, primarySizeCalculator, secondarySizeCalculator, direction, primarySizePadding, secondarySizePadding);

	layoutManager:SetHeightAsPrimary(layout.isColumnBased);

	layoutManager:SetPrimaryPaddingStrategy(GridLayoutUtilPrimaryPaddingStrategy.AllPaddingToFirst);
	layoutManager:SetSecondaryPaddingStrategy(GridLayoutUtilSecondaryPaddingStrategy.Equal);

	local sectionPadding = 0;
	local sectionSize = layout.stride;
	if layout.direction.isVertical then
		layoutManager:SetSectionStrategy(GenerateClosure(GridLayoutUtilSectionStrategy.SplitRegionsIntoGridSectionsVertical, sectionSize, sectionPadding));
	else
		layoutManager:SetSectionStrategy(GenerateClosure(GridLayoutUtilSectionStrategy.SplitRegionsIntoGridSections, sectionSize, sectionPadding));
	end

	layoutManager:SetCrossSectionStrategy(GridLayoutUtilCrossSectionStrategy.CalculateGridCrossSections);
	layoutManager:ApplyToRegions(initialAnchor, regions);
end


GridLayoutManagerMixin = {};

function GridLayoutManagerMixin:Init(primarySizeCalculator, secondarySizeCalculator, direction, primarySizePadding, secondarySizePadding)
	self.primarySizeCalculator = primarySizeCalculator;
	self.secondarySizeCalculator = secondarySizeCalculator;
	self.primaryMultiplier = direction.primaryMultiplier;
	self.secondaryMultiplier = direction.secondaryMultiplier;
	self.primarySizePadding = primarySizePadding;
	self.secondarySizePadding = secondarySizePadding;
end

function GridLayoutManagerMixin:SetSectionStrategy(sectionStrategy)
	self.sectionStrategy = sectionStrategy;
end

function GridLayoutManagerMixin:SetCrossSectionStrategy(crossSectionStrategy)
	self.crossSectionStrategy = crossSectionStrategy;
end

function GridLayoutManagerMixin:SetPrimaryPaddingStrategy(primaryPaddingStrategy)
	self.primaryPaddingStrategy = primaryPaddingStrategy;
end

function GridLayoutManagerMixin:SetSecondaryPaddingStrategy(secondaryPaddingStrategy)
	self.secondaryPaddingStrategy = secondaryPaddingStrategy;
end

function GridLayoutManagerMixin:SetHeightAsPrimary(isHeightPrimary)
	self.isHeightPrimary = isHeightPrimary;
end

function GridLayoutManagerMixin:ApplyToRegions(initialAnchor, regions)
	if #regions == 0 then
		return;
	end

	local sectionGroups = self.sectionStrategy(self, regions);
	local crossSectionGroups = self.crossSectionStrategy(self, sectionGroups);
	self:ApplyPrimaryPadding(self, crossSectionGroups);
	self:ApplySecondaryPadding(self, sectionGroups);
	self:ApplyAnchoring(sectionGroups, initialAnchor);
end

function GridLayoutManagerMixin:ApplyPrimaryPadding(layoutManager, crossSectionGroups)
	if self.primaryPaddingStrategy == nil then
		return;
	end

	for crossSectionIndex, crossSectionGroup in ipairs(crossSectionGroups) do
		local crossSectionPrimarySize = crossSectionGroup:GetCachedPrimarySize();
		for sectionIndex, section in crossSectionGroup:EnumerateSections() do
			local availableSpace = crossSectionPrimarySize - section:GetCachedPrimarySize();
			self.primaryPaddingStrategy(section, GridLayoutRegionEntryMixin.GetPrimarySize, GridLayoutRegionEntryMixin.SetExtraPrimaryPadding, GridLayoutRegionEntryMixin.SetExtraPrimarySpacing, availableSpace);
		end
	end
end

function GridLayoutManagerMixin:ApplySecondaryPadding(layoutManager, sectionGroups)
	if self.secondaryPaddingStrategy == nil then
		return;
	end

	for sectionIndex, section in sectionGroups:EnumerateSections() do
		local sectionSecondarySize = section:GetCachedSecondarySize();
		self.secondaryPaddingStrategy(section, GridLayoutRegionEntryMixin.GetSecondarySize, GridLayoutRegionEntryMixin.SetExtraSecondaryPadding, GridLayoutRegionEntryMixin.SetExtraSecondarySpacing, sectionSecondarySize);
	end
end

function GridLayoutManagerMixin:ApplyAnchoring(sectionGroups, initialAnchor)
	local isHeightPrimary = self.isHeightPrimary;
	local primaryMultiplier = self.primaryMultiplier;
	local secondaryMultiplier = self.secondaryMultiplier;

	local primaryOffset = 0;
	local secondaryOffset = 0;
	local sectionPrimaryPadding = (self:GetPrimarySizePadding() * primaryMultiplier);
	for sectionIndex, section in sectionGroups:EnumerateSections() do
		primaryOffset = 0;

		for regionEntryIndex, regionEntry in section:EnumerateRegionEntries() do
			if regionEntryIndex ~= 1 then
				primaryOffset = primaryOffset + sectionPrimaryPadding;
			end

			local extraPrimaryPadding = (regionEntry:GetExtraPrimaryPadding() * primaryMultiplier);
			primaryOffset = primaryOffset + extraPrimaryPadding;

			local secondaryPadding = regionEntry:GetExtraSecondaryPadding() * secondaryMultiplier;
			local clearAllPoints = true;

			if isHeightPrimary then
				initialAnchor:SetPointWithExtraOffset(regionEntry:GetRegion(), clearAllPoints, secondaryOffset + secondaryPadding, primaryOffset);
			else
				initialAnchor:SetPointWithExtraOffset(regionEntry:GetRegion(), clearAllPoints, primaryOffset, secondaryOffset + secondaryPadding);
			end

			local primaryAdjustment = ((regionEntry:GetPrimarySize() + regionEntry:GetExtraPrimarySpacing()) * primaryMultiplier);
			primaryOffset = primaryOffset + primaryAdjustment;
		end

		local sectionSpacing = (section:GetSecondarySize() + self:GetSecondarySizePadding()) * secondaryMultiplier;
		secondaryOffset = secondaryOffset + sectionSpacing;
	end
end

function GridLayoutManagerMixin:CalculatePrimarySize(region)
	return self.primarySizeCalculator(region);
end

function GridLayoutManagerMixin:CalculateSecondarySize(region)
	return self.secondarySizeCalculator(region);
end

function GridLayoutManagerMixin:GetPrimarySizePadding()
	return self.primarySizePadding;
end

function GridLayoutManagerMixin:GetSecondarySizePadding()
	return self.secondarySizePadding;
end


GridLayoutRegionEntryMixin = {};

function GridLayoutRegionEntryMixin:Init(layoutManager, region)
	self.region = region;
	self.primarySize = layoutManager:CalculatePrimarySize(region);
	self.secondarySize = layoutManager:CalculateSecondarySize(region);
end

function GridLayoutRegionEntryMixin:GetRegion()
	return self.region;
end

function GridLayoutRegionEntryMixin:GetPrimarySize()
	return self.primarySize;
end

function GridLayoutRegionEntryMixin:GetSecondarySize()
	return self.secondarySize;
end

function GridLayoutRegionEntryMixin:SetExtraPrimaryPadding(extraPrimaryPadding)
	self.extraPrimaryPadding = extraPrimaryPadding;
end

function GridLayoutRegionEntryMixin:GetExtraPrimaryPadding()
	return self.extraPrimaryPadding or 0;
end

function GridLayoutRegionEntryMixin:SetExtraSecondaryPadding(extraSecondaryPadding)
	self.extraSecondaryPadding = extraSecondaryPadding;
end

function GridLayoutRegionEntryMixin:GetExtraSecondaryPadding()
	return self.extraSecondaryPadding or 0;
end

function GridLayoutRegionEntryMixin:SetExtraPrimarySpacing(extraPrimarySpacing)
	self.extraPrimarySpacing = extraPrimarySpacing;
end

function GridLayoutRegionEntryMixin:GetExtraPrimarySpacing()
	return self.extraPrimarySpacing or 0;
end

function GridLayoutRegionEntryMixin:SetExtraSecondarySpacing(extraSecondarySpacing)
	self.extraSecondarySpacing = extraSecondarySpacing;
end

function GridLayoutRegionEntryMixin:GetExtraSecondarySpacing()
	return self.extraSecondarySpacing or 0;
end


GridLayoutSectionMixin = {};

function GridLayoutSectionMixin:Init(layoutManager)
	self.layoutManager = layoutManager;
	self.regionEntries = {};
end

function GridLayoutSectionMixin:AddRegion(region)
	table.insert(self.regionEntries, CreateAndInitFromMixin(GridLayoutRegionEntryMixin, self.layoutManager, region));
end

function GridLayoutSectionMixin:AddRegionEntry(regionEntry)
	table.insert(self.regionEntries, regionEntry);
end

function GridLayoutSectionMixin:GetRegionEntry(index)
	return self.regionEntries[index];
end

function GridLayoutSectionMixin:GetNumRegionEntries()
	return #self.regionEntries;
end

function GridLayoutSectionMixin:EnumerateRegionEntries()
	return ipairs(self.regionEntries);
end

function GridLayoutSectionMixin:GetCachedPrimarySize()
	if self.cachedPrimarySize then
		return self.cachedPrimarySize;
	end

	self.cachedPrimarySize = self:GetPrimarySize();
	return self.cachedPrimarySize;
end

function GridLayoutSectionMixin:GetPrimarySize()
	local totalPrimarySize = 0;
	local numRegionEntries = #self.regionEntries;
	for i, regionEntry in ipairs(self.regionEntries) do
		totalPrimarySize = totalPrimarySize + regionEntry:GetPrimarySize();

		if i ~= numRegionEntries then
			totalPrimarySize = totalPrimarySize + self.layoutManager:GetPrimarySizePadding();
		end
	end

	return totalPrimarySize;
end

function GridLayoutSectionMixin:GetCachedSecondarySize()
	if self.cachedSecondarySize then
		return self.cachedSecondarySize;
	end

	self.cachedSecondarySize = self:GetSecondarySize();
	return self.cachedSecondarySize;
end

function GridLayoutSectionMixin:GetSecondarySize()
	local maxSecondarySize = 0;
	for i, regionEntry in ipairs(self.regionEntries) do
		maxSecondarySize = math.max(maxSecondarySize, regionEntry:GetSecondarySize());
	end

	return maxSecondarySize;
end


GridLayoutSectionGroupMixin = {};

function GridLayoutSectionGroupMixin:Init(layoutManager)
	self.layoutManager = layoutManager;
	self.sections = {};
end

function GridLayoutSectionGroupMixin:AddEmptySection()
	local newSection = CreateAndInitFromMixin(GridLayoutSectionMixin, self.layoutManager);
	table.insert(self.sections, newSection);
	return newSection;
end

function GridLayoutSectionGroupMixin:AddToSection(sectionIndex, regionEntry)
	self.sections[sectionIndex] = self.sections[sectionIndex] or CreateAndInitFromMixin(GridLayoutSectionMixin, self.layoutManager);
	self.sections[sectionIndex]:AddRegionEntry(regionEntry);
end

function GridLayoutSectionGroupMixin:EnumerateSections()
	return ipairs(self.sections);
end

function GridLayoutSectionGroupMixin:GetCachedPrimarySize()
	if self.cachedPrimarySize then
		return self.cachedPrimarySize;
	end

	self.cachedPrimarySize = self:GetPrimarySize();
	return self.cachedPrimarySize;
end

function GridLayoutSectionGroupMixin:GetPrimarySize()
	local maxPrimarySize = 0;
	for i, section in ipairs(self.sections) do
		maxPrimarySize = math.max(maxPrimarySize, section:GetPrimarySize());
	end

	return maxPrimarySize;
end

function GridLayoutSectionGroupMixin:GetCachedSecondarySize()
	if self.cachedSecondarySize then
		return self.cachedSecondarySize;
	end

	self.cachedSecondarySize = self:GetSecondarySize();
	return self.cachedSecondarySize;
end

function GridLayoutSectionGroupMixin:GetSecondarySize()
	local maxSecondarySize = 0;
	for i, section in ipairs(self.sections) do
		maxSecondarySize = math.max(maxSecondarySize, section:GetSecondarySize());
	end

	return maxSecondarySize;
end


GridLayoutUtilSectionStrategy = {};

function GridLayoutUtilSectionStrategy.SplitRegionsIntoSectionsBySize(maxSectionSize, sectionPadding, layoutManager, regionDataProvider, sectionSizeCalculator)
	local sectionGroups = CreateAndInitFromMixin(GridLayoutSectionGroupMixin, layoutManager);
	local currentSection = sectionGroups:AddEmptySection();
	local currentSectionSize = 0;

	local infiniteGuard = 300;
	for i = 1, infiniteGuard do
		local region = regionDataProvider(i);
		if region == nil then
			break;
		end

		local isFirstInSection = (currentSectionSize == 0);
		local regionSize = sectionSizeCalculator(region);
		local padding = (isFirstInSection and 0 or sectionPadding);
		local newSectionSize = (padding + currentSectionSize + regionSize);
		if isFirstInSection or (newSectionSize <= maxSectionSize) then
			currentSectionSize = newSectionSize;
		else
			currentSection = sectionGroups:AddEmptySection();
			currentSectionSize = regionSize;
		end

		currentSection:AddRegion(region);
	end

	return sectionGroups;
end

function GridLayoutUtilSectionStrategy.SplitRegionsIntoSectionsByNaturalSize(sectionSize, sectionPadding, layoutManager, regions)
	local function NaturalRegionDataProvider(i)
		return regions[i];
	end

	local function NaturalSectionSizeCalculator(region)
		return layoutManager:CalculatePrimarySize(region);
	end

	return GridLayoutUtilSectionStrategy.SplitRegionsIntoSectionsBySize(layoutManager, NaturalRegionDataProvider, NaturalSectionSizeCalculator, sectionSize, sectionPadding);
end

function GridLayoutUtilSectionStrategy.SplitRegionsIntoGridSectionsInternal(sectionSize, sectionPadding, layoutManager, regionDataProvider)
	local function GridSectionSizeCalculator()
		return 1;
	end

	return GridLayoutUtilSectionStrategy.SplitRegionsIntoSectionsBySize(sectionSize, sectionPadding, layoutManager, regionDataProvider, GridSectionSizeCalculator);
end

function GridLayoutUtilSectionStrategy.SplitRegionsIntoGridSections(sectionSize, sectionPadding, layoutManager, regions)
	local function GridRegionDataProviderByRow(i)
		return regions[i];
	end

	return GridLayoutUtilSectionStrategy.SplitRegionsIntoGridSectionsInternal(sectionSize, sectionPadding, layoutManager, GridRegionDataProviderByRow);
end

function GridLayoutUtilSectionStrategy.SplitRegionsIntoGridSectionsVertical(sectionSize, sectionPadding, layoutManager, regions)
	local numRegions = #regions;
	local numCrossSections = math.ceil(numRegions / sectionSize);
	local function GridRegionDataProviderVertical(i)
		if i > numRegions then
			return nil;
		end

		local row = ((i - 1) % sectionSize) * numCrossSections;
		local column = math.ceil(i / sectionSize);
		return regions[row + column];
	end

	return GridLayoutUtilSectionStrategy.SplitRegionsIntoGridSectionsInternal(sectionSize, sectionPadding, layoutManager, GridRegionDataProviderVertical);
end


GridLayoutUtilCrossSectionStrategy = {};

function GridLayoutUtilCrossSectionStrategy.CalculateGridCrossSections(layoutManager, sectionGroups)
	local crossSectionGroups = {};

	local infiniteGuard = 300;
	for crossSectionIndex = 1, infiniteGuard do
		local crossSection = CreateAndInitFromMixin(GridLayoutSectionGroupMixin, layoutManager);
		local crossSectionIsEmpty = true;
		for i, section in sectionGroups:EnumerateSections() do
			local sectionRegion = section:GetRegionEntry(crossSectionIndex);
			if sectionRegion then
				crossSection:AddToSection(i, sectionRegion);
				crossSectionIsEmpty = false;
			else
				crossSection:AddEmptySection();
			end
		end

		if crossSectionIsEmpty then
			break;
		end

		table.insert(crossSectionGroups, crossSection);
	end

	return crossSectionGroups;
end


GridLayoutUtilPrimaryPaddingStrategy = {};

function GridLayoutUtilPrimaryPaddingStrategy.AllPaddingToFirst(section, regionSizeCalculator, paddingSetter, spacingSetter, availableSize)
	local firstRegionEntry = section:GetRegionEntry(1);
	if firstRegionEntry ~= nil then
		paddingSetter(firstRegionEntry, availableSize);
	end
end

function GridLayoutUtilPrimaryPaddingStrategy.AllSpacingToLast(section, regionSizeCalculator, paddingSetter, spacingSetter, availableSize)
	local lastRegionIndex = section:GetNumRegionEntries();
	if lastRegionIndex ~= 0 then
		local lastRegionEntry = section:GetRegionEntry(lastRegionIndex);
		spacingSetter(lastRegionEntry, availableSize);
	end
end

function GridLayoutUtilPrimaryPaddingStrategy.EvenSpacing(section, regionSizeCalculator, paddingSetter, spacingSetter, availableSize)
	local numRegionEntries = section:GetNumRegionEntries();
	if numRegionEntries == 0 then
		return;
	end

	if numRegionEntries == 1 then
		local regionEntry = section:GetRegionEntry(1);
		local equalPadding = availableSize / 2;
		paddingSetter(regionEntry, equalPadding);
		spacingSetter(regionEntry, equalPadding);
		return;
	end

	local spacedEntries = numRegionEntries - 1;
	local equalSpacing = availableSize / spacedEntries;

	for i = 1, spacedEntries do
		local regionEntry = section:GetRegionEntry(i);
		paddingSetter(regionEntry, equalSpacing);
	end
end


GridLayoutUtilSecondaryPaddingStrategy = {};

function GridLayoutUtilSecondaryPaddingStrategy.Equal(section, regionSizeCalculator, paddingSetter, spacingSetter, sectionSecondarySize)
	for i, regionEntry in section:EnumerateRegionEntries() do
		local padding = (sectionSecondarySize - regionSizeCalculator(regionEntry)) / 2;
		paddingSetter(regionEntry, padding);
		spacingSetter(regionEntry, padding);
	end
end

function GridLayoutUtilSecondaryPaddingStrategy.AllPadding(section, regionSizeCalculator, paddingSetter, spacingSetter, sectionSecondarySize)
	for i, regionEntry in section:EnumerateRegionEntries() do
		local availableSize = sectionSecondarySize - regionSizeCalculator(regionEntry);
		paddingSetter(regionEntry, availableSize);
	end
end

function GridLayoutUtilSecondaryPaddingStrategy.AllSpacing(section, regionSizeCalculator, paddingSetter, spacingSetter, sectionSecondarySize)
	for i, regionEntry in section:EnumerateRegionEntries() do
		local availableSize = sectionSecondarySize - regionSizeCalculator(regionEntry);
		spacingSetter(regionEntry, availableSize);
	end
end
