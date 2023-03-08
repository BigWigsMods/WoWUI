
---------------
--NOTE - Please do not change this section without talking to Dan
local _, tbl = ...;
if tbl then
	tbl.SecureCapsuleGet = SecureCapsuleGet;

	local function Import(name)
		tbl[name] = tbl.SecureCapsuleGet(name);
	end

	Import("IsOnGlueScreen");

	if ( tbl.IsOnGlueScreen() ) then
		tbl._G = _G;	--Allow us to explicitly access the global environment at the glue screens
	end

	Import("GMError");
	Import("math");
	Import("Clamp");

	setfenv(1, tbl);
end
----------------

--------------------------------------------------------------------------------
-- BaseLayout Mixin
--------------------------------------------------------------------------------

BaseLayoutMixin = {};

function BaseLayoutMixin:OnShow()
	self:Layout();
end

function BaseLayoutMixin:IsLayoutFrame()
	return true;
end

function BaseLayoutMixin:IgnoreLayoutIndex()
	return false;
end

function BaseLayoutMixin:MarkIgnoreInLayout(region, ...)
	if region then
		region.ignoreInLayout = true;
		self:MarkIgnoreInLayout(...);
	end
end

local function IsLayoutFrame(f)
	return f.IsLayoutFrame and f:IsLayoutFrame();
end

