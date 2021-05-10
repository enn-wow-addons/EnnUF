
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
-- Helpers --
-------------

local function EnnUF_GetHealthColor(unit)
    if SunwayUF_UnitIsPlayer(unit) then
        if not SunwayUF_UnitIsPVP(unit) then
            return EnnUF.Colors.Health.Unflagged
        elseif SunwayUF_UnitIsFriend(unit, "player") then
            return EnnUF.Colors.Health.Friend
        elseif not SunwayUF_UnitIsPVP("player") then
            return EnnUF.Colors.Health.Neutral
        else
            return EnnUF.Colors.Health.Enemy
        end
    else
        local reaction = SunwayUF_UnitReaction(unit, "player");

        if not reaction then
            return EnnUF.Colors.Health.Unknown;
        elseif reaction < 4 then
            return EnnUF.Colors.Health.Enemy;
        elseif reaction > 4 then
            return EnnUF.Colors.Health.Friend;
        else
            return EnnUF.Colors.Health.Neutral;
        end
    end
end

local function EnnUF_GetPowerColor(unit, uf)
    local powerType = SunwayUF_UnitPowerType(unit);

    if powerType == 0 then
        return EnnUF.Colors.Power.Mana;
    elseif powerType == 1 then
        return EnnUF.Colors.Power.Rage;
    elseif powerType == 2 then
        return EnnUF.Colors.Power.Focus;
    elseif powerType == 3 then
        return EnnUF.Colors.Power.Energy;
    else
        return EnnUF.Colors.Power.Unknown;
    end
end

-------------
-- Methods --
-------------

function EnnUF.UnitFrame:UpdateHealthColor()
    local color = EnnUF_GetHealthColor(self.unitid);
    self.healthBar:SetVertexColor(color.r, color.g, color.b, color.a);
end

function EnnUF.UnitFrame:UpdatePowerColor()
    local color = EnnUF_GetPowerColor(self.unitid);
    self.manaBar:SetVertexColor(color.r, color.g, color.b, color.a);
end

function EnnUF.UnitFrame:UpdateHealth()
    self.healthBar:SetWidth(self.frame:GetWidth() * SunwayUF_GetHealthPercentage(self.unitid)-4);
    self.healthBarText:SetText(SunwayUF_UnitHealth(self.unitid));
end

function EnnUF.UnitFrame:UpdatePower()
    self.manaBar:SetWidth(self.frame:GetWidth() * SunwayUF_GetPowerPercentage(self.unitid)-4);
    self.manaBarText:SetText(SunwayUF_UnitPower(self.unitid));
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
    -- TODO: update iff unit == target
    if SunwayUF_UnitExists(uf.unitid) then
        uf:UpdateHealth();
        uf:UpdatePower();

        uf:UpdateHealthColor();
        uf:UpdatePowerColor();

        uf:Show();
    else
        uf:Hide();
    end
end

EnnUF_UnitFrame_EventHandle["ADDON_LOADED"] = function(uf)
    if SunwayUF_UnitExists(uf.unitid) then
        uf:UpdateHealth();
        uf:UpdatePower();

        uf:UpdateHealthColor();
        uf:UpdatePowerColor();

        uf:Show();
    else
        uf:Hide();
    end
end

EnnUF_UnitFrame_EventHandle["PLAYER_ENTERING_WORLD"] = function(uf)
    if SunwayUF_UnitExists(uf.unitid) then
        uf:UpdateHealth();
        uf:UpdatePower();

        uf:UpdateHealthColor();
        uf:UpdatePowerColor();

        uf:Show();
    else
        uf:Hide();
    end
end

EnnUF_UnitFrame_EventHandle["UNIT_AURA"] = function(uf)
    uf:UpdateHealth();
    uf:UpdatePower();

    local _, unitClass = SunwayUF_UnitClass(uf.unitid);
    if unitClass == "DRUID" then
        uf:UpdatePowerColor();
    end
end

EnnUF_UnitFrame_EventHandle["UNIT_FLAGS"] = function(uf)
    uf:UpdateHealthColor();
end

EnnUF_UnitFrame_EventHandle["UNIT_HEALTH"] = function(uf)
    uf:UpdateHealth();
end

EnnUF_UnitFrame_EventHandle["UNIT_HEALTH_FREQUENT"] = function(uf)
    uf:UpdateHealth();
end

EnnUF_UnitFrame_EventHandle["UNIT_MANA"] = function(uf)
    uf:UpdatePower();
end

EnnUF_UnitFrame_EventHandle["UNIT_ENERGY"] = function(uf)
    uf:UpdatePower();
end
