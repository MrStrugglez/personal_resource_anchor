local AceAddon = LibStub("AceAddon-3.0")
local LibEditModeOverride = LibStub("LibEditModeOverride-1.0")

local EssentialCooldownController = AceAddon:NewAddon("EssentialCooldownController")

function EssentialCooldownController:OnInitialize()
    self.orignalAnchor,
    self.OrignalParent,
    self.OriginalParentAnchor,
    self.OriginalXOffset,
    self.OriginalYOffset = EssentialCooldownViewer:GetPoint()
    self.OriginalScale = EssentialCooldownViewer:GetScale()
end

function EssentialCooldownController:AttachToPersonResourceDisplay(anchor,
                                                                   parentAnchor,
                                                                   xOffset,
                                                                   yOffset,
                                                                   scale,
                                                                   inheritPersonalResourceDisplayVisibility)
    local personalResourceDisplay = C_NamePlate.GetNamePlateForUnit("player").UnitFrame
    if not personalResourceDisplay then return end

    self:RestoreParent()
    EssentialCooldownViewer:SetScale(scale)

    if inheritPersonalResourceDisplayVisibility then
        self:SetPersonalResourceDisplayAsParent()
    end

    EssentialCooldownViewer:ClearAllPoints()
    EssentialCooldownViewer:SetPoint(anchor,
        personalResourceDisplay,
        parentAnchor,
        xOffset,
        yOffset)
end

function EssentialCooldownController:DetachFromPersonResourceDisplay()

end

function EssentialCooldownController:SetPersonalResourceDisplayAsParent()
    local personalResourceDisplay = C_NamePlate.GetNamePlateForUnit("player")
    if not personalResourceDisplay then return end

    EssentialCooldownViewer:SetParent(personalResourceDisplay.UnitFrame)
end

function EssentialCooldownController:RestoreParent()
    EssentialCooldownViewer:SetParent(self.parent)
end

---@param visibility Enum.CooldownViewerVisibleSetting
function EssentialCooldownController:SetVisibility(visibility)
    LibEditModeOverride:LoadLayouts()
    LibEditModeOverride:SetFrameSetting(EssentialCooldownViewer, Enum.EditModeCooldownViewerSetting.VisibleSetting,
        visibility)
    LibEditModeOverride:ApplyChanges()
end
