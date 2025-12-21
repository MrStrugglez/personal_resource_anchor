local addonName, addonTable = ...
local AceAddon = LibStub("AceAddon-3.0")

---@class UtilityCooldownController
local UtilityCooldownController = AceAddon:GetAddon(Enum.Addons.UtilityCooldownController) --[[@as UtilityCooldownController]]
local GameSettingsController = AceAddon:GetAddon(Enum.Addons.GameSettingsController)
local AceConfigPreset = AceAddon:GetAddon(Enum.Addons.AceConfigPreset)

local FrameControllerMixin = addonTable.Mixins.FrameController
UtilityCooldownController = Mixin(UtilityCooldownController, FrameControllerMixin)

local title = "Utility Cooldown Viewer"
local description = "Settings related to the Utility Cooldown Viewer frame."

function UtilityCooldownController:Init()
	local frame = UtilityCooldownViewer
	local settings = addonTable.db.global.utilityCooldownViewer
	self:InitFrameData(frame, settings)
end

function UtilityCooldownController:GetOptions(order)
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
