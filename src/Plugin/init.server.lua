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

--

local function buildCheckpointLoop()
    return Loop.new(sendCheckpointMessage)
end

--

local INTERVAL = Plugin.CHECKPOINT_INTERVAL

local function startCheckpointLoop(loop)
    loop:run(INTERVAL)
end

--

local function updateButtonIcon(button, settings, toggle)
    toggle = not toggle

    local icon

    if toggle then
        icon = settings.ICON
    else
        icon = settings.ICON_SECONDARY
    end

    -- for some reason roblox doesnt load plugin icons if this is the case
    if button.Icon == icon then
        return
    end

    button.Icon = icon
end

---------------

local toolbar = plugin:CreateToolbar(Plugin.TOOLBAR)

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

local currentCheckpointLoop
local isDisabled = false
local isPaused = false

---------------

local function onStartClick()
    if not isDisabled or isPaused then
        return
    end

    sendStartMessage()

    currentCheckpointLoop = buildCheckpointLoop()
    startCheckpointLoop(currentCheckpointLoop)

    togglePause.Enabled = true
end

local function onStopClick()
    if isDisabled then
        return
    end

    sendEndMessage()

    currentCheckpointLoop:discard()

    togglePause.Enabled = false
end


--

toggleStart.Click:Connect(function()
    isDisabled = not isDisabled
    isPaused = false

    if isDisabled then
        onStartClick()
    else
        onStopClick()
    end

    updateButtonIcon(togglePause, Plugin.PAUSE_TOGGLE_BUTTON, isPaused)
    updateButtonIcon(toggleStart, Plugin.START_TOGGLE_BUTTON, isDisabled)
end)

---------------

local function onPause()
    if not isPaused or not isDisabled then
        return
    end

    sendPauseMessage()

    currentCheckpointLoop:stop()
end

local function onResume()
    if isPaused or not isDisabled then
        return
    end

    sendResumeMessage()

    startCheckpointLoop(currentCheckpointLoop)
end

--

togglePause.Click:Connect(function()
    isPaused = not isPaused

    if isPaused then
        onPause()
    else
        onResume()
    end

    updateButtonIcon(togglePause, Plugin.PAUSE_TOGGLE_BUTTON, isPaused)
end)

---------------