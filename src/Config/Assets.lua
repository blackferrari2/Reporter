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
    "https://cdn.discordapp.com/attachments/1133978455910907995/1134270876024582145/jxKH2a0.png",
}

setmetatable(ASSETS.BIG_POSTERS, ROULLETE)
setmetatable(ASSETS.SMALL_POSTERS, ROULLETE)

--

ASSETS.EMOJIS = {
    START = "<:BOT_START:1134268151635394572>",
    END = "<:BOT_END:1134268145595596872>",
    PAUSE = "<:BOT_PAUSE:1134268148137349210>",
    RESUME = "<:BOT_RESUME:1134268149416603781>",
    CHECKPOINT = "<:BOT_CHECKPOINT:1134268144333099008>",
}

---------------

return ASSETS