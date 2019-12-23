local mod = get_mod("lobby_improvements")

return {
	name = "Lobby improvements",
	is_togglable = false,
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
