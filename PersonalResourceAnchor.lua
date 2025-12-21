local addonName, addonTable = ...
local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceDB = LibStub("AceDB-3.0")

---@class PersonalResourceDisplayAnchor
local PersonalResourceDisplayAnchor = AceAddon:GetAddon(Enum.Addons.PersonalResourceDisplayAnchor) --[[@as PersonalResourceDisplayAnchor]]
local EssentialCooldownController = AceAddon:GetAddon(Enum.Addons.EssentialCooldownController)
local UtilityCooldownController = AceAddon:GetAddon(Enum.Addons.UtilityCooldownController)
local FrameController = AceAddon:GetAddon(Enum.Addons.FrameController)

local OptionsTitle = "Personal Resource Anchor"
local DBName = "PersonalResourceAnchorDB"
local isPlayerFrameActive = false

function PersonalResourceDisplayAnchor:OnEnable()
	self:InitDB()
	FrameController:Init({ EssentialCooldownController, UtilityCooldownController })
	self:InitOptionsFrames()

	self:RegisterEvent("NAME_PLATE_UNIT_ADDED")
	self:RegisterEvent("NAME_PLATE_UNIT_REMOVED")

	hooksecurefunc(EditModeManagerFrame, "EnterEditMode", function()
		FrameController:EnterEditMode()
	end)

	hooksecurefunc(EditModeManagerFrame, "ExitEditMode", function()
		FrameController:ExitEditMode()
	end)
end

function PersonalResourceDisplayAnchor:InitDB()
	addonTable.db = AceDB:New(DBName, addonTable.defaults, true)
end

function PersonalResourceDisplayAnchor:InitOptionsFrames()
	local options = addonTable:GetOptions()
	AceConfig:RegisterOptionsTable(addonName, options)
	AceConfigDialog:AddToBlizOptions(addonName, OptionsTitle)
end

function PersonalResourceDisplayAnchor:NAME_PLATE_UNIT_ADDED(event, unitToken)
	if UnitIsUnit(unitToken, "player") then
		FrameController:ReAttach()
		isPlayerFrameActive = true
	else
		if not isPlayerFrameActive then
			FrameController:StartupHideFrames()
		end
	end
end

function PersonalResourceDisplayAnchor:NAME_PLATE_UNIT_REMOVED(event, unitToken)
	if UnitIsUnit(unitToken, "player") then
		isPlayerFrameActive = false
		FrameController:PersonalResourceDisplayHidden()
	end
end
