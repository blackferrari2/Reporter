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
    "https://cdn.discordapp.com/attachments/1092934480534196424/1134563448160788531/oydAaqG.png",
    "https://cdn.discordapp.com/attachments/1092934480534196424/1134563435426885753/J4NUcWv.png",
}

setmetatable(ASSETS.BIG_POSTERS, ROULLETE)
setmetatable(ASSETS.SMALL_POSTERS, ROULLETE)

--

ASSETS.EMOJIS = {
    START = "<:BOT_START:1135047206089531532>",
    END = "<:BOT_END:1135047201131868221>",
    PAUSE = "<:BOT_PAUSE:1135047202780217345>",
    RESUME = "<:BOT_RESUME:1135047204030124143>",
    CHECKPOINT = "<:BOT_CHECKPOINT:1135047198963400784>",
}

---------------

return ASSETS