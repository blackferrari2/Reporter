-- <> default message templates <> --

local TEMPLATES = {}

TEMPLATES.TAGS = {
    EMOJI = "(tag_emoji)",
    PROJECT_NAME = "(tag_pname)",
    DATE = "(tag_date)",
    TIME_ELAPSED = "(tag_time)",
    NAME = "(tag_author)",
    ANY = "(tag_arbitrary)",
}

---------------

local TAGS = TEMPLATES.TAGS

--

TEMPLATES.SEPARATOR = "### . . . . . . . . . . . . . . . . . . . . . . . . . . . . ."

--[[
    [EMOJI] `NEW [PROJECT_NAME] SESSION: [DATE]`
    ```[ANY]```
]]
TEMPLATES.START = TAGS.EMOJI .. "`NEW [" .. TAGS.PROJECT_NAME .. "] SESSION: " .. TAGS.DATE .. "`" .. "\n```" .. TAGS.ANY .. "```"

-- [EMOJI] `END [PROJECT_NAME] SESSION: [TIME_ELAPSED]`
TEMPLATES.END = TAGS.EMOJI .. "`END [" .. TAGS.PROJECT_NAME .. "] SESSION: " .. TAGS.TIME_ELAPSED .. "`"

-- [EMOJI] `THE SESSION HAS BEEN PAUSED`
TEMPLATES.PAUSE = TAGS.EMOJI .. "`THE SESSION HAS BEEN PAUSED`"

-- [EMOJI] `THE SESSION HAS BEEN RESUMED`
TEMPLATES.RESUME = TAGS.EMOJI .. "`THE SESSION HAS BEEN RESUMED`"

-- [EMOJI] **checkpoint:** *[NAME]* [ANY]
TEMPLATES.CHECKPOINT = TAGS.EMOJI .. "**checkpoint:** *" .. TAGS.NAME .. "* " .. TAGS.ANY

---------------

return TEMPLATES