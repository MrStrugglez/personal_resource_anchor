local addonName, addonTable = ...
local AceAddon = LibStub("AceAddon-3.0")

---@class EssentialCooldownController
local EssentialCooldownController = AceAddon:GetAddon(Enum.Addons.EssentialCooldownController) --[[@as EssentialCooldownController]]
local GameSettingsController = AceAddon:GetAddon(Enum.Addons.GameSettingsController)
local AceConfigPreset = AceAddon:GetAddon(Enum.Addons.AceConfigPreset)

local FrameControllerMixin = addonTable.Mixins.FrameController
EssentialCooldownController = Mixin(EssentialCooldownController, FrameControllerMixin)

local title = "Essential Cooldown Viewer"
local description = "Settings related to the Essential Cooldown Viewer frame."

function EssentialCooldownController:Init()
	local frame = EssentialCooldownViewer
	local settings = addonTable.db.global.essentialCooldownViewer
	self:InitFrameData(frame, settings)
end

function EssentialCooldownController:GetOptions(order)
	return AceConfigPreset:CooldownBarSettings(
		title,
		description,
		self.settings,
		order,
		GameSettingsController,
		function()
			self:OnAttachToggle()
		end,
		function()
			self:OnInheritVisibilityToggle()
		end,
		function()
			self:OnVisibilityChange()
		end,
		function()
			self:ReAttach()
		end
	)
end
