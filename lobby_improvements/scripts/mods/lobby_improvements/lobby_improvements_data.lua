local mod = get_mod("lobby_improvements")

mod.SETTINGS = {
	SKIP_COUNTDOWN = "skip_preparation_countdown",
	POPUP = "show_popup"
}

return {
	name = "lobby_improvements",
	description = mod:localize("mod_description"),
	is_togglable = true,
	options = {
		widgets = {
			{
				setting_id    = mod.SETTINGS.SKIP_COUNTDOWN,
				type          = "checkbox",
				default_value = true
			},
			{
				setting_id    = mod.SETTINGS.POPUP,
				type          = "checkbox",
				default_value = false
			}
		}
	  }
}
