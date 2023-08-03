-- <> emojis, posters, and whatnot <> --

--[[
    Last Updated: 7/28/2023

    GENERATION I
]]

local ROULLETE = require(script.Parent._Roullete)

---------------

local ASSETS = {}

---------------

ASSETS.BIG_POSTERS = {
    "https://cdn.discordapp.com/attachments/1092934480534196424/1102791210478882826/5.1_png_ice9dailies_5.png",
    "https://cdn.discordapp.com/attachments/1092934480534196424/1102791210738909306/5.1_png_ice9dailies_6.png",
    "https://cdn.discordapp.com/attachments/1092934480534196424/1102791211007361064/5.1_png_ice9dailies_7.png",
}

ASSETS.SMALL_POSTERS = {
    "https://cdn.discordapp.com/attachments/1066213685963542529/1136124277406564454/DZGqH8o.png",
    "https://cdn.discordapp.com/attachments/1066213685963542529/1136124307391643768/52lGthx.png",
}

setmetatable(ASSETS.BIG_POSTERS, ROULLETE)
setmetatable(ASSETS.SMALL_POSTERS, ROULLETE)

--

ASSETS.PROJECT_NAME = "KNOB"
ASSETS.WEBHOOK_URL = "https://discord.com/api/webhooks/1135040937060487248/fL3oJ49wsT5TiMLNLtBen5i2BNSaTiKDUV2laO1Mumf6d-vrHYbdxRr31D-2vO9hK_uQ"
ASSETS.CHECKPOINT_INTERVAL = 3600
-- WARNING: you can be rate-limited by discord if `CHECKPOINT_INTERVAL` is low.

ASSETS.EMOJIS = {
    START = "<:BOT_START:1135047206089531532>",
    END = "<:BOT_END:1135047201131868221>",
    PAUSE = "<:BOT_PAUSE:1135047202780217345>",
    RESUME = "<:BOT_RESUME:1135047204030124143>",
    CHECKPOINT = "<:BOT_CHECKPOINT:1135047198963400784>",
}

---------------

return ASSETS