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
    self.stop = obliterator:Add(GoodSignal.new(), "DisconnectAll")

    return self
end

function LOOP:run(interval)
    if self.status ~= LOOP.STATUS.IDLE then
        return
    end

    self.status = LOOP.STATUS.ACTIVE

    local active = true

    self.stop:Once(function()
        active = false
    end)

    task.spawn(function()
        while active do
            self:callback()

            task.wait(interval)
        end
    end)
end

function LOOP:kill()
    if self.status ~= LOOP.STATUS.ACTIVE then
        return
    end

    self.stop:Fire()
    self.status = LOOP.STATUS.IDLE
end

function LOOP:discard()
    if self.status == LOOP.STATUS.DEAD then
        return
    end

    self:kill()
    self.status = LOOP.STATUS.DEAD
end

---------------

return LOOP