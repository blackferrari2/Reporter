-- <> messages that are sent whenever a new session starts <> --

--[[
    NOTE

    DO NOT EDIT THE FUNCTION names UNLESS U KNOW WHAT UR DOING
]]

local bot = script.Parent

local Assets = require(bot.Assets)
local Templates = require(bot.Templates)
local Openers = require(bot.Openers)
local Checkpoints = require(bot.Checkpoints)

---------------

local POSTS = {}
POSTS.__index = POSTS

---------------

function POSTS.new(webhook)
    local self = {}
    setmetatable(self, POSTS)

    self.webhook = webhook

    return self
end

function POSTS:LINE_SEPARATOR()
    local template = Templates.SEPARATOR

    --self.webhook:message(template)

    warn(template)
end

--

local TAGS = Templates.TAGS
local MATCH_WHOLE_WORDS_PATTERN = "%w+"

local function format(text, definitions)
    return string.gsub(text, MATCH_WHOLE_WORDS_PATTERN, definitions)
end

function POSTS:START()
    local template = Templates.START
    local quote = Openers:GET()

    local text = format(template, {
        [TAGS.EMOJI] = Assets.EMOJIS.START,
        [TAGS.PROJECT_NAME] = Assets.PROJECT_NAME,
        [TAGS.DATE] = os.date(),
        [TAGS.ANY] = quote,
    })

    warn(text)

    if true then
        return
    end

    self.webhook:message(text)

    local poster = Assets.BIG_POSTERS:GET()

    self.webhook:message(poster)

    self:LINE_SEPARATOR()
end

function POSTS:PAUSE()
    local template = Templates.PAUSE

    local text = format(template, {
        [TAGS.EMOJI] = Assets.EMOJIS.PAUSE,
    })

    warn(text)

    if true then
        return
    end

    self.webhook:message(text)
end

function POSTS:RESUME()
    local template = Templates.RESUME

    local text = format(template, {
        [TAGS.EMOJI] = Assets.EMOJIS.RESUME,
    })

    warn(text)

    if true then
        return
    end

    self.webhook:message(text)
end

function POSTS:CHECKPOINT()
    local checkpoint = Checkpoints:GET()
    local template = Templates.CHECKPOINT

    local text = format(template, {
        [TAGS.EMOJI] = Assets.EMOJIS.CHECKPOINT,
        [TAGS.NAME] = checkpoint.AUTHOR,
        [TAGS.ANY] = checkpoint.MESSAGE,
    })

    warn(text)

    if true then
        return
    end

    self.webhook:message(text)
end

--

local function secondsToHMS(sec)
    local hour = sec / 60^2
    local minute = sec / 60 % 60
    local second = sec % 60

	return string.format("%02i:%02i:%02i", hour, minute, second)
end

function POSTS:END(loop)
    local timeElapsed = secondsToHMS(loop.totalTimeRunning)

    self:LINE_SEPARATOR()

    local template = Templates.END

    local text = format(template, {
        [TAGS.EMOJI] = Assets.EMOJIS.END,
        [TAGS.PROJECT_NAME] = Assets.PROJECT_NAME,
        [TAGS.TIME_ELAPSED] = timeElapsed,
    })

    warn(text)

    if true then
        return
    end

    self.webhook:message(text)

    local poster = Assets.SMALL_POSTERS:GET()

    self.webhook:message(poster)
end

---------------

return POSTS