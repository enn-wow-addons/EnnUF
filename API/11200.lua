
------------------
-- API For 1.12 --
------------------

if true then

    function SunwayUF_ChatMsg(text)
        DEFAULT_CHAT_FRAME:AddMessage(text);
    end

    function SunwayUF_GetHealthPercentage(unit)
        return UnitHealth(unit) / UnitHealthMax(unit);
    end

    function SunwayUF_GetPowerPercentage(unit, type)
        return UnitMana(unit) / UnitManaMax(unit);
    end

    SunwayUF_UnitClass = UnitClass;
    SunwayUF_UnitReaction = UnitReaction;
    SunwayUF_UnitIsPVP = UnitIsPVP;
    SunwayUF_UnitPowerType = UnitPowerType;
    SunwayUF_UnitIsPlayer = UnitIsPlayer;
    SunwayUF_UnitIsFriend = UnitIsFriend;

end
