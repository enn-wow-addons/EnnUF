
local SunwayUF_PlayerUnitFrame;

------------------
-- Load Handler --
------------------

function SunwayUF_PlayerUF_Load()
    SunwayUF_PlayerUnitFrame = SunwayUF_MiniUnitFrame:new(0, -250, 180, 14);

    SunwayUF_PlayerUnitFrame:SetEventHandler(SunwayUF_PlayerUF_OnEvent);

    SunwayUF_PlayerUnitFrame:RegisterEvent("ADDON_LOADED");
    SunwayUF_PlayerUnitFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
    SunwayUF_PlayerUnitFrame:RegisterEvent("PLAYER_AURAS_CHANGED");
    SunwayUF_PlayerUnitFrame:RegisterEvent("UNIT_FLAGS");
    SunwayUF_PlayerUnitFrame:RegisterEvent("UNIT_HEALTH");
    SunwayUF_PlayerUnitFrame:RegisterEvent("UNIT_HEALTH_FREQUENT");
    SunwayUF_PlayerUnitFrame:RegisterEvent("UNIT_MANA");
    SunwayUF_PlayerUnitFrame:RegisterEvent("UNIT_ENERGY");
end

-------------------
-- Event Handler --
-------------------

SunwayUF_PlayerUF_HandleEvent = {}

SunwayUF_PlayerUF_HandleEvent["ADDON_LOADED"] = function()
    SunwayUF_PlayerUnitFrame:SetBarRelativeWidth("HEALTH", SunwayUF_GetHealthPercentage("player"));
    SunwayUF_PlayerUnitFrame:SetBarRelativeWidth("POWER", SunwayUF_GetPowerPercentage("player"));

    SunwayUF_UpdateHealthColor("player", SunwayUF_PlayerUnitFrame);
    SunwayUF_UpdatePowerColor("player", SunwayUF_PlayerUnitFrame);
end

SunwayUF_PlayerUF_HandleEvent["PLAYER_ENTERING_WORLD"] = function()
    SunwayUF_PlayerUnitFrame:SetBarRelativeWidth("HEALTH", SunwayUF_GetHealthPercentage("player"));
    SunwayUF_PlayerUnitFrame:SetBarRelativeWidth("POWER", SunwayUF_GetPowerPercentage("player"));

    SunwayUF_UpdateHealthColor("player", SunwayUF_PlayerUnitFrame);
    SunwayUF_UpdatePowerColor("player", SunwayUF_PlayerUnitFrame);
end

SunwayUF_PlayerUF_HandleEvent["PLAYER_AURAS_CHANGED"] = function()
    SunwayUF_PlayerUnitFrame:SetBarRelativeWidth("HEALTH", SunwayUF_GetHealthPercentage("player"));
    SunwayUF_PlayerUnitFrame:SetBarRelativeWidth("POWER", SunwayUF_GetPowerPercentage("player"));

    local _, playerClass = SunwayUF_UnitClass("player");
    if playerClass == "DRUID" then
        SunwayUF_PlayerUnitFrame:SetBarRelativeWidth("POWER", SunwayUF_GetPowerPercentage("player"));
        SunwayUF_UpdatePowerColor("player", SunwayUF_PlayerUnitFrame);
    end
end

SunwayUF_PlayerUF_HandleEvent["UNIT_FLAGS"] = function()
    SunwayUF_UpdateHealthColor("player", SunwayUF_PlayerUnitFrame);
end

SunwayUF_PlayerUF_HandleEvent["UNIT_HEALTH"] = function()
    SunwayUF_PlayerUnitFrame:SetBarRelativeWidth("HEALTH", SunwayUF_GetHealthPercentage("player"));
end

SunwayUF_PlayerUF_HandleEvent["UNIT_HEALTH_FREQUENT"] = function()
    SunwayUF_PlayerUnitFrame:SetBarRelativeWidth("HEALTH", SunwayUF_GetHealthPercentage("player"));
end

SunwayUF_PlayerUF_HandleEvent["UNIT_MANA"] = function()
    SunwayUF_PlayerUnitFrame:SetBarRelativeWidth("POWER", SunwayUF_GetPowerPercentage("player"));
end

SunwayUF_PlayerUF_HandleEvent["UNIT_ENERGY"] = function()
    SunwayUF_PlayerUnitFrame:SetBarRelativeWidth("POWER", SunwayUF_GetPowerPercentage("player"));
end

function SunwayUF_PlayerUF_OnEvent()
    if SunwayUF_PlayerUF_HandleEvent[event] then
        SunwayUF_PlayerUF_HandleEvent[event]();
    end
end
