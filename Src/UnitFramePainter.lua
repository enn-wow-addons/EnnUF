-------------------------------------
-- Local Helpers for Paint Manager --
-------------------------------------

-- Returns health color based on a reaction towards player
local function getReactionColor(unit, preset)
    if EnnUF_API_UnitIsPlayer(unit) then
        if not EnnUF_API_UnitIsPVP(unit) then
            return preset.Unflagged
        elseif EnnUF_API_UnitIsFriend(unit, "player") then
            return preset.Friend
        elseif not EnnUF_UnitIsPVP("player") then
            return preset.Neutral
        else
            return preset.Enemy
        end
    else
        local reaction = EnnUF_API_UnitReaction(unit, "player");

        if not reaction then
            return preset.Unknown;
        elseif reaction < 4 then
            return preset.Enemy;
        elseif reaction > 4 then
            return preset.Friend;
        else
            return preset.Neutral;
        end
    end
end

-- Returns power color based on a power type
local function getPowerColor(unit, preset)
    local powerType = EnnUF_API_UnitPowerType(unit);

    if powerType == 0 then
        return preset.Mana;
    elseif powerType == 1 then
        return preset.Rage;
    elseif powerType == 2 then
        return preset.Focus;
    elseif powerType == 3 then
        return preset.Energy;
    else
        return preset.Unknown;
    end
end

-------------------
-- Paint Manager --
-------------------

EnnUF_UnitFramePainter = {}
EnnUF_UnitFramePainter.__index = EnnUF_UnitFramePainter;

-- TODO: feature to support additional color presets
EnnUF_UnitFramePainter.healthColorPreset = EnnUF_Conf.Cols.DefaultHealth;
EnnUF_UnitFramePainter.powerColorPreset = EnnUF_Conf.Cols.DefaultPower;

-- TODO: feature to support additional color handlers
function EnnUF_UnitFramePainter:getHealthColor(unit)
    return getReactionColor(unit, self.healthColorPreset)
end

function EnnUF_UnitFramePainter:getPowerColor(unit)
    return getPowerColor(unit, self.powerColorPreset)
end
