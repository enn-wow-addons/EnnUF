
local SunwayUF_TargetUnitFrame;

------------------
-- Load Handler --
------------------

function SunwayUF_TargetUF_Load()
    SunwayUF_TargetUnitFrame = SunwayUF_MiniUnitFrame:new(0, -200, 200, 20);

    SunwayUF_TargetUnitFrame:SetEventHandler(SunwayUF_TargetUF_OnEvent);

    SunwayUF_TargetUnitFrame:RegisterEvent("ADDON_LOADED");
    SunwayUF_TargetUnitFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
    SunwayUF_TargetUnitFrame:RegisterEvent("PLAYER_TARGET_CHANGED");
    SunwayUF_TargetUnitFrame:RegisterEvent("UNIT_AURA");
    SunwayUF_TargetUnitFrame:RegisterEvent("UNIT_FLAGS");
    SunwayUF_TargetUnitFrame:RegisterEvent("UNIT_HEALTH");
    SunwayUF_TargetUnitFrame:RegisterEvent("UNIT_HEALTH_FREQUENT");
    SunwayUF_TargetUnitFrame:RegisterEvent("UNIT_MANA");
    SunwayUF_TargetUnitFrame:RegisterEvent("UNIT_ENERGY");    
end

-------------------
-- Event Handler --
-------------------

SunwayUF_TargetUF_HandleEvent = {}

SunwayUF_TargetUF_HandleEvent["ADDON_LOADED"] = function()
    if SunwayUF_UnitExists("target") then
        SunwayUF_UpdateHealth("target", SunwayUF_TargetUnitFrame);
        SunwayUF_UpdatePower("target", SunwayUF_TargetUnitFrame);

        SunwayUF_UpdateHealthColor("target", SunwayUF_TargetUnitFrame);
        SunwayUF_UpdatePowerColor("target", SunwayUF_TargetUnitFrame);

        SunwayUF_UpdateHealthText("target", SunwayUF_TargetUnitFrame);
        SunwayUF_UpdatePowerText("target", SunwayUF_TargetUnitFrame);

        SunwayUF_TargetUnitFrame:Show();
    else
        SunwayUF_TargetUnitFrame:Hide();
    end
end

SunwayUF_TargetUF_HandleEvent["PLAYER_ENTERING_WORLD"] = function()
    if SunwayUF_UnitExists("target") then
        SunwayUF_UpdateHealth("target", SunwayUF_TargetUnitFrame);
        SunwayUF_UpdatePower("target", SunwayUF_TargetUnitFrame);

        SunwayUF_UpdateHealthColor("target", SunwayUF_TargetUnitFrame);
        SunwayUF_UpdatePowerColor("target", SunwayUF_TargetUnitFrame);

        SunwayUF_UpdateHealthText("target", SunwayUF_TargetUnitFrame);
        SunwayUF_UpdatePowerText("target", SunwayUF_TargetUnitFrame);

        SunwayUF_TargetUnitFrame:Show();
    else
        SunwayUF_TargetUnitFrame:Hide();
    end
end

SunwayUF_TargetUF_HandleEvent["PLAYER_TARGET_CHANGED"] = function()
    if SunwayUF_UnitExists("target") then
        SunwayUF_UpdateHealth("target", SunwayUF_TargetUnitFrame);
        SunwayUF_UpdatePower("target", SunwayUF_TargetUnitFrame);

        SunwayUF_UpdateHealthColor("target", SunwayUF_TargetUnitFrame);
        SunwayUF_UpdatePowerColor("target", SunwayUF_TargetUnitFrame);

        SunwayUF_UpdateHealthText("target", SunwayUF_TargetUnitFrame);
        SunwayUF_UpdatePowerText("target", SunwayUF_TargetUnitFrame);

        SunwayUF_TargetUnitFrame:Show();
    else
        SunwayUF_TargetUnitFrame:Hide();
    end
end

SunwayUF_TargetUF_HandleEvent["UNIT_AURA"] = function()
    SunwayUF_UpdateHealth("target", SunwayUF_TargetUnitFrame);
    SunwayUF_UpdatePower("target", SunwayUF_TargetUnitFrame);

    SunwayUF_UpdateHealthText("target", SunwayUF_TargetUnitFrame);
    SunwayUF_UpdatePowerText("target", SunwayUF_TargetUnitFrame);

    local _, targetClass = SunwayUF_UnitClass("target");
    if targetClass == "DRUID" then
        SunwayUF_UpdatePowerColor("target", SunwayUF_TargetUnitFrame);
    end
end

SunwayUF_TargetUF_HandleEvent["UNIT_FLAGS"] = function()
    SunwayUF_UpdateHealthColor("target", SunwayUF_TargetUnitFrame);
end

SunwayUF_TargetUF_HandleEvent["UNIT_HEALTH"] = function()
    SunwayUF_UpdateHealth("target", SunwayUF_TargetUnitFrame);

    SunwayUF_UpdateHealthText("target", SunwayUF_TargetUnitFrame);
end

SunwayUF_TargetUF_HandleEvent["UNIT_HEALTH_FREQUENT"] = function()
    SunwayUF_UpdateHealth("target", SunwayUF_TargetUnitFrame);

    SunwayUF_UpdateHealthText("target", SunwayUF_TargetUnitFrame);
end

SunwayUF_TargetUF_HandleEvent["UNIT_MANA"] = function()
    SunwayUF_UpdatePower("target", SunwayUF_TargetUnitFrame);

    SunwayUF_UpdatePowerText("target", SunwayUF_TargetUnitFrame);
end

SunwayUF_TargetUF_HandleEvent["UNIT_ENERGY"] = function()
    SunwayUF_UpdatePower("target", SunwayUF_TargetUnitFrame);

    SunwayUF_UpdatePowerText("target", SunwayUF_TargetUnitFrame);
end

function SunwayUF_TargetUF_OnEvent()
    if SunwayUF_TargetUF_HandleEvent[event] then
        SunwayUF_TargetUF_HandleEvent[event]();
    end
end
