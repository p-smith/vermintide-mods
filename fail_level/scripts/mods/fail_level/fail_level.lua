local mod = get_mod("fail_level")

local function with_game_state(func)
    return function()
        local gm = Managers.state.game_mode

        if gm and gm._level_key ~= "inn_level" then
            func(gm)
        end
    end
end

mod.do_fail = with_game_state(function(gm)
    gm:fail_level()
end)

mod.do_go_home = with_game_state(function(gm)
    gm:start_specific_level("inn_level")
end)

mod.do_restart = with_game_state(function(gm)
    gm:retry_level()
end)

mod:command("fail", mod:localize("fail_command_description"), mod.do_fail)
mod:command("home", mod:localize("home_command_description"), mod.do_go_home)
mod:command("restart", mod:localize("restart_command_description"), mod.do_restart)
