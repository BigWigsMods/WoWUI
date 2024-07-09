-- Panel Positions
PANEL_INSET_LEFT_OFFSET = 4;
PANEL_INSET_RIGHT_OFFSET = -6;
PANEL_INSET_BOTTOM_OFFSET = 4;
PANEL_INSET_BOTTOM_BUTTON_OFFSET = 26;
PANEL_INSET_TOP_OFFSET = -24;
PANEL_INSET_ATTIC_OFFSET = -60;

-- Magic Button code
function MagicButton_OnLoad(self)
	local leftHandled = false;
	local rightHandled = false;

	-- Find out where this button is anchored and adjust positions/separators as necessary
	for i=1, self:GetNumPoints() do
		local point, relativeTo, relativePoint, offsetX, offsetY = self:GetPoint(i);

		if (relativeTo:GetObjectType() == "Button" and (point == "TOPLEFT" or point == "LEFT")) then

			if (offsetX == 0 and offsetY == 0) then
				self:SetPoint(point, relativeTo, relativePoint, 1, 0);
			end

			if (relativeTo.RightSeparator) then
				-- Modify separator to make it a Middle
				self.LeftSeparator = relativeTo.RightSeparator;
			else
				-- Add a Middle separator
				self.LeftSeparator = self:CreateTexture(self:GetName() and self:GetName().."_LeftSeparator" or nil, "BORDER");
				relativeTo.RightSeparator = self.LeftSeparator;
			end

			self.LeftSeparator:SetTexture("Interface\\FrameGeneral\\UI-Frame");
			self.LeftSeparator:SetTexCoord(0.00781250, 0.10937500, 0.75781250, 0.95312500);
			self.LeftSeparator:SetWidth(13);
			self.LeftSeparator:SetHeight(25);
			self.LeftSeparator:SetPoint("TOPRIGHT", self, "TOPLEFT", 5, 1);

			leftHandled = true;

		elseif (relativeTo:GetObjectType() == "Button" and (point == "TOPRIGHT" or point == "RIGHT")) then

			if (offsetX == 0 and offsetY == 0) then
				self:SetPoint(point, relativeTo, relativePoint, -1, 0);
			end

			if (relativeTo.LeftSeparator) then
				-- Modify separator to make it a Middle
				self.RightSeparator = relativeTo.LeftSeparator;
			else
				-- Add a Middle separator
				self.RightSeparator = self:CreateTexture(self:GetName() and self:GetName().."_RightSeparator" or nil, "BORDER");
				relativeTo.LeftSeparator = self.RightSeparator;
			end

			self.RightSeparator:SetTexture("Interface\\FrameGeneral\\UI-Frame");
			self.RightSeparator:SetTexCoord(0.00781250, 0.10937500, 0.75781250, 0.95312500);
			self.RightSeparator:SetWidth(13);
			self.RightSeparator:SetHeight(25);
			self.RightSeparator:SetPoint("TOPLEFT", self, "TOPRIGHT", -5, 1);

			rightHandled = true;

		elseif (point == "BOTTOMLEFT") then
			if (offsetX == 0 and offsetY == 0) then
				self:SetPoint(point, relativeTo, relativePoint, 4, 4);
			end
			leftHandled = true;
		elseif (point == "BOTTOMRIGHT") then
			if (offsetX == 0 and offsetY == 0) then
				self:SetPoint(point, relativeTo, relativePoint, -6, 4);
			end
			rightHandled = true;
		elseif (point == "BOTTOM") then
			if (offsetY == 0) then
				self:SetPoint(point, relativeTo, relativePoint, 0, 4);
			end
		end
	end

	-- If this button didn't have a left anchor, add the left border texture
	if (not leftHandled) then
		if (not self.LeftSeparator) then
			-- Add a Left border
			self.LeftSeparator = self:CreateTexture(self:GetName() and self:GetName().."_LeftSeparator" or nil, "BORDER");
			self.LeftSeparator:SetTexture("Interface\\FrameGeneral\\UI-Frame");
			self.LeftSeparator:SetTexCoord(0.24218750, 0.32812500, 0.63281250, 0.82812500);
			self.LeftSeparator:SetWidth(11);
			self.LeftSeparator:SetHeight(25);
			self.LeftSeparator:SetPoint("TOPRIGHT", self, "TOPLEFT", 6, 1);
		end
	end

	-- If this button didn't have a right anchor, add the right border texture
	if (not rightHandled) then
		if (not self.RightSeparator) then
			-- Add a Right border
			self.RightSeparator = self:CreateTexture(self:GetName() and self:GetName().."_RightSeparator" or nil, "BORDER");
			self.RightSeparator:SetTexture("Interface\\FrameGeneral\\UI-Frame");
			self.RightSeparator:SetTexCoord(0.90625000, 0.99218750, 0.00781250, 0.20312500);
			self.RightSeparator:SetWidth(11);
			self.RightSeparator:SetHeight(25);
			self.RightSeparator:SetPoint("TOPLEFT", self, "TOPRIGHT", -6, 1);
		end
	end
end

function DynamicResizeButton_Resize(self)
	local padding = 40;
	local width = self:GetWidth();
	local textWidth = self:GetTextWidth() + padding;
	self:SetWidth(math.max(width, textWidth));
end

-- ButtonFrameTemplate code
function ButtonFrameTemplate_HideButtonBar(self)
	if self.bottomInset then
		self.bottomInset:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", PANEL_INSET_RIGHT_OFFSET, PANEL_INSET_BOTTOM_OFFSET);
	else
		_G[self:GetName() .. "Inset"]:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", PANEL_INSET_RIGHT_OFFSET, PANEL_INSET_BOTTOM_OFFSET);
	end
	_G[self:GetName() .. "BtnCornerLeft"]:Hide();
	_G[self:GetName() .. "BtnCornerRight"]:Hide();
	_G[self:GetName() .. "ButtonBottomBorder"]:Hide();
end

function ButtonFrameTemplate_ShowButtonBar(self)
	if self.topInset then
		self.topInset:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", PANEL_INSET_RIGHT_OFFSET, PANEL_INSET_BOTTOM_BUTTON_OFFSET);
	else
		_G[self:GetName() .. "Inset"]:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", PANEL_INSET_RIGHT_OFFSET, PANEL_INSET_BOTTOM_BUTTON_OFFSET);
	end
	_G[self:GetName() .. "BtnCornerLeft"]:Show();
	_G[self:GetName() .. "BtnCornerRight"]:Show();
	_G[self:GetName() .. "ButtonBottomBorder"]:Show();
end

function ButtonFrameTemplate_HideAttic(self)
	if self.topInset then
		self.topInset:SetPoint("TOPLEFT", self, "TOPLEFT", PANEL_INSET_LEFT_OFFSET, PANEL_INSET_TOP_OFFSET);
	else
		self.Inset:SetPoint("TOPLEFT", self, "TOPLEFT", PANEL_INSET_LEFT_OFFSET, PANEL_INSET_TOP_OFFSET);
	end
	self.TopTileStreaks:Hide();
end

function ButtonFrameTemplate_ShowAttic(self)
	if self.topInset then
		self.topInset:SetPoint("TOPLEFT", self, "TOPLEFT", PANEL_INSET_LEFT_OFFSET, PANEL_INSET_ATTIC_OFFSET);
	else
		self.Inset:SetPoint("TOPLEFT", self, "TOPLEFT", PANEL_INSET_LEFT_OFFSET, PANEL_INSET_ATTIC_OFFSET);
	end
	self.TopTileStreaks:Show();
end


function ButtonFrameTemplate_HidePortrait(self)
	if(self.portrait) then
		self.portrait:Hide();
		self.PortraitFrame:Hide();
		self.TopLeftCorner:Show();
		self.TopBorder:SetPoint("TOPLEFT", self.TopLeftCorner, "TOPRIGHT",  0, 0);
		self.LeftBorder:SetPoint("TOPLEFT", self.TopLeftCorner, "BOTTOMLEFT",  0, 0);
	end
end

function ButtonFrameTemplate_ShowPortrait(self)
	self.portrait:Show();
	self.PortraitFrame:Show();
	self.TopLeftCorner:Hide();
	self.TopBorder:SetPoint("TOPLEFT", self.PortraitFrame, "TOPRIGHT",  0, -10);
	self.LeftBorder:SetPoint("TOPLEFT", self.PortraitFrame, "BOTTOMLEFT",  8, 0);
end

function ButtonFrameTemplateMinimizable_HidePortrait(self)
	ButtonFrameTemplate_HidePortrait(self);
end

function ButtonFrameTemplateMinimizable_ShowPortrait(self)
	ButtonFrameTemplate_ShowPortrait(self);
end

-- A bit ugly, we want the talent frame to display a dialog box in certain conditions.
function UIPanelCloseButton_OnClick(self)
	local parent = self:GetParent();
	if parent then
		local continueHide = true;
		if parent.onCloseCallback then
			continueHide = parent.onCloseCallback(self);
		end

		if continueHide then
			HideUIPanel(parent);
		end
	end
end

-- Scrollframe functions
function UIPanelScrollFrame_OnLoad(self)
	local scrollbar = self.ScrollBar or _G[self:GetName().."ScrollBar"];
	scrollbar:SetMinMaxValues(0, 0);
	scrollbar:SetValue(0);
	self.offset = 0;

	local scrollDownButton = scrollbar.ScrollDownButton or _G[scrollbar:GetName().."ScrollDownButton"];
	local scrollUpButton = scrollbar.ScrollUpButton or _G[scrollbar:GetName().."ScrollUpButton"];

	scrollDownButton:Disable();
	scrollUpButton:Disable();

	if ( self.scrollBarHideable ) then
		scrollbar:Hide();
		scrollDownButton:Hide();
		scrollUpButton:Hide();
	else
		scrollDownButton:Disable();
		scrollUpButton:Disable();
		scrollDownButton:Show();
		scrollUpButton:Show();
	end
	if ( self.noScrollThumb ) then
		(scrollbar.ThumbTexture or _G[scrollbar:GetName().."ThumbTexture"]):Hide();
	end
end

function HideParentPanel(self)
	HideUIPanel(self:GetParent());
end

function EditBox_HandleTabbing(self, tabList)
	local editboxName = self:GetName();
	local index;
	for i=1, #tabList do
		if ( editboxName == tabList[i] ) then
			index = i;
			break;
		end
	end
	if ( IsShiftKeyDown() ) then
		index = index - 1;
	else
		index = index + 1;
	end

	if ( index == 0 ) then
		index = #tabList;
	elseif ( index > #tabList ) then
		index = 1;
	end

	local target = tabList[index];
	_G[target]:SetFocus();
end

function EditBox_SetFocus (self)
	self:SetFocus();
end

function InputBoxInstructions_OnTextChanged(self)
	self.Instructions:SetShown(self:GetText() == "")
end

function InputBoxInstructions_UpdateColorForEnabledState(self, color)
	if color then
		self:SetTextColor(color:GetRGBA());
	end
end

function InputBoxInstructions_OnDisable(self)
	InputBoxInstructions_UpdateColorForEnabledState(self, self.disabledColor);
end

function InputBoxInstructions_OnEnable(self)
	InputBoxInstructions_UpdateColorForEnabledState(self, self.enabledColor);
end

function SearchBoxTemplate_OnLoad(self)
	self.searchIcon:SetVertexColor(0.6, 0.6, 0.6);
	self:SetTextInsets(16, 20, 0, 0);
	self.Instructions:SetText(SEARCH);
	self.Instructions:ClearAllPoints();
	self.Instructions:SetPoint("TOPLEFT", self, "TOPLEFT", 16, 0);
	self.Instructions:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -20, 0);
