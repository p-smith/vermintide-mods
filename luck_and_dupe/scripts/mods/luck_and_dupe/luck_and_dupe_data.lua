local mod = get_mod("luck_and_dupe")

return {
	name = "Luck and dupe indicators",
	description = mod:localize("mod_description"),
	is_togglable = false,
	options = {
		widgets = {
			{
				setting_id = "show_luck",
				type = "checkbox",
				default_value = true
			},
			{
				setting_id = "show_dupe",
				type = "checkbox",
				default_value = true
			}
		}
	}
}
