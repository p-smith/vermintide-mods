return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`rat_climb_teleport_fix` mod must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("rat_climb_teleport_fix", {
			mod_script       = "scripts/mods/rat_climb_teleport_fix/rat_climb_teleport_fix",
			mod_data         = "scripts/mods/rat_climb_teleport_fix/rat_climb_teleport_fix_data",
			mod_localization = "scripts/mods/rat_climb_teleport_fix/rat_climb_teleport_fix_localization",
		})
	end,
	packages = {
		"resource_packages/rat_climb_teleport_fix/rat_climb_teleport_fix",
	},
}
