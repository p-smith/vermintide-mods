local mod = get_mod("lobby_improvements")

mod.SETTINGS = {
	SKIP_COUNTDOWN = "skip_preparation_countdown",
	POPUP = "show_popup"
}

local localization_data = {}

localization_data[mod.SETTINGS.SKIP_COUNTDOWN] = {
	en = "Skip countdown"
}

localization_data[mod.SETTINGS.POPUP] = {
	en = "Always show the hero popup"
}

localization_data[mod.SETTINGS.SKIP_COUNTDOWN .. "_description"] = {
	en = "Skip the 'Prepare Yourselves' countdown when hosting or joining a game in progress"
}

localization_data[mod.SETTINGS.POPUP .. "_description"] = {
	en = "Always show the hero popup when joining a lobby, even if your selected hero is available."
}

return localization_data
