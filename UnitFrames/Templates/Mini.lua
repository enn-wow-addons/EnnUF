
-------------------------
-- MiniUnitFrame Class --
-------------------------

SunwayUF_MiniUnitFrame = {}
SunwayUF_MiniUnitFrame.__index = SunwayUF_MiniUnitFrame;

function SunwayUF_MiniUnitFrame:new(x, y, width, height)
    local frame=CreateFrame("Frame", nil, UIParent);
    frame:SetPoint("CENTER", UIParent, "CENTER", x, y);
    frame:SetHeight(height);
    frame:SetWidth(width);

    local body = frame:CreateTexture(nil, "ARTWORK")
    body:SetAllPoints(frame);
    body:SetTexture("Interface\\ChatFrame\\ChatFrameBackground");
    body:SetVertexColor(0, 0, 0, 0.7);

    local healthBar = frame:CreateTexture(nil, "OVERLAY");
    healthBar:SetPoint("TOPLEFT", frame, "TOPLEFT", 2, -2);
    healthBar:SetHeight(height/2-3);
    healthBar:SetWidth(width-4);
    healthBar:SetTexture("Interface\\AddOns\\SunwayUF\\UnitFrames\\Textures\\Bar.tga");
    healthBar:SetVertexColor(1, 1, 1, 1);
    healthBar:SetAlpha(1);

    local manaBar = frame:CreateTexture(nil, "OVERLAY");
    manaBar:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 2, 2);
    manaBar:SetHeight(height/2-3);
    manaBar:SetWidth(width-4);
    manaBar:SetTexture("Interface\\AddOns\\SunwayUF\\UnitFrames\\Textures\\Bar.tga");
    manaBar:SetVertexColor(1, 1, 1, 1);
    manaBar:SetAlpha(1);

    local newObj = {}
    newObj.frame = frame;
    newObj.body = body;
    newObj.healthBar = healthBar;
    newObj.manaBar = manaBar;

    return setmetatable(newObj, SunwayUF_MiniUnitFrame);
end

function SunwayUF_MiniUnitFrame:SetBarColor(barName, r, g, b, a)
    if barName == "HEALTH" then
        self.healthBar:SetVertexColor(r,g,b,a);
    elseif barName == "POWER" then
        self.manaBar:SetVertexColor(r,g,b,a);
    end
end

function SunwayUF_MiniUnitFrame:SetBarTexture(barName, texturePath)
    if barName == "HEALTH" then
        self.healthBar:SetTexture(texturePath);
    elseif barName == "POWER" then
        self.manaBar:SetTexture(texturePath);
    end 
end

function SunwayUF_MiniUnitFrame:SetBarRelativeWidth(barName, percentage)
    if barName == "HEALTH" then
        self.healthBar:SetWidth(self.frame:GetWidth() * percentage-4);
    elseif barName == "POWER" then
        self.manaBar:SetWidth(self.frame:GetWidth() * percentage-4);
    end
end

function SunwayUF_MiniUnitFrame:SetEventHandler(eventHandler)
    self.frame:SetScript("OnEvent", eventHandler);
end

function SunwayUF_MiniUnitFrame:RegisterEvent(eventName)
    self.frame:RegisterEvent(eventName);
end
