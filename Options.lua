local addonName, addonTable = ...
local AceAddon = LibStub("AceAddon-3.0")

local GameSettingsController = AceAddon:GetAddon(Enum.Addons.GameSettingsController)
local EssentialCooldownController = AceAddon:GetAddon(Enum.Addons.EssentialCooldownController)
local UtilityCooldownController = AceAddon:GetAddon(Enum.Addons.UtilityCooldownController)

local optionsTitle = "Personal Resource Anchor"

function addonTable:GetOptions()
	return {
		name = optionsTitle,
		type = "group",
		args = {
			gameSettings = GameSettingsController:GetOptions(1),
			essentialCooldownViewer = EssentialCooldownController:GetOptions(2),
			utilityCooldownViewer = UtilityCooldownController:GetOptions(3),
		},
	}
end
