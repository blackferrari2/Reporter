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

local function isEmptyText(text)
    return text == nil or text == "" or text == " "
end

function WEBHOOK:message(text)
    if isEmptyText(text) then
        return
    end

    local data = {
        content = text,
    }

    self:_encodeAndPost(data)
end

function WEBHOOK:_encodeAndPost(data)
    local encoded = HttpService:JSONEncode(data)

    HttpService:PostAsync(self.URL, encoded)
end

---------------

return WEBHOOK