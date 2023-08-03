-- <> messages that are sent every now and then while a session is active <> --

--[[
    NOTE

    All entries MUST have an `AUTHOR` and `MESSAGE` fields
]]

local ROULLETE = require(script.Parent._Roullete)

---------------

local CHECKPOINTS = {}
setmetatable(CHECKPOINTS, ROULLETE)

--

CHECKPOINTS{
    AUTHOR = "author",
    MESSAGE = "text"
}

---------------

return CHECKPOINTS