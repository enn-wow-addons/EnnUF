local version, build, date, toc = GetBuildInfo();

-----------------------------------------
-- API Overrides for Vanilla (1.12.1+) --
-----------------------------------------

function EnnUF_API_ChatMsg(text)
    DEFAULT_CHAT_FRAME:AddMessage(text);
end

EnnUF_API_UnitExists = UnitExists;
EnnUF_API_UnitClass = UnitClass;
EnnUF_API_UnitReaction = UnitReaction;
EnnUF_API_UnitIsPlayer = UnitIsPlayer;
EnnUF_API_UnitIsFriend = UnitIsFriend;
EnnUF_API_UnitIsPVP = UnitIsPVP;

function EnnUF_API_UnitHealthRel(unit)
    return UnitHealth(unit) / UnitHealthMax(unit);
end

EnnUF_API_UnitHealthAbs = UnitHealth;

EnnUF_API_UnitPowerRel = function(unit, type)
    return UnitMana(unit) / UnitManaMax(unit);
end

EnnUF_API_UnitPowerAbs = function(unit, type)
    return UnitMana(unit);
end

EnnUF_API_UnitPowerType = UnitPowerType;

----------------------------------------------
-- API Overrides for Wotlk Vanilla (3.0.0+) --
----------------------------------------------

if toc < 30000 then return end;

EnnUF_API_UnitPowerRel = function(unit, type)
    return UnitPower(unit, type) / UnitPowerMax(unit, type);
end

EnnUF_API_UnitPowerAbs = UnitPower;

----------------------------------------------
-- API Overrides for Wotlk Classic (3.4.0+) --
----------------------------------------------

if toc < 30400 then return end;

-- TODO: move hardcoded overrides here
