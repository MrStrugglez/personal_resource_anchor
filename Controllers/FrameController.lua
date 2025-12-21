local addonName, addonTable = ...

local AceAddon = LibStub("AceAddon-3.0")
---@class FrameController
local FrameController = AceAddon:GetAddon(Enum.Addons.FrameController) --[[@as FrameController]]

function FrameController:Init(controllers)
	self.controllers = controllers

	for _, controller in pairs(self.controllers) do
		controller:Init()
	end
end

function FrameController:ShowFrames()
	for _, controller in pairs(self.controllers) do
		controller:Show()
	end
end

function FrameController:StartupHideFrames()
	for _, controller in pairs(self.controllers) do
		controller:StartupHide()
	end
end

function FrameController:AttachFrames()
	for _, controller in pairs(self.controllers) do
		controller:AttachToPersonalResourceDisplay()
	end
end

function FrameController:DetachFrames()
	for _, controller in pairs(self.controllers) do
		controller:DetachFromPersonalResourceDisplay()
	end
end

function FrameController:ReAttach()
	for _, controller in pairs(self.controllers) do
		controller:ReAttach()
	end
end

function FrameController:EnterEditMode()
	for _, controller in pairs(self.controllers) do
		controller:DetachFromPersonalResourceDisplay()
	end
end

function FrameController:ExitEditMode()
	for _, controller in pairs(self.controllers) do
		controller:UpdateOriginalPoint()
		controller:AttachToPersonalResourceDisplay()
		controller:StartupHide()
	end
end

function FrameController:UpdateOriginalPoints()
	for _, controller in pairs(self.controllers) do
		controller:UpdateOriginalPoint()
	end
end

function FrameController:PersonalResourceDisplayHidden()
	for _, controller in pairs(self.controllers) do
		if not controller.settings.inheritPersonalResourceDisplayVisibility then
			controller:DetachFromPersonalResourceDisplay()
		end
	end
end
