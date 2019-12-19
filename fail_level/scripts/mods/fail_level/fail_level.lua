local mod = get_mod("fail_level")

local function do_fail()
    if Managers.state.game_mode._level_key ~= "inn_level" then
        Managers.state.game_mode:fail_level()
    end
end

mod:command("fail", "Trigger a defeated screen.", do_fail)