end

function SearchBoxTemplate_OnEditFocusLost(self)
	if ( self:GetText() == "" ) then
		self.searchIcon:SetVertexColor(0.6, 0.6, 0.6);
		self.clearButton:Hide();
	end
end

function SearchBoxTemplate_OnEditFocusGained(self)
	self.searchIcon:SetVertexColor(1.0, 1.0, 1.0);
	self.clearButton:Show();
end

function SearchBoxTemplate_OnTextChanged(self)
	if ( not self:HasFocus() and self:GetText() == "" ) then
		self.searchIcon:SetVertexColor(0.6, 0.6, 0.6);
		self.clearButton:Hide();
	else
		self.searchIcon:SetVertexColor(1.0, 1.0, 1.0);
		self.clearButton:Show();
	end
	InputBoxInstructions_OnTextChanged(self);
end

function SearchBoxTemplate_ClearText(self)
	self:SetText("");
	self:ClearFocus();
end

function SearchBoxTemplateClearButton_OnClick(self)
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
	local editBox = self:GetParent();
	editBox:SetText("");
	editBox:ClearFocus();
end

PanelTabButtonMixin = {};

function PanelTabButtonMixin:OnLoad()
	self:SetFrameLevel(self:GetFrameLevel() + 4);
	self:RegisterEvent("DISPLAY_SIZE_CHANGED");
end

function PanelTabButtonMixin:OnEvent(event, ...)
	if self:IsVisible() then
		PanelTemplates_TabResize(self, self:GetParent().tabPadding, nil, self:GetParent().minTabWidth, self:GetParent().maxTabWidth);
	end
end

function PanelTabButtonMixin:OnShow()
	PanelTemplates_TabResize(self, self:GetParent().tabPadding, nil, self:GetParent().minTabWidth, self:GetParent().maxTabWidth);
end

function PanelTabButtonMixin:OnEnter()
	if self.Text:IsTruncated() then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
		GameTooltip:SetText(self.Text:GetText());
	end
end

function PanelTabButtonMixin:OnLeave()
	GameTooltip_Hide();
end

PanelTopTabButtonMixin = {};

local TOP_TAB_HEIGHT_PERCENT = 0.75;
local TOP_TAB_BOTTOM_TEX_COORD = 1 - TOP_TAB_HEIGHT_PERCENT;

function PanelTopTabButtonMixin:OnLoad()
	PanelTabButtonMixin.OnLoad(self);

	for _, tabTexture in ipairs(self.TabTextures) do
		tabTexture:SetTexCoord(0, 1, 1, TOP_TAB_BOTTOM_TEX_COORD);
		tabTexture:SetHeight(tabTexture:GetHeight() * TOP_TAB_HEIGHT_PERCENT);
	end

	self.Left:ClearAllPoints();
	self.Left:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", -3, 0);
	self.Right:ClearAllPoints();
	self.Right:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 7, 0);

	self.LeftActive:ClearAllPoints();
	self.LeftActive:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", -1, 0);
	self.RightActive:ClearAllPoints();
	self.RightActive:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 8, 0);

	self.isTopTab = true;
end

-- functions to manage tab interfaces where only one tab of a group may be selected
function PanelTemplates_Tab_OnClick(self, frame)
	PanelTemplates_SetTab(frame, self:GetID())
end

function PanelTemplates_SetTab(frame, id)
	frame.selectedTab = id;
	PanelTemplates_UpdateTabs(frame);
end

function PanelTemplates_SetTabEnabled(frame, index, enabled)
	if (enabled) then
		PanelTemplates_EnableTab(frame, index);
	else
		PanelTemplates_DisableTab(frame, index);
	end
end

function PanelTemplates_GetSelectedTab(frame)
	return frame.selectedTab;
end

local function GetTabByIndex(frame, index)
	return frame.Tabs and frame.Tabs[index] or _G[frame:GetName().."Tab"..index];
end

function PanelTemplates_UpdateTabs(frame)
	if ( frame.selectedTab ) then
		local tab;
		for i=1, frame.numTabs, 1 do
			tab = GetTabByIndex(frame, i);
			if ( tab.isDisabled ) then
				PanelTemplates_SetDisabledTabState(tab);
			elseif ( i == frame.selectedTab ) then
				PanelTemplates_SelectTab(tab);
			else
				PanelTemplates_DeselectTab(tab);
			end
		end
	end
end

function PanelTemplates_GetTabWidth(tab)
	local tabName = tab:GetName();

	local sideWidths = 2 * _G[tabName.."Left"]:GetWidth();
	return tab:GetTextWidth() + sideWidths;
end

function PanelTemplates_TabResize(tab, padding, absoluteSize, minWidth, maxWidth, absoluteTextSize)
	local tabName = tab:GetName();

	local buttonMiddle = tab.Middle or tab.middleTexture or _G[tabName.."Middle"];
	local buttonMiddleDisabled = tab.MiddleDisabled or (tabName and _G[tabName.."MiddleDisabled"]);
	local left = tab.Left or tab.leftTexture or _G[tabName.."Left"];
	local sideWidths = 2 * left:GetWidth();
	local tabText = tab.Text or _G[tab:GetName().."Text"];
	local highlightTexture = tab.HighlightTexture or (tabName and _G[tabName.."HighlightTexture"]);

	local width, tabWidth;
	local textWidth;
	if ( absoluteTextSize ) then
		textWidth = absoluteTextSize;
	else
		tabText:SetWidth(0);
		textWidth = tabText:GetWidth();
	end
	-- If there's an absolute size specified then use it
	if ( absoluteSize ) then
		if ( absoluteSize < sideWidths) then
			width = 1;
			tabWidth = sideWidths
		else
			width = absoluteSize - sideWidths;
			tabWidth = absoluteSize
		end
		tabText:SetWidth(width);
	else
		-- Otherwise try to use padding
		if ( padding ) then
			width = textWidth + padding;
		else
			width = textWidth + 24;
		end
		-- If greater than the maxWidth then cap it
		if ( maxWidth and width > maxWidth ) then
			if ( padding ) then
				width = maxWidth + padding;
			else
				width = maxWidth + 24;
			end
			tabText:SetWidth(width);
		else
			tabText:SetWidth(0);
		end
		if (minWidth and width < minWidth) then
			width = minWidth;
		end
		tabWidth = width + sideWidths;
	end

	if ( buttonMiddle ) then
		buttonMiddle:SetWidth(width);
	end
	if ( buttonMiddleDisabled ) then
		buttonMiddleDisabled:SetWidth(width);
	end

	tab:SetWidth(tabWidth);

	if ( highlightTexture ) then
		highlightTexture:SetWidth(tabWidth);
	end
end

function PanelTemplates_ResizeTabsToFit(frame, maxWidthForAllTabs)
	local selectedIndex = PanelTemplates_GetSelectedTab(frame);
	if ( not selectedIndex ) then
		return;
	end

	local currentWidth = 0;
	local truncatedText = false;
	for i = 1, frame.numTabs do
		local tab = GetTabByIndex(frame, i);
		currentWidth = currentWidth + tab:GetWidth();
		if tab.Text:IsTruncated() then
			truncatedText = true;
		end
	end
	if ( not truncatedText and currentWidth <= maxWidthForAllTabs ) then
		return;
	end

	local currentTab = GetTabByIndex(frame, selectedIndex);
	PanelTemplates_TabResize(currentTab, 0);
	local availableWidth = maxWidthForAllTabs - currentTab:GetWidth();
	local widthPerTab = availableWidth / (frame.numTabs - 1);
	for i = 1, frame.numTabs do
		if ( i ~= selectedIndex ) then
			local tab = GetTabByIndex(frame, i);
			PanelTemplates_TabResize(tab, 0, widthPerTab);
		end
	end
end

function PanelTemplates_SetNumTabs(frame, numTabs)
	frame.numTabs = numTabs;
end

function PanelTemplates_DisableTab(frame, index)
	GetTabByIndex(frame, index).isDisabled = 1;
	PanelTemplates_UpdateTabs(frame);
end

function PanelTemplates_EnableTab(frame, index)
	local tab = GetTabByIndex(frame, index);
	tab.isDisabled = nil;
	-- Reset text color
	tab:SetDisabledFontObject(GameFontHighlightSmall);
	PanelTemplates_UpdateTabs(frame);
end

function PanelTemplates_HideTab(frame, index)
	local tab = GetTabByIndex(frame, index);
	tab:Hide();
end

function PanelTemplates_ShowTab(frame, index)
	local tab = GetTabByIndex(frame, index);
	tab:Show();
end

function PanelTemplates_DeselectTab(tab)
	local name = tab:GetName();

	local left = tab.Left or _G[name.."Left"];
	local middle = tab.Middle or _G[name.."Middle"];
	local right = tab.Right or _G[name.."Right"];
	left:Show();
	middle:Show();
	right:Show();
	--tab:UnlockHighlight();
	tab:Enable();
	local text = tab.Text or _G[name.."Text"];
	text:SetPoint("CENTER", tab, "CENTER", (tab.deselectedTextX or 0), (tab.deselectedTextY or 2));

	local leftDisabled = tab.LeftDisabled or _G[name.."LeftDisabled"];
	local middleDisabled = tab.MiddleDisabled or _G[name.."MiddleDisabled"];
	local rightDisabled = tab.RightDisabled or _G[name.."RightDisabled"];
	if leftDisabled then leftDisabled:Hide(); end
	if middleDisabled then middleDisabled:Hide(); end
	if rightDisabled then rightDisabled:Hide(); end
end

function PanelTemplates_SelectTab(tab)
	local name = tab:GetName();

	local left = tab.Left or _G[name.."Left"];
	local middle = tab.Middle or _G[name.."Middle"];
	local right = tab.Right or _G[name.."Right"];
	left:Hide();
	middle:Hide();
	right:Hide();
	--tab:LockHighlight();
	tab:Disable();
	tab:SetDisabledFontObject(GameFontHighlightSmall);
	local text = tab.Text or _G[name.."Text"];
	text:SetPoint("CENTER", tab, "CENTER", (tab.selectedTextX or 0), (tab.selectedTextY or -3));

	local leftDisabled = tab.LeftDisabled or _G[name.."LeftDisabled"];
	local middleDisabled = tab.MiddleDisabled or _G[name.."MiddleDisabled"];
	local rightDisabled = tab.RightDisabled or _G[name.."RightDisabled"];
	if leftDisabled then leftDisabled:Show(); end
	if middleDisabled then middleDisabled:Show(); end
	if rightDisabled then rightDisabled:Show(); end

	local tooltip = GetAppropriateTooltip();
	if tooltip:IsOwned(tab) then
		tooltip:Hide();
	end
