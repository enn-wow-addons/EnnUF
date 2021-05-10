
------------------------------
-- Player Unit Frame Loader --
------------------------------

local EnnUF_PlayerFrame;

local function EnnUF_PlayerUF_Load()
    EnnUF_PlayerFrame = EnnUF.UnitFrame:new("player", 0, -250, 180, 14);

    EnnUF_PlayerFrame:SetEventHandler(function()
        if EnnUF_UnitFrame_EventHandle[event] then
            EnnUF_UnitFrame_EventHandle[event](EnnUF_PlayerFrame);
        end
    end);

    EnnUF_PlayerFrame:RegisterEvent("ADDON_LOADED");
    EnnUF_PlayerFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
    EnnUF_PlayerFrame:RegisterEvent("PLAYER_AURAS_CHANGED");
    EnnUF_PlayerFrame:RegisterEvent("UNIT_FLAGS");
    EnnUF_PlayerFrame:RegisterEvent("UNIT_HEALTH");
    EnnUF_PlayerFrame:RegisterEvent("UNIT_HEALTH_FREQUENT");
    EnnUF_PlayerFrame:RegisterEvent("UNIT_MANA");
    EnnUF_PlayerFrame:RegisterEvent("UNIT_ENERGY");
end

------------------------------
-- Target Unit Frame Loader --
------------------------------

local EnnUF_TargetFrame;

local function EnnUF_TargetUF_Load()
    EnnUF_TargetFrame = EnnUF.UnitFrame:new("target", 0, -200, 200, 20);

    EnnUF_TargetFrame:SetEventHandler(function()
        if EnnUF_UnitFrame_EventHandle[event] then
            EnnUF_UnitFrame_EventHandle[event](EnnUF_TargetFrame);
        end
    end);

    EnnUF_TargetFrame:RegisterEvent("ADDON_LOADED");
    EnnUF_TargetFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
    EnnUF_TargetFrame:RegisterEvent("PLAYER_TARGET_CHANGED");
    EnnUF_TargetFrame:RegisterEvent("UNIT_AURA");
    EnnUF_TargetFrame:RegisterEvent("UNIT_FLAGS");
    EnnUF_TargetFrame:RegisterEvent("UNIT_HEALTH");
    EnnUF_TargetFrame:RegisterEvent("UNIT_HEALTH_FREQUENT");
    EnnUF_TargetFrame:RegisterEvent("UNIT_MANA");
    EnnUF_TargetFrame:RegisterEvent("UNIT_ENERGY");
end

------------
-- Loader --
------------

EnnUF_PlayerUF_Load();
EnnUF_TargetUF_Load();
