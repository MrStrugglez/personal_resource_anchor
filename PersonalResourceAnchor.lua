-- Personal Resource Anchor
-- Anchors EssentialCooldownViewer and UtilityCooldownViewer to the Personal Resource Display

local addonName, addon = ...

-- Create main frame
local frame = CreateFrame("Frame")

-- Function to anchor the cooldown viewers to the Personal Resource Display
local function AnchorCooldownViewers()
    -- Get the Personal Resource Display (NamePlate1)
    local personalResourceDisplay = NamePlateDriverFrame and NamePlateDriverFrame.namePlateFrameBase or C_NamePlate.GetNamePlateForUnit("player")
    
    -- Alternative method to get Personal Resource Display
    if not personalResourceDisplay then
        personalResourceDisplay = _G["NamePlate1"]
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

-- Provide a slash command to manually re-anchor if needed
SLASH_PERSONALRESOURCEANCHOR1 = "/pra"
SLASH_PERSONALRESOURCEANCHOR2 = "/personalresourceanchor"
SlashCmdList["PERSONALRESOURCEANCHOR"] = function(msg)
    if msg == "anchor" or msg == "" then
        AnchorCooldownViewers()
        print("|cFF00FF00Personal Resource Anchor:|r Manual anchoring executed")
    elseif msg == "help" then
        print("|cFF00FF00Personal Resource Anchor Commands:|r")
        print("/pra or /pra anchor - Manually re-anchor cooldown viewers")
        print("/pra help - Show this help message")
    else
        print("|cFFFF0000Personal Resource Anchor:|r Unknown command. Type '/pra help' for help")
    end
end

print("|cFF00FF00Personal Resource Anchor|r loaded. Type /pra help for commands.")
