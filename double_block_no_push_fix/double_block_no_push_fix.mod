return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`Double block fix` mod must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("double_block_no_push_fix", {
			mod_script       = "scripts/mods/double_block_no_push_fix/double_block_no_push_fix",
			mod_data         = "scripts/mods/double_block_no_push_fix/double_block_no_push_fix_data",
			mod_localization = "scripts/mods/double_block_no_push_fix/double_block_no_push_fix_localization",
		})
	end,
	packages = {
		"resource_packages/double_block_no_push_fix/double_block_no_push_fix",
	},
}
