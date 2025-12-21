local addonName, addonTable = ...
local AceAddon = LibStub("AceAddon-3.0")

---@class AceConfigPreset
local AceConfigPreset = AceAddon:GetAddon(Enum.Addons.AceConfigPreset) --[[@as AceConfigPreset]]

function AceConfigPreset:Header(title, order)
	return { type = "header", name = title, order = order }
end

function AceConfigPreset:InfoBanner(order, info)
	return {
		type = "group",
		name = "Information",
		inline = true,
		order = order,
		args = {
			infoBanner = {
				order = 1,
				type = "description",
				fontSize = "medium",
				name = info,
			},
		},
	}
end

function AceConfigPreset:Spacer(order)
	return {
		order = order,
		type = "description",
		fontSize = "medium",
		name = " ",
	}
end

function AceConfigPreset:CooldownViewerSettings(order, GameSettingsController)
	return {
		type = "group",
		inline = true,
		name = "Cooldown Viewer",
		order = order,
		args = {
			enableCooldownViewer = {
				order = 1,
				type = "toggle",
				name = "Enable Cooldown Manager",
				width = "double",
				desc = "This enables/disables the in-game Cooldown Viewer and all associated frames. \n\n Gameplay -> Gameplay Enhancements -> Cooldown Viewer \n",
				get = function()
					return GameSettingsController:GetCVarBool(Enum.CVarKeys.EnableCooldownViewer)
				end,
				set = function(info, val)
					GameSettingsController:SetCooldownViewer(val)
				end,
			},
		},
	}
end

function AceConfigPreset:PersonalResourceDisplaySettings(order, GameSettingsController)
	return {
		type = "group",
		inline = true,
		name = "Personal Resource Display",
		order = order,
		args = {
			personalResourceDisplay = {
				order = 1,
				type = "toggle",
				name = "Enable Personal Resource Display",
				width = "double",
				desc = "Add Health and Resource below your character. \n\n Gameplay -> Combat -> Personal Resource Display",
				get = function()
					return GameSettingsController:GetCVarBool(Enum.CVarKeys.EnablePersonalResource)
				end,
				set = function(info, val)
					GameSettingsController:SetPersonalResourceDisplay(val)
				end,
			},

			friendlyBuffs = {
				order = 2,
				type = "toggle",
				name = "Show Friendly Buffs",
				width = "double",
				desc = "Show friendly buffs under your character \n\n Gameplay -> Combat",
				get = function()
					return GameSettingsController:GetCVarBool(Enum.CVarKeys.ShowFriendlyBuffs)
				end,
				set = function(info, val)
					GameSettingsController:SetCVar(Enum.CVarKeys.ShowFriendlyBuffs, val)
				end,
				disabled = function()
					return not GameSettingsController:GetCVarBool(Enum.CVarKeys.EnablePersonalResource)
				end,
			},

			personalResourceDisplayCooldowns = {
				order = 3,
				type = "toggle",
				name = "Show Personal Cooldowns",
				width = "double",
				desc = "Show cooldowns for important spells under your character \n\n Gameplay -> Combat -> Personal Resource Display",
				get = function()
					return GameSettingsController:GetCVarBool(Enum.CVarKeys.EnablePersonalResourceCooldowns)
				end,
				set = function(info, val)
					GameSettingsController:SetCVar(Enum.CVarKeys.EnablePersonalResourceCooldowns, val)
				end,
				disabled = function()
					return not GameSettingsController:GetCVarBool(Enum.CVarKeys.EnablePersonalResource)
				end,
			},

			clickThrough = {
				order = 4,
				type = "toggle",
				name = "Make Click-Through",
				width = "double",
				desc = "Add Health and Resource below your character. \n\n Gameplay -> Combat -> Personal Resource Display",
				get = function()
					return GameSettingsController:GetCVarBool(Enum.CVarKeys.NameplatePersonalClickThrough)
				end,
				set = function(info, val)
					GameSettingsController:SetCVar(Enum.CVarKeys.NameplatePersonalClickThrough, val)
				end,
			},

			spacer1 = self:Spacer(5),

			personalResourceDisplayVisibilitySetting = self:PersonalResourceDisplayVisibilitySettings(
				6,
				GameSettingsController
			),
		},
	}
end

