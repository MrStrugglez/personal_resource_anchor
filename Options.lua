-- PersonalResourceAnchor/Options.lua

-- Define the visibility options for the selects
local VISIBILITY_OPTIONS = {
    ["ALWAYS_VISIBLE"] = "Always visible",
    ["IN_COMBAT"]      = "In combat",
    ["HIDDEN"]         = "Hidden",
}

local ANCHOR_POINTS = {
    ["TOPLEFT"]     = "Top Left",
    ["TOP"]         = "Top",
    ["TOPRIGHT"]    = "Top Right",
    ["LEFT"]        = "Left",
    ["CENTER"]      = "Center",
    ["RIGHT"]       = "Right",
    ["BOTTOMLEFT"]  = "Bottom Left",
    ["BOTTOM"]      = "Bottom",
    ["BOTTOMRIGHT"] = "Bottom Right",
}
-- The function that AceConfig calls to get the options table.
-- It receives the AceDB object, which is needed to define the 'handler'.
function PersonalResourceAnchor_GetOptions(db,
                                           OnAttachEssential,
                                           OnAttachUtility,
                                           OnInheritVisibility,
                                           OnVisibilityChange,
                                           OnEssentialScaleChange,
                                           OnUtilityScaleChange,
                                           OnPositionChange)
    -- WoW's standard anchor points table for the 'select' type.

    -- Define the options table structure
    return {
        name = "Personal Resource Anchor",
        handler = db,
        type = "group",
        args = {
            general = {
                type = "group",
                name = "General Settings",
                order = 1,
                args = {
                    header1 = { type = "header", name = "Attachments", order = 1 },
                    -- Tickbox: Attach Essential Cooldowns
                    AttachEssential = {
                        type = "toggle",
                        name = "Attach Essential Cooldowns",
                        desc = "Enables the display of essential cooldowns.",
                        order = 2,
                        get = function() return db.profile.AttachEssential end,
                        set = function(info, val)
                            db.profile.AttachEssential = val; OnAttachEssential()
                        end,
                    },
                    -- Tickbox: Attach Utility Cooldowns
                    AttachUtility = {
                        type = "toggle",
                        name = "Attach Utility Cooldowns",
                        desc = "Enables the display of utility cooldowns.",
                        order = 3,
                        get = function() return db.profile.AttachUtility end,
                        set = function(info, val)
                            db.profile.AttachUtility = val; OnAttachUtility()
                        end,
                    },

                    -- Tickbox: Inherit Personal Resource Display visibility
                    InheritVisibility = {
                        type = "toggle",
                        name = "Inherit Personal Resource Display visibility",
                        desc =
                        "If checked, cooldown frames will only show when the Personal Resource Display is visible.",
                        order = 4,
                        get = function() return db.profile.InheritVisibility end,
                        set = function(info, val)
                            db.profile.InheritVisibility = val; OnInheritVisibility()
                        end,
                    },

                    header2 = { type = "header", name = "Scale", order = 5 },

                    EssentialScale = {
                        type = "range",
                        name = "Essential Cooldown Scale",
                        min = 0.1,
                        max = 3,
                        step = 0.1,
                        order = 6,
                        get = function() return db.profile.EssentialScale end,
                        set = function(info, val)
                            db.profile.EssentialScale = val; OnEssentialScaleChange()
                        end,
                        disabled = function() return not db.profile.AttachEssential end,
                    },

                    UtilityScale = {
                        type = "range",
                        name = "Utility Cooldown Scale",
                        min = 0.1,
                        max = 3,
                        step = 0.1,
                        order = 7,
                        get = function() return db.profile.UtilityScale end,
                        set = function(info, val)
                            db.profile.UtilityScale = val; OnUtilityScaleChange()
                        end,
                        disabled = function() return not db.profile.AttachUtility end,
                    },

                    header3 = { type = "header", name = "Visibility", order = 5 },

                    -- select: Essential Cooldowns Visibility
                    EssentialVisibility = {
                        type = "select",
                        name = "Essential Cooldowns Visibility",
                        values = VISIBILITY_OPTIONS,
                        order = 6,
                        get = function() return db.profile.EssentialVisibility end,
                        set = function(info, val)
                            db.profile.EssentialVisibility = val; OnVisibilityChange()
                        end,
                        disabled = function() return db.profile.InheritVisibility end,
                    },

                    -- select: Utility Cooldowns Visibility
                    UtilityVisibility = {
                        type = "select",
                        name = "Utility Cooldowns Visibility",
                        values = VISIBILITY_OPTIONS,
                        order = 7,
                        get = function() return db.profile.UtilityVisibility end,
                        set = function(info, val)
                            db.profile.UtilityVisibility = val; OnVisibilityChange()
                        end,
                        disabled = function() return db.profile.InheritVisibility end,
                    },
                }
            },

            positioning = {
                type = "group",
                name = "Positioning",
                order = 2,
                args = {
                    -- Anchor Selection: Personal Resource Display Anchors

                    header4 = { type = "header", name = "Essential Cooldowns", order = 1 },

                    EssentialPersonalResourceAnchor = {
                        type = "select",
                        name = "Personal Resource Display Anchor",
                        desc = "The anchor point used for the Personal Resource Display.",
                        values = ANCHOR_POINTS,
                        order = 2,
                        get = function() return db.profile.EssentialPersonalResourceAnchor end,
                        set = function(info, val)
                            db.profile.EssentialPersonalResourceAnchor = val; OnPositionChange()
                        end,
                        disabled = function() return not db.profile.AttachEssential end,
                    },

                    EssentialAnchor = {
                        type = "select",
                        name = "Essential Anchor Point",
                        desc = "Which point of the cooldown frame attaches to the main display.",
                        values = ANCHOR_POINTS,
                        order = 3,
                        get = function() return db.profile.EssentialAnchor end,
                        set = function(info, val)
                            db.profile.EssentialAnchor = val; OnPositionChange()
                        end,
                        disabled = function() return not db.profile.AttachEssential end,
                    },

                    -- Slider: Essential Cooldowns X Offset (Step 10)
                    EssentialOffsetX = {
                        type = "range",
                        name = "X Offset",
                        min = -300,
                        max = 300,
                        step = 1,
                        order = 4,
                        get = function() return db.profile.EssentialOffsetX end,
                        set = function(info, val)
                            db.profile.EssentialOffsetX = val; OnPositionChange()
                        end,
                        disabled = function() return not db.profile.AttachEssential end,
                    },
                    -- Slider: Essential Cooldowns Y Offset (Step 10)
                    EssentialOffsetY = {
                        type = "range",
                        name = "Y Offset",
                        min = -300,
                        max = 300,
                        step = 1,
                        order = 5,
                        get = function() return db.profile.EssentialOffsetY end,
                        set = function(info, val)
                            db.profile.EssentialOffsetY = val; OnPositionChange()
                        end,
                        disabled = function() return not db.profile.AttachEssential end,
                    },



                    header5 = { type = "header", name = "Utility Cooldowns", order = 6 },

                    UtilityPersonalResourceAnchor = {
                        type = "select",
                        name = "Personal Resource Display Anchor",
                        desc = "The anchor point used for the Personal Resource Display.",
                        values = ANCHOR_POINTS,
                        order = 7,
                        get = function() return db.profile.UtilityPersonalResourceAnchor end,
                        set = function(info, val)
                            db.profile.UtilityPersonalResourceAnchor = val; OnPositionChange()
                        end,
                        disabled = function() return not db.profile.AttachUtility end,
                    },

                    UtilityAnchor = {
                        type = "select",
                        name = "Utility Anchor Point",
                        desc = "Which point of the cooldown frame attaches to the main display.",
                        values = ANCHOR_POINTS,
                        order = 8,
                        get = function() return db.profile.UtilityAnchor end,
                        set = function(info, val)
                            db.profile.UtilityAnchor = val; OnPositionChange()
                        end,
                        disabled = function() return not db.profile.AttachUtility end,
                    },

                    -- Slider: Utility Cooldowns X Offset (Step 10)
                    UtilityOffsetX = {
                        type = "range",
                        name = "X Offset",
                        min = -300,
                        max = 300,
                        step = 1,
                        order = 9,
                        get = function() return db.profile.UtilityOffsetX end,
                        set = function(info, val)
                            db.profile.UtilityOffsetX = val; OnPositionChange()
                        end,
                        disabled = function() return not db.profile.AttachUtility end,
                    },
                    -- Slider: Utility Cooldowns Y Offset (Step 10)
                    UtilityOffsetY = {
                        type = "range",
                        name = "Y Offset",
                        min = -300,
                        max = 300,
                        step = 1,
                        order = 10,
                        get = function() return db.profile.UtilityOffsetY end,
                        set = function(info, val)
                            db.profile.UtilityOffsetY = val; OnPositionChange()
                        end,
                        disabled = function() return not db.profile.AttachUtility end,
                    },


                }
            }
        }
    }
end