end

function PanelTemplates_SetDisabledTabState(tab)
	local name = tab:GetName();
	local left = tab.Left or _G[name.."Left"];
	local middle = tab.Middle or _G[name.."Middle"];
	local right = tab.Right or _G[name.."Right"];
	left:Show();
	middle:Show();
	right:Show();
	--tab:UnlockHighlight();
	tab:Disable();
	tab.text = tab:GetText();
	-- Gray out text
	tab:SetDisabledFontObject(GameFontDisableSmall);
	local leftDisabled = tab.LeftDisabled or _G[name.."LeftDisabled"];
	local middleDisabled = tab.MiddleDisabled or _G[name.."MiddleDisabled"];
	local rightDisabled = tab.RightDisabled or _G[name.."RightDisabled"];
	if leftDisabled then leftDisabled:Hide(); end
	if middleDisabled then middleDisabled:Hide(); end
	if rightDisabled then rightDisabled:Hide(); end
end

-- NOTE: If your edit box never shows partial lines of text, then this function will not work when you use
-- your mouse to move the edit cursor. You need the edit box to cut lines of text so that you can use your
-- mouse to highlight those partially-seen lines; otherwise you won't be able to use the mouse to move the
-- cursor above or below the current scroll area of the edit box.
function ScrollingEdit_OnUpdate(self, elapsed, scrollFrame)
	local height, range, scroll, cursorOffset;
	if ( self.handleCursorChange ) then
		if ( not scrollFrame ) then
			scrollFrame = self:GetParent();
		end
		height = scrollFrame:GetHeight();
		range = scrollFrame:GetVerticalScrollRange();
		scroll = scrollFrame:GetVerticalScroll();
		cursorOffset = -self.cursorOffset;

		if ( math.floor(height) <= 0 or math.floor(range) <= 0 ) then
			--Frame has no area, nothing to calculate.
			return;
		end

		while ( cursorOffset < scroll ) do
			scroll = (scroll - (height / 2));
			if ( scroll < 0 ) then
				scroll = 0;
			end
			scrollFrame:SetVerticalScroll(scroll);
		end

		while ( (cursorOffset + self.cursorHeight) > (scroll + height) and scroll < range ) do
			scroll = (scroll + (height / 2));
			if ( scroll > range ) then
				scroll = range;
			end
			scrollFrame:SetVerticalScroll(scroll);
		end

		self.handleCursorChange = false;
	end
end

function ScrollingEdit_OnTextChanged(self, scrollFrame)
	-- force an update when the text changes
	self.handleCursorChange = true;
	ScrollingEdit_OnUpdate(self, 0, scrollFrame);
end

function ScrollingEdit_OnLoad(self)
	ScrollingEdit_SetCursorOffsets(self, 0, 0);
end

function ScrollingEdit_SetCursorOffsets(self, offset, height)
	self.cursorOffset = offset;
	self.cursorHeight = height;
end

function ScrollingEdit_OnCursorChanged(self, x, y, w, h)
	ScrollingEdit_SetCursorOffsets(self, y, h);
	self.handleCursorChange = true;
end

NumericInputSpinnerMixin = {};

-- "public"
function NumericInputSpinnerMixin:SetValue(value)
	local newValue = Clamp(value, self.min or -math.huge, self.max or math.huge);
	if newValue ~= self.currentValue then
		self.currentValue = newValue;
		self:SetNumber(newValue);

		if self.onValueChangedCallback then
			self.onValueChangedCallback(self, self:GetNumber());
		end
	end
end

function NumericInputSpinnerMixin:SetMinMaxValues(min, max)
	if self.min ~= min or self.max ~= max then
		self.min = min;
		self.max = max;

		self:SetValue(self:GetValue());
	end
end

function NumericInputSpinnerMixin:GetValue()
	return self.currentValue or self.min or 0;
end

function NumericInputSpinnerMixin:SetOnValueChangedCallback(onValueChangedCallback)
	self.onValueChangedCallback = onValueChangedCallback;
end

function NumericInputSpinnerMixin:Increment(amount)
	self:SetValue(self:GetValue() + (amount or 1));
end

function NumericInputSpinnerMixin:Decrement(amount)
	self:SetValue(self:GetValue() - (amount or 1));
end

function NumericInputSpinnerMixin:SetEnabled(enable)
	self.IncrementButton:SetEnabled(enable);
	self.DecrementButton:SetEnabled(enable);
	getmetatable(self).__index.SetEnabled(self, enable);
end

function NumericInputSpinnerMixin:Enable()
	self:SetEnabled(true)
end

function NumericInputSpinnerMixin:Disable()
	self:SetEnabled(false)
end

-- "private"
function NumericInputSpinnerMixin:OnTextChanged()
	self:SetValue(self:GetNumber());
end

local MAX_TIME_BETWEEN_CHANGES_SEC = .5;
local MIN_TIME_BETWEEN_CHANGES_SEC = .075;
local TIME_TO_REACH_MAX_SEC = 3;

function NumericInputSpinnerMixin:StartIncrement()
	self.incrementing = true;
	self.startTime = GetTime();
	self.nextUpdate = MAX_TIME_BETWEEN_CHANGES_SEC;
	self:SetScript("OnUpdate", self.OnUpdate);
	self:Increment();
	self:ClearFocus();
end

function NumericInputSpinnerMixin:EndIncrement()
	self:SetScript("OnUpdate", nil);
end

function NumericInputSpinnerMixin:StartDecrement()
	self.incrementing = false;
	self.startTime = GetTime();
	self.nextUpdate = MAX_TIME_BETWEEN_CHANGES_SEC;
	self:SetScript("OnUpdate", self.OnUpdate);
	self:Decrement();
	self:ClearFocus();
end

function NumericInputSpinnerMixin:EndDecrement()
	self:SetScript("OnUpdate", nil);
end

function NumericInputSpinnerMixin:OnUpdate(elapsed)
	self.nextUpdate = self.nextUpdate - elapsed;
	if self.nextUpdate <= 0 then
		if self.incrementing then
			self:Increment();
		else
			self:Decrement();
		end

		local totalElapsed = GetTime() - self.startTime;

		local nextUpdateDelta = Lerp(MAX_TIME_BETWEEN_CHANGES_SEC, MIN_TIME_BETWEEN_CHANGES_SEC, Saturate(totalElapsed / TIME_TO_REACH_MAX_SEC));
		self.nextUpdate = self.nextUpdate + nextUpdateDelta;
	end
end

MaximizeMinimizeButtonFrameMixin = {};

function MaximizeMinimizeButtonFrameMixin:OnShow()
	if self.cvar then
		local minimized = GetCVarBool(self.cvar);
		if minimized then
			self:Minimize();
		else
			self:Maximize();
		end
	end
end

function MaximizeMinimizeButtonFrameMixin:SetMinimizedCVar(cvar)
	self.cvar = cvar;
end

function MaximizeMinimizeButtonFrameMixin:SetOnMaximizedCallback(maximizedCallback)
	self.maximizedCallback = maximizedCallback;
end

function MaximizeMinimizeButtonFrameMixin:Maximize()
	if self.maximizedCallback then
		self.maximizedCallback(self);
	end

	if self.cvar then
		SetCVar(self.cvar, 0);
	end

	self.MaximizeButton:Hide();
	self.MinimizeButton:Show();
end

function MaximizeMinimizeButtonFrameMixin:SetOnMinimizedCallback(minimizedCallback)
	self.minimizedCallback = minimizedCallback;
end

function MaximizeMinimizeButtonFrameMixin:Minimize()
	if self.minimizedCallback then
		self.minimizedCallback(self);
	end

	if self.cvar then
		SetCVar(self.cvar, 1);
	end

	self.MaximizeButton:Show();
	self.MinimizeButton:Hide();
end

PortraitFrameTemplateMixin = {}

function PortraitFrameTemplateMixin:OnLoad()

	local use2XFrameTextures = GetCVarBool("useHighResolutionUITextures");
	if (use2XFrameTextures) then
		self.PortraitFrame:SetAtlas("UI-Frame-Portrait-2x");
		self.TopRightCorner:SetAtlas("UI-Frame-TopCornerRight-2x");

		self.TopBorder:SetAtlas("_UI-Frame-TittleTile2x");

		self.BotLeftCorner:SetAtlas("UI-Frame-BotCornerLeft-2x");
		self.BotRightCorner:SetAtlas("UI-Frame-BotCornerRight-2x");

		self.BottomBorder:SetAtlas("_UI-Frame-Bot2x");
		self.LeftBorder:SetAtlas("!UI-Frame-LeftTile2x");
		self.RightBorder:SetAtlas("!UI-Frame-RightTile2x");
	end
end

function PortraitFrameTemplateMixin:GetTitleText()
	return self.TitleText;
end

function PortraitFrameTemplateMixin:SetTitle(title)
	self:GetTitleText():SetText(title);
end

function PortraitFrameTemplateMixin:SetTitleFormatted(fmt, ...)
	self:GetTitleText():SetFormattedText(fmt, ...);
end

-- Truncated Button code

function TruncatedButton_OnSizeChanged(self, width, height)
	self.Text:SetWidth(width - 5);
	self.Text:SetHeight(height);
end

function TruncatedButton_OnEnter(self)
	if self.Text:IsTruncated() then
		local tooltip = GetAppropriateTooltip();
		tooltip:SetOwner(self, "ANCHOR_RIGHT");
		tooltip:SetText(self.Text:GetText());
		tooltip:Show();
	end
end

function TruncatedButton_OnLeave(self)
	local tooltip = GetAppropriateTooltip();
	if tooltip:GetOwner() == self then
		tooltip:Hide();
	end
end

-- Truncated Tooltip Script code

function TruncatedTooltipScript_OnEnter(self)
	local text = self.truncatedTooltipScriptText or self.Text;
	if text:IsTruncated() then
		local tooltip = GetAppropriateTooltip();
		tooltip:SetOwner(self, "ANCHOR_RIGHT");
		tooltip:SetText(text:GetText());
		tooltip:Show();
	end
end

function TruncatedTooltipScript_OnLeave(self)
	local tooltip = GetAppropriateTooltip();
	if tooltip:GetOwner() == self then
		tooltip:Hide();
	end
end

function GetAppropriateTopLevelParent()
	return UIParent or GlueParent;
end

function SetAppropriateTopLevelParent(frame)
	local parent = GetAppropriateTopLevelParent();
	if parent then
		frame:SetParent(parent);
	end
end

function GetAppropriateTooltip()
	return UIParent and GameTooltip or GlueTooltip;
end

ColumnDisplayMixin = {};

function ColumnDisplayMixin:OnLoad()
	self.columnHeaders = CreateFramePool("BUTTON", self, "ColumnDisplayButtonTemplate");
end

