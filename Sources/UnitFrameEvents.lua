------------------------
-- Unit Frame Helpers --
------------------------

local function UpdateUnitFrameFull(uf)
    if EnnUF_UnitExists(uf.unitid) then
        uf:UpdateHealth(
            EnnUF_GetHealthPercentage(uf.unitid), EnnUF_UnitHealth(uf.unitid));
        uf:UpdateHealthColor(
            EnnUF_GetHealthColor(uf.unitid));

        uf:UpdatePower(
            EnnUF_GetPowerPercentage(uf.unitid), EnnUF_UnitPower(uf.unitid));
        uf:UpdatePowerColor(
            EnnUF_GetPowerColor(uf.unitid));

        uf:Show();
    else
        uf:Hide();
    end
end

local function UpdateUnitFrameHealth(uf)
    uf:UpdateHealth(EnnUF_GetHealthPercentage(uf.unitid), EnnUF_UnitHealth(uf.unitid));
end

local function UpdateUnitFramePower(uf)
    uf:UpdatePower(EnnUF_GetPowerPercentage(uf.unitid), EnnUF_UnitPower(uf.unitid));
end

local function UpdateUnitFrameSpecialAura(uf)
    UpdateUnitFrameHealth(uf)
    UpdateUnitFramePower(uf)

    local _, unitClass = EnnUF_UnitClass(uf.unitid);
    if unitClass == "DRUID" then
        uf:UpdatePowerColor(EnnUF_GetPowerColor(uf.unitid));
    end
end

local function UpdateUnitFrameSpecialFlags(uf)
    uf:UpdateHealthColor(EnnUF_GetHealthColor(uf.unitid));
end

------------------------------
-- Unit Frame Event Handles --
------------------------------

EnnUF_UnitFrame_EventHandle = {}

EnnUF_UnitFrame_EventHandle["ADDON_LOADED"] = UpdateUnitFrameFull
EnnUF_UnitFrame_EventHandle["PLAYER_ENTERING_WORLD"] = UpdateUnitFrameFull
EnnUF_UnitFrame_EventHandle["PLAYER_TARGET_CHANGED"] = UpdateUnitFrameFull
EnnUF_UnitFrame_EventHandle["PLAYER_FOCUS_CHANGED"] = UpdateUnitFrameFull
EnnUF_UnitFrame_EventHandle["UNIT_TARGET"] = UpdateUnitFrameFull

EnnUF_UnitFrame_EventHandle["UNIT_HEALTH"] = UpdateUnitFrameHealth
EnnUF_UnitFrame_EventHandle["UNIT_HEALTH_FREQUENT"] = UpdateUnitFrameHealth

EnnUF_UnitFrame_EventHandle["UNIT_MANA"] = UpdateUnitFramePower
EnnUF_UnitFrame_EventHandle["UNIT_ENERGY"] = UpdateUnitFramePower

EnnUF_UnitFrame_EventHandle["UNIT_AURA"] = UpdateUnitFrameSpecialAura
EnnUF_UnitFrame_EventHandle["UNIT_FLAGS"] = UpdateUnitFrameSpecialFlags
