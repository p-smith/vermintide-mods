local mod = get_mod("different_bots")

local DEBUG_ENABLED                         = false
local ENABLE_DEBUG_FEEDS                    = false
local DEBUG_PARAMETER_20191029              = false
local DEBUG_NO_RANGED_ATTACKS               = false
local DEBUG_NO_MELEE_ATTACKS                = false
local DEBUG_ALWAYS_LIGHT_MELEE_ATTACKS      = false
local DEBUG_ALWAYS_HEAVY_MELEE_ATTACKS      = false -- overrides DEBUG_ALWAYS_LIGHT_MELEE_ATTACKS
local ENABLE_PICKUP_ON_PING_DEBUG_OUTPUT    = false
 
local MANUAL_HEAL_DISABLED = 1
local MANUAL_HEAL_OPTIONAL = 2
local MANUAL_HEAL_MANDATORY = 3

function mod.noop()
end