--[[
The layout of your column display might look something like:
local FOO_COLUMN_INFO = {
	[1] = {
		title = FOO_COLUMN_xxx_TITLE,
		width = 60,
	},

	...

	[5] = {
		title = FOO_COLUMN_xxxxx_TITLE,
		width = 0,
	},
};
--]]

function ColumnDisplayMixin:LayoutColumns(columnInfo, extraColumnInfo)
	self.columnHeaders:ReleaseAll();

	local extraHeader = nil;
	if extraColumnInfo then
		extraHeader = self.columnHeaders:Acquire();
		extraHeader:SetText(extraColumnInfo.title);
		extraHeader:SetWidth(extraColumnInfo.width);
		extraHeader:SetPoint("BOTTOMRIGHT", -28, 1);
		extraHeader:SetID(#columnInfo + 1);
		extraHeader:Show();
	end

	local previousHeader = nil;
	for i, info in ipairs(columnInfo) do
		local header = self.columnHeaders:Acquire();
		header:SetText(info.title);
		header:SetWidth(info.width);
		header:SetID(i);
		if i == 1 then
			header:SetPoint("BOTTOMLEFT", 2, 1);
			if #columnInfo == 1 then
				header:SetPoint("BOTTOMRIGHT");
			end
		else
			header:SetPoint("BOTTOMLEFT", previousHeader, "BOTTOMRIGHT", -2, 0);

			if i == #columnInfo and info.width == 0 then
				if extraHeader then
					header:SetPoint("BOTTOMRIGHT", extraHeader, "BOTTOMLEFT", 2, 0);
				else
					header:SetPoint("BOTTOMRIGHT", -28, 1);
				end
			end
		end

		header:Show();
		previousHeader = header;
	end
end

function ColumnDisplayMixin:OnClick(columnIndex)
	if self.sortingFunction then
		self.sortingFunction(self, columnIndex);
	end
end

function ColumnDisplayButton_OnClick(self)
	self:GetParent():OnClick(self:GetID());
end


UIMenuButtonStretchMixin = {}

function UIMenuButtonStretchMixin:SetTextures(texture)
	self.TopLeft:SetTexture(texture);
	self.TopRight:SetTexture(texture);
	self.BottomLeft:SetTexture(texture);
	self.BottomRight:SetTexture(texture);
	self.TopMiddle:SetTexture(texture);
	self.MiddleLeft:SetTexture(texture);
	self.MiddleRight:SetTexture(texture);
	self.BottomMiddle:SetTexture(texture);
	self.MiddleMiddle:SetTexture(texture);
end

function UIMenuButtonStretchMixin:OnMouseDown(button)
	if ( self:IsEnabled() ) then
		self:SetTextures("Interface\\Buttons\\UI-Silver-Button-Down");
		if ( self.Icon ) then
			if ( not self.Icon.oldPoint ) then
				local point, relativeTo, relativePoint, x, y = self.Icon:GetPoint(1);
				self.Icon.oldPoint = point;
				self.Icon.oldX = x;
				self.Icon.oldY = y;
			end
			self.Icon:SetPoint(self.Icon.oldPoint, self.Icon.oldX + 1, self.Icon.oldY - 1);
		end
	end
end

function UIMenuButtonStretchMixin:OnMouseUp(button)
	if ( self:IsEnabled() ) then
		self:SetTextures("Interface\\Buttons\\UI-Silver-Button-Up");
		if ( self.Icon ) then
			self.Icon:SetPoint(self.Icon.oldPoint, self.Icon.oldX, self.Icon.oldY);
		end
	end
end

function UIMenuButtonStretchMixin:OnShow()
	-- we need to reset our textures just in case we were hidden before a mouse up fired
	self:SetTextures("Interface\\Buttons\\UI-Silver-Button-Up");
end

function UIMenuButtonStretchMixin:OnEnable()
	self:SetTextures("Interface\\Buttons\\UI-Silver-Button-Up");
end

function UIMenuButtonStretchMixin:OnEnter()
	if(self.tooltipText ~= nil) then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
		GameTooltip_SetTitle(GameTooltip, self.tooltipText);
		GameTooltip:Show();
	end
end

function UIMenuButtonStretchMixin:OnLeave()
	if(self.tooltipText ~= nil) then
		GameTooltip:Hide();
	end
end

DialogHeaderMixin = {};

function DialogHeaderMixin:OnLoad()
	if self.textString then
		self:Setup(self.textString);
	end
end

function DialogHeaderMixin:Setup(text)
	self.Text:SetText(text);
	self:SetWidth(self.Text:GetWidth() + self.headerTextPadding);
end

SelectionPopoutWithButtonsMixin = {};

function SelectionPopoutWithButtonsMixin:OnLoad()
	local xOffset = self.incrementOffsetX or 4;
	self.IncrementButton:SetPoint("LEFT", self.Button, "RIGHT", xOffset, 0);
	self.IncrementButton:SetScript("OnClick", GenerateClosure(self.OnIncrementClicked, self));

	xOffset = self.decrementOffsetX or -5;
	self.DecrementButton:SetPoint("RIGHT", self.Button, "LEFT", xOffset, 0);
	self.DecrementButton:SetScript("OnClick", GenerateClosure(self.OnDecrementClicked, self));
end

function SelectionPopoutWithButtonsMixin:SetEnabled_(enabled)
	self.Button:SetEnabled_(enabled);
	self:UpdateButtons();
end

function SelectionPopoutWithButtonsMixin:OnIncrementClicked(button, buttonName, down)
	self.Button:Increment();
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
end

function SelectionPopoutWithButtonsMixin:OnDecrementClicked(button, buttonName, down)
	self.Button:Decrement();
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
end

function SelectionPopoutWithButtonsMixin:SetupSelections(selections, selectedIndex, label)
	local result = self.Button:SetupSelections(selections, selectedIndex);
	self:UpdateButtons();
	return result;
end

function SelectionPopoutWithButtonsMixin:OnEnter()
end

function SelectionPopoutWithButtonsMixin:OnLeave()
end

function SelectionPopoutWithButtonsMixin:Increment()
	self.Button:Increment();
end

function SelectionPopoutWithButtonsMixin:Decrement()
	self.Button:Decrement();
end

function SelectionPopoutWithButtonsMixin:OnPopoutShown()
end

function SelectionPopoutWithButtonsMixin:HidePopout()
	self.Button:HidePopout();
end

function SelectionPopoutWithButtonsMixin:OnEntrySelected(entryData)
end

function SelectionPopoutWithButtonsMixin:GetTooltipText()
	return self.Button:GetTooltipText();
end

function SelectionPopoutWithButtonsMixin:OnEntryMouseEnter(entry)
end

function SelectionPopoutWithButtonsMixin:OnEntryMouseLeave(entry)
end

function SelectionPopoutWithButtonsMixin:GetMaxPopoutHeight()
end

function SelectionPopoutWithButtonsMixin:UpdateButtons()
	local enabled = self.Button:IsEnabled();
	if enabled then
		local selections = self.Button:GetSelections()

		local forward = true;
		local index = self.Button:GetAdjustedIndex(forward, selections);
		self.IncrementButton:SetEnabled(index ~= nil);

		forward = false;
		index = self.Button:GetAdjustedIndex(forward, selections);
		self.DecrementButton:SetEnabled(index ~= nil);
	else
		self.IncrementButton:SetEnabled(false);
		self.DecrementButton:SetEnabled(false);
	end
end

SelectionPopoutWithButtonsAndLabelMixin = CreateFromMixins(SelectionPopoutWithButtonsMixin);

function SelectionPopoutWithButtonsAndLabelMixin:SetupSelections(selections, selectedIndex, label)
	SelectionPopoutWithButtonsMixin.SetupSelections(self, selections, selectedIndex);

	self.Label:SetText(label);
end

SelectionPopoutMixin = {};

function SelectionPopoutMixin:OnShow()
	self:Layout();
	self.logicalParent:OnPopoutShown();
	SelectionPopouts:Add(self);
end

function SelectionPopoutMixin:OnHide()
	SelectionPopouts:Remove(self);
end

SelectionPopoutEntryMixin = {};

function SelectionPopoutEntryMixin:OnLoad()
	self.parentButton = self:GetParent().logicalParent;
end

function SelectionPopoutEntryMixin:HandlesGlobalMouseEvent(buttonID, event)
	return event == "GLOBAL_MOUSE_DOWN" and buttonID == "LeftButton";
end

function SelectionPopoutEntryMixin:SetupEntry(selectionData, index, isSelected, multipleColumns, hasAFailedReq, hasALockedChoice)
	self.isSelected = isSelected;
	self.selectionData = selectionData;
	self.popoutHasAFailedReq = hasAFailedReq;
	self.popoutHasALockedChoice = hasALockedChoice;

	self.SelectionDetails:SetupDetails(selectionData, index, isSelected, hasAFailedReq, hasALockedChoice);
	self.SelectionDetails:AdjustWidth(multipleColumns, self.defaultWidth);
end

function SelectionPopoutEntryMixin:GetTooltipText()
	return self.SelectionDetails:GetTooltipText();
end

function SelectionPopoutEntryMixin:OnEnter()
	self.parentButton:OnEntryMouseEnter(self);
end

function SelectionPopoutEntryMixin:OnLeave()
	self.parentButton:OnEntryMouseLeave(self);
end

function SelectionPopoutEntryMixin:OnClick()
	self.parentButton:OnEntryClicked(self.selectionData);
end

SelectionPopouts = {};

function SelectionPopouts:OnLoad()
	self.popouts = {};
end

function SelectionPopouts:ContainsMouse()
	for index, popout in ipairs(self.popouts) do
		if popout:IsShown() and popout:IsMouseOver() then
			return true;
		end
	end
	return false;
end

function SelectionPopouts:CloseAll()
	local shallow = true;
	local popoutsCopy = CopyTable(self.popouts, shallow);
	wipe(self.popouts);

	for index, popout in ipairs(popoutsCopy) do
		popout.logicalParent:HidePopout();
	end
end

function SelectionPopouts:HandleGlobalMouseEvent(buttonID, event)
	if event == "GLOBAL_MOUSE_DOWN" and (buttonID == "LeftButton" or buttonID == "RightButton") then
		if not self:ContainsMouse() then
			self:CloseAll();
		end
	end
end

function SelectionPopouts:Add(popout)
	table.insert(self.popouts, popout);
end

function SelectionPopouts:Remove(popout)
	tDeleteItem(self.popouts, popout);
end

SelectionPopouts:OnLoad();

DefaultScaleFrameMixin = {};

function DefaultScaleFrameMixin:OnDefaultScaleFrameLoad()
	self:RegisterEvent("DISPLAY_SIZE_CHANGED");
	self:UpdateScale();
end

function DefaultScaleFrameMixin:OnDefaultScaleFrameEvent(event, ...)
	if event == "DISPLAY_SIZE_CHANGED" then
		self:UpdateScale();
	end
end

function DefaultScaleFrameMixin:UpdateScale()
	ApplyDefaultScale(self, self.minScale, self.maxScale);
end

UIButtonMixin = {}

function UIButtonMixin:OnClick(...)
	PlaySound(self.onClickSoundKit or SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);

	if self.onClickHandler then
		self.onClickHandler(self, ...);
	end
end

function UIButtonMixin:OnEnter()
	if self.onEnterHandler and self.onEnterHandler(self) then
		return;
	end

	local defaultTooltipAnchor = "ANCHOR_RIGHT";
	if self:IsEnabled() then
		if self.tooltipTitle or self.tooltipText then
			local tooltip = GetAppropriateTooltip();
			tooltip:SetOwner(self, self.tooltipAnchor or defaultTooltipAnchor, self.tooltipOffsetX, self.tooltipOffsetY);

			if self.tooltipTitle then
				GameTooltip_SetTitle(tooltip, self.tooltipTitle, self.tooltipTitleColor);
			end

			if self.tooltipText then
				local wrap = true;
				GameTooltip_AddColoredLine(tooltip, self.tooltipText, self.tooltipTextColor or NORMAL_FONT_COLOR, wrap);
			end

			tooltip:Show();
		end
	else
		if self.disabledTooltip then
			local tooltip = GetAppropriateTooltip();
			GameTooltip_ShowDisabledTooltip(tooltip, self, self.disabledTooltip, self.disabledTooltipAnchor or defaultTooltipAnchor, self.disabledTooltipOffsetX, self.disabledTooltipOffsetY);
		end
	end
end

function UIButtonMixin:OnLeave()
	local tooltip = GetAppropriateTooltip();
	tooltip:Hide();
end

function UIButtonMixin:SetOnClickHandler(onClickHandler, onClickSoundKit)
	self.onClickHandler = onClickHandler;
	self.onClickSoundKit = onClickSoundKit;
end

function UIButtonMixin:SetOnEnterHandler(onEnterHandler)
	self.onEnterHandler = onEnterHandler;
end

function UIButtonMixin:SetTooltipInfo(tooltipTitle, tooltipText)
	self.tooltipTitle = tooltipTitle;
	self.tooltipText = tooltipText;
end

function UIButtonMixin:SetTooltipAnchor(tooltipAnchor, tooltipOffsetX, tooltipOffsetY)
	self.tooltipAnchor = tooltipAnchor;
	self.tooltipOffsetX = tooltipOffsetX;
	self.tooltipOffsetY = tooltipOffsetY;
end

function UIButtonMixin:SetDisabledTooltip(disabledTooltip, disabledTooltipAnchor, disabledTooltipOffsetX, disabledTooltipOffsetY)
	self.disabledTooltip = disabledTooltip;
	self.disabledTooltipAnchor = disabledTooltipAnchor;
	self.disabledTooltipOffsetX = disabledTooltipOffsetX;
	self.disabledTooltipOffsetY = disabledTooltipOffsetY;
	self:SetMotionScriptsWhileDisabled(disabledTooltip ~= nil);
end

IconButtonMixin = CreateFromMixins(UIButtonMixin);

function IconButtonMixin:OnLoad()
	if self.icon then
		self:SetIcon(self.icon);
	elseif self.iconAtlas then
		self:SetAtlas(self.iconAtlas, self.useAtlasSize);
	end

	if self.useIconAsHighlight then
		if self.icon then
			self:SetHighlightTexture(self.icon, "ADD");
		elseif self.iconAtlas then
			self:SetHighlightAtlas(self.iconAtlas, "ADD");
		end

		local highlightTexture = self:GetHighlightTexture();
		highlightTexture:SetPoint("TOPLEFT", self.Icon, "TOPLEFT");
		highlightTexture:SetPoint("BOTTOMRIGHT", self.Icon, "BOTTOMRIGHT");
	end

	if self.iconSize then
		self.Icon:SetSize(self.iconSize, self.iconSize);
	elseif self.iconWidth then
		self.Icon:SetSize(self.iconWidth, self.iconHeight);
	end
end

function IconButtonMixin:OnMouseDown()
	if self:IsEnabled() then
		self.Icon:SetPoint("CENTER", self, "CENTER", 1, -1);
	end
end

function IconButtonMixin:OnMouseUp()
	self.Icon:SetPoint("CENTER", self, "CENTER");
end

function IconButtonMixin:SetIcon(icon)
	self.Icon:SetTexture(icon);
end

function IconButtonMixin:SetAtlas(atlas, useAtlasSize)
	self.Icon:SetAtlas(atlas, useAtlasSize);
end

function IconButtonMixin:SetEnabledState(enabled)
	self:SetEnabled(enabled);
	self.Icon:SetDesaturated(not enabled);
end

SquareIconButtonMixin = CreateFromMixins(IconButtonMixin);

function SquareIconButtonMixin:OnMouseDown()
	-- Overrides IconButtonMixin.

	if self:IsEnabled() then
		-- Square icon button template still uses down-to-the-left depress behavior to match the existing art.
		self.Icon:SetPoint("CENTER", self, "CENTER", -2, -1);
	end
end

function SquareIconButtonMixin:OnMouseUp()
	-- Overrides IconButtonMixin.

	self.Icon:SetPoint("CENTER", self, "CENTER", -1, 0);
end

SelectionPopoutButtonMixin = CreateFromMixins(CallbackRegistryMixin, EventButtonMixin);
SelectionPopoutButtonMixin:GenerateCallbackEvents(
	{
		"OnValueChanged",
	}
);

function SelectionPopoutButtonMixin:OnLoad()
	CallbackRegistryMixin.OnLoad(self);

	self.parent = self:GetParent();

	if self.SelectionDetails then
		self.SelectionDetails:SetFrameLevel(self:GetFrameLevel());
	end

	self.Popout.logicalParent = self;

	if IsOnGlueScreen() then
		self.Popout:SetParent(GlueParent);
		self.Popout:SetFrameStrata("FULLSCREEN_DIALOG");
		self.Popout:SetToplevel(true);
		self.Popout:SetScale(self:GetEffectiveScale());
	elseif not DoesAncestryInclude(BarberShopFrame, self) then
		self.Popout:SetParent(UIParent);
		self.Popout:SetFrameStrata("FULLSCREEN_DIALOG");
		self.Popout:SetToplevel(true);
	end

	self.buttonPool = CreateFramePool("BUTTON", self.Popout, self.selectionEntryTemplates);
	self.initialAnchor = AnchorUtil.CreateAnchor("TOPLEFT", self.Popout, "TOPLEFT", 6, -12);
end

function SelectionPopoutButtonMixin:HandlesGlobalMouseEvent(buttonID, event)
	return event == "GLOBAL_MOUSE_DOWN" and buttonID == "LeftButton";
end

function SelectionPopoutButtonMixin:OnEnter()
	if self.parent.OnEnter then
		self.parent:OnEnter();
	end
	if not self.Popout:IsShown() then
		self.NormalTexture:SetAtlas("charactercreate-customize-dropdownbox-hover");
	end
end

function SelectionPopoutButtonMixin:OnLeave()
	if self.parent.OnLeave then
		self.parent:OnLeave();
	end
	if not self.Popout:IsShown() then
		self.NormalTexture:SetAtlas("charactercreate-customize-dropdownbox");
	end
end

function SelectionPopoutButtonMixin:SetEnabled_(enabled)
	self:SetEnabled(enabled);
end

function SelectionPopoutButtonMixin:OnPopoutShown()
	if self.parent.OnPopoutShown then
		self.parent:OnPopoutShown();
	end
end

function SelectionPopoutButtonMixin:OnHide()
	self:HidePopout();
end

function SelectionPopoutButtonMixin:HidePopout()
	self.Popout:Hide();

	if GetMouseFocus() == self then
		self.NormalTexture:SetAtlas("charactercreate-customize-dropdownbox-hover");
	else
		self.NormalTexture:SetAtlas("charactercreate-customize-dropdownbox");
	end

	self.HighlightTexture:SetAlpha(0);
end

function SelectionPopoutButtonMixin:ShowPopout()
	if self.popoutNeedsUpdate then
		self:UpdatePopout();
	end
	SelectionPopouts:CloseAll();

	self.Popout:Show();
	self.NormalTexture:SetAtlas("charactercreate-customize-dropdownbox-open");
	self.HighlightTexture:SetAlpha(0.2);
end

function SelectionPopoutButtonMixin:SetPopoutStrata(strata)
	self.Popout:SetFrameStrata(strata);
end

function SelectionPopoutButtonMixin:SetupSelections(selections, selectedIndex)
	self.selections = selections;
	self.selectedIndex = selectedIndex;

	if self.Popout:IsShown() then
		self:UpdatePopout();
	else
		self.popoutNeedsUpdate = true;
	end

	return self:UpdateButtonDetails();
end

local MAX_POPOUT_ENTRIES_FOR_1_COLUMN = 10;
local MAX_POPOUT_ENTRIES_FOR_2_COLUMNS = 24;
local MAX_POPOUT_ENTRIES_FOR_3_COLUMNS = 36;

local function getNumColumnsAndStride(numSelections, maxStride)
	local numColumns, stride;
	if numSelections > MAX_POPOUT_ENTRIES_FOR_3_COLUMNS then
		numColumns, stride = 4, math.ceil(numSelections / 4);
	elseif numSelections > MAX_POPOUT_ENTRIES_FOR_2_COLUMNS then
		numColumns, stride = 3, math.ceil(numSelections / 3);
	elseif numSelections > MAX_POPOUT_ENTRIES_FOR_1_COLUMN then
		numColumns, stride =  2, math.ceil(numSelections / 2);
	else
		numColumns, stride =  1, numSelections;
	end

	if maxStride and stride > maxStride then
		numColumns = math.ceil(numSelections / maxStride);
		stride = math.ceil(numSelections / numColumns);
	end

	return numColumns, stride;
end

function SelectionPopoutButtonMixin:GetMaxPopoutStride()
	local maxPopoutHeight = self.parent.GetMaxPopoutHeight and self.parent:GetMaxPopoutHeight() or nil;
	if maxPopoutHeight then
		local selectionHeight = 20;
		return math.floor(maxPopoutHeight / selectionHeight);
	end
end

function SelectionPopoutButtonMixin:UpdatePopout()
	self.buttonPool:ReleaseAll();

	local selections = self:GetSelections();
	local numColumns, stride = getNumColumnsAndStride(#selections, self:GetMaxPopoutStride());
	local buttons = {};

	local hasIneligibleChoice = false;
	local hasLockedChoice = false;
	for _, selectionData in ipairs(selections) do
		if selectionData.ineligibleChoice then
			hasIneligibleChoice = true;
		end
		if selectionData.isLocked then
			hasLockedChoice = true;
		end
	end

	local maxDetailsWidth = 0;
	for index, selectionInfo in ipairs(selections) do
		local button = self.buttonPool:Acquire();

		local isSelected = (index == self.selectedIndex);
		button:SetupEntry(selectionInfo, index, isSelected, numColumns > 1, hasIneligibleChoice, hasLockedChoice);
		maxDetailsWidth = math.max(maxDetailsWidth, button.SelectionDetails:GetWidth());

		table.insert(buttons, button);
	end

	for _, button in ipairs(buttons) do
		button.SelectionDetails:SetWidth(maxDetailsWidth);
		button:Layout();
		button:Show();
	end

	if stride ~= self.lastStride then
		self.layout = AnchorUtil.CreateGridLayout(GridLayoutMixin.Direction.TopLeftToBottomRightVertical, stride);
		self.lastStride = stride;
	end

	AnchorUtil.GridLayout(buttons, self.initialAnchor, self.layout);

	self.popoutNeedsUpdate = false;
end

function SelectionPopoutButtonMixin:GetSelections()
	return self.selections;
end

function SelectionPopoutButtonMixin:GetCurrentSelectedData()
	local selections = self:GetSelections();
	return selections[self.selectedIndex];
end

function SelectionPopoutButtonMixin:UpdateButtonDetails()
	if self.SelectionDetails then
		self.SelectionDetails:SetupDetails(self:GetCurrentSelectedData(), self.selectedIndex);
	end
end

function SelectionPopoutButtonMixin:GetTooltipText()
	if self.SelectionDetails then
		return self.SelectionDetails:GetTooltipText();
	end

	return nil;
end

function SelectionPopoutButtonMixin:TogglePopout()
	local showPopup = not self.Popout:IsShown();
	if showPopup then
		self:ShowPopout();
	else
		self:HidePopout();
	end
end

function SelectionPopoutButtonMixin:OnMouseWheel(delta)
	if delta > 0 then
		self:Increment();
	else
		self:Decrement();
	end
end

function SelectionPopoutButtonMixin:OnMouseDown()
	if self:IsEnabled() then
		self:TogglePopout();
		PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON);
	end
end

function SelectionPopoutButtonMixin:FindIndex(predicate)
	return FindInTableIf(self:GetSelections(), predicate);
end

function SelectionPopoutButtonMixin:IsDataMatch(data1, data2)
	return data1 == data2;
end

function SelectionPopoutButtonMixin:OnEntryClicked(entryData)
	if entryData.isLocked then
		return;
	end
	local newIndex = self:FindIndex(function(element)
		return self:IsDataMatch(element, entryData);
	end);
	self:SetSelectedIndex(newIndex);

	self:HidePopout();

	PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON);
