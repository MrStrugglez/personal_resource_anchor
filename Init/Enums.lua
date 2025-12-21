local addonName, addonTable = ...
AceAddon = LibStub("AceAddon-3.0")

---@enum Enum.Addons
Enum.Addons = {
	GameSettingsController = "GameSettingController",
	EssentialCooldownController = "EssentialCooldownController",
	UtilityCooldownController = "UtilityCooldownController",
	AceConfigPreset = "AceConfigPreset",
	FrameController = "FrameController",
	PersonalResourceDisplayAnchor = "PersonalResourceDisplayAnchor",
}

---@enum Enum.CVarKeys
Enum.CVarKeys = {
	EnablePersonalResource = "nameplateShowSelf",
	ShowFriendlyBuffs = "nameplateShowFriendlyBuffs",
	NameplatePersonalClickThrough = "NameplatePersonalClickThrough",
	NameplatePersonalHideDelayAlpha = "NameplatePersonalHideDelayAlpha",
	NameplatePersonalHideDelaySeconds = "NameplatePersonalHideDelaySeconds",
	NameplatePersonalShowAlways = "NameplatePersonalShowAlways",
	NameplatePersonalShowInCombat = "NameplatePersonalShowInCombat",
	NameplatePersonalShowWithTarget = "NameplatePersonalShowWithTarget",
	EnablePersonalResourceCooldowns = "nameplateShowPersonalCooldowns",
	EnableCooldownViewer = "cooldownViewerEnabled",
}

---@enum Enum.FrameAnchors
Enum.FrameAnchors = {
	TopLeft = "TOPLEFT",
	Top = "TOP",
	TopRight = "TOPRIGHT",
	Left = "LEFT",
	Center = "CENTER",
	Right = "RIGHT",
	BottomLeft = "BOTTOMLEFT",
	Bottom = "BOTTOM",
	BottomRight = "BOTTOMRIGHT",
}

---@enum Enum.PersonalResourceDisplayWithTargetVisibilityOptions
Enum.PersonalResourceDisplayWithTargetVisibilityOptions = {
	[0] = "Disabled",
	[1] = "With Hostile Targets",
	[2] = "With Any Target",
}

---@enum Enum.EditModeVisibilityOptions
Enum.EditModeVisibilityOptions = {
	[Enum.CooldownViewerVisibleSetting.Always] = "Always visible",
	[Enum.CooldownViewerVisibleSetting.InCombat] = "In combat",
	[Enum.CooldownViewerVisibleSetting.Hidden] = "Hidden",
}

---@enum Enum.FrameAnchorOptions
Enum.FrameAnchorOptions = {
	[Enum.FrameAnchors.TopLeft] = "Top Left",
	[Enum.FrameAnchors.Top] = "Top",
	[Enum.FrameAnchors.TopRight] = "Top Right",
	[Enum.FrameAnchors.Left] = "Left",
	[Enum.FrameAnchors.Center] = "Center",
	[Enum.FrameAnchors.Right] = "Right",
	[Enum.FrameAnchors.BottomLeft] = "Bottom Left",
	[Enum.FrameAnchors.Bottom] = "Bottom",
	[Enum.FrameAnchors.BottomRight] = "Bottom Right",
}
