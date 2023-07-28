-- <> for randomly picked community-created quotes / messages <> --

--[[
    Last Updated: 7/28/2023

    GENERATION I
]]

local ROULLETE = {}

ROULLETE.__call = function(self, data)
    table.insert(self, data)
end

---------------

local CHECKPOINTS = {}
setmetatable(CHECKPOINTS, ROULLETE)

--

CHECKPOINTS{
    AUTHOR = "idk",
    MESSAGE = "message"
}

---------------

local OPENERS = {}
setmetatable(OPENERS, ROULLETE)

--

OPENERS(
    "opener"
)

---------------

ROULLETE.CHECKPOINTS = CHECKPOINTS
ROULLETE.OPENERS = OPENERS

return ROULLETE