end

function SelectionPopoutButtonMixin:Update()
	self:UpdateButtonDetails();
	self:UpdatePopout();

	if self.parent.UpdateButtons then
		self.parent:UpdateButtons();
	end
end

function SelectionPopoutButtonMixin:CallOnEntrySelected(entryData)
	if self.parent.OnEntrySelected then
		self.parent:OnEntrySelected(entryData);
	end
end

function SelectionPopoutButtonMixin:OnEntryMouseEnter(entry)
	if self.parent.OnEntryMouseEnter then
		self.parent:OnEntryMouseEnter(entry);
	end
end

function SelectionPopoutButtonMixin:OnEntryMouseLeave(entry)
	if self.parent.OnEntryMouseLeave then
		self.parent:OnEntryMouseLeave(entry);
	end
end

function SelectionPopoutButtonMixin:GetAdjustedIndex(forward, selections)
	if not self.selectedIndex then
		return nil;
	end
	local offset = forward and 1 or -1;
	local nextIndex = self.selectedIndex + offset;
	local data = selections[nextIndex];
	while data do
		if data.disabled == nil and not data.isLocked then
			return nextIndex;
		else
			nextIndex = nextIndex + offset;
			data = selections[nextIndex];
		end
	end

	return nil;
end

function SelectionPopoutButtonMixin:Increment()
	local forward = true;
	local index = self:GetAdjustedIndex(forward, self:GetSelections());
	self:SetSelectedIndex(index);
