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
local packages = source.Packages

local Config = require(script.Config)
local Loop = require(resources.Loop)
local WebhookService = require(resources.WebhookService)
local t = require(packages.t)

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
    local settingsAlreadyExist = findBotSettings()

    if settingsAlreadyExist then
        warn("SETTINGS ALREADY EXIST. REPLACING WITH A NEW COPY")

        settingsAlreadyExist:Destroy()
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
local checkpointLoopRate = false

local shouldStart = false
local shouldPause = false

---------------

local bot = findBotSettings()

local function setup()
    local assets = require(bot.Assets)

    checkpointLoopRate = assets.CHECKPOINT_INTERVAL

    local messageList = require(bot.Posts)
    local webhook = WebhookService.new(assets.WEBHOOK_URL)

    sendBotMessage = messageList.new(webhook)
end

-- checks to see if files in the bot settings are valid
local function verify()
    local roullete = require(bot._Roullete)
    local isRoullete = t.metatable(roullete)

    assert(t.callback(roullete.__call))
    assert(t.callback(roullete.GET))

    local openers = require(bot.Openers)
    local openersCheck = t.values(t.string)

    assert(openersCheck(openers))
    assert(isRoullete(openers))

    local checkpoints = require(bot.Checkpoints)
    local checkpointsCheck = t.values(t.strictInterface({
        AUTHOR = t.string,
        MESSAGE = t.string,
    }))

    assert(checkpointsCheck(checkpoints))
    assert(isRoullete(checkpoints))

    local assets = require(bot.Assets)
    local assetsCheck = t.interface({
        PROJECT_NAME = t.string,
        WEBHOOK_URL = t.string,
        CHECKPOINT_INTERVAL = t.numberMin(30),

        EMOJIS = t.table,
        BIG_POSTERS = t.table,
        SMALL_POSTERS = t.table,
    })

    assert(assetsCheck(assets))

    local emojis = assets.EMOJIS
    local emojisCheck = t.strictInterface({
        START = t.string,
        END = t.string,
        PAUSE = t.string,
        RESUME = t.string,
        CHECKPOINT = t.string,
    })

    assetsCheck(emojisCheck(emojis))

    local bigPosters = assets.BIG_POSTERS
    local smallPosters = assets.SMALL_POSTERS
    local posterCheck = t.union(t.values(t.string), isRoullete)

    assert(posterCheck(bigPosters))
    assert(posterCheck(smallPosters))

    warn("bot plugin assets r good to go")
end

local function make()
    setup()
    verify()

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

local function createCheckpointLoop()
    checkpointLoop = Loop.new(function()
        sendBotMessage:CHECKPOINT()
    end)

    return checkpointLoop
end

local function onStart()
    sendBotMessage:START()

    createCheckpointLoop():run(checkpointLoopRate)
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
    togglePause.Enabled = not shouldStart

    if not shouldStart then
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

    checkpointLoop:run(checkpointLoopRate)
end

--

togglePause.Click:Connect(function()
    shouldPause = not shouldPause

    updateButtonIcon(togglePause, Config.PAUSE_TOGGLE_BUTTON, shouldPause)

    if shouldPause then
        onPause()
    else
        onResume()
    end
end)

---------------