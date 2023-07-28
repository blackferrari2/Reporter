-- <> messages that are sent every now and then while a session is active <> --

--[[
    Last Updated: 7/28/2023

    GENERATION I
]]

local ROULLETE = require(script.Parent._Roullete)

---------------

local CHECKPOINTS = {}
setmetatable(CHECKPOINTS, ROULLETE)

--

CHECKPOINTS{
    AUTHOR = "blackferrari2",
    MESSAGE = "first"
}

CHECKPOINTS{
    AUTHOR = "SYSTEM",
    MESSAGE = "Suggest your ads / random quotes here! <#1020087951847338086>. (Text only)"
}

CHECKPOINTS{
    AUTHOR = "SYSTEM",
    MESSAGE = "Lorem ipsum dolor sit amet"
}

---------------

return CHECKPOINTS