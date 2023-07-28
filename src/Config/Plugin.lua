-- <> plugin-related settings <> --

local PLUGIN = {}

---------------

PLUGIN.PROJECT_NAME = "KNOB"
PLUGIN.WEBHOOK_URL = "https://discord.com/api/webhooks/1134250972441485433/3MOw7Y_WRIA28aosMo_de_E7Pq_lT6OQt-lPgp2xFdH_r5egICNOi68OxJZrU9V8IoQ-"
PLUGIN.CHECKPOINT_INTERVAL = 120
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