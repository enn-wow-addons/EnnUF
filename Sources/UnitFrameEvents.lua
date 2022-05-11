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

EnnUF_UnitFrame_EventHandle = {}

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
    if uf.unitid ~= arg1 then return end
    UpdateUnitFrameFull(uf)
end

EnnUF_UnitFrame_EventHandle["UNIT_HEALTH"] = function(uf)
    if uf.unitid ~= arg1 then return end
    UpdateUnitFrameHealth(uf)
end

EnnUF_UnitFrame_EventHandle["UNIT_HEALTH_FREQUENT"] = function(uf)
    if uf.unitid ~= arg1 then return end
    UpdateUnitFrameHealth(uf)
end

EnnUF_UnitFrame_EventHandle["UNIT_MANA"] = function(uf)
    if uf.unitid ~= arg1 then return end
    UpdateUnitFramePower(uf)
end

EnnUF_UnitFrame_EventHandle["UNIT_ENERGY"] = function(uf)
    if uf.unitid ~= arg1 then return end
    UpdateUnitFramePower(uf)
end

EnnUF_UnitFrame_EventHandle["UNIT_POWER"] = function(uf)
    if uf.unitid ~= arg1 then return end
    UpdateUnitFramePower(uf)
end

EnnUF_UnitFrame_EventHandle["UNIT_AURA"] = function(uf)
    if uf.unitid ~= arg1 then return end
    UpdateUnitFrameSpecialAura(uf)
end

EnnUF_UnitFrame_EventHandle["UNIT_FLAGS"] = function(uf)
    if uf.unitid ~= arg1 then return end
    UpdateUnitFrameSpecialFlags(uf)
end