function BaseLayoutMixin:AddLayoutChildren(layoutChildren, ...)
	for i = 1, select("#", ...) do
		local region = select(i, ...);
		if region:IsShown() and not region.ignoreInLayout and (self:IgnoreLayoutIndex() or region.layoutIndex) then
			layoutChildren[#layoutChildren + 1] = region;
		end
	end
end

function LayoutIndexComparator(left, right)
	if (left.layoutIndex == right.layoutIndex and left ~= right) then
		local leftName = (left.GetDebugName and left:GetDebugName()) or "unnamed";
		local rightName = (right.GetDebugName and right:GetDebugName()) or "unnamed";
		GMError(("Duplicate layoutIndex found: %d for %s and %s"):format(left.layoutIndex, leftName, rightName));
	end
	return left.layoutIndex < right.layoutIndex;
end

function BaseLayoutMixin:GetLayoutChildren()
	local children = {};
	self:AddLayoutChildren(children, self:GetChildren());
	self:AddLayoutChildren(children, self:GetRegions());
	self:AddLayoutChildren(children, self:GetAdditionalRegions());
	if not self:IgnoreLayoutIndex() then
		table.sort(children, LayoutIndexComparator);
	end

	return children;
end

function BaseLayoutMixin:GetAdditionalRegions()
	-- optional;
end

function BaseLayoutMixin:Layout()
	assert(false); -- Implement in derived class
end

function BaseLayoutMixin:OnUpdate()
	if self:IsDirty() then
		self:Layout();
	end
end

function BaseLayoutMixin:MarkDirty()
	self.dirty = true;

	-- Tell any ancestors who may also be LayoutFrames that they should also become dirty
	local parent = self:GetParent();
	while parent do
		if IsLayoutFrame(parent) then
			parent:MarkDirty();
			return;
		end

		parent = parent:GetParent();
	end
end

function BaseLayoutMixin:MarkClean()
	self.dirty = false;
	self:OnCleaned();
end

function BaseLayoutMixin:IsDirty()
	return self.dirty;
end

function BaseLayoutMixin:OnCleaned()
	-- implement in derived if you want
end

--------------------------------------------------------------------------------
-- Layout Mixin
--------------------------------------------------------------------------------

LayoutMixin = CreateFromMixins(BaseLayoutMixin);

function LayoutMixin:GetPadding()
	return (self.leftPadding or 0),
		   (self.rightPadding or 0),
		   (self.topPadding or 0),
		   (self.bottomPadding or 0);
end

-- If child is a layoutFrame that doesn't ignoreLayoutIndex (i.e. child is a vertical or horizontal layout frame) then we need to ignore the padding set on it
-- If we don't ignore padding here we will be applying that padding twice (once here when we lay out the child and then again when Layout is called on the child itself)
function LayoutMixin:GetChildPadding(child)
	if IsLayoutFrame(child) and not child:IgnoreLayoutIndex() then
		return 0, 0, 0, 0;
	else
		return (child.leftPadding or 0),
			   (child.rightPadding or 0),
			   (child.topPadding or 0),
			   (child.bottomPadding or 0);
	end
end

local function GetSize(desired, fixed, minimum, maximum)
	return fixed or Clamp(desired, minimum or desired, maximum or desired);
end

function LayoutMixin:CalculateFrameSize(childrenWidth, childrenHeight)
	local frameWidth, frameHeight;
	local leftPadding, rightPadding, topPadding, bottomPadding = self:GetPadding();

	childrenWidth = childrenWidth + leftPadding + rightPadding;
	childrenHeight = childrenHeight + topPadding + bottomPadding;

	-- Expand this frame if the "expand" keyvalue is set and children width or height is larger.
	-- Otherwise, set this frame size to the fixed size if set, or the size of the children
	if (self.expand and self.fixedWidth and childrenWidth > self.fixedWidth) then
		frameWidth = childrenWidth;
	else
		frameWidth = self.fixedWidth or childrenWidth;
	end
	if (self.expand and self.fixedHeight and childrenHeight > self.fixedHeight) then
		frameHeight = childrenHeight;
	else
		frameHeight = self.fixedHeight or childrenHeight;
	end
	return GetSize(frameWidth, nil, self.minimumWidth, self.maximumWidth), GetSize(frameHeight, nil, self.minimumHeight, self.maximumHeight);
end

function LayoutMixin:Layout()
	local children = self:GetLayoutChildren();
	local childrenWidth, childrenHeight, hasExpandableChild = self:LayoutChildren(children);

	local frameWidth, frameHeight = self:CalculateFrameSize(childrenWidth, childrenHeight);

	-- If at least one child had "expand" set and we did not already expand them, call LayoutChildren() again to expand them
	if (hasExpandableChild) then
		childrenWidth, childrenHeight = self:LayoutChildren(children, frameWidth, frameHeight);
		frameWidth, frameHeight = self:CalculateFrameSize(childrenWidth, childrenHeight);
	end

	self:SetSize(frameWidth, frameHeight);
	self:MarkClean();
end

--------------------------------------------------------------------------------
-- VerticalLayout Mixin
--------------------------------------------------------------------------------

VerticalLayoutMixin = {};

function VerticalLayoutMixin:LayoutChildren(children, expandToWidth)
	local frameLeftPadding, frameRightPadding, topOffset = self:GetPadding();
	local spacing = self.spacing or 0;
	local childrenWidth, childrenHeight = 0, 0;
	local hasExpandableChild = false;

	-- Calculate width and height based on children
	for i, child in ipairs(children) do
		if IsLayoutFrame(child) then
			child:Layout();
		end

		local childWidth, childHeight = child:GetSize();
		local leftPadding, rightPadding, topPadding, bottomPadding = self:GetChildPadding(child);
		if (child.expand) then
			hasExpandableChild = true;
		end

		-- Expand child width if it is set to expand and we also have an expandToWidth value.
		if (child.expand and expandToWidth) then
			childWidth = expandToWidth - leftPadding - rightPadding - frameLeftPadding - frameRightPadding;
			child:SetWidth(childWidth);
			childHeight = child:GetHeight();
		end

		if self.respectChildScale then
			local childScale = child:GetScale();
			childWidth = childWidth * childScale;
			childHeight = childHeight * childScale;
		end

		childrenWidth = math.max(childrenWidth, childWidth + leftPadding + rightPadding);
		childrenHeight = childrenHeight + childHeight + topPadding + bottomPadding;
		if (i > 1) then
			childrenHeight = childrenHeight + spacing;
		end

		-- Set child position
		child:ClearAllPoints();
		topOffset = topOffset + topPadding;
		if (child.align == "right") then
			local rightOffset = frameRightPadding + rightPadding;
			child:SetPoint("TOPRIGHT", -rightOffset, -topOffset);
		elseif (child.align == "center") then
			local leftOffset = (frameLeftPadding - frameRightPadding + leftPadding - rightPadding) / 2;
			child:SetPoint("TOP", leftOffset, -topOffset);
		else
			local leftOffset = frameLeftPadding + leftPadding;
			child:SetPoint("TOPLEFT", leftOffset, -topOffset);
		end
		topOffset = topOffset + childHeight + bottomPadding + spacing;
	end

	return childrenWidth, childrenHeight, hasExpandableChild;
end

--------------------------------------------------------------------------------
-- HorizontalLayout Mixin
--------------------------------------------------------------------------------

HorizontalLayoutMixin = {};

function HorizontalLayoutMixin:LayoutChildren(children, ignored, expandToHeight)
	local leftOffset, _, frameTopPadding, frameBottomPadding = self:GetPadding();
	local spacing = self.spacing or 0;
	local childrenWidth, childrenHeight = 0, 0;
	local hasExpandableChild = false;

	-- Calculate width and height based on children
	for i, child in ipairs(children) do
		if IsLayoutFrame(child) then
			child:Layout();
		end

		local childWidth, childHeight = child:GetSize();
		local leftPadding, rightPadding, topPadding, bottomPadding = self:GetChildPadding(child);
		if (child.expand) then
			hasExpandableChild = true;
		end

		-- Expand child height if it is set to expand and we also have an expandToHeight value.
		if (child.expand and expandToHeight) then
			childHeight = expandToHeight - topPadding - bottomPadding - frameTopPadding - frameBottomPadding;
			child:SetHeight(childHeight);
			childWidth = child:GetWidth();
		end

		if self.respectChildScale then
			local childScale = child:GetScale();
			childWidth = childWidth * childScale;
			childHeight = childHeight * childScale;
		end

		childrenHeight = math.max(childrenHeight, childHeight + topPadding + bottomPadding);
		childrenWidth = childrenWidth + childWidth + leftPadding + rightPadding;
		if (i > 1) then
			childrenWidth = childrenWidth + spacing;
		end

		-- Set child position
		child:ClearAllPoints();
		leftOffset = leftOffset + leftPadding;
		if (child.align == "bottom") then
			local bottomOffset = frameBottomPadding + bottomPadding;
			child:SetPoint("BOTTOMLEFT", leftOffset, bottomOffset);
		elseif (child.align == "center") then
			local topOffset = (frameTopPadding - frameBottomPadding + topPadding - bottomPadding) / 2;
			child:SetPoint("LEFT", leftOffset, -topOffset);
		else
			local topOffset = frameTopPadding + topPadding;
			child:SetPoint("TOPLEFT", leftOffset, -topOffset);
		end
		leftOffset = leftOffset + childWidth + rightPadding + spacing;
	end

	return childrenWidth, childrenHeight, hasExpandableChild;
end

--------------------------------------------------------------------------------
-- ResizeLayout Mixin
--------------------------------------------------------------------------------

ResizeLayoutMixin = CreateFromMixins(BaseLayoutMixin);

local function GetExtents(childFrame, left, right, top, bottom, layoutFrameScale)
	local frameLeft, frameBottom, frameWidth, frameHeight, defaulted = GetUnscaledFrameRect(childFrame, layoutFrameScale);
	local frameRight = frameLeft + frameWidth;
	local frameTop = frameBottom + frameHeight;

	left = left and math.min(frameLeft, left) or frameLeft;
	right = right and math.max(frameRight, right) or frameRight;
	top = top and math.max(frameTop, top) or frameTop;
	bottom = bottom and math.min(frameBottom, bottom) or frameBottom;

	return left, right, top, bottom, defaulted;
end

function ResizeLayoutMixin:IgnoreLayoutIndex()
	return true;
end

function ResizeLayoutMixin:Layout()
	-- GetExtents will fail if the LayoutFrame has 0 width or height, so set them to 1 to start
	self:SetSize(1, 1);

	-- GetExtents will also fail if the LayoutFrame has no anchors set, so if that is the case, set an anchor and then clear it after we are done
	local hadNoAnchors = (self:GetNumPoints() == 0);
	if hadNoAnchors then
		self:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, 0);
	end

	local left, right, top, bottom, defaulted;
	local layoutFrameScale = self:GetEffectiveScale();
	for childIndex, child in ipairs(self:GetLayoutChildren()) do
		if IsLayoutFrame(child) then
			child:Layout();
		end

		local l, r, t, b, d = GetExtents(child, left, right, top, bottom, layoutFrameScale);
		left, right, top, bottom = l, r, t, b;
		defaulted = defaulted or d;
	end

	if left and right and top and bottom then
		local width = GetSize((right - left) + (self.widthPadding or 0), self.fixedWidth, self.minimumWidth, self.maximumWidth);
		local height = GetSize((top - bottom) + (self.heightPadding or 0), self.fixedHeight, self.minimumHeight, self.maximumHeight);
		self:SetSize(width, height);
	end

	if hadNoAnchors then
		self:ClearAllPoints();
	end

	self:MarkClean();
