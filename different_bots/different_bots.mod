return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`different_bots` mod must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("different_bots", {
			mod_script       = "scripts/mods/different_bots/different_bots",
			mod_data         = "scripts/mods/different_bots/different_bots_data",
			mod_localization = "scripts/mods/different_bots/different_bots_localization",
		})
	end,
	packages = {
		"resource_packages/different_bots/different_bots",
	},
}
