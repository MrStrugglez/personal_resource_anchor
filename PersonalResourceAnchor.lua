local LibStub = LibStub
local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceDB = LibStub("AceDB-3.0")
local LibEditModeOverride = LibStub("LibEditModeOverride-1.0")

local addonName, addonTable = ...
local ecvAnchor, ecvParent, ecvParentAnchor, ecvXoffset, ecvYOffset, ecvScale
local ucvAnchor, ucvParent, ucvParentAnchor, ucvXoffset, ucvYOffset, ucvScale
local inEditMode = false

local function setEssentialCooldownPersonalResourceDisplayAsParent()
    local nameplate = C_NamePlate.GetNamePlateForUnit("player")
    if not nameplate then return end

    local profile = addonTable.db.profile
    if not profile.AttachEssential then return end
    EssentialCooldownViewer:SetParent(nameplate.UnitFrame)
end

local function setUtilityCooldownPersonalResourceDisplayAsParent()
    local nameplate = C_NamePlate.GetNamePlateForUnit("player")
    if not nameplate then return end

    local profile = addonTable.db.profile
    if not profile.AttachUtility then return end
    UtilityCooldownViewer:SetParent(nameplate.UnitFrame)
end

local function resetEsstentialCooldownParent()
    local profile = addonTable.db.profile
    if profile.InheritVisibility then return end
    EssentialCooldownViewer:SetParent(ecvParent)
end

local function resetUtilityCooldownParent()
    local profile = addonTable.db.profile
    if profile.InheritVisibility then return end
    UtilityCooldownViewer:SetParent(ucvParent)
end

local function attachEssentialCooldownsToPlayerNameplate()
    local profile = addonTable.db.profile
    if not profile.AttachEssential then return end

    local nameplate = C_NamePlate.GetNamePlateForUnit("player")
    if not nameplate then return end

    if inEditMode then return end

    resetEsstentialCooldownParent()
    EssentialCooldownViewer:SetScale(profile.EssentialScale)

    if profile.InheritVisibility then
        setEssentialCooldownPersonalResourceDisplayAsParent()
    end

    EssentialCooldownViewer:ClearAllPoints()
    EssentialCooldownViewer:SetPoint(profile.EssentialAnchor, nameplate.UnitFrame,
        profile.EssentialPersonalResourceAnchor,
        profile.EssentialOffsetX, profile.EssentialOffsetY)
end

local function attachUtilityCooldownsToPlayerNameplate()
    local profile = addonTable.db.profile
    if not profile.AttachUtility then return end

    local nameplate = C_NamePlate.GetNamePlateForUnit("player")
    if not nameplate then return end

    if inEditMode then return end

    resetUtilityCooldownParent()
    UtilityCooldownViewer:SetScale(profile.UtilityScale)

    if profile.InheritVisibility then
        setUtilityCooldownPersonalResourceDisplayAsParent()
    end

    UtilityCooldownViewer:ClearAllPoints()
    UtilityCooldownViewer:SetPoint(profile.UtilityAnchor, nameplate.UnitFrame, profile.UtilityPersonalResourceAnchor,
        profile.UtilityOffsetX, profile.UtilityOffsetY)
end

local function resetEssentialCooldownsFrame()
    local profile = addonTable.db.profile
    if profile.InheritVisibility then return end

    local nameplate = C_NamePlate.GetNamePlateForUnit("player")
    if not nameplate then return end

    EssentialCooldownViewer:ClearAllPoints()
    resetEsstentialCooldownParent()

    EssentialCooldownViewer:SetScale(ecvScale)

    EssentialCooldownViewer:SetPoint(ecvAnchor, ecvParent, ecvParentAnchor, ecvXoffset, ecvYOffset)
end

local function resetUtilityCooldownsFrame()
    local profile = addonTable.db.profile
    if profile.InheritVisibility then return end

    local nameplate = C_NamePlate.GetNamePlateForUnit("player")
    if not nameplate then return end

    UtilityCooldownViewer:ClearAllPoints()
    resetUtilityCooldownParent()

    UtilityCooldownViewer:SetScale(ucvScale)

    UtilityCooldownViewer:SetPoint(ucvAnchor, ucvParent, ucvParentAnchor, ucvXoffset, ucvYOffset)
end