end

function SelectionPopoutButtonMixin:Decrement()
	local forward = false;
	local index = self:GetAdjustedIndex(forward, self:GetSelections());
	self:SetSelectedIndex(index);
end

function SelectionPopoutButtonMixin:SetSelectedIndex(newIndex)
	local oldIndex = self.selectedIndex;
	local isNewIndex = newIndex and newIndex ~= oldIndex;
	if isNewIndex then
		self.selectedIndex = newIndex;
		self:Update();

		self:TriggerEvent(SelectionPopoutButtonMixin.Event.OnValueChanged, self:GetCurrentSelectedData());
	end

	if self.parent.ShouldTriggerSelection and self.parent.ShouldTriggerSelection(oldIndex, newIndex) or isNewIndex then
		self:CallOnEntrySelected(self:GetCurrentSelectedData());
	end
end

DropDownControlMixin = {};

function DropDownControlMixin:OnLoad()
	local function InitializeDropDownFrame()
		self:Initialize();
	end

	UIDropDownMenu_Initialize(self.DropDownMenu, InitializeDropDownFrame);

	self:UpdateWidth(self:GetWidth());
end

function DropDownControlMixin:UpdateWidth(width)
	UIDropDownMenu_SetWidth(self.DropDownMenu, width - 20);
end

function DropDownControlMixin:SetControlWidth(width)
	self:SetWidth(width);
	self:UpdateWidth(width);
end

function DropDownControlMixin:Initialize()
	if self.options == nil then
		return;
	end

	local function DropDownControlButton_OnClick(button)
		local isUserInput = true;
		self:SetSelectedValue(button.value, isUserInput);
	end

	for i, option in ipairs(self.options) do
		local info = UIDropDownMenu_CreateInfo();
		if not self.skipNormalSetup then
			info.text = option.text;
			info.minWidth = 108;
			info.value = option.value;
			info.checked = self.selectedValue == option.value;
			info.func = DropDownControlButton_OnClick;
		end

		if self.customSetupCallback ~= nil then
			self.customSetupCallback(info);
		end

		UIDropDownMenu_AddButton(info);
	end
end

function DropDownControlMixin:SetSelectedValue(value, isUserInput)
	self.selectedValue = value;

	if value == nil then
		UIDropDownMenu_SetText(self.DropDownMenu, self.noneSelectedText);
	elseif self.options ~= nil then
		for i, option in ipairs(self.options) do
			if option.value == value then
				UIDropDownMenu_SetText(self.DropDownMenu, option.selectedText or option.text);
			end
		end
	end

	if self.optionSelectedCallback ~= nil then
		self.optionSelectedCallback(value, isUserInput);
	end
end

function DropDownControlMixin:GetSelectedValue()
	return self.selectedValue;
end

function DropDownControlMixin:SetOptionSelectedCallback(optionSelectedCallback)
	self.optionSelectedCallback = optionSelectedCallback;
end

-- options: an array of tables that contain info to display the different dropdown options.
-- Option keys:
--   value: a unique value that identifies the option and is passed through to optionSelectedCallback.
--   text: the text that appears in the dropdown list, and on the dropdown control when an option is selected.
--   selectedText: an override for text that appears on the dropdown control when an option is selected.
function DropDownControlMixin:SetOptions(options, defaultSelectedValue)
	self.options = options;
	self:Initialize();

	if defaultSelectedValue then
		self:SetSelectedValue(defaultSelectedValue);
	end
end

function DropDownControlMixin:GetOptionCount()
	return self.options and #self.options or 0;
end

function DropDownControlMixin:HasOptions()
	return self:GetOptionCount() > 0;
end

function DropDownControlMixin:SetCustomSetup(customSetupCallback, skipNormalSetup)
	self.customSetupCallback = customSetupCallback;
	self.skipNormalSetup = skipNormalSetup;
end

function DropDownControlMixin:SetTextJustifyH(...)
	self.DropDownMenu.Text:SetJustifyH(...);
end

function DropDownControlMixin:AdjustTextPointsOffset(...)
	self.DropDownMenu.Text:AdjustPointsOffset(...);
end

EnumDropDownControlMixin = CreateFromMixins(DropDownControlMixin);

function EnumDropDownControlMixin:SetEnum(enum, nameTranslation, ordering)
	local options = {};
	for enumKey, enumValue in pairs(enum) do
		table.insert(options, { value = enumValue, text = nameTranslation(enumValue), });
	end

	if ordering then
		local function EnumOrderingComparator(lhs, rhs)
			return ordering[lhs.value] < ordering[rhs.value];
		end

		table.sort(options, EnumOrderingComparator);
	else
		local function EnumComparator(lhs, rhs)
			return lhs.value < rhs.value;
		end

		table.sort(options, EnumComparator);
	end

	self:SetOptions(options);
end

-- Click to drag directly attached to frame itself.
ClickToDragMixin = {};

function ClickToDragMixin:OnLoad()
	self:RegisterForDrag("LeftButton");
end

function ClickToDragMixin:OnDragStart()
	self:StartMoving();
end

function ClickToDragMixin:OnDragStop()
	self:StopMovingOrSizing();
end

-- Click to drag attached to a subframe. For example, a title bar.
PanelDragBarMixin = {};

function PanelDragBarMixin:OnLoad()
	self:RegisterForDrag("LeftButton");
	self:SetTarget(self:GetParent());
end

function PanelDragBarMixin:Init(target)
	self:SetTarget(target);
end

function PanelDragBarMixin:SetTarget(target)
	self.target = target;
end

function PanelDragBarMixin:OnDragStart()
	local target = self.target;

	local continueDragStart = true;
	if target.onDragStartCallback then
		continueDragStart = target.onDragStartCallback(self);
	end

	if continueDragStart then
		target:StartMoving();
	end

	if SetCursor then
		SetCursor("UI_MOVE_CURSOR");
	end
end

function PanelDragBarMixin:OnDragStop()
	local target = self.target;

	local continueDragStop = true;
	if target.onDragStopCallback then
		continueDragStop = target.onDragStopCallback(self);
	end

	if continueDragStop then
		target:StopMovingOrSizing();
	end

	if SetCursor then
		SetCursor(nil);
	end
end

PanelResizeButtonMixin = {};

function PanelResizeButtonMixin:Init(target, minWidth, minHeight, maxWidth, maxHeight, rotationDegrees)
	self.target = target;
	self.minWidth = minWidth;
	self.minHeight = minHeight;
	self.maxWidth = maxWidth;
	self.maxHeight = maxHeight;

	local originalTargetOnSizeChanged = target:GetScript("OnSizeChanged") or nop;
	target:SetScript("OnSizeChanged", function(target, width, height)
		originalTargetOnSizeChanged(target, width, height);

		if width < self.minWidth then
			target:SetWidth(self.minWidth);
		elseif self.maxWidth and width > self.maxWidth then
			target:SetWidth(self.maxWidth);
		end

		if height < self.minHeight then
			target:SetHeight(self.minHeight);
		elseif self.maxHeight and height > self.maxHeight then
			target:SetHeight(self.maxHeight);
		end
	end);

	if rotationDegrees ~= nil then
		self:SetRotationDegrees(rotationDegrees);
	end
end

function PanelResizeButtonMixin:OnEnter()
	if SetCursor then
		SetCursor("UI_RESIZE_CURSOR");
	end
end

function PanelResizeButtonMixin:OnLeave()
	if SetCursor then
		SetCursor(nil);
	end
end

