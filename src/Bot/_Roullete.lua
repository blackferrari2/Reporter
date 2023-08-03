-- <> metatable. used for randomly picked values <> --

--[[
    NOTE

    DO NOT EDIT UNLESS U KNOW WHAT UR DOING
]]

local ROULLETE = {}
ROULLETE.__index = ROULLETE

--

ROULLETE.__call = function(self, data)
    table.insert(self, data)
end

---------------

local RANDOM = Random.new()

-- returns a random value from itself
function ROULLETE:GET()
    local key = RANDOM:NextInteger(1, #self)

    return self[key]
end

---------------

return ROULLETE