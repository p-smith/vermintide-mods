local mod = get_mod("lobby_improvements")

mod:hook(LevelCountdownUI, "rpc_start_game_countdown", function(func, self, sender)
    func(self, sender)

    if mod:get(mod.SETTINGS.SKIP_COUNTDOWN) and Managers.player.is_server then
        self.enter_game_timer = 1
        self.total_start_game_time = 0
        self.last_timer_value = 0

        self.play_sound(self, "Play_hud_matchmaking_countdown_final")

        local widget_content = self.countdown_widget.content

        widget_content.info_text = ""
        widget_content.timer_text = Localize("game_starts_prepare")
    end

    return
end)

mod:hook(MatchmakingStateStartGame, "update_start_game_timer", function(func, self, dt)
    if not mod:get(mod.SETTINGS.SKIP_COUNTDOWN) then
        return func(self, dt)
    end

    self.start_game_timer = nil

    return true
end)

mod:hook(MatchmakingStateJoinGame, "on_enter", function(func, self, state_context)
    if not mod:get(mod.SETTINGS.POPUP) then
        return func(self, state_context)
    else
        self.lobby_data = state_context.profiles_data
        self.state_context = state_context
        self.lobby_client = state_context.lobby_client
        self.join_lobby_data = state_context.join_lobby_data
        self.lobby_data.selected_level_key = self.join_lobby_data.selected_level_key
        self.lobby_data.difficulty = self.join_lobby_data.difficulty
        local matchmaking_manager = self.matchmaking_manager
        local hero_index, hero_name = self._current_hero(self)

        assert(hero_index, "no hero index? this is wrong")

        self.wanted_profile_index = hero_index

        self.show_popup = true

        self.matchmaking_manager:set_status_message("matchmaking_status_joining_game")

        self._update_lobby_data_timer = 0
    end

    return
end)
