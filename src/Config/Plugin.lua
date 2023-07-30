-- <> plugin-related settings <> --

local PLUGIN = {}

---------------

PLUGIN.PROJECT_NAME = "KNOB"
PLUGIN.WEBHOOK_URL = "https://discord.com/api/webhooks/1135040937060487248/fL3oJ49wsT5TiMLNLtBen5i2BNSaTiKDUV2laO1Mumf6d-vrHYbdxRr31D-2vO9hK_uQ"
PLUGIN.CHECKPOINT_INTERVAL = 3600
-- ^^
-- change project name to whatever youd like
-- !! DONT SHARE WEBHOOK_URL ANYWHERE !!
-- WARNING: you can be rate-limited by discord if `CHECKPOINT_INTERVAL` is low.

PLUGIN.TOOLBAR = "Progress Printer"

PLUGIN.START_TOGGLE_BUTTON = {
    TITLE = "Start / End",
    TIP = "Start or end a session.",
    ICON = "http://www.roblox.com/asset/?id=14219066164",
    ICON_SECONDARY = "http://www.roblox.com/asset/?id=14219067357",
}

PLUGIN.PAUSE_TOGGLE_BUTTON = {
    TITLE = "Pause / Resume",
    TIP = "Pause or resume your session.",
    ICON = "http://www.roblox.com/asset/?id=14220518020",
    ICON_SECONDARY = "http://www.roblox.com/asset/?id=14220518644",
}

---------------

return PLUGIN