end

--------------------------------------------------------------------------------
-- GridLayoutFrameMixin
--------------------------------------------------------------------------------

GridLayoutFrameMixin = {}

function GridLayoutFrameMixin:Layout()
	local layoutChildren = self:GetLayoutChildren();
	if not self:ShouldUpdateLayout(layoutChildren) then
		return;
	end

	-- Multipliers determine the direction the layout grows for grid layouts
	-- Positive means right/up
	-- Negative means left/down
	local xMultiplier = self.layoutFramesGoingRight and 1 or -1;
	local yMultiplier = self.layoutFramesGoingUp and 1 or -1;

	-- Create the grid layout according to whether we are horizontal or vertical
	local layout;
	if self.isHorizontal then
		layout = GridLayoutUtil.CreateStandardGridLayout(self.stride, self.childXPadding, self.childYPadding, xMultiplier, yMultiplier);
	else
		layout = GridLayoutUtil.CreateVerticalGridLayout(self.stride, self.childXPadding, self.childYPadding, xMultiplier, yMultiplier);
	end

	-- Need to change where the frames anchor based on how the layout grows
	local anchorPoint;
	if self.layoutFramesGoingUp then
		anchorPoint = self.layoutFramesGoingRight and "BOTTOMLEFT" or "BOTTOMRIGHT";
	else
		anchorPoint = self.layoutFramesGoingRight and "TOPLEFT" or "TOPRIGHT";
	end

	-- Apply the layout and then update our size
	GridLayoutUtil.ApplyGridLayout(layoutChildren, AnchorUtil.CreateAnchor(anchorPoint, self, anchorPoint), layout);
	ResizeLayoutMixin.Layout(self);
	self:CacheLayoutSettings(layoutChildren);
