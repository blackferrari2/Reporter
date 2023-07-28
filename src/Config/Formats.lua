-- <> default text formats <> --

local FORMATS = {}

FORMATS.TAGS = {
    EMOJI = "(tag_emoji)",
    PROJECT_NAME = "(tag_pname)",
    DATE = "(tag_date)",
    TIME_ELAPSED = "(tag_time)",
    NAME = "(tag_author)",
    ANY = "(tag_arbitrary)",
}

---------------

local TAGS = FORMATS.TAGS

--

--[[
    [EMOJI] `NEW [PROJECT_NAME] SESSION: [DATE]`
    ```[ANY]```
]]
FORMATS.START = TAGS.EMOJI .. "`NEW [" .. TAGS.PROJECT_NAME .. "] SESSION: " .. TAGS.DATE .. "`" .. "\n" .. TAGS.ANY

-- [EMOJI] `END [PROJECT_NAME] SESSION: [TIME_ELAPSED]`
FORMATS.END = TAGS.EMOJI .. "`END [" .. TAGS.PROJECT_NAME .. "] SESSION: " .. TAGS.TIME_ELAPSED .. "`"

-- [EMOJI] `THE SESSION HAS BEEN PAUSED`
FORMATS.PAUSE = TAGS.EMOJI .. "`THE SESSION HAS BEEN PAUSED`"

-- [EMOJI] `THE SESSION HAS BEEN RESUMED`
FORMATS.PAUSE = TAGS.EMOJI .. "`THE SESSION HAS BEEN RESUMED`"

-- [EMOJI] **checkpoint:** *[NAME]* [ANY]
FORMATS.CHECKPOINT = TAGS.EMOJI .. "**checkpoint:** *" .. TAGS.NAME .. "* " .. TAGS.ANY

---------------

return FORMATS