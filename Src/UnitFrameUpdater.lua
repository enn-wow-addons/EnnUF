------------------------------------------
-- Local Helpers for Unit Frame Updater --
------------------------------------------

local function updateUnitFrameFull(uf)
    if EnnUF_API_UnitExists(uf.unitid) then
        uf:UpdateHealth(EnnUF_API_UnitHealthRel(uf.unitid));
        uf:UpdateHealthText(EnnUF_API_UnitHealthAbs(uf.unitid));
        -- TODO: extract color painter to be able to customize behaviour
        uf:UpdateHealthColor(EnnUF_UnitFramePainter:getHealthColor(uf.unitid));

        uf:UpdatePower(EnnUF_API_UnitPowerRel(uf.unitid));
        uf:UpdatePowerText(EnnUF_API_UnitPowerAbs(uf.unitid));
        -- TODO: extract color painter to be able to customize behaviour
        uf:UpdatePowerColor(EnnUF_UnitFramePainter:getPowerColor(uf.unitid));

        uf:Show();
    else
        uf:Hide();
    end
end

local function updateUnitFrameHealth(uf)
    uf:UpdateHealth(EnnUF_API_UnitHealthRel(uf.unitid));
    uf:UpdateHealthText(EnnUF_API_UnitHealthAbs(uf.unitid));
end

local function updateUnitFramePower(uf)
    uf:UpdatePower(EnnUF_API_UnitPowerRel(uf.unitid));
    uf:UpdatePowerText(EnnUF_API_UnitPowerAbs(uf.unitid));
end

local function updateUnitFrameSpecialAura(uf)
    uf:UpdateHealth(EnnUF_API_UnitHealthRel(uf.unitid));
    uf:UpdateHealthText(EnnUF_API_UnitHealthAbs(uf.unitid));

    uf:UpdatePower(EnnUF_API_UnitPowerRel(uf.unitid));
    uf:UpdatePowerText(EnnUF_API_UnitPowerAbs(uf.unitid));

    local _, unitClass = EnnUF_API_UnitClass(uf.unitid);
    if unitClass == "DRUID" then
        -- TODO: extract color painter to be able to customize behaviour
        uf:UpdatePowerColor(EnnUF_UnitFramePainter:getPowerColor(uf.unitid));
    end
end

local function updateUnitFrameSpecialFlags(uf)
    -- TODO: extract color painter to be able to customize behaviour
    uf:UpdateHealthColor(EnnUF_UnitFramePainter:getHealthColor(uf.unitid));
end

------------------------
-- Unit Frame Updater --
------------------------

local EnnUF_UnitFrameUpdater = {}

EnnUF_UnitFrameUpdater["ADDON_LOADED"] = function(uf)
    -- EnnUF_API_ChatMsg("ADDON_LOADED")
    updateUnitFrameFull(uf)
end

EnnUF_UnitFrameUpdater["PLAYER_ENTERING_WORLD"] = function(uf)
    -- EnnUF_API_ChatMsg("PLAYER_ENTERING_WORLD")
    updateUnitFrameFull(uf)
end

EnnUF_UnitFrameUpdater["PLAYER_TARGET_CHANGED"] = function(uf)
    -- EnnUF_API_ChatMsg("PLAYER_TARGET_CHANGED")
    if uf.unitid ~= "target" and uf.unitid ~= "targettarget" then return end
    updateUnitFrameFull(uf)
end

EnnUF_UnitFrameUpdater["PLAYER_FOCUS_CHANGED"] = function(uf)
    -- EnnUF_API_ChatMsg("PLAYER_FOCUS_CHANGED")
    if uf.unitid ~= "focus" and uf.unitid ~= "focustarget" then return end
    updateUnitFrameFull(uf)
end

EnnUF_UnitFrameUpdater["UNIT_TARGET"] = function(uf, arg1)
    -- EnnUF_API_ChatMsg("UNIT_TARGET")
    -- NOTE: PLAYER_TARGET_CHANGED can be removed with additional checks:
    -- (arg1 == "player" and uf.unitid == "target") or
    -- (arg1 == "player" and uf.unitid == "targettarget") or
    if arg1.."target" == uf.unitid then
        updateUnitFrameFull(uf)
    end
