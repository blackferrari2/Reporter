-- <> emojis, posters, and whatnot <> --

--[[
    NOTES

    - if you dont want posters, leave the tables EMPTY. but do not delete them
    - DONT SHARE WEBHOOK_URL. KEEP THIS DIRECTORY SOMEWHERE SAFE LIKE SERVER STORAGE
]]

local ROULLETE = require(script.Parent._Roullete)

---------------

local ASSETS = {}

---------------

ASSETS.BIG_POSTERS = {
}

ASSETS.SMALL_POSTERS = {
}

setmetatable(ASSETS.BIG_POSTERS, ROULLETE)
setmetatable(ASSETS.SMALL_POSTERS, ROULLETE)

--

ASSETS.PROJECT_NAME = "Project Name"
ASSETS.WEBHOOK_URL = "[replace me!]"
ASSETS.CHECKPOINT_INTERVAL = 3600
-- WARNING: you can be rate-limited by discord if `CHECKPOINT_INTERVAL` is low.
-- minimum: 30s or else the plugin will throw an error

--[[
    HOW TO GET EMOJI IDS:

    type "\:emoji_name:" in the discord chat

    this should give you a result like so:

    "<:EMOJI_NAME:11029589010201>"

    replace the placeholder values with it according to ur preferences

    DONT EDIT THE NAMES! "START", "END", ...
        only the values
        ... or else the plugin breaks
        :p
]]
ASSETS.EMOJIS = {
    START = "<PLACEHOLDER>",
    END = "<PLACEHOLDER>",
    PAUSE = "<PLACEHOLDER>",
    RESUME = "<PLACEHOLDER>",
    CHECKPOINT = "<PLACEHOLDER>",
}

---------------

return ASSETS