local function setEssentialCooldownVisibility(visibility) -- Ensure the frame is shown before applying visibility driverFrame
    LibEditModeOverride:LoadLayouts()

    print(Enum.EditModeCooldownViewerSetting.VisibleSetting)
    print(Enum.ActionBarVisibleSetting.Hidden)

    print(visibility)
    if visibility == "ALWAYS_VISIBLE" then
        LibEditModeOverride:SetFrameSetting(EssentialCooldownViewer, Enum.EditModeCooldownViewerSetting.VisibleSetting,
            Enum.CooldownViewerVisibleSetting.Always)
    elseif visibility == "IN_COMBAT" then
        LibEditModeOverride:SetFrameSetting(EssentialCooldownViewer, Enum.EditModeCooldownViewerSetting.VisibleSetting,
            Enum.CooldownViewerVisibleSetting.InCombat)
    elseif visibility == "HIDDEN" then
        LibEditModeOverride:SetFrameSetting(EssentialCooldownViewer, Enum.EditModeCooldownViewerSetting.VisibleSetting,
            Enum.CooldownViewerVisibleSetting.Hidden)
    end
    LibEditModeOverride:ApplyChanges()
end

local function setUtilityCooldownVisibility(visibility) -- Ensure the frame is shown before applying visibility driverFrame
    LibEditModeOverride:LoadLayouts()

    print(Enum.EditModeCooldownViewerSetting.VisibleSetting)
    print(Enum.ActionBarVisibleSetting.Hidden)

    print(visibility)
    if visibility == "ALWAYS_VISIBLE" then
        LibEditModeOverride:SetFrameSetting(UtilityCooldownViewer, Enum.EditModeCooldownViewerSetting.VisibleSetting,
            Enum.CooldownViewerVisibleSetting.Always)
    elseif visibility == "IN_COMBAT" then
        LibEditModeOverride:SetFrameSetting(UtilityCooldownViewer, Enum.EditModeCooldownViewerSetting.VisibleSetting,
            Enum.CooldownViewerVisibleSetting.InCombat)
    elseif visibility == "HIDDEN" then
        LibEditModeOverride:SetFrameSetting(UtilityCooldownViewer, Enum.EditModeCooldownViewerSetting.VisibleSetting,
            Enum.CooldownViewerVisibleSetting.Hidden)
    end
    LibEditModeOverride:ApplyChanges()
end


EventRegistry:RegisterFrameEventAndCallback("EDIT_MODE_LAYOUTS_UPDATED", function()
    print("EDIT_MODE_LAYOUTS_UPDATED event received, saving cooldown viewer frame positions")
    ecvAnchor, ecvParent, ecvParentAnchor, ecvXoffset, ecvYOffset = EssentialCooldownViewer:GetPoint()
    ecvScale = EssentialCooldownViewer:GetScale()
    ucvAnchor, ucvParent, ucvParentAnchor, ucvXoffset, ucvYOffset = UtilityCooldownViewer:GetPoint()
    ucvScale = UtilityCooldownViewer:GetScale()
end)


local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("NAME_PLATE_UNIT_ADDED")
eventFrame:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventFrame:SetScript("OnEvent", function(self, event, unit)
    if (event == "PLAYER_ENTERING_WORLD") then
        hooksecurefunc(EditModeManagerFrame, "EnterEditMode", function()
            inEditMode = true
            resetEssentialCooldownsFrame()
            resetUtilityCooldownsFrame()
        end)

        hooksecurefunc(EditModeManagerFrame, "ExitEditMode", function()
            inEditMode = false
            attachEssentialCooldownsToPlayerNameplate()
            attachUtilityCooldownsToPlayerNameplate()
        end)
    end

    if (event == "NAME_PLATE_UNIT_ADDED" and (UnitIsUnit(unit, "player"))) then
        resetEssentialCooldownsFrame()
        attachEssentialCooldownsToPlayerNameplate()

        resetUtilityCooldownsFrame()
        attachUtilityCooldownsToPlayerNameplate()
    elseif (event == "NAME_PLATE_UNIT_REMOVED" and (UnitIsUnit(unit, "player"))) then
        resetEssentialCooldownsFrame()
        resetUtilityCooldownsFrame()
    end
end)




-- **1. Default Settings**
local defaults = {
    profile = {
        AttachEssential = true,
        AttachUtility = false,
        InheritVisibility = true,

        EssentialScale = 1.0,
        UtilityScale = 1.0,

        EssentialVisibility = "Always visible",
        UtilityVisibility = "In combat",

        EssentialPersonalResourceAnchor = "CENTER",
        ResourceAnchor = "CENTER",
        EssentialAnchor = "TOP",
        UtilityAnchor = "BOTTOM",

        EssentialOffsetX = 0,
        EssentialOffsetY = 30,
        UtilityOffsetX = 0,
        UtilityOffsetY = -30,
    },
}


