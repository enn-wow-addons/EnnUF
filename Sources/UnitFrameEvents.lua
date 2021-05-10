
------------------------------
-- Unit Frame Event Handles --
------------------------------

EnnUF_UnitFrame_EventHandle = {}

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
