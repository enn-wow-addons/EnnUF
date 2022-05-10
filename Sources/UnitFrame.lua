
----------------------
-- Unit Frame Class --
----------------------

EnnUF.UnitFrame = {}
EnnUF.UnitFrame.__index = EnnUF.UnitFrame;

function EnnUF.UnitFrame:new(unitid, x, y, width, height)
    local frame=CreateFrame("Frame", nil, UIParent);
    frame:SetPoint("CENTER", UIParent, "CENTER", x, y);
    frame:SetHeight(height);
    frame:SetWidth(width);

    local body = frame:CreateTexture(nil, "BACKGROUND")
    body:SetAllPoints(frame);
    body:SetTexture(EnnUF.Backgrounds.Default);
    body:SetVertexColor(0, 0, 0, 0.4);

    local healthBarBg = frame:CreateTexture(nil, "BORDER");
    healthBarBg:SetPoint("TOPLEFT", frame, "TOPLEFT", 2, -2);
    healthBarBg:SetHeight(height/2-3);
    healthBarBg:SetWidth(width-4);
    healthBarBg:SetTexture(EnnUF.Bars.Default);
    healthBarBg:SetVertexColor(0, 0, 0, 0.3);
    -- healthBarBg:SetAlpha(1);

    local healthBar = frame:CreateTexture(nil, "ARTWORK");
    healthBar:SetPoint("TOPLEFT", frame, "TOPLEFT", 2, -2);
    healthBar:SetHeight(height/2-3);
    healthBar:SetWidth(width-4);
    healthBar:SetTexture(EnnUF.Bars.Default);
    healthBar:SetVertexColor(1, 1, 1, 1);
    healthBar:SetAlpha(1);

    local healthBarText = frame:CreateFontString(nil,"OVERLAY");
    healthBarText:SetFont(EnnUF.Fonts.Default, 10, "HIGHLIGHT");
    healthBarText:SetPoint("CENTER",0,5)
    healthBarText:SetTextColor(0, 0, 0);
    healthBarText:SetText(nil);

    local manaBarBg = frame:CreateTexture(nil, "BORDER");
    manaBarBg:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 2, 2);
    manaBarBg:SetHeight(height/2-3);
    manaBarBg:SetWidth(width-4);
    manaBarBg:SetTexture(EnnUF.Bars.Default);
    manaBarBg:SetVertexColor(0, 0, 0, 0.3);
    -- manaBarBg:SetAlpha(1);

    local manaBar = frame:CreateTexture(nil, "ARTWORK");
    manaBar:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 2, 2);
    manaBar:SetHeight(height/2-3);
    manaBar:SetWidth(width-4);
    manaBar:SetTexture(EnnUF.Bars.Default);
    manaBar:SetVertexColor(1, 1, 1, 1);
    manaBar:SetAlpha(1);

    local manaBarText = frame:CreateFontString(nil,"OVERLAY");
    manaBarText:SetFont(EnnUF.Fonts.Default, 10, "HIGHLIGHT");
    manaBarText:SetPoint("CENTER",0,-5)
    manaBarText:SetTextColor(0, 0, 0);
    manaBarText:SetText(nil);

    local newObj = {}
    newObj.unitid = unitid;
    newObj.frame = frame;
    newObj.body = body;
    newObj.healthBarBg = healthBarBg;
    newObj.manaBarBg = manaBarBg;
    newObj.healthBar = healthBar;
    newObj.manaBar = manaBar;
    newObj.healthBarText = healthBarText;
    newObj.manaBarText = manaBarText;

    return setmetatable(newObj, EnnUF.UnitFrame);
end

------------------------
-- Unit Frame Methods --
------------------------

function EnnUF.UnitFrame:UpdateHealthColor(color)
    self.healthBar:SetVertexColor(color.r, color.g, color.b, color.a);
end

function EnnUF.UnitFrame:UpdatePowerColor(color)
    self.manaBar:SetVertexColor(color.r, color.g, color.b, color.a);
end

function EnnUF.UnitFrame:UpdateHealth(percent, text)
    self.healthBar:SetWidth(self.frame:GetWidth() * percent - 4);
    self.healthBarText:SetText(text);
end

function EnnUF.UnitFrame:UpdatePower(percent, text)
    self.manaBar:SetWidth(self.frame:GetWidth() * percent - 4);
    self.manaBarText:SetText(text);
end

function EnnUF.UnitFrame:Show()
    self.frame:Show();
end

function EnnUF.UnitFrame:Hide()
    self.frame:Hide();
end

function EnnUF.UnitFrame:SetEventHandler(eventHandler)
    self.frame:SetScript("OnEvent", eventHandler);
end

function EnnUF.UnitFrame:RegisterEvent(eventName)
    self.frame:RegisterEvent(eventName);
end
