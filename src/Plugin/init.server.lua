-- <> main plugin script <> --

local config = script.Config
local resources = script.Resources

local Loop = require(resources.Loop)
local WebhookService = require(resources.WebhookService)

local Plugin = require(config.Plugin)
local Templates = require(config.Templates)
local Roulletes = require(config.Roulletes)
local Assets = require(config.Assets)

---------------

local RANDOM = Random.new()

local function getRandomArrayValue(array)
    local key = RANDOM:NextInteger(1, #array)

    return array[key]
end

--

local MATCH_WHOLE_WORDS_PATTERN = "%w+"

local function format(text, definitions)
    return string.gsub(text, MATCH_WHOLE_WORDS_PATTERN, definitions)
end

--

local TAGS = Templates.TAGS

local function sendStartMessage()
    local template = Templates.START
    local quote = getRandomArrayValue(Roulletes.OPENERS)

    local result = format(template, {
        [TAGS.EMOJI] = Assets.EMOJIS.START,
        [TAGS.PROJECT_NAME] = Plugin.PROJECT_NAME,
        [TAGS.DATE] = os.date(),
        [TAGS.ANY] = quote,
    })

    warn(result)

    local poster = getRandomArrayValue(Assets.BIG_POSTERS)

    warn(poster)
end

local function sendEndMessage(loop)
    local template = Templates.END

    local result = format(template, {
        [TAGS.EMOJI] = Assets.EMOJIS.END,
        [TAGS.PROJECT_NAME] = Plugin.PROJECT_NAME,
        [TAGS.TIME_ELAPSED] = loop.totalTimeRunning,
    })

    warn(result)

    local poster = getRandomArrayValue(Assets.SMALL_POSTERS)

    warn(poster)
end

local function sendPauseMessage()
    local template = Templates.PAUSE

    local result = format(template, {
        [TAGS.EMOJI] = Assets.EMOJIS.PAUSE,
    })

    warn(result)
end

local function sendResumeMessage()
    local template = Templates.RESUME

    local result = format(template, {
        [TAGS.EMOJI] = Assets.EMOJIS.RESUME,
    })

    warn(result)
end

local function sendCheckpointMessage()
    local checkpoint = getRandomArrayValue(Roulletes.CHECKPOINTS)
    local template = Templates.CHECKPOINT

    local result = format(template, {
        [TAGS.EMOJI] = Assets.EMOJIS.CHECKPOINT,
        [TAGS.NAME] = checkpoint.AUTHOR,
        [TAGS.ANY] = checkpoint.MESSAGE,
    })

    warn(result)
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