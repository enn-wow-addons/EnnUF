
local version, build, date, toc = GetBuildInfo();

-----------------
-- API Helpers --
-----------------

function EnnUF_ChatMsg(text)
    DEFAULT_CHAT_FRAME:AddMessage(text);
end

function EnnUF_UnitHealthRel(unit)
    return UnitHealth(unit) / UnitHealthMax(unit);
end

if toc >= 30000 then
    function EnnUF_UnitPowerRel(unit, type)
        return UnitPower(unit, type) / UnitPowerMax(unit, type);
    end

    EnnUF_UnitPowerAbs = UnitPower;
else
    function EnnUF_UnitPowerRel(unit, type)
        return UnitMana(unit) / UnitManaMax(unit);
    end

    function EnnUF_UnitPowerAbs(unit, type)
        return UnitMana(unit);
    end
end

EnnUF_UnitExists = UnitExists;

EnnUF_UnitIsPlayer = UnitIsPlayer;
EnnUF_UnitIsFriend = UnitIsFriend;
EnnUF_UnitIsPVP = UnitIsPVP;

EnnUF_UnitHealthAbs = UnitHealth;
EnnUF_UnitPowerType = UnitPowerType;
EnnUF_UnitReaction = UnitReaction;
EnnUF_UnitClass = UnitClass;

-------------------
-- Other Helpers --
-------------------

function EnnUF_UnitHealthColor(unit)
    if EnnUF_UnitIsPlayer(unit) then
        if not EnnUF_UnitIsPVP(unit) then
            return EnnUF.Colors.Health.Unflagged
        elseif EnnUF_UnitIsFriend(unit, "player") then
            return EnnUF.Colors.Health.Friend
        elseif not EnnUF_UnitIsPVP("player") then
            return EnnUF.Colors.Health.Neutral
        else
            return EnnUF.Colors.Health.Enemy
        end
    else
        local reaction = EnnUF_UnitReaction(unit, "player");

        if not reaction then
            return EnnUF.Colors.Health.Unknown;
        elseif reaction < 4 then
            return EnnUF.Colors.Health.Enemy;
        elseif reaction > 4 then
            return EnnUF.Colors.Health.Friend;
        else
            return EnnUF.Colors.Health.Neutral;
        end
    end
end

function EnnUF_UnitPowerColor(unit, uf)
    local powerType = EnnUF_UnitPowerType(unit);

    if powerType == 0 then
        return EnnUF.Colors.Power.Mana;
    elseif powerType == 1 then
        return EnnUF.Colors.Power.Rage;
    elseif powerType == 2 then
        return EnnUF.Colors.Power.Focus;
    elseif powerType == 3 then
        return EnnUF.Colors.Power.Energy;
    else
        return EnnUF.Colors.Power.Unknown;
    end
end
