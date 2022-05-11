------------------------
-- Unit Frame Helpers --
------------------------

local function UpdateUnitFrameFull(uf)
    if EnnUF_UnitExists(uf.unitid) then
        uf:UpdateHealth(EnnUF_UnitHealthRel(uf.unitid));
        uf:UpdateHealthText(EnnUF_UnitHealthAbs(uf.unitid));
        uf:UpdateHealthColor(EnnUF_UnitHealthColor(uf.unitid));

        uf:UpdatePower(EnnUF_UnitPowerRel(uf.unitid));
        uf:UpdatePowerText(EnnUF_UnitPowerAbs(uf.unitid));
        uf:UpdatePowerColor(EnnUF_UnitPowerColor(uf.unitid));

        uf:Show();
    else
        uf:Hide();
    end
end

local function UpdateUnitFrameHealth(uf)
    uf:UpdateHealth(EnnUF_UnitHealthRel(uf.unitid));
    uf:UpdateHealthText(EnnUF_UnitHealthAbs(uf.unitid));
end

local function UpdateUnitFramePower(uf)
    uf:UpdatePower(EnnUF_UnitPowerRel(uf.unitid));
    uf:UpdatePowerText(EnnUF_UnitPowerAbs(uf.unitid));
end

local function UpdateUnitFrameSpecialAura(uf)
    uf:UpdateHealth(EnnUF_UnitHealthRel(uf.unitid));
    uf:UpdateHealthText(EnnUF_UnitHealthAbs(uf.unitid));

    uf:UpdatePower(EnnUF_UnitPowerRel(uf.unitid));
    uf:UpdatePowerText(EnnUF_UnitPowerAbs(uf.unitid));

    local _, unitClass = EnnUF_UnitClass(uf.unitid);
    if unitClass == "DRUID" then
        uf:UpdatePowerColor(EnnUF_UnitPowerColor(uf.unitid));
    end
end

local function UpdateUnitFrameSpecialFlags(uf)
    uf:UpdateHealthColor(EnnUF_UnitHealthColor(uf.unitid));
end

------------------------------
-- Unit Frame Event Handles --
------------------------------

local EnnUF_UnitFrame_EventHandle = {}

EnnUF_UnitFrame_EventHandle["ADDON_LOADED"] = function(uf)
    UpdateUnitFrameFull(uf)
end

EnnUF_UnitFrame_EventHandle["PLAYER_ENTERING_WORLD"] = function(uf)
    UpdateUnitFrameFull(uf)
end

EnnUF_UnitFrame_EventHandle["PLAYER_TARGET_CHANGED"] = function(uf)
    if uf.unitid ~= "target" and uf.unitid ~= "targettarget" then return end
    UpdateUnitFrameFull(uf)
end

EnnUF_UnitFrame_EventHandle["PLAYER_FOCUS_CHANGED"] = function(uf)
    if uf.unitid ~= "focus" and uf.unitid ~= "focustarget" then return end
    UpdateUnitFrameFull(uf)
end

EnnUF_UnitFrame_EventHandle["UNIT_TARGET"] = function(uf)
    -- NOTE: PLAYER_TARGET_CHANGED can be removed with additional checks:
    -- (arg1 == "player" and uf.unitid == "target") or
    -- (arg1 == "player" and uf.unitid == "targettarget") or
    if arg1.."target" == uf.unitid then
        UpdateUnitFrameFull(uf)
    end
end

EnnUF_UnitFrame_EventHandle["UNIT_HEALTH"] = function(uf)
    -- NOTE: doesn't work if unit is not a party or raid member
    -- if uf.unitid ~= arg1 then return end
    UpdateUnitFrameHealth(uf)
end

EnnUF_UnitFrame_EventHandle["UNIT_HEALTH_FREQUENT"] = function(uf)
    -- NOTE: doesn't work if unit is not a party or raid member
    -- if uf.unitid ~= arg1 then return end
    UpdateUnitFrameHealth(uf)
end

EnnUF_UnitFrame_EventHandle["UNIT_MANA"] = function(uf)
    -- NOTE: doesn't work if unit is not a party or raid member
    -- if uf.unitid ~= arg1 then return end
    UpdateUnitFramePower(uf)
end

EnnUF_UnitFrame_EventHandle["UNIT_ENERGY"] = function(uf)
    -- NOTE: doesn't work if unit is not a party or raid member
    -- if uf.unitid ~= arg1 then return end
    UpdateUnitFramePower(uf)
end

EnnUF_UnitFrame_EventHandle["UNIT_POWER"] = function(uf)
    -- NOTE: doesn't work if unit is not a party or raid member
    -- if uf.unitid ~= arg1 then return end
    UpdateUnitFramePower(uf)
end

EnnUF_UnitFrame_EventHandle["UNIT_AURA"] = function(uf)
    -- NOTE: doesn't work if unit is not a party or raid member
    -- if uf.unitid ~= arg1 then return end
    UpdateUnitFrameSpecialAura(uf)
end

EnnUF_UnitFrame_EventHandle["UNIT_FLAGS"] = function(uf)
    -- NOTE: doesn't work if unit is not a party or raid member
    -- if uf.unitid ~= arg1 then return end
    UpdateUnitFrameSpecialFlags(uf)
end

-------------------------------
-- Unit Frame Event Register --
-------------------------------

function EnnUF_CreateAndRegister(unitid, x, y, width, height)
    local uf = EnnUF.UnitFrame:new(unitid, x, y, width, height)

    uf:SetEventHandler(function()
        if EnnUF_UnitFrame_EventHandle[event] then
            EnnUF_UnitFrame_EventHandle[event](uf);
        end
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
    uf:RegisterEvent("UNIT_MANA");
    uf:RegisterEvent("UNIT_ENERGY");
    -- Update unit frame in special case
    uf:RegisterEvent("UNIT_AURA");
    uf:RegisterEvent("UNIT_FLAGS");

    return uf;
end
