return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`Luck and dupe indicators` mod must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("luck_and_dupe", {
			mod_script       = "scripts/mods/luck_and_dupe/luck_and_dupe",
			mod_data         = "scripts/mods/luck_and_dupe/luck_and_dupe_data",
			mod_localization = "scripts/mods/luck_and_dupe/luck_and_dupe_localization",
		})
	end,
	packages = {
		"resource_packages/luck_and_dupe/luck_and_dupe",
	},
}