end

function GridLayoutFrameMixin:CacheLayoutSettings(layoutChildren)
    self.oldGridSettings = {
		layoutChildren = layoutChildren;
        childXPadding = self.childXPadding;
		childYPadding = self.childYPadding;
		isHorizontal = self.isHorizontal;
		stride = self.stride;
		layoutFramesGoingRight = self.layoutFramesGoingRight;
		layoutFramesGoingUp = self.layoutFramesGoingUp;
    };
end

function GridLayoutFrameMixin:ShouldUpdateLayout(layoutChildren)
    if not self:IsShown() then
        return false;
    end

    if self.oldGridSettings == nil then
        return true;
    end

    if #self.oldGridSettings.layoutChildren ~= #layoutChildren
	or self.oldGridSettings.childXPadding ~= self.childXPadding
	or self.oldGridSettings.childYPadding ~= self.childYPadding
    or self.oldGridSettings.isHorizontal ~= self.isHorizontal
    or self.oldGridSettings.stride ~= self.stride
    or self.oldGridSettings.layoutFramesGoingRight ~= self.layoutFramesGoingRight
    or self.oldGridSettings.layoutFramesGoingUp ~= self.layoutFramesGoingUp then
        return true;
    end

    for index, child in ipairs(layoutChildren) do
        if self.oldGridSettings.layoutChildren[index] ~= child then
            return true;
        end
    end

    return false;
end

function GridLayoutFrameMixin:IgnoreLayoutIndex()
	return false;
end