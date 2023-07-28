-- <> lets you post messages to discord <> --

local HttpService = game:GetService("HttpService")

---------------

local WEBHOOK = {}
WEBHOOK.__index = WEBHOOK

---------------

function WEBHOOK.new(URL)
    local self = {}
    setmetatable(self, WEBHOOK)

    self.URL = URL

    return self
end

function WEBHOOK:message(text)
    local data = {
        content = text,
    }

    self:_encodeAndPost(data)
end

function WEBHOOK:_encodeAndPost(data)
    local encoded = HttpService:JSONEncode(data)

    task.spawn(function()
        HttpService:PostAsync(self.URL, encoded)
    end)
end

---------------

return WEBHOOK