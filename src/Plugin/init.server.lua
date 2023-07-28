-- <> main plugin script <> --

--[[
    progress printer plugin. create and track work sessions

    watch out for rate limits

    loosely created by blackferrari2 (Jonichromed)
    Last Updated: 7/28/2023

    :D
]]

local config = script.Config
local resources = script.Resources

local Loop = require(resources.Loop)
local WebhookService = require(resources.WebhookService)

local Plugin = require(config.Plugin)
local Templates = require(config.Templates)
local Checkpoints = require(config.Checkpoints)
local Openers = require(config.Openers)
local Assets = require(config.Assets)

---------------

local MATCH_WHOLE_WORDS_PATTERN = "%w+"

local function format(text, definitions)
    return string.gsub(text, MATCH_WHOLE_WORDS_PATTERN, definitions)
end

--

local function secondsToHMS(sec)
    local hour = sec / 60^2
    local minute = sec / 60 % 60
    local second = sec % 60

	return string.format("%02i:%02i:%02i", hour, minute, second)
end

--

local webhook = WebhookService.new(Plugin.WEBHOOK_URL)

local function sendLineSeparator()
    local template = Templates.SEPARATOR

    webhook:message(template)
end

local TAGS = Templates.TAGS

local function sendStartMessage()
    local template = Templates.START
    local quote = Openers:get()

    local result = format(template, {
        [TAGS.EMOJI] = Assets.EMOJIS.START,
        [TAGS.PROJECT_NAME] = Plugin.PROJECT_NAME,
        [TAGS.DATE] = os.date(),
        [TAGS.ANY] = quote,
    })

    webhook:message(result)

    local poster = Assets.BIG_POSTERS:get()

    webhook:message(poster)

    sendLineSeparator()
end

local function sendEndMessage(loop)
    local timeElapsed = secondsToHMS(loop.totalTimeRunning)
    local template = Templates.END

    sendLineSeparator()

    local result = format(template, {
        [TAGS.EMOJI] = Assets.EMOJIS.END,
        [TAGS.PROJECT_NAME] = Plugin.PROJECT_NAME,
        [TAGS.TIME_ELAPSED] = timeElapsed,
    })

    webhook:message(result)

    local poster = Assets.SMALL_POSTERS:get()

    webhook:message(poster)
end

local function sendPauseMessage()
    local template = Templates.PAUSE

    local result = format(template, {
        [TAGS.EMOJI] = Assets.EMOJIS.PAUSE,
    })

    webhook:message(result)
end

local function sendResumeMessage()
    local template = Templates.RESUME

    local result = format(template, {
        [TAGS.EMOJI] = Assets.EMOJIS.RESUME,
    })

    webhook:message(result)
end

local function sendCheckpointMessage()
    local checkpoint = Checkpoints:get()
    local template = Templates.CHECKPOINT

    local result = format(template, {
        [TAGS.EMOJI] = Assets.EMOJIS.CHECKPOINT,
        [TAGS.NAME] = checkpoint.AUTHOR,
        [TAGS.ANY] = checkpoint.MESSAGE,
    })

    webhook:message(result)
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

    sendEndMessage(currentCheckpointLoop)

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

-- have it off by default on startup
togglePause.Enabled = false

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