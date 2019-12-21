local mod = get_mod("fail_level")

return {
	name = "Fail level",
	description = mod:localize("mod_description"),
	is_togglable = true,
	options = {
		widgets = {
			{
				setting_id      = "fail_command_hotkey",
				type            = "keybind",
				default_value   = {},
				keybind_trigger = "pressed",
				keybind_type    = "function_call",
				function_name   = "do_fail"
			},
			{
				setting_id      = "home_command_hotkey",
				type            = "keybind",
				default_value   = {},
				keybind_trigger = "pressed",
				keybind_type    = "function_call",
				function_name   = "do_go_home"
			},
			{
				setting_id      = "restart_command_hotkey",
				type            = "keybind",
				default_value   = {},
				keybind_trigger = "pressed",
				keybind_type    = "function_call",
				function_name   = "do_restart"
			},
		}
	}

}
