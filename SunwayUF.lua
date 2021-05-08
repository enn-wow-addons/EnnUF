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
            color = EnnUF.Colors.Health.Unflagged
        elseif SunwayUF_UnitIsFriend(unit, "player") then
            color = EnnUF.Colors.Health.Friend
        elseif not SunwayUF_UnitIsPVP("player") then
            color = EnnUF.Colors.Health.Neutral
        else
            color = EnnUF.Colors.Health.Enemy
        end
    else
        local reaction = SunwayUF_UnitReaction(unit, "player");
    
        if not reaction then
            color = EnnUF.Colors.Health.Unknown;
        elseif reaction < 4 then
            color = EnnUF.Colors.Health.Enemy;
        elseif reaction > 4 then
            color = EnnUF.Colors.Health.Friend;
        else
            color = EnnUF.Colors.Health.Neutral;
        end
    end

    uf:SetBarColor("HEALTH", color.r, color.g, color.b, 1);
end

function SunwayUF_UpdatePowerColor(unit, uf)
    local powerType = SunwayUF_UnitPowerType(unit);

    if powerType == 0 then
        color = EnnUF.Colors.Power.Mana;
    elseif powerType == 1 then
        color = EnnUF.Colors.Power.Rage;
    elseif powerType == 2 then
        color = EnnUF.Colors.Power.Focus;
    elseif powerType == 3 then
        color = EnnUF.Colors.Power.Energy;
    else 
        color = EnnUF.Colors.Power.Unknown;
    end

    uf:SetBarColor("POWER", color.r, color.g, color.b, 1);
end

SunwayUF_PlayerUF_Load();
SunwayUF_TargetUF_Load();
