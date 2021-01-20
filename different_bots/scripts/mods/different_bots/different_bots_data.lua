local mod = get_mod("different_bots")

local SETTINGS = mod.SETTINGS

return {
	name = "Different bots",
	description = mod:localize("mod_description"),
	is_togglable = true,
	options = {
		widgets = {
			{
				setting_id = SETTINGS.BOT_TO_AVOID,
				type = "dropdown",
				default_value = 2,
				options = {
					{text = SETTINGS.BOT_TO_AVOID_WH, value = 1},
					{text = SETTINGS.BOT_TO_AVOID_BW, value = 2},
					{text = SETTINGS.BOT_TO_AVOID_DR, value = 3},
					{text = SETTINGS.BOT_TO_AVOID_WW, value = 4},
					{text = SETTINGS.BOT_TO_AVOID_ES, value = 5}
				}
			},
			{
				setting_id = SETTINGS.OVERRIDE_LEFT_PLAYER,
				type = "checkbox",
				default_value = true
			},
			{
				setting_id = SETTINGS.NO_CHASE_RATLING,
				type = "checkbox",
				default_value = true
			},
			{
				setting_id = SETTINGS.NO_CHASE_GLOBADIER,
				type = "checkbox",
				default_value = true
			},
			{
				setting_id = SETTINGS.NO_SEEK_COVER,
				type = "checkbox",
				default_value = true
			},
			{
				setting_id = SETTINGS.BETTER_MELEE,
				type = "checkbox",
				default_value = true
			},
			{
				setting_id = SETTINGS.BETTER_RANGED,
				type = "checkbox",
				default_value = true
			},
			{
				setting_id = SETTINGS.VENT_ALLOWED,
				type = "checkbox",
				default_value = true,
				sub_widgets = {
					{
						setting_id = SETTINGS.VENT_HP_THRESHOLD,
						type = "numeric",
						default_value = 75,
						range = {0, 100}
					}
				}
			},
			{
				setting_id = SETTINGS.MANUAL_HEAL,
				type = "dropdown",
				default_value = 1,
				options = {
					{text = SETTINGS.MANUAL_HEAL_OFF, value = 1},
					{text = SETTINGS.MANUAL_HEAL_OPTIONAL, value = 2, show_widgets = {1, 2, 3, 4}},
					{text = SETTINGS.MANUAL_HEAL_MANDATORY, value = 3, show_widgets = {1, 2, 3, 4}}
				},
				sub_widgets = {
					{
						setting_id = SETTINGS.MANUAL_HEAL_KEY1,
						type = "keybind",
						keybind_global = false,
						keybind_trigger = "held",
						keybind_type = "function_call",
						function_name = "noop",
						default_value = {}
					},
					{
						setting_id = SETTINGS.MANUAL_HEAL_KEY2,
						type = "keybind",
						keybind_global = false,
						keybind_trigger = "held",
						keybind_type = "function_call",
						function_name = "noop",
						default_value = {}
					},
					{
						setting_id = SETTINGS.MANUAL_HEAL_KEY3,
						type = "keybind",
						keybind_global = false,
						keybind_trigger = "held",
						keybind_type = "function_call",
						function_name = "noop",
						default_value = {}
					},
					{
						setting_id = SETTINGS.MANUAL_HEAL_KEY4,
						type = "keybind",
						keybind_global = false,
						keybind_trigger = "held",
						keybind_type = "function_call",
						function_name = "noop",
						default_value = {}
					}
				}
			},
			{
				setting_id = SETTINGS.LOOT_GRIMS,
				type = "checkbox",
				default_value = true
			},
			{
				setting_id = SETTINGS.LOOT_TOMES,
				type = "checkbox",
				default_value = true
			},
			{
				setting_id = SETTINGS.FORCE_LOOT_PINGED_ITEM,
				type = "keybind",
				keybind_global = false,
				keybind_trigger = "pressed",
				keybind_type = "function_call",
				function_name = "noop",
				default_value = {}
			},
			{
				setting_id = SETTINGS.HP_BASED_LOOT_PINGED_HEAL,
				type = "checkbox",
				default_value = false,
				sub_widgets = {
					{
						setting_id = SETTINGS.HP_BASED_HEALTH_WEIGHT,
						type = "numeric",
						range = {0, 5},
						default_value = 3
					},
					{
						setting_id = SETTINGS.HP_BASED_WOUNDED_WEIGHT,
						type = "numeric",
						range = {0, 5},
						default_value = 3
					},
					{
						setting_id = SETTINGS.HP_BASED_GRIM_WEIGHT,
						type = "numeric",
						range = {0, 5},
						default_value = 3
					}
				}
			},
			{
				setting_id = SETTINGS.KEEP_TOMES,
				type = "checkbox",
				default_value = true
			},
			{
				setting_id = SETTINGS.PING_STORMVERMIN,
				type = "checkbox",
				default_value = true
			},
			{
				setting_id = SETTINGS.FOLLOW,
				type = "checkbox",
				default_value = true
			},
			{
				setting_id = SETTINGS.CONSERVE_SNIPER_AMMO,
				type = "checkbox",
				default_value = true
			},
			{
				setting_id = SETTINGS.HELP_WITH_BREAKABLES_OBJECTIVES,
				type = "checkbox",
				default_value = true,
				sub_widgets = {
					{
						setting_id = SETTINGS.BREAKABLES_OBJECTIVES_THRESHOLD,
						type = "numeric",
						range = {0, 100},
						default_value = 0
					}
				}
			},
			{
				setting_id = SETTINGS.DEFEND_MISSION_OBJECTIVES,
				type = "checkbox",
				default_value = true,
				sub_widgets = {
					{
						setting_id = SETTINGS.DEFEND_MISSION_OBJECTIVES_TOGGLE_KEY,
						type = "keybind",
						keybind_global = false,
						keybind_trigger = "pressed",
						keybind_type = "function_call",
						function_name = "noop",
						default_value = {}
					}
				}
			},
			{
				setting_id = SETTINGS.AUTOEQUIP,
				type = "checkbox",
				default_value = false,
				sub_widgets = {
					{
						setting_id = SETTINGS.AUTOEQUIP_SLOT,
						type = "numeric",
						range = {1, 9},
						default_value = 1
					}
				}
			},
			{
				setting_id = SETTINGS.BOT_INFO_GUARD_BREAK_GLOBAL_MESSAGE,
				type = "checkbox",
				default_value = false
			},
			{
				setting_id = SETTINGS.BOT_AGGRESSIVE_MELEE_MODE,
				type = "checkbox",
				default_value = true
			},
			{
				setting_id = SETTINGS.CC_ATTACKS_ALLOWED,
				type = "checkbox",
				default_value = true,
				sub_widgets = {
					{
						setting_id = SETTINGS.CC_ATTACKS_SHIELD_HAMMER,
						type = "checkbox",
						default_value = true
					},
					{
						setting_id = SETTINGS.CC_ATTACKS_SHIELD_AXE,
						type = "checkbox",
						default_value = true
					},
					{
						setting_id = SETTINGS.CC_ATTACKS_SHIELD_MACE,
						type = "checkbox",
						default_value = true
					},
					{
						setting_id = SETTINGS.CC_ATTACKS_SHIELD_SWORD,
						type = "checkbox",
						default_value = true
					},
					{
						setting_id = SETTINGS.CC_ATTACKS_2H_HAMMERS,
						type = "checkbox",
						default_value = true
					}
				}
			},
			{
				setting_id = SETTINGS.KB_AGAINST_ARMOR,
				type = "checkbox",
				default_value = true
			},
			{
				setting_id = SETTINGS.PERFORMANCE_REDUCTION_SHOW,
				type = "checkbox",
				default_value = false,
				sub_widgets = {
					{
						setting_id = SETTINGS.CAP_SLIDERS_MELEE,
						type = "numeric",
						range = {0, 100},
						default_value = 100
					},
					{
						setting_id = SETTINGS.CAP_SLIDERS_RANGED,
						type = "numeric",
						range = {0, 100},
						default_value = 100
					},
					{
						setting_id = SETTINGS.CAP_SLIDERS_SPECIALS,
						type = "numeric",
						range = {0, 100},
						default_value = 100
					},
					{
						setting_id = SETTINGS.IGNORE_SPECIALS_PINGS,
						type = "checkbox",
						default_value = false
					},
					{
						setting_id = SETTINGS.REDUCE_AMBIENT_SHOOTING,
						type = "checkbox",
						default_value = false
					},
				}
			},
			{
				setting_id = SETTINGS.ALWAYS_PASS_DRAUGHTS_TO_HUMANS,
				type = "checkbox",
				default_value = false
			},
			{
				setting_id = SETTINGS.TRADING_PREFER_ENABLE,
				type = "checkbox",
				default_value = false,
				sub_widgets = {
					{
						setting_id = SETTINGS.TRADING_PREFER_POTION,
						type = "dropdown",
						default_value = 0,
						options = {
							{text = SETTINGS.TRADING_PREFER_NO_PREF, value = 0},
							{text = SETTINGS.TRADING_PREFER_STR_POT, value = 1},
							{text = SETTINGS.TRADING_PREFER_SPEED_POT, value = 2},
							{text = SETTINGS.TRADING_PREFER_DIFFERENT_POT, value = 3},
						}
					},
					{
						setting_id = SETTINGS.TRADING_PREFER_GRENADE,
						type = "dropdown",
						default_value = 0,
						options = {
							{text = SETTINGS.TRADING_PREFER_NO_PREF, value = 0},
							{text = SETTINGS.TRADING_PREFER_FRAG_BOMB, value = 1},
							{text = SETTINGS.TRADING_PREFER_FIRE_BOMB, value = 2},
							{text = SETTINGS.TRADING_PREFER_DIFFERENT_BOMB, value = 3},
						}
					},
					{
						setting_id = SETTINGS.TRADING_PREFER_MAX_DISTANCE,
						type = "numeric",
						range = {4, 20},
						default_value = 20
					},
				}
			},
		}
	}
}