end

EnnUF_UnitFrameUpdater["UNIT_HEALTH"] = function(uf)
    -- EnnUF_API_ChatMsg("UNIT_HEALTH")
    -- NOTE: doesn't work if unit is not a party or raid member
    -- if uf.unitid ~= arg1 then return end
    updateUnitFrameHealth(uf)
end

EnnUF_UnitFrameUpdater["UNIT_HEALTH_FREQUENT"] = function(uf)
    -- EnnUF_API_ChatMsg("UNIT_HEALTH_FREQUENT")
    -- NOTE: doesn't work if unit is not a party or raid member
    -- if uf.unitid ~= arg1 then return end
    updateUnitFrameHealth(uf)
end

EnnUF_UnitFrameUpdater["UNIT_MANA"] = function(uf)
    -- EnnUF_API_ChatMsg("UNIT_MANA")
    -- NOTE: doesn't work if unit is not a party or raid member
    -- if uf.unitid ~= arg1 then return end
    updateUnitFramePower(uf)
end

EnnUF_UnitFrameUpdater["UNIT_ENERGY"] = function(uf)
    -- EnnUF_API_ChatMsg("UNIT_ENERGY")
    -- NOTE: doesn't work if unit is not a party or raid member
    -- if uf.unitid ~= arg1 then return end
    updateUnitFramePower(uf)
end

EnnUF_UnitFrameUpdater["UNIT_POWER_UPDATE"] = function(uf)
    -- EnnUF_API_ChatMsg("UNIT_POWER")
    -- NOTE: doesn't work if unit is not a party or raid member
    -- if uf.unitid ~= arg1 then return end
    updateUnitFramePower(uf)
end

EnnUF_UnitFrameUpdater["UNIT_AURA"] = function(uf)
    -- EnnUF_API_ChatMsg("UNIT_AURA")
    -- NOTE: doesn't work if unit is not a party or raid member
    -- if uf.unitid ~= arg1 then return end
    updateUnitFrameSpecialAura(uf)
end

EnnUF_UnitFrameUpdater["UNIT_FLAGS"] = function(uf)
    -- EnnUF_API_ChatMsg("UNIT_FLAGS")
    -- NOTE: doesn't work if unit is not a party or raid member
    -- if uf.unitid ~= arg1 then return end
    updateUnitFrameSpecialFlags(uf)
end

------------------------
-- Unit Frame Updater --
------------------------

function EnnUF_CreateAndRegister(unitid, conf)
    local uf = EnnUF_UnitFrame:new(unitid, conf.x, conf.y, conf.width, conf.height)

    uf:SetEventHandler(function(self, event, arg1, arg2, arg3)
        -- if EnnUF_UnitFrameUpdater[event] then
            EnnUF_UnitFrameUpdater[event](uf, arg1, arg2, arg3);
        -- end
    end);

    -- Recreate unit frame
    uf:RegisterEvent("ADDON_LOADED");
    uf:RegisterEvent("PLAYER_ENTERING_WORLD");
    -- Update unit frame completely
    uf:RegisterEvent("UNIT_TARGET");
    uf:RegisterEvent("PLAYER_TARGET_CHANGED"); -- for @target, @targettarget
    uf:RegisterEvent("PLAYER_FOCUS_CHANGED"); -- for @focus, @focustarget
    -- Update unit frame health
    uf:RegisterEvent("UNIT_HEALTH");
    uf:RegisterEvent("UNIT_HEALTH_FREQUENT");
    -- Update unit frame power
    -- uf:RegisterEvent("UNIT_MANA");
    uf:RegisterEvent("UNIT_POWER_UPDATE");
    -- Update unit frame in special case
    uf:RegisterEvent("UNIT_AURA");
    uf:RegisterEvent("UNIT_FLAGS");

    return uf;
end
