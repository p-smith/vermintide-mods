return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`show_potion_type` mod must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("show_potion_type", {
			mod_script       = "scripts/mods/show_potion_type/show_potion_type",
			mod_data         = "scripts/mods/show_potion_type/show_potion_type_data",
			mod_localization = "scripts/mods/show_potion_type/show_potion_type_localization",
		})
	end,
	packages = {
		"resource_packages/show_potion_type/show_potion_type",
	},
}
