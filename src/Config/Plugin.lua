-- <> plugin-related settings <> --

local PLUGIN = {}

---------------

PLUGIN.PROJECT_NAME = "Project Name"
PLUGIN.WEBHOOK_URL = "https://discord.com/api/webhooks/1134250972441485433/3MOw7Y_WRIA28aosMo_de_E7Pq_lT6OQt-lPgp2xFdH_r5egICNOi68OxJZrU9V8IoQ-"
PLUGIN.CHECKPOINT_INTERVAL = 1
-- ^^
-- change project name to whatever youd like
-- !! DONT SHARE WEBHOOK_URL ANYWHERE !!
-- WARNING: you can be rate-limited by discord if `CHECKPOINT_INTERVAL` is low.

PLUGIN.TOOLBAR = "Toolbar"

PLUGIN.START_TOGGLE_BUTTON = {
    TITLE = "title",
    TIP = "tip",
    ICON = "http://www.roblox.com/asset/?id=14219066164",
    ICON_SECONDARY = "http://www.roblox.com/asset/?id=14219066164",
}

PLUGIN.PAUSE_TOGGLE_BUTTON = {
    TITLE = "title",
    TIP = "tip",
    ICON = "http://www.roblox.com/asset/?id=14219066164",
    ICON_SECONDARY = "http://www.roblox.com/asset/?id=14219066164",
}

---------------

return PLUGIN