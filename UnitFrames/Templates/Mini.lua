
-------------------------
-- MiniUnitFrame Class --
-------------------------

EnnUF.UnitFrame = {}
EnnUF.UnitFrame.__index = EnnUF.UnitFrame;

function EnnUF.UnitFrame:new(x, y, width, height)
    local frame=CreateFrame("Frame", nil, UIParent);
    frame:SetPoint("CENTER", UIParent, "CENTER", x, y);
    frame:SetHeight(height);
    frame:SetWidth(width);

    local body = frame:CreateTexture(nil, "ARTWORK")
    body:SetAllPoints(frame);
    body:SetTexture(EnnUF.Backgrounds.Default);
    body:SetVertexColor(0, 0, 0, 0.7);

    local healthBar = frame:CreateTexture(nil, "OVERLAY");
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

    local manaBar = frame:CreateTexture(nil, "OVERLAY");
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
    newObj.frame = frame;
    newObj.body = body;
    newObj.healthBar = healthBar;
    newObj.manaBar = manaBar;
    newObj.healthBarText = healthBarText;
    newObj.manaBarText = manaBarText;

    return setmetatable(newObj, EnnUF.UnitFrame);
end

function EnnUF.UnitFrame:SetBarColor(barName, r, g, b, a)
    if barName == "HEALTH" then
        self.healthBar:SetVertexColor(r,g,b,a);
    elseif barName == "POWER" then
        self.manaBar:SetVertexColor(r,g,b,a);
    end
end

function EnnUF.UnitFrame:SetBarTexture(barName, texturePath)
    if barName == "HEALTH" then
        self.healthBar:SetTexture(texturePath);
    elseif barName == "POWER" then
        self.manaBar:SetTexture(texturePath);
    end 
end

function EnnUF.UnitFrame:SetBarText(barName, text)
    if barName == "HEALTH" then
        self.healthBarText:SetText(text);
    elseif barName == "POWER" then
        self.manaBarText:SetText(text);
    end
end

function EnnUF.UnitFrame:SetBarRelativeWidth(barName, percentage)
    if barName == "HEALTH" then
        self.healthBar:SetWidth(self.frame:GetWidth() * percentage-4);
    elseif barName == "POWER" then
        self.manaBar:SetWidth(self.frame:GetWidth() * percentage-4);
    end
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
