local mod = get_mod("show_potion_type")

--[[
	Show Potion Type, by Grundlid.
--]]
mod:hook(_G, "Localize", function (func, id, ...)
	if string.find(id, "DONT_LOCALIZE_") == 1 then
		return string.sub(id, 15)
	end

	return func(id, ...)
end)

mod:hook(GenericUnitInteractorExtension, "interaction_description", function (func, self, fail_reason, interaction_type)
	local interaction_type = interaction_type or self.interaction_context.interaction_type
	local interaction_template = InteractionDefinitions[interaction_type]
	local hud_description, extra_param = interaction_template.client.hud_description(self.interaction_context.interactable_unit, interaction_template.config, fail_reason, self.unit)
	local hud_description_no_failure, extra_param_no_failure = interaction_template.client.hud_description(self.interaction_context.interactable_unit, interaction_template.config, nil, self.unit)

	if hud_description == nil then
		return "<ERROR: UNSPECIFIED INTERACTION HUD DESCRIPTION>"
	end

	if hud_description and hud_description_no_failure and hud_description == "grimoire_equipped" and string.find(hud_description_no_failure, "potion") ~= nil then
		return "DONT_LOCALIZE_"..Localize("grimoire_equipped").." "..Localize(hud_description_no_failure)
	end

	return func(self, fail_reason, interaction_type)
end)