function PanelResizeButtonMixin:OnMouseDown()
	self.isActive = true;

	local target = self.target;
	if not target then
		return;
	end

	local continueResizeStart = true;
	if target.onResizeStartCallback then
		continueResizeStart = target.onResizeStartCallback(self);
	end

	if continueResizeStart then
		local alwaysStartFromMouse = true;
		self.target:StartSizing("BOTTOMRIGHT", alwaysStartFromMouse);
	end
end

function PanelResizeButtonMixin:OnMouseUp()
	self.isActive = false;

	local target = self.target;
	if not target then
		return;
	end

	local continueResizeStop = true;
	if target.onResizeStopCallback then
		continueResizeStop = target.onResizeStopCallback(self);
	end

	if continueResizeStop then
		target:StopMovingOrSizing();
	end

	if self.resizeStoppedCallback ~= nil then
		self.resizeStoppedCallback(self.target);
	end
end

function PanelResizeButtonMixin:IsActive()
	return not not self.isActive;
end

function PanelResizeButtonMixin:SetMinWidth(minWidth)
	self.minWidth = minWidth;
end

function PanelResizeButtonMixin:SetMinHeight(minHeight)
	self.minHeight = minHeight;
end

function PanelResizeButtonMixin:SetRotationDegrees(rotationDegrees)
	local rotationRadians = (rotationDegrees / 180) * math.pi;
	self:SetRotationRadians(rotationRadians);
end

function PanelResizeButtonMixin:SetRotationRadians(rotationRadians)
	local childRegions = { self:GetRegions() };
	for i, child in ipairs(childRegions) do
		if child.SetRotation ~= nil then
			child:SetRotation(rotationRadians);
		end
	end
end

function PanelResizeButtonMixin:SetOnResizeStoppedCallback(resizeStoppedCallback)
	self.resizeStoppedCallback = resizeStoppedCallback;
end

IconSelectorPopupFrameTemplateMixin = {};


IconSelectorPopupFrameModes = EnumUtil.MakeEnum(
	"New",
	"Edit"
);

IconSelectorPopupFrameIconFilterTypes = EnumUtil.MakeEnum(
	"All",
	"Spell",
	"Item"
);


local ValidIconSelectorCursorTypes = {
	"item",
	"spell",
	"mount",
	"battlepet",
	"macro"
};

local function IconSelectorPopupFrame_IconFilterToIconTypes(filter)
	if (filter == IconSelectorPopupFrameIconFilterTypes.All) then
		return IconDataProvider_GetAllIconTypes();
	elseif (filter == IconSelectorPopupFrameIconFilterTypes.Spell) then
		return { IconDataProviderIconType.Spell };
	elseif (filter == IconSelectorPopupFrameIconFilterTypes.Item) then
		return { IconDataProviderIconType.Item };
	end
	return nil;
end

local IconSelectorPopupFramesShown = 0;

function IconSelectorPopupFrameTemplateMixin:OnLoad()
	local function IconButtonInitializer(button, selectionIndex, icon)
		button:SetIconTexture(icon);
	end
	self.IconSelector:SetSetupCallback(IconButtonInitializer);
	self.IconSelector:AdjustScrollBarOffsets(0, 18, -1);

	self.BorderBox.OkayButton:SetScript("OnClick", function()
		PlaySound(SOUNDKIT.GS_TITLE_OPTION_OK);
		self:OkayButton_OnClick();
	end);

	self.BorderBox.CancelButton:SetScript("OnClick", function()
		PlaySound(SOUNDKIT.GS_TITLE_OPTION_OK);
		self:CancelButton_OnClick();
	end);

	self.BorderBox.EditBoxHeaderText:SetText(self.editBoxHeaderText);

	-- Icon Filter Dropdown
	local function IconFilterTypeNameTranslation(enumValue)
		for key, value in pairs(IconSelectorPopupFrameIconFilterTypes) do
			if value == enumValue then
				local keyUppercase = strupper(key);
				return _G["ICON_FILTER_" .. keyUppercase];
			end
		end
	end

	local function IconFilterTypeSelectedCallback(value, isUserInput)
		self:SetIconFilter(value);
	end

	self.BorderBox.IconTypeDropDown:SetControlWidth(125);
	self.BorderBox.IconTypeDropDown:SetTextJustifyH("LEFT");
	self.BorderBox.IconTypeDropDown:SetEnum(IconSelectorPopupFrameIconFilterTypes, IconFilterTypeNameTranslation);
	self.BorderBox.IconTypeDropDown:SetSelectedValue(IconSelectorPopupFrameIconFilterTypes.All);
	self.BorderBox.IconTypeDropDown:SetOptionSelectedCallback(IconFilterTypeSelectedCallback);
end

-- Usually overridden by inheriting frame.
function IconSelectorPopupFrameTemplateMixin:OnShow()
	IconSelectorPopupFramesShown = IconSelectorPopupFramesShown + 1;

	self:RegisterEvent("CURSOR_CHANGED");
	self:RegisterEvent("GLOBAL_MOUSE_UP");

	self.BorderBox.SelectedIconArea.SelectedIconButton:SetIconSelector(self);
	self.BorderBox.IconSelectorEditBox:SetIconSelector(self);
end

-- Usually overridden by inheriting frame.
function IconSelectorPopupFrameTemplateMixin:OnHide()
	IconSelectorPopupFramesShown = IconSelectorPopupFramesShown - 1;
	self:UnregisterEvent("CURSOR_CHANGED");
	self:UnregisterEvent("GLOBAL_MOUSE_UP");
end

-- Usually overridden by inheriting frame.
function IconSelectorPopupFrameTemplateMixin:Update()
end

function IconSelectorPopupFrameTemplateMixin:OnEvent(event, ...)
	if ( event == "CURSOR_CHANGED" ) then
		local cursorType = GetCursorInfo();
		local isValidCursorType = false;
		for _, validType in ipairs(ValidIconSelectorCursorTypes) do
			if ( cursorType == validType ) then
				isValidCursorType = true;
				break;
			end
		end

		self.BorderBox.IconDragArea:SetShown(isValidCursorType);
		self.BorderBox.IconSelectionText:SetShown(not isValidCursorType);
		self.BorderBox.IconTypeDropDown:SetShown(not isValidCursorType);
		self.IconSelector:SetShown(not isValidCursorType);
	elseif ( event == "GLOBAL_MOUSE_UP" and DoesAncestryInclude(self, GetMouseFocus())) then
		self:SetIconFromMouse();
	end
end

function IconSelectorPopupFrameTemplateMixin:SetIconFromMouse()
	local cursorType, ID = GetCursorInfo();
	for _, validType in ipairs(ValidIconSelectorCursorTypes) do
		if ( cursorType == validType ) then
			local icon;
			if ( cursorType == "item" ) then
				icon = select(10, C_Item.GetItemInfo(ID));
			elseif ( cursorType == "spell" ) then
				-- 'ID' field for spells would actually be the slot number, not the actual spellID, so we get this separately.
				local spellID = select(4, GetCursorInfo());
				icon = select(3, GetSpellInfo(spellID));
			elseif ( cursorType == "mount" ) then
				icon = select(3, C_MountJournal.GetMountInfoByID(ID));
			elseif ( cursorType == "battlepet" ) then
				icon = select(9, C_PetJournal.GetPetInfoByPetID(ID));
			elseif ( cursorType == "macro" ) then
				icon = select(2, GetMacroInfo(ID));
			end

			self.IconSelector:SetSelectedIndex(self:GetIndexOfIcon(icon));
			self.IconSelector:ScrollToSelectedIndex();
			ClearCursor();

			if ( icon ) then
				self.BorderBox.SelectedIconArea.SelectedIconButton:SetIconTexture(icon);
			end

			self:SetSelectedIconText();
			break;
		end
	end
end

function IconSelectorPopupFrameTemplateMixin:SetSelectedIconText()
	if ( self:GetSelectedIndex() ) then
		self.BorderBox.SelectedIconArea.SelectedIconText.SelectedIconDescription:SetText(ICON_SELECTION_CLICK);
		self.BorderBox.SelectedIconArea.SelectedIconText.SelectedIconDescription:SetFontObject(GameFontHighlightSmall);
	else
		self.BorderBox.SelectedIconArea.SelectedIconText.SelectedIconDescription:SetText(ICON_SELECTION_NOTINLIST);
		self.BorderBox.SelectedIconArea.SelectedIconText.SelectedIconDescription:SetFontObject(GameFontDisableSmall);
	end

	self.BorderBox.SelectedIconArea.SelectedIconText:Layout();
end

-- Usually overridden by inheriting frame.
function IconSelectorPopupFrameTemplateMixin:OkayButton_OnClick()
	self:Hide();
end

-- Usually overridden by inheriting frame.
function IconSelectorPopupFrameTemplateMixin:CancelButton_OnClick()
	self:Hide();
end

function IconSelectorPopupFrameTemplateMixin:SetIconFilter(iconFilter)
	if (self.iconFilter == iconFilter) then
		return;
	end

	self.iconFilter = iconFilter;
	local iconTypes = IconSelectorPopupFrame_IconFilterToIconTypes(self.iconFilter);
	self.iconDataProvider:SetIconTypes(iconTypes);
	self.IconSelector:UpdateSelections();
	self:ReevaluateSelectedIcon();
end

function IconSelectorPopupFrameTemplateMixin:GetIconFilter()
	return self.iconFilter;
end

function IconSelectorPopupFrameTemplateMixin:GetIconByIndex(index)
	return self.iconDataProvider:GetIconByIndex(index);
end

function IconSelectorPopupFrameTemplateMixin:GetIndexOfIcon(icon)
	return self.iconDataProvider:GetIndexOfIcon(icon);
end

function IconSelectorPopupFrameTemplateMixin:GetNumIcons()
	return self.iconDataProvider:GetNumIcons();
end

function IconSelectorPopupFrameTemplateMixin:GetSelectedIndex()
	return self.IconSelector:GetSelectedIndex();
end

function IconSelectorPopupFrameTemplateMixin:ReevaluateSelectedIcon()
	local texture = self.BorderBox.SelectedIconArea.SelectedIconButton:GetIconTexture();
	self.IconSelector:SetSelectedIndex(self:GetIndexOfIcon(texture));
	self:SetSelectedIconText();
end

function IsAnyIconSelectorPopupFrameShown()
	return IconSelectorPopupFramesShown and IconSelectorPopupFramesShown > 0;
end

SelectedIconButtonMixin = {};

function SelectedIconButtonMixin:SetIconTexture(iconTexture)
	self.Icon:SetTexture(iconTexture);
end

function SelectedIconButtonMixin:GetIconTexture()
	return self.Icon:GetTexture();
end

function SelectedIconButtonMixin:SetSelectedTexture()
	self.SelectedTexture:SetShown(self:GetIconSelectorPopupFrame():GetSelectedIndex() == nil);
end

function SelectedIconButtonMixin:OnClick()
	if ( self:GetIconSelectorPopupFrame():GetSelectedIndex() == nil ) then
		return;
	end

	self:GetIconSelectorPopupFrame().IconSelector:ScrollToSelectedIndex();
