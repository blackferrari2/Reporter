-- <> main plugin script <> --

local config = script.Config
local resources = script.Resources

local Loop = require(resources.Loop)

local Titles = require(config.Titles)
local Formats = require(config.Formats)
local Checkpoints = require(config.Checkpoints)
local Assets = require(config.Assets)

---------------

local function test()
    
end

---------------

local toolbar = plugin:CreateToolbar("test")

local toggleStart = toolbar:CreateButton(
    "id",
    "tip",
    "http://www.roblox.com/asset/?id=14219066164",
    "text"
)

local togglePause = toolbar:CreateButton(
    "id",
    "tip",
    "http://www.roblox.com/asset/?id=14219066164",
    "text"
)

--

togglePause.Enabled = false

---------------

toggleStart.Click:Connect(function()

end)