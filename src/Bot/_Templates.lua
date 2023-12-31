-- <> default message templates <> --

--[[
    WARNING

    DO NOT EDIT TAGS OR TEMPLATE NAMES UNLESS U KNOW WHAT UR DOING
]]

local TEMPLATES = {}

TEMPLATES.TAGS = {
    EMOJI = "tagEMOJI",
    PROJECT_NAME = "tagPNAME",
    DATE = "tagDATE",
    TIME_ELAPSED = "tagTIME",
    NAME = "tagNAME",
    ANY = "tagARBITRARY",
}

---------------

local TAGS = TEMPLATES.TAGS

--

TEMPLATES.SEPARATOR = "### . . . . . . . . . . . . . . . . . . . . . . . . . . . . ."

--[[
    [EMOJI] `NEW [PROJECT_NAME] SESSION: [DATE]`
    ```[ANY]```
]]
TEMPLATES.START = TAGS.EMOJI .. " `NEW [" .. TAGS.PROJECT_NAME .. "] SESSION: " .. TAGS.DATE .. "`" .. "\n```" .. TAGS.ANY .. "```"

-- [EMOJI] `END [PROJECT_NAME] SESSION: [TIME_ELAPSED]`
TEMPLATES.END = TAGS.EMOJI .. " `END [" .. TAGS.PROJECT_NAME .. "] SESSION: " .. TAGS.TIME_ELAPSED .. " Elapsed`"

-- [EMOJI] `THE SESSION HAS BEEN PAUSED`
TEMPLATES.PAUSE = TAGS.EMOJI .. " `THE SESSION HAS BEEN PAUSED`"

-- [EMOJI] `THE SESSION HAS BEEN RESUMED`
TEMPLATES.RESUME = TAGS.EMOJI .. " `THE SESSION HAS BEEN RESUMED`"

-- [EMOJI] **checkpoint:** *[NAME]* [ANY]
TEMPLATES.CHECKPOINT = TAGS.EMOJI .. " **checkpoint:** *[" .. TAGS.NAME .. "]* " .. TAGS.ANY

---------------

return TEMPLATES