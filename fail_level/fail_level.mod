return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`fail_level` mod must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("fail_level", {
			mod_script       = "scripts/mods/fail_level/fail_level",
			mod_data         = "scripts/mods/fail_level/fail_level_data",
			mod_localization = "scripts/mods/fail_level/fail_level_localization",
		})
	end,
	packages = {
		"resource_packages/fail_level/fail_level",
	},
}