function AceConfigPreset:PersonalResourceDisplayVisibilitySettings(order, GameSettingsController)
	return {
		type = "group",
		name = "Visibility",
		order = order,
		args = {
			showAlways = {
				order = 1,
				type = "toggle",
				width = "double",
				name = "Show Always",
				desc = "Determines if the the Personal Resource Display is always shown",
				get = function()
					return GameSettingsController:GetCVarBool(Enum.CVarKeys.NameplatePersonalShowAlways)
				end,
				set = function(info, val)
					GameSettingsController:SetCVar(Enum.CVarKeys.NameplatePersonalShowAlways, val)
				end,
			},

			showInCombat = {
				order = 2,
				type = "toggle",
				width = "double",

				name = "Show In Combat",
				desc = "Determines if the the Personal Resource Display is shown only in combat",
				get = function()
					return GameSettingsController:GetCVarBool(Enum.CVarKeys.NameplatePersonalShowInCombat)
				end,
				set = function(info, val)
					GameSettingsController:SetCVar(Enum.CVarKeys.NameplatePersonalShowInCombat, val)
				end,
			},

			spacer1 = self:Spacer(3),

			showWithTarget = {
				order = 4,
				type = "select",
				width = "normal",
				name = "Show With Target",
				desc = "Determines how the Personal Resource Display is shown when selecting a target.",
				values = Enum.PersonalResourceDisplayWithTargetVisibilityOptions,
				get = function()
					return GameSettingsController:GetCVarNumber(Enum.CVarKeys.NameplatePersonalShowWithTarget)
				end,
				set = function(info, val)
					GameSettingsController:SetCVar(Enum.CVarKeys.NameplatePersonalShowWithTarget, val)
				end,
			},

			spacer2 = self:Spacer(5),

			hideDelaySeconds = {
				order = 6,
				type = "range",
				name = "Hide Delay Seconds",
				min = 0,
				max = 10,
				step = 0.1,
				desc = "Determines the length of time in seconds that the Personal Resource Display will be visible after no visibility conditions are met.",
				get = function()
					return GameSettingsController:GetCVarNumber(Enum.CVarKeys.NameplatePersonalHideDelaySeconds)
				end,
				set = function(info, val)
					GameSettingsController:SetCVar(Enum.CVarKeys.NameplatePersonalHideDelaySeconds, val)
				end,
			},

			hideDelayAlpha = {
				order = 7,
				type = "range",
				name = "Hide Delay Alpha",
				min = 0,
				max = 1,
				step = 0.01,
				desc = "Determines the alpha of the Personal Resource Display after no visibility conditions are met (during the period of time specified by Hide Delay Seconds). ",
				get = function()
					return GameSettingsController:GetCVarNumber(Enum.CVarKeys.NameplatePersonalHideDelayAlpha)
				end,
				set = function(info, val)
					GameSettingsController:SetCVar(Enum.CVarKeys.NameplatePersonalHideDelayAlpha, val)
				end,
			},
		},
	}
end

function AceConfigPreset:GameSettings(order, GameSettingsController)
	return {
		type = "group",
		name = "Game Settings",
		order = order,
		args = {
			info = self:InfoBanner(
				1,
				"These settings modify the game settings themselves. Refer to the Tooltip for where to find it in the official settings."
			),
			cooldownViewerSetting = self:CooldownViewerSettings(2, GameSettingsController),
			personalResourceDisplaySetting = self:PersonalResourceDisplaySettings(3, GameSettingsController),
		},
	}
end

