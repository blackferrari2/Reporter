-- <> main plugin script <> --

local config = script.Config
local resources = script.Resources

local Loop = require(resources.Loop)
local WebhookService = require(resources.WebhookService)

local Plugin = require(config.Plugin)
local Formats = require(config.Formats)
local Checkpoints = require(config.Checkpoints)
local Assets = require(config.Assets)

---------------

local function sendStartMessage()
    warn("start")
end

local function sendEndMessage()
    warn("end")
end

local function sendPauseMessage()
    warn("pause")
end

local function sendResumeMessage()
    warn("resume")
end

local function sendCheckpointMessage()
    warn("checkpoint")
end

---------------

local checkpoints = Loop.new(sendCheckpointMessage)
local toolbar = plugin:CreateToolbar("test")

local toggleStart = toolbar:CreateButton(
    "startToggle",
    Plugin.START_TOGGLE_BUTTON.TIP,
    Plugin.START_TOGGLE_BUTTON.ICON,
    Plugin.START_TOGGLE_BUTTON.TITLE
)

local togglePause = toolbar:CreateButton(
    "pauseToggle",
    Plugin.PAUSE_TOGGLE_BUTTON.TIP,
    Plugin.PAUSE_TOGGLE_BUTTON.ICON,
    Plugin.PAUSE_TOGGLE_BUTTON.TITLE
)

--

togglePause.Enabled = false

---------------

local isEnabled = false

local function onStartClick()
    sendStartMessage()
    checkpoints:run(Plugin.CHECKPOINT_INTERVAL)
end

local function onStopClick()
    sendEndMessage()
    checkpoints:discard()
end

toggleStart.Click:Connect(function()
    isEnabled = not isEnabled

    if isEnabled then
        onStartClick()
    else
        onStopClick()
    end
end)