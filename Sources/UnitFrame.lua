
---------------------
-- UnitFrame Class --
---------------------

EnnUF.UnitFrame = {}
EnnUF.UnitFrame.__index = EnnUF.UnitFrame;

function EnnUF.UnitFrame:new(unitid, x, y, width, height)
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
    newObj.unitid = unitid;
    newObj.frame = frame;
    newObj.body = body;
    newObj.healthBar = healthBar;
    newObj.manaBar = manaBar;
    newObj.healthBarText = healthBarText;
    newObj.manaBarText = manaBarText;

    return setmetatable(newObj, EnnUF.UnitFrame);
end

-------------
-- Methods --
-------------

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

-------------------
-- Event Handles --
-------------------

EnnUF_UnitFrame_EventHandle = {}

EnnUF_UnitFrame_EventHandle["PLAYER_TARGET_CHANGED"] = function(uf)
    if EnnUF_UnitExists(uf.unitid) then
        uf:UpdateHealth(EnnUF_GetHealthPercentage(uf.unitid), EnnUF_UnitHealth(uf.unitid));
        uf:UpdatePower(EnnUF_GetPowerPercentage(uf.unitid), EnnUF_UnitPower(uf.unitid));

        uf:UpdateHealthColor(EnnUF_GetHealthColor(uf.unitid));
        uf:UpdatePowerColor(EnnUF_GetPowerColor(uf.unitid));

        uf:Show();
    else
        uf:Hide();
    end
end

EnnUF_UnitFrame_EventHandle["ADDON_LOADED"] = function(uf)
    if EnnUF_UnitExists(uf.unitid) then
        uf:UpdateHealth(EnnUF_GetHealthPercentage(uf.unitid), EnnUF_UnitHealth(uf.unitid));
        uf:UpdatePower(EnnUF_GetPowerPercentage(uf.unitid), EnnUF_UnitPower(uf.unitid));

        uf:UpdateHealthColor(EnnUF_GetHealthColor(uf.unitid));
        uf:UpdatePowerColor(EnnUF_GetPowerColor(uf.unitid));

        uf:Show();
    else
        uf:Hide();
    end
end

EnnUF_UnitFrame_EventHandle["PLAYER_ENTERING_WORLD"] = function(uf)
    if EnnUF_UnitExists(uf.unitid) then
        uf:UpdateHealth(EnnUF_GetHealthPercentage(uf.unitid), EnnUF_UnitHealth(uf.unitid));
        uf:UpdatePower(EnnUF_GetPowerPercentage(uf.unitid), EnnUF_UnitPower(uf.unitid));

        uf:UpdateHealthColor(EnnUF_GetHealthColor(uf.unitid));
        uf:UpdatePowerColor(EnnUF_GetPowerColor(uf.unitid));

        uf:Show();
    else
        uf:Hide();
    end
end

EnnUF_UnitFrame_EventHandle["UNIT_AURA"] = function(uf)
    uf:UpdateHealth(EnnUF_GetHealthPercentage(uf.unitid), EnnUF_UnitHealth(uf.unitid));
    uf:UpdatePower(EnnUF_GetPowerPercentage(uf.unitid), EnnUF_UnitPower(uf.unitid));

    local _, unitClass = EnnUF_UnitClass(uf.unitid);
    if unitClass == "DRUID" then
        uf:UpdatePowerColor(EnnUF_GetPowerColor(uf.unitid));
    end
end

EnnUF_UnitFrame_EventHandle["UNIT_FLAGS"] = function(uf)
    uf:UpdateHealthColor(EnnUF_GetHealthColor(uf.unitid));
end

EnnUF_UnitFrame_EventHandle["UNIT_HEALTH"] = function(uf)
    uf:UpdateHealth(EnnUF_GetHealthPercentage(uf.unitid), EnnUF_UnitHealth(uf.unitid));
end

EnnUF_UnitFrame_EventHandle["UNIT_HEALTH_FREQUENT"] = function(uf)
    uf:UpdateHealth(EnnUF_GetHealthPercentage(uf.unitid), EnnUF_UnitHealth(uf.unitid));
end

EnnUF_UnitFrame_EventHandle["UNIT_MANA"] = function(uf)
    uf:UpdatePower(EnnUF_GetPowerPercentage(uf.unitid), EnnUF_UnitPower(uf.unitid));
end

EnnUF_UnitFrame_EventHandle["UNIT_ENERGY"] = function(uf)
    uf:UpdatePower(EnnUF_GetPowerPercentage(uf.unitid), EnnUF_UnitPower(uf.unitid));
end