function AceConfigPreset:CooldownBarSettings(
	title,
	description,
	settings,
	order,
	GameSettingsController,
	onAttachToggle,
	onInheritVisibilityToggle,
	onVisibilityChange,
	OnReAttach
)
	return {
		type = "group",
		name = title,
		order = order,
		args = {
			attachGroup = {
				type = "group",
				inline = true,
				name = title,
				order = 1,
				args = {
					attach = {
						order = 1,
						type = "toggle",
						name = "Attach",
						width = "full",
						desc = "Attach the "
							.. title
							.. " to the Personal Resource Display. This will only happen once the Personal Resource Display is shown.",
						get = function()
							return settings.attach
						end,
						set = function(info, val)
							settings.attach = val
							onAttachToggle()
						end,
						disabled = function()
							return not GameSettingsController:GetCVarBool(Enum.CVarKeys.EnablePersonalResource)
						end,
					},
				},
			},

			visibilityGroup = {
				type = "group",
				inline = true,
				name = "Visibility",
				order = 2,
				args = {
					visibility = {
						order = 1,
						type = "select",
						name = "Visibility",
						desc = "Setting this changes the frame visibility setting in Edit Mode using the Edit Mode API. \n\n Invoking the API closes the setting window. \n\n This works independent of the 'Inherit Personal Resource Display visibility' settings",
						values = Enum.EditModeVisibilityOptions,
						get = function()
							return settings.visibility
						end,
						set = function(val)
							settings.visibility = val
							onVisibilityChange()
						end,
						disabled = function()
							return not GameSettingsController:GetCVarBool(Enum.CVarKeys.EnablePersonalResource)
						end,
					},

					spacer1 = self:Spacer(2),

					inheritVisibility = {
						order = 3,
						type = "toggle",
						name = "Inherit Personal Resource Display visibility",
						width = "full",
						desc = "Inherit the visibility settings from the Personal Resource Display. Meaning the "
							.. title
							.. " will show/hide along with the Personal Resource Display regardless of the combat state. It is adviced you set the visibility setting to 'Always Visible' for best experience.",
						get = function()
							return settings.inheritPersonalResourceDisplayVisibility
						end,
						set = function(val)
							settings.inheritPersonalResourceDisplayVisibility = val
							onInheritVisibilityToggle()
						end,
						disabled = function()
							return not settings.attach
								or not GameSettingsController:GetCVarBool(Enum.CVarKeys.EnablePersonalResource)
						end,
					},
				},
			},

			positionAndScaleGroup = {
				type = "group",
				inline = true,
				name = "Position and Scale",
				order = 4,
				args = {
					scale = {
						order = 1,
						type = "range",
						name = "Scale",
						width = "double",
						min = 0.1,
						max = 3,
						step = 0.01,
						get = function()
							return settings.scale
						end,
						set = function(info, val)
							settings.scale = val
							OnReAttach()
						end,
						disabled = function()
							return not settings.attach
								or not GameSettingsController:GetCVarBool(Enum.CVarKeys.EnablePersonalResource)
						end,
					},

					spacer1 = self:Spacer(2),

					personalResourceDisplayAnchor = {
						order = 3,
						type = "select",
						name = "Personal Resource Display Anchor",
						desc = "The anchor point used for the Personal Resource Display. This is the point the frame will attach to.",
						values = Enum.FrameAnchorOptions,
						get = function()
							return settings.personalResourceDisplayAnchor
						end,
						set = function(info, val)
							settings.personalResourceDisplayAnchor = val
							OnReAttach()
						end,
						disabled = function()
							return not settings.attach
								or not GameSettingsController:GetCVarBool(Enum.CVarKeys.EnablePersonalResource)
						end,
					},

					anchor = {
						order = 4,
						type = "select",
						name = "Anchor",
						desc = "Which point of the frame attaches to the Personal Resource Display Anchor.",
						values = Enum.FrameAnchorOptions,
						get = function()
							return settings.anchor
						end,
						set = function(info, val)
							settings.anchor = val
							OnReAttach()
						end,
						disabled = function()
							return not settings.attach
								or not GameSettingsController:GetCVarBool(Enum.CVarKeys.EnablePersonalResource)
						end,
					},

					xOffset = {
						order = 5,
						type = "range",
						name = "X Offset",
						min = -300,
						max = 300,
						step = 1,
						get = function()
							return settings.xOffset
						end,
						set = function(info, val)
							settings.xOffset = val
							OnReAttach()
						end,
						disabled = function()
							return not settings.attach
								or not GameSettingsController:GetCVarBool(Enum.CVarKeys.EnablePersonalResource)
						end,
					},

					yOffset = {
						order = 6,
						type = "range",
						name = "Y Offset",
						min = -300,
						max = 300,
						step = 1,
						get = function()
							return settings.yOffset
						end,
						set = function(info, val)
							settings.yOffset = val
							OnReAttach()
						end,
						disabled = function()
							return not settings.attach
								or not GameSettingsController:GetCVarBool(Enum.CVarKeys.EnablePersonalResource)
						end,
					},
				},
			},
		},
	}
end
