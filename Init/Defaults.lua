local addonName, addonTable = ...

addonTable.Mixins = {}

addonTable.defaults = {
	global = {
		gameSettingsController = {
			personalResourceDisplayEnabled = false,
		},
		essentialCooldownViewer = {
			attach = true,
			inheritPersonalResourceDisplayVisibility = true,
			visibility = Enum.CooldownViewerVisibleSetting.Always,
			personalResourceDisplayAnchor = Enum.FrameAnchors.Bottom,
			anchor = Enum.FrameAnchors.Top,
			xOffset = 0,
			yOffset = 0,
			scale = 1.0,
		},
		utilityCooldownViewer = {
			attach = true,
			inheritPersonalResourceDisplayVisibility = true,
			visibility = Enum.CooldownViewerVisibleSetting.Always,
			personalResourceDisplayAnchor = Enum.FrameAnchors.Bottom,
			anchor = Enum.FrameAnchors.Top,
			xOffset = 0,
			yOffset = 0,
			scale = 1.0,
		},
	},
}
