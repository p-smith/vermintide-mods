return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`lobby_improvements` mod must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("lobby_improvements", {
			mod_script       = "scripts/mods/lobby_improvements/lobby_improvements",
			mod_data         = "scripts/mods/lobby_improvements/lobby_improvements_data",
			mod_localization = "scripts/mods/lobby_improvements/lobby_improvements_localization",
		})
	end,
	packages = {
		"resource_packages/lobby_improvements/lobby_improvements",
	},
}
