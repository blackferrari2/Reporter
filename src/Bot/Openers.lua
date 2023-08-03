-- <> messages that are sent whenever a new session starts <> --

--[[
    NOTE

    openers must be strings. (text only)
]]

local ROULLETE = require(script.Parent._Roullete)

---------------

local OPENERS = {}
setmetatable(OPENERS, ROULLETE)

--

OPENERS(
    "this is an opener"
)

---------------

return OPENERS