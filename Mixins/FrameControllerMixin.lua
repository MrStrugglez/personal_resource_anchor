local addonName, addonTable = ...
local AceAddon = LibStub("AceAddon-3.0")
local LibEditModeOverride = LibStub("LibEditModeOverride-1.0")

local GameSettingsController = AceAddon:GetAddon(Enum.Addons.GameSettingsController)

addonTable.Mixins.FrameController = {}

function addonTable.Mixins.FrameController:InitFrameData(frame, settings)
	self.frame = frame
	self.settings = settings
	self.originalAnchor, self.originalParent, self.originalParentAnchor, self.originalXOffset, self.originalYOffset =
		frame:GetPoint()
	self.originalScale = frame:GetScale()
end

function addonTable.Mixins.FrameController:Show()
	self.frame:Show()
end

function addonTable.Mixins.FrameController:StartupHide()
	if
		self.settings.inheritPersonalResourceDisplayVisibility
		and self.settings.attach
		and self.settings.visibility == Enum.CooldownViewerVisibleSetting.Always
		and GameSettingsController:GetCVarBool(Enum.CVarKeys.EnablePersonalResource)
	then
		self.frame:Hide()
	end
end

function addonTable.Mixins.FrameController:AttachToPersonalResourceDisplay()
	local personalResourceDisplay = C_NamePlate.GetNamePlateForUnit("player")

	if not personalResourceDisplay then
		return
	end

	if not self.settings.attach then
		return
	end

	self:Show()

	self:UpdateOriginalPoints()

	self:SetScale(self.settings.scale)

	self.frame:ClearAllPoints()

	if self.settings.inheritPersonalResourceDisplayVisibility then
		self:SetPersonalResourceDisplayAsParent()
	else
		self:RestoreParent()
	end

	self.frame:SetPoint(
		self.settings.anchor,
		personalResourceDisplay.UnitFrame,
		self.settings.personalResourceDisplayAnchor,
		self.settings.xOffset,
		self.settings.yOffset
	)
end

function addonTable.Mixins.FrameController:DetachFromPersonalResourceDisplay()
	self:Show()
	self.frame:ClearAllPoints()

	self:RestoreParent()
	self.frame:SetScale(self.originalScale)

	self.frame:SetPoint(
		self.originalAnchor,
		self.originalParent,
		self.originalParentAnchor,
		self.originalXOffset,
		self.originalYOffset
	)
end

function addonTable.Mixins.FrameController:ReAttach()
	self:DetachFromPersonalResourceDisplay()
	self:AttachToPersonalResourceDisplay()
end

function addonTable.Mixins.FrameController:SetPersonalResourceDisplayAsParent()
	local personalResourceDisplay = C_NamePlate.GetNamePlateForUnit("player")
	if not personalResourceDisplay then
		return
	end

	if not self.settings.attach then
		return
	end

	if self.settings.inheritPersonalResourceDisplayVisibility then
		self.frame:SetParent(personalResourceDisplay.UnitFrame)
	end
end

function addonTable.Mixins.FrameController:RestoreParent()
	self.frame:SetParent(self.originalParent)
end

function addonTable.Mixins.FrameController:SetScale(scale)
	self:RestoreParent()
	self.frame:SetScale(scale)
	self:SetPersonalResourceDisplayAsParent()
end

---@param visibility Enum.CooldownViewerVisibleSetting
function addonTable.Mixins.FrameController:SetVisibility(visibility)
	LibEditModeOverride:LoadLayouts()
	LibEditModeOverride:SetFrameSetting(self.frame, Enum.EditModeCooldownViewerSetting.VisibleSetting, visibility)
	LibEditModeOverride:ApplyChanges()
end

function addonTable.Mixins.FrameController:UpdateOriginalPoints()
	self.originalAnchor, self.originalParent, self.originalParentAnchor, self.originalXOffset, self.originalYOffset =
		self.frame:GetPoint()
	self.originalScale = self.frame:GetScale()
end

function addonTable.Mixins.FrameController:OnAttachToggle()
	if self.settings.attach then
		self:StartupHide()
		self:AttachToPersonalResourceDisplay()
	else
		self:DetachFromPersonalResourceDisplay()
	end
end

function addonTable.Mixins.FrameController:OnInheritVisibilityToggle()
	self:ReAttach()
end

function addonTable.Mixins.FrameController:OnVisibilityChange()
	self:SetVisibility(self.settings.visibility)
end
