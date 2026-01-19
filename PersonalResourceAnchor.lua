-- Personal Resource Anchor
-- Anchors EssentialCooldownViewer and UtilityCooldownViewer to the Personal Resource Display

local addonName, addon = ...

-- Create main frame
local frame = CreateFrame("Frame")

-- Function to anchor the cooldown viewers to the Personal Resource Display
local function AnchorCooldownViewers()
    -- Get the Personal Resource Display (NamePlate1)
    -- Try multiple methods to get the Personal Resource Display
    local personalResourceDisplay = _G["NamePlate1"]
    
    -- Fallback: Try to get it from the player's nameplate
    if not personalResourceDisplay then
        local playerNameplate = C_NamePlate.GetNamePlateForUnit("player")
        if playerNameplate and playerNameplate.UnitFrame then
            personalResourceDisplay = playerNameplate.UnitFrame
        end
    end
    
    -- Get the cooldown viewer frames
    local essentialCooldownViewer = _G["EssentialCooldownViewer"]
    local utilityCooldownViewer = _G["UtilityCooldownViewer"]
    
    -- Check if Personal Resource Display exists
    if personalResourceDisplay then
        -- Anchor EssentialCooldownViewer to the Personal Resource Display
        if essentialCooldownViewer then
            essentialCooldownViewer:ClearAllPoints()
            -- Center bottom of PRD to center top of EssentialCooldownViewer
            essentialCooldownViewer:SetPoint("TOP", personalResourceDisplay, "BOTTOM", 0, -5)
            print("|cFF00FF00Personal Resource Anchor:|r EssentialCooldownViewer anchored to Personal Resource Display")
        else
            print("|cFFFF0000Personal Resource Anchor:|r EssentialCooldownViewer not found")
        end
        
        -- Anchor UtilityCooldownViewer below EssentialCooldownViewer
        if utilityCooldownViewer then
            utilityCooldownViewer:ClearAllPoints()
            if essentialCooldownViewer then
                -- Center bottom of EssentialCooldownViewer to center top of UtilityCooldownViewer
                utilityCooldownViewer:SetPoint("TOP", essentialCooldownViewer, "BOTTOM", 0, -5)
                print("|cFF00FF00Personal Resource Anchor:|r UtilityCooldownViewer anchored below EssentialCooldownViewer")
            else
                -- If EssentialCooldownViewer doesn't exist, anchor directly to PRD
                utilityCooldownViewer:SetPoint("TOP", personalResourceDisplay, "BOTTOM", 0, -5)
                print("|cFF00FF00Personal Resource Anchor:|r UtilityCooldownViewer anchored to Personal Resource Display")
            end
        else
            print("|cFFFF0000Personal Resource Anchor:|r UtilityCooldownViewer not found")
        end
    else
        print("|cFFFF0000Personal Resource Anchor:|r Personal Resource Display (NamePlate1) not found")
    end
end

-- Event handler function
local function OnEvent(self, event, ...)
    if event == "PLAYER_LOGIN" then
        -- Wait a short moment for all frames to be loaded
        C_Timer.After(1, function()
            AnchorCooldownViewers()
        end)
    end
end

-- Register events
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", OnEvent)

print("|cFF00FF00Personal Resource Anchor|r loaded.")
