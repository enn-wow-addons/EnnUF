
SunwayUF_Colors = {}

SunwayUF_Colors.Health = {}
SunwayUF_Colors.Health.Friend    = { r=0, g=1, b=0 }
SunwayUF_Colors.Health.Enemy     = { r=1, g=0, b=0 }
SunwayUF_Colors.Health.Neutral   = { r=1, g=1, b=0 }
SunwayUF_Colors.Health.Unflagged = { r=0, g=0.2, b=1 }
SunwayUF_Colors.Health.Unknown   = { r=1, g=1, b=1 }

SunwayUF_Colors.Power = {}
SunwayUF_Colors.Power.Mana    = { r=0.3, g=0.3, b=1 }
SunwayUF_Colors.Power.Rage    = { r=1, g=0.3, b=0.3 }
SunwayUF_Colors.Power.Focus   = { r=1, g=0.6, b=0.3 }
SunwayUF_Colors.Power.Energy  = { r=1, g=1, b=0.3 }

SunwayUF_Colors.Power.Unknown = { r=1, g=1, b=1 }

function SunwayUF_UpdateHealth(unit, uf)
    uf:SetBarRelativeWidth("HEALTH", SunwayUF_GetHealthPercentage(unit));
end

function SunwayUF_UpdatePower(unit, uf)
    uf:SetBarRelativeWidth("POWER", SunwayUF_GetPowerPercentage(unit));
end

function SunwayUF_UpdateHealthText(unit, uf)
    uf:SetBarText("HEALTH", SunwayUF_UnitHealth(unit));
end

function SunwayUF_UpdatePowerText(unit, uf)
    uf:SetBarText("POWER", SunwayUF_UnitPower(unit));
end

function SunwayUF_UpdateHealthColor(unit, uf)
    local color;

    if SunwayUF_UnitIsPlayer(unit) then
        if not SunwayUF_UnitIsPVP(unit) then
            color = SunwayUF_Colors.Health.Unflagged
        elseif SunwayUF_UnitIsFriend(unit, "player") then
            color = SunwayUF_Colors.Health.Friend
        elseif not SunwayUF_UnitIsPVP("player") then
            color = SunwayUF_Colors.Health.Neutral
        else
            color = SunwayUF_Colors.Health.Enemy
        end
    else
        local reaction = SunwayUF_UnitReaction(unit, "player");
    
        if not reaction then
            color = SunwayUF_Colors.Health.Unknown;
        elseif reaction < 4 then
            color = SunwayUF_Colors.Health.Enemy;
        elseif reaction > 4 then
            color = SunwayUF_Colors.Health.Friend;
        else
            color = SunwayUF_Colors.Health.Neutral;
        end
    end

    uf:SetBarColor("HEALTH", color.r, color.g, color.b, 1);
end

function SunwayUF_UpdatePowerColor(unit, uf)
    local powerType = SunwayUF_UnitPowerType(unit);

    if powerType == 0 then
        color = SunwayUF_Colors.Power.Mana;
    elseif powerType == 1 then
        color = SunwayUF_Colors.Power.Rage;
    elseif powerType == 2 then
        color = SunwayUF_Colors.Power.Focus;
    elseif powerType == 3 then
        color = SunwayUF_Colors.Power.Energy;
    else 
        color = SunwayUF_Colors.Power.Unknown;
    end

    uf:SetBarColor("POWER", color.r, color.g, color.b, 1);
end

SunwayUF_PlayerUF_Load();
SunwayUF_TargetUF_Load();
