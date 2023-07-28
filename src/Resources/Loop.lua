-- <> todo desc <> --

local source = script.Parent.Parent.Parent
local packages = source.Packages

local Janitor = require(packages.janitor)
local GoodSignal = require(packages.goodsignal)

---------------

local LOOP = {}
LOOP.__index = LOOP

LOOP.STATUS = {
    IDLE = 0,
    ACTIVE = 1,
    DEAD = 2,
}

---------------

function LOOP.new(callback)
    local self = {}
    setmetatable(self, LOOP)

    self.status = LOOP.STATUS.IDLE
    self.callback = callback

    local obliterator = Janitor.new()

    self.janitor = obliterator
    self.kill = obliterator:Add(GoodSignal.new(), "DisconnectAll")

    return self
end

function LOOP:run(interval)
    if self.status ~= LOOP.STATUS.IDLE then
        return
    end

    self.status = LOOP.STATUS.ACTIVE

    local active = true

    self.kill:Once(function()
        active = false
    end)

    task.spawn(function()
        while task.wait(interval) and active do
            self:callback()
        end
    end)
end

function LOOP:stop()
    if self.status ~= LOOP.STATUS.ACTIVE then
        return
    end

    self.kill:Fire()
    self.status = LOOP.STATUS.IDLE
end

function LOOP:discard()
    if self.status == LOOP.STATUS.DEAD then
        return
    end

    self:stop()
    self.status = LOOP.STATUS.DEAD
end

---------------

return LOOP