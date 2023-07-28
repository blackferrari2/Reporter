-- <> metatable. used for randomly picked values <> --

local ROULLETE = {}
ROULLETE.__index = ROULLETE

--

ROULLETE.__call = function(self, data)
    table.insert(self, data)
end

---------------

local RANDOM = Random.new()

-- returns a random value from itself
function ROULLETE:get()
    local key = RANDOM:NextInteger(1, #self)

    return self[key]
end

---------------

return ROULLETE