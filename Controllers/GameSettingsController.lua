local addonName, addonTable = ...

local AceAddon = LibStub("AceAddon-3.0")
---@class GameSettingsController
local GameSettingsController = AceAddon:GetAddon(Enum.Addons.GameSettingsController) --[[@as GameSettingsController]]
local AceConfigPreset = AceAddon:GetAddon(Enum.Addons.AceConfigPreset)
local FrameController = AceAddon:GetAddon(Enum.Addons.FrameController)

---@param cvarKey Enum.CVarKeys
---@return boolean?
function GameSettingsController:GetCVarBool(cvarKey)
	return GetCVarBool(cvarKey)
end

---@param cvarKey Enum.CVarKeys
---@return number?
function GameSettingsController:GetCVarNumber(cvarKey)
	return tonumber(GetCVar(cvarKey))
end

---@param cvarKey Enum.CVarKeys
function GameSettingsController:SetCVar(cvarKey, value)
	return SetCVar(cvarKey, value)
end

function GameSettingsController:SetPersonalResourceDisplay(enable)
	SetCVar(Enum.CVarKeys.EnablePersonalResource, enable)

	if enable then
		FrameController:StartupHideFrames()
	end

	if not enable and GameSettingsController:GetCooldownViewer() then
		FrameController:DetachFrames()
	end
end

---@returns Enum.PersonalResourceDisplayVisibilityOptions
function GameSettingsController:GetPersonalResourceDisplayVisibility()
	local showAlways = GetCVarBool(Enum.CVarKeys.NameplatePersonalShowAlways)
	local showInCombat = GetCVarBool(Enum.CVarKeys.NameplatePersonalShowInCombat)

	if showAlways and not showInCombat then
		return Enum.CVarKeys.NameplatePersonalShowAlways
	elseif showInCombat and not showAlways then
		return Enum.CVarKeys.NameplatePersonalShowInCombat
	end
end

function GameSettingsController:SetCooldownViewer(enable)
	if not enable then
		FrameController:DetachFrames()
	end

	if enable then
		FrameController:StartupHideFrames()
	end

	SetCVar(Enum.CVarKeys.EnableCooldownViewer, enable)
end

function GameSettingsController:GetOptions(order)
	return AceConfigPreset:GameSettings(order, self)
end