-- **3. Addon Initialization**
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, name)
    if name == addonName then
        self:UnregisterAllEvents()
        PersonalResourceAnchor_OnInitialize()
    end
end)

-- **5. Initialization Logic**
function PersonalResourceAnchor_OnInitialize()
    addonTable.db = AceDB:New("PersonalResourceAnchorDB", defaults, true)
    local options = PersonalResourceAnchor_GetOptions(addonTable.db,
        addonTable.OnAttachEssential,
        addonTable.OnAttachUtility,
        addonTable.OnInheritVisibility,
        addonTable.OnVisibilityChange,
        addonTable.OnEssentialScaleChange,
        addonTable.OnUtilityScaleChange,
        addonTable.OnPositionChange)
    AceConfig:RegisterOptionsTable(addonName, options)
    addonTable.optionsFrame = AceConfigDialog:AddToBlizOptions(addonName, "Personal Resource Anchor")
end

function addonTable.OnAttachEssential()
    local settings = addonTable.db.profile

    if settings.AttachEssential then
        attachEssentialCooldownsToPlayerNameplate()
    else
        resetEssentialCooldownsFrame()
    end
end

function addonTable.OnAttachUtility()
    local settings = addonTable.db.profile

    if settings.AttachUtility then
        attachUtilityCooldownsToPlayerNameplate()
    else
        resetUtilityCooldownsFrame()
    end
end

function addonTable.OnInheritVisibility()
    local settings = addonTable.db.profile

    if settings.InheritVisibility then
        setEssentialCooldownPersonalResourceDisplayAsParent()
        setUtilityCooldownPersonalResourceDisplayAsParent()

        LibEditModeOverride:LoadLayouts()
        LibEditModeOverride:SetFrameSetting(EssentialCooldownViewer, Enum.EditModeCooldownViewerSetting.VisibleSetting,
            Enum.CooldownViewerVisibleSetting.Always)
        LibEditModeOverride:ApplyChanges()

        settings.EssentialVisibility = "ALWAYS_VISIBLE"
        settings.UtilityVisibility = "ALWAYS_VISIBLE"
    else
        resetEsstentialCooldownParent()
        resetUtilityCooldownParent()
    end
end

function addonTable.OnVisibilityChange()
    local settings = addonTable.db.profile

    if settings.EssentialVisibility then
        setEssentialCooldownVisibility(settings.EssentialVisibility)
    end

    if settings.UtilityVisibility then
        setUtilityCooldownVisibility(settings.UtilityVisibility)
    end
end

function addonTable.OnPositionChange()
    local settings = addonTable.db.profile
    local nameplate = C_NamePlate.GetNamePlateForUnit("player")

    if not nameplate then return end

    print("Utilty Personal Resource Anchor:")
    print(settings.UtilityPersonalResourceAnchor)
    print(settings.UtilityAnchor)

    print("Essential Personal Resource Anchor:")
    print(settings.EssentialPersonalResourceAnchor)
    print(settings.EssentialAnchor)

    if settings.AttachEssential and
        settings.EssentialPersonalResourceAnchor and
        settings.EssentialAnchor and
        settings.EssentialOffsetX and
        settings.EssentialOffsetY then
        EssentialCooldownViewer:ClearAllPoints()
        EssentialCooldownViewer:SetPoint(settings.EssentialAnchor, nameplate.UnitFrame,
            settings.EssentialPersonalResourceAnchor,
            settings.EssentialOffsetX, settings.EssentialOffsetY)
    end

    if settings.AttachUtility and
        settings.UtilityPersonalResourceAnchor and
        settings.UtilityAnchor and
        settings.UtilityOffsetX and
        settings.UtilityOffsetY then
        UtilityCooldownViewer:ClearAllPoints()
        UtilityCooldownViewer:SetPoint(settings.UtilityAnchor, nameplate.UnitFrame,
            settings.UtilityPersonalResourceAnchor,
            settings.UtilityOffsetX, settings.UtilityOffsetY)
    end
end

function addonTable.OnEssentialScaleChange()
    local settings = addonTable.db.profile

    if
        settings.EssentialScale then
        resetEssentialCooldownsFrame()
        attachEssentialCooldownsToPlayerNameplate()
    end
end

function addonTable.OnUtilityScaleChange()
    local settings = addonTable.db.profile

    if
        settings.UtilityScale then
        resetUtilityCooldownsFrame()
        attachUtilityCooldownsToPlayerNameplate()
    end
end
