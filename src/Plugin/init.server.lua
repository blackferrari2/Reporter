-- <> MAIN PLUGIN SCRIPT <> --

--[[
    progress printer plugin. create and track work sessions

    watch out for rate limits
]]

--[[
    by Jonichromed (blackferrari2)
    Last Updated: 2nd of August, 2023

    PATCH NOTES:
        - now not hard coded
        - refurbished, redone, redusted
]]

assert(plugin, "NOT RUNNING IN PLUGIN")

local source = script.Parent
local resources = script.Resources

local Config = require(script.Config)
local Loop = require(resources.Loop)
local WebhookService = require(resources.WebhookService)

---------------

local INDEX = 0

local function createButton(toolbar, config)
    local button = toolbar:CreateButton(
        tostring(INDEX),
        config.TIP,
        config.ICON,
        config.TITLE
    )

    INDEX += 1

    return button
end

--

local function updateButtonIcon(button, config, toggle)
    toggle = not toggle

    local icon

    if toggle then
        icon = config.ICON
    else
        icon = config.ICON_SECONDARY
    end

    -- for some reason roblox doesnt load plugin icons if this is the case
    if button.Icon == icon then
        return
    end

    button.Icon = icon
end

--

local PARENT = game:GetService("ServerStorage")
local NAME = "_BOT_PLUGIN_ASSETS"

local function findBotSettings()
    return PARENT:FindFirstChild(NAME)
end

local function createBotSettings()
    if findBotSettings() then
        error("BOT DIRECTORY ALREADY EXISTS")
    end

    local template = source.Bot
    local clone = template:Clone()

    clone.Name = NAME
    clone.Parent = PARENT

    return clone
end

---------------

local toolbar = plugin:CreateToolbar(Config.TOOLBAR)

local toggleStart = createButton(toolbar, Config.START_TOGGLE_BUTTON)
local togglePause = createButton(toolbar, Config.PAUSE_TOGGLE_BUTTON)
local create = createButton(toolbar, Config.CREATE_ASSETS_BUTTON)

-- all buttons are disabled by default if theres no bot settings folder found
toggleStart.Enabled = false
togglePause.Enabled = false

--

local sendBotMessage = false
local checkpointLoop = false
local shouldStart = false
local shouldPause = false

---------------

local bot = findBotSettings()

local function setup()
    local assets = require(bot.Assets)
    local messageList = require(bot.Posts)

    local webhook = WebhookService.new(assets.WEBHOOK_URL)

    sendBotMessage = messageList.new(webhook)
end

-- checks to see if files in the bot settings are valid
local function verify()
end

local function make()
    verify()
    setup()

    toggleStart.Enabled = true
end

--

-- settings already found, can start
if bot then
    make()
end

create.Click:Connect(function()
    bot = createBotSettings()

    make()
end)

---------------

local INTERVAL = Config.CHECKPOINT_INTERVAL

local function createCheckpointLoop()
    checkpointLoop = Loop.new(function()
        sendBotMessage:CHECKPOINT()
    end)

    return checkpointLoop
end

local function onStart()
    sendBotMessage:START()

    createCheckpointLoop():run(INTERVAL)
end

local function onStop()
    -- if `:kill()` isnt called, `loop.totalTimeRunning` doesnt update
    checkpointLoop:discard()

    sendBotMessage:END(checkpointLoop)
end


--

toggleStart.Click:Connect(function()
    shouldStart = not shouldStart

    updateButtonIcon(toggleStart, Config.START_TOGGLE_BUTTON, shouldStart)

    if shouldStart then
        onStart()
    else
        onStop()
    end
end)

-- reset pause button back to idle when ending a session
toggleStart.Click:Connect(function()
    togglePause.Enabled = shouldStart

    if shouldStart then
        return
    end

    shouldPause = false

    updateButtonIcon(togglePause, Config.PAUSE_TOGGLE_BUTTON, shouldPause)
end)

---------------

local function onPause()
    sendBotMessage:PAUSE()

    checkpointLoop:stop()
end

local function onResume()
    sendBotMessage:RESUME()

    createCheckpointLoop():run(INTERVAL)
end

--

togglePause.Click:Connect(function()
    shouldPause = not shouldPause

    if shouldPause then
        onPause()
    else
        onResume()
    end
end)

---------------