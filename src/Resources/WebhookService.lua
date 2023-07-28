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

function WEBHOOK:message(text, lag)
    local data = {
        content = text,
    }

    self:_encodeAndPost(data, lag)
end

-- `lag` is so that i dont get rate limited... :p
function WEBHOOK:_encodeAndPost(data, lag)
    local encoded = HttpService:JSONEncode(data)

    task.spawn(function()
        task.wait(lag)

        HttpService:PostAsync(self.URL, encoded)
    end)
end

---------------

return WEBHOOK