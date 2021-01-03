local mod = get_mod("lobby_improvements")

mod.SETTINGS = {
	SKIP_COUNTDOWN = "skip_preparation_countdown",
	POPUP = "show_popup",
	TELEPORT_TO_HOST = "teleport_to_host"
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

localization_data[mod.SETTINGS.TELEPORT_TO_HOST] = {
	en = "Spawn near host"
}

localization_data[mod.SETTINGS.TELEPORT_TO_HOST .. "_description"] = {
	en = "Change your spawn location to be close to the host after joining a lobby, if it otherwise would be too far away from any player.\n" ..
		"If the host is dead, you will spawn next to another player.\n"
}

return localization_data
