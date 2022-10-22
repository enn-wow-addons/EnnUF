----------------------
-- Unit Frame Class --
----------------------

EnnUF_UnitFrame = {}
EnnUF_UnitFrame.__index = EnnUF_UnitFrame;

-- TODO: remove hardcoded size constants and make them dependent on size preset
function EnnUF_UnitFrame:new(unitid, x, y, width, height)
    local frame=CreateFrame("Frame", nil, UIParent);
    frame:SetPoint("CENTER", UIParent, "CENTER", x, y);
    frame:SetHeight(height);
    frame:SetWidth(width);

    local body = frame:CreateTexture(nil, "BACKGROUND")
    body:SetAllPoints(frame);
    body:SetTexture(EnnUF_Res.Bgs.Default);
    body:SetVertexColor(0, 0, 0, 0.4);

    local healthBarBg = frame:CreateTexture(nil, "BORDER");
    healthBarBg:SetPoint("TOPLEFT", frame, "TOPLEFT", 2, -2);
    healthBarBg:SetHeight(height/2-3);
    healthBarBg:SetWidth(width-4);
    healthBarBg:SetTexture(EnnUF_Res.Bars.Default);
    healthBarBg:SetVertexColor(0, 0, 0, 0.3);
    -- healthBarBg:SetAlpha(1);

    local healthBar = frame:CreateTexture(nil, "ARTWORK");
    healthBar:SetPoint("TOPLEFT", frame, "TOPLEFT", 2, -2);
    healthBar:SetHeight(height/2-3);
    healthBar:SetWidth(width-4);
    healthBar:SetTexture(EnnUF_Res.Bars.Default);
    healthBar:SetVertexColor(1, 1, 1, 1);
    healthBar:SetAlpha(1);

    local healthBarText = frame:CreateFontString(nil,"OVERLAY");
    healthBarText:SetFont(EnnUF_Res.Fonts.Default, 10, "HIGHLIGHT");
    healthBarText:SetPoint("CENTER",0,5)
    healthBarText:SetTextColor(0, 0, 0);
    healthBarText:SetText(nil);
    healthBarText:Hide()

    local manaBarBg = frame:CreateTexture(nil, "BORDER");
    manaBarBg:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 2, 2);
    manaBarBg:SetHeight(height/2-3);
    manaBarBg:SetWidth(width-4);
    manaBarBg:SetTexture(EnnUF_Res.Bars.Default);
    manaBarBg:SetVertexColor(0, 0, 0, 0.3);
    -- manaBarBg:SetAlpha(1);

    local manaBar = frame:CreateTexture(nil, "ARTWORK");
    manaBar:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 2, 2);
    manaBar:SetHeight(height/2-3);
    manaBar:SetWidth(width-4);
    manaBar:SetTexture(EnnUF_Res.Bars.Default);
    manaBar:SetVertexColor(1, 1, 1, 1);
    manaBar:SetAlpha(1);

    local manaBarText = frame:CreateFontString(nil,"OVERLAY");
    manaBarText:SetFont(EnnUF_Res.Fonts.Default, 10, "HIGHLIGHT");
    manaBarText:SetPoint("CENTER",0,-5)
    manaBarText:SetTextColor(0, 0, 0);
    manaBarText:SetText(nil);
    manaBarText:Hide()

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

    return setmetatable(newObj, EnnUF_UnitFrame);
end

------------------------
-- Unit Frame Methods --
------------------------

function EnnUF_UnitFrame:UpdateHealthColor(color)
    self.healthBar:SetVertexColor(color.r, color.g, color.b, color.a);
end

function EnnUF_UnitFrame:UpdatePowerColor(color)
    self.manaBar:SetVertexColor(color.r, color.g, color.b, color.a);
end

function EnnUF_UnitFrame:UpdateHealth(percent)
    -- TODO: remove hardcoded constant and make it dependent on size preset
    self.healthBar:SetWidth(self.frame:GetWidth() * percent - 4);
end

function EnnUF_UnitFrame:UpdatePower(percent)
    -- TODO: remove hardcoded constant and make it dependent on size preset
    self.manaBar:SetWidth(self.frame:GetWidth() * percent - 4);
end

function EnnUF_UnitFrame:UpdateHealthText(text)
    self.healthBarText:SetText(text);
end

function EnnUF_UnitFrame:UpdatePowerText(text)
    self.manaBarText:SetText(text);
end

function EnnUF_UnitFrame:Show()
    self.frame:Show();
end

function EnnUF_UnitFrame:Hide()
    self.frame:Hide();
end

function EnnUF_UnitFrame:SetEventHandler(eventHandler)
    self.frame:SetScript("OnEvent", eventHandler);
end

function EnnUF_UnitFrame:RegisterEvent(eventName)
    self.frame:RegisterEvent(eventName);
end
