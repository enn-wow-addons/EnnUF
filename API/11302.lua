
------------------
-- API For 1.13 --
------------------

if false then

    function SunwayUF_ChatMsg(text)
        DEFAULT_CHAT_FRAME:AddMessage(text);
    end

    function SunwayUF_GetHealthPercentage(unit)
        return UnitHealth(unit) / UnitHealthMax(unit);
    end

    function SunwayUF_GetPowerPercentage(unit, type)
        return UnitPower(unit, type) / UnitPowerMax(unit, type);
    end

    function SunwayUF_UnitClass(unit)
        local localizedClass, englishClass = UnitClass(unit);
        return localizedClass, englishClass;
    end

    SunwayUF_UnitReaction = UnitReaction;
    SunwayUF_UnitIsPVP = UnitIsPVP;

    function SunwayUF_UnitPowerType(unit)
        local powerType, powerTypeString = UnitPowerType(unit);
        return powerType, powerTypeString;
    end

    SunwayUF_UnitIsPlayer = UnitIsPlayer;
    SunwayUF_UnitIsFriend = UnitIsFriend;

end