end

function SelectedIconButtonMixin:GetIconSelectorPopupFrame()
	return self.selectedIconButtonIconSelector;
end

function SelectedIconButtonMixin:SetIconSelector(iconSelector)
	self.selectedIconButtonIconSelector = iconSelector;
end

SearchBoxListElementMixin = {};

function SearchBoxListElementMixin:OnEnter()
	self:GetParent():SetSearchPreviewSelection(self:GetID());
end

function SearchBoxListElementMixin:OnClick()
	PlaySound(SOUNDKIT.IG_SPELLBOOK_OPEN);
end

-- SearchBoxListMixin was refactored out of EncounterJournal for use in Professions but is not complete. It doesn't
-- provide any interface for handling the bar progress updates.
SearchBoxListMixin = {};

function SearchBoxListMixin:OnLoad()
	SearchBoxTemplate_OnLoad(self);

	self.searchButtons = {};

	local function SetupButton(button, index)
		button:SetFrameStrata("DIALOG");
		button:SetFrameLevel(self:GetFrameLevel() + 10);
		button:SetID(index);
		button:Hide();
	end

	local buttonFirst = CreateFrame("BUTTON", nil, self, self.buttonTemplate);
	buttonFirst:SetPoint("TOPLEFT", self.searchPreviewContainer, "TOPLEFT");
	buttonFirst:SetPoint("BOTTOMRIGHT", self.searchPreviewContainer, "BOTTOMRIGHT");
	SetupButton(buttonFirst, 1);
	table.insert(self.searchButtons, buttonFirst);

	local buttonsMax = math.max(1, self.buttonCount or 5);
	local buttonIndex = 2;
	local buttonLast = buttonFirst;
	while buttonIndex <= buttonsMax do
		local button = CreateFrame("BUTTON", nil, self, self.buttonTemplate);
		button:SetPoint("TOPLEFT", buttonLast, "BOTTOMLEFT");
		button:SetPoint("TOPRIGHT", buttonLast, "BOTTOMRIGHT");
		SetupButton(button, buttonIndex);

		table.insert(self.searchButtons, button);
		buttonIndex = buttonIndex + 1;
		buttonLast = button;
	end

	self.showAllResults = CreateFrame("BUTTON", nil, self, self.showAllButtonTemplate);
	self.showAllResults:SetPoint("LEFT", buttonFirst, "LEFT");
	self.showAllResults:SetPoint("RIGHT", buttonFirst, "RIGHT");
	self.showAllResults:SetPoint("TOP", buttonLast, "BOTTOM");
	local showAllResultsIndex =  #self.searchButtons + 1;
	SetupButton(self.showAllResults, showAllResultsIndex);
	self.allResultsIndex = showAllResultsIndex;

	local bar = self.searchProgress.bar;
	bar:SetStatusBarColor(0, .6, 0, 1);
	bar:SetMinMaxValues(0, 1000);
	bar:SetValue(0);
	bar:GetStatusBarTexture():SetDrawLayer("BORDER");

	bar:SetScript("OnHide", function()
		bar:SetValue(0);
		bar.previousResults = nil;
	end);

	self.HasStickyFocus = function()
		return DoesAncestryInclude(self, GetMouseFocus());
	end
	self.selectedIndex = 1;
end

function SearchBoxListMixin:HideSearchPreview()
	self.searchProgress:Hide();
	self.showAllResults:Hide();

	for index, button in ipairs(self.searchButtons) do
		button:Hide();
	end

	self.searchPreviewContainer:Hide();
end

function SearchBoxListMixin:HideSearchProgress()
	self.searchProgress:Hide();
	self:FixSearchPreviewBottomBorder();
end

function SearchBoxListMixin:Close()
	self:HideSearchPreview();
	self:ClearFocus();
end

function SearchBoxListMixin:Clear()
	self.clearButton:Click();
end

function SearchBoxListMixin:IsSearchPreviewShown()
	return self.searchPreviewContainer:IsShown();
end

function SearchBoxListMixin:SetSearchResultsFrame(frame)
	self.searchResultsFrame = frame;
end

function SearchBoxListMixin:OnShow()
	self:SetFrameLevel(self:GetParent():GetFrameLevel() + 10);
end

function SearchBoxListMixin:IsCurrentTextValidForSearch()
	return self:IsTextValidForSearch(self:GetText());
end

function SearchBoxListMixin:IsTextValidForSearch(text)
	return strlen(text) >= (self.minCharacters or 1);
end

function SearchBoxListMixin:OnTextChanged()
	SearchBoxTemplate_OnTextChanged(self);

	local text = self:GetText();
	if not self:IsTextValidForSearch(text) then
		self:HideSearchPreview();
		return false, text;
	end

	self:SetSearchPreviewSelection(1);

	return true, text;
end

function SearchBoxListMixin:GetButtons()
	return self.searchButtons;
end

function SearchBoxListMixin:GetAllResultsButton()
	return self.showAllResults;
end

function SearchBoxListMixin:GetSearchButtonCount()
	return #self:GetButtons();
end

function SearchBoxListMixin:UpdateSearchPreview(finished, dbLoaded, numResults)
	local lastShown = self;
	if self.searchButtons[numResults] then
		lastShown = self.searchButtons[numResults];
	end

	self.showAllResults:Hide();
	self.searchProgress:Hide();
	if not finished then
		self.searchProgress:SetPoint("TOP", lastShown, "BOTTOM", 0, 0);

		if dbLoaded then
			self.searchProgress.loading:Hide();
			self.searchProgress.bar:Show();
		else
			self.searchProgress.loading:Show();
			self.searchProgress.bar:Hide();
		end

		self.searchProgress:Show();
	elseif not self.searchButtons[numResults] then
		self.showAllResults.text:SetText(SEARCH_RESULTS_SHOW_COUNT:format(numResults));
		self.showAllResults:Show();
	end

	self:FixSearchPreviewBottomBorder();
	self.searchPreviewContainer:Show();
end

function SearchBoxListMixin:FixSearchPreviewBottomBorder()
	local lastShownButton = nil;
	if self.showAllResults:IsShown() then
		lastShownButton = self.showAllResults;
	elseif self.searchProgress:IsShown() then
		lastShownButton = self.searchProgress;
	else
		for index, button in ipairs(self:GetButtons()) do
			if button:IsShown() then
				lastShownButton = button;
			end
		end
	end

	if lastShownButton ~= nil then
		self.searchPreviewContainer.botRightCorner:SetPoint("BOTTOM", lastShownButton, "BOTTOM", 0, -8);
		self.searchPreviewContainer.botLeftCorner:SetPoint("BOTTOM", lastShownButton, "BOTTOM", 0, -8);
	else
		self:HideSearchPreview();
	end
end

function SearchBoxListMixin:SetSearchPreviewSelection(selectedIndex)
	local numShown = 0;
	for index, button in ipairs(self:GetButtons()) do
		button.selectedTexture:Hide();

		if button:IsShown() then
			numShown = numShown + 1;
		end
	end

	if self.showAllResults:IsShown() then
		numShown = numShown + 1;
	end
	self.showAllResults.selectedTexture:Hide();

	if numShown == 0 then
		selectedIndex = 1;
	elseif selectedIndex > numShown then
		-- Wrap under to the beginning.
		selectedIndex = 1;
	elseif selectedIndex < 1 then
		-- Wrap over to the end;
		selectedIndex = numShown;
	end

	self.selectedIndex = selectedIndex;

	if selectedIndex == self.allResultsIndex then
		self.showAllResults.selectedTexture:Show();
	else
		self.searchButtons[selectedIndex].selectedTexture:Show();
	end
end

function SearchBoxListMixin:SetSearchPreviewSelectionToAllResults()
	self:SetSearchPreviewSelection(self.allResultsIndex);
end

function SearchBoxListMixin:OnEnterPressed()
	if self.selectedIndex > self.allResultsIndex or self.selectedIndex < 0 then
		return;
	elseif self.selectedIndex == self.allResultsIndex then
		if self.showAllResults:IsShown() then
			self.showAllResults:Click();
		end
	else
		local preview = self.searchButtons[self.selectedIndex];
		if preview:IsShown() then
			preview:Click();
		end
	end

	self:HideSearchPreview();
end

function SearchBoxListMixin:OnKeyDown(key)
	if key == "UP" then
		self:SetSearchPreviewSelection(self.selectedIndex - 1);
	elseif key == "DOWN" then
		self:SetSearchPreviewSelection(self.selectedIndex + 1);
	end
end

function SearchBoxListMixin:OnFocusLost()
	SearchBoxTemplate_OnEditFocusLost(self);
	self:HideSearchPreview();
end

function SearchBoxListMixin:OnFocusGained()
	SearchBoxTemplate_OnEditFocusGained(self);

	if self.searchResultsFrame then
		self.searchResultsFrame:Hide();
	end

	self:SetSearchPreviewSelection(1);
end


-- Allows inheriting buttons to override OnLoad and OnShow
ButtonControllerMixin = {};

function ButtonControllerMixin:OnLoad()
	if self:GetParent().InitButton then
		self:GetParent():InitButton();
	end
end

function ButtonControllerMixin:OnShow()
	if self:GetParent().UpdateButton then
		self:GetParent():UpdateButton();
	end
end

AlphaHighlightButtonMixin = {};

function AlphaHighlightButtonMixin:UpdateHighlightForState()
	self:SetHighlightAtlas(self:GetHighlightForState());
end

function AlphaHighlightButtonMixin:GetHighlightForState()
	if self.isPressed then
		return self.PushedTexture:GetAtlas();
	end

	return self.NormalTexture:GetAtlas();
end

function AlphaHighlightButtonMixin:OnMouseDown()
	self:SetPressed(true);
end

function AlphaHighlightButtonMixin:OnMouseUp()
	self:SetPressed(false);
end

function AlphaHighlightButtonMixin:SetPressed(pressed)
	self.isPressed = pressed;
	self:UpdateHighlightForState();
end

IconSelectorEditBoxMixin = {};

function IconSelectorEditBoxMixin:OnTextChanged()
	local iconSelectorPopupFrame = self:GetIconSelectorPopupFrame();
	local text = self:GetText();
	text = string.gsub(text, "\"", "");
	if #text > 0 then
		iconSelectorPopupFrame.BorderBox.OkayButton:Enable();
	else
		iconSelectorPopupFrame.BorderBox.OkayButton:Disable();
	end
end

function IconSelectorEditBoxMixin:OnEnterPressed()
	local text = self:GetText();
	text = string.gsub(text, "\"", "");
	if #text > 0 then
		self:GetIconSelectorPopupFrame():OkayButton_OnClick();
	end
end

function IconSelectorEditBoxMixin:OnEscapePressed()
	self:GetIconSelectorPopupFrame():CancelButton_OnClick();
end

function IconSelectorEditBoxMixin:GetIconSelectorPopupFrame()
	return self.editBoxIconSelector;
end

function IconSelectorEditBoxMixin:SetIconSelector(iconSelector)
	self.editBoxIconSelector = iconSelector;
end