local mod = get_mod("lobby_improvements")

--[[
    Skip countdown
]]
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

--[[
    Show hero popup
]]
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

--[[
    Show heroes in lobby list
]]
local LobbyListEx = {
    max_list_entries = 100
}

function LobbyListEx.get_current_hero_index()
    local peer_id = Network.peer_id()
    local player = Managers.player:player_from_peer_id(peer_id)
    local player_idx = (player and player.profile_index) or 0

    return player_idx
end

function LobbyListEx.is_hero_available_in_lobby(hero_index, lobby_data)
    local player_slot_name = "player_slot_" .. tostring(hero_index)
    local player_id = lobby_data[player_slot_name]

    if not player_id then
        return true
    end

    if player_id == "available" then
        return true
    end

    local local_player = Managers.player:local_player()
    local local_player_id = local_player.profile_id(local_player)

    if player_id == local_player_id then
        return true
    end

    return false
end

function LobbyListEx.create_lobby_buttons()
    LobbyListEx.heroes_button = UIWidgets.create_text_button("heroes_text_button", "Heroes", 18)
    LobbyListEx.heroes_button.style.text.localize = false
    LobbyListEx.heroes_button.style.text_hover.localize = false
end

function LobbyListEx.sort_lobbies_on_heroes_asc(lobby_a, lobby_b)
    local current_hero_index = LobbyListEx.get_current_hero_index()

    local hero_available_a = LobbyListEx.is_hero_available_in_lobby(current_hero_index, lobby_a) and 1 or 0
    local hero_available_b = LobbyListEx.is_hero_available_in_lobby(current_hero_index, lobby_b) and 1 or 0

    return hero_available_b < hero_available_a
end

function LobbyListEx.sort_lobbies_on_heroes_desc(lobby_a, lobby_b)
    local current_hero_index = LobbyListEx.get_current_hero_index()

    local hero_available_a = LobbyListEx.is_hero_available_in_lobby(current_hero_index, lobby_a) and 1 or 0
    local hero_available_b = LobbyListEx.is_hero_available_in_lobby(current_hero_index, lobby_b) and 1 or 0

    return hero_available_a < hero_available_b
end

function LobbyListEx.create_lobby_list_entry_style()
    return {
        background = {
            size = {
                1348,
                45
            },
            offset = {
                0,
                0,
                1
            }
        },
        locked_level = {
            size = {
                20,
                26
            },
            offset = {
                360,
                10,
                3
            }
        },
        locked_difficulty = {
            size = {
                20,
                26
            },
            offset = {
                610,
                10,
                3
            }
        },
        locked_status = {
            size = {
                20,
                26
            },
            offset = {
                830,
                10,
                3
            }
        },
        title_text = {
            vertical_alignment = "center",
            horizontal_alignment = "left",
            font_type = "hell_shark",
            size = {
                1348,
                45
            },
            text_color = Colors.color_definitions.white,
            font_size = 18,
            offset = {
                10,
                0,
                2
            }
        },
        level_text = {
            vertical_alignment = "center",
            horizontal_alignment = "left",
            font_type = "hell_shark",
            size = {
                1348,
                45
            },
            text_color = Colors.color_definitions.white,
            font_size = 18,
            offset = {
                380,
                0,
                2
            }
        },
        difficulty_text = {
            vertical_alignment = "center",
            horizontal_alignment = "left",
            font_type = "hell_shark",
            size = {
                1348,
                45
            },
            text_color = Colors.color_definitions.white,
            font_size = 18,
            offset = {
                630,
                0,
                2
            }
        },
        num_players_text = {
            vertical_alignment = "center",
            horizontal_alignment = "left",
            font_type = "hell_shark",
            size = {
                1348,
                45
            },
            text_color = Colors.color_definitions.white,
            font_size = 18,
            offset = {
                750,
                0,
                2
            }
        },
        status_text = {
            vertical_alignment = "center",
            horizontal_alignment = "left",
            font_type = "hell_shark",
            size = {
                1348,
                45
            },
            text_color = Colors.color_definitions.white,
            font_size = 18,
            offset = {
                850,
                0,
                2
            }
        },
        hero_icon_1 = {
            size = { 30, 26 },
            offset = {
                950,
                8,
                3
            }
        },
        hero_icon_2 = {
            size = { 30, 26 },
            offset = {
                982,
                8,
                3
            }
        },
        hero_icon_3 = {
            size = { 30, 26 },
            offset = {
                1014,
                8,
                3
            }
        },
        hero_icon_4 = {
            size = { 30, 26 },
            offset = {
                1046,
                8,
                3

            }
        },
        hero_icon_5 = {
            size = { 30, 26 },
            offset = {
                1078,
                8,
                3
            }
        },
        country_text = {
            vertical_alignment = "center",
            horizontal_alignment = "right",
            font_type = "hell_shark",
            size = {
                1348,
                45
            },
            text_color = Colors.color_definitions.white,
            font_size = 18,
            offset = {
                -5,
                0,
                2
            }
        }
    }
end

function LobbyListEx.make_utf8_valid(str)
    while not Utf8.valid(str) do
        local length = string.len(str)

        if length == 1 then
            str = ""
        else
            str = string.sub(str, 1, length - 1)
        end
    end

    return str
end

function LobbyListEx.lobby_level_display_name(lobby_data)
    local level = lobby_data.selected_level_key or lobby_data.level_key
    local level_setting = level and LevelSettings[level]
    local level_display_name = level and level_setting.display_name
    local level_text = (level and Localize(level_display_name)) or "-"

    return level_text
end

function LobbyListEx.lobby_difficulty_display_name(lobby_data)
    local difficulty = lobby_data.difficulty
    local difficulty_setting = difficulty and DifficultySettings[difficulty]
    local difficulty_display_name = difficulty and difficulty_setting.display_name
    local difficulty_text = (difficulty and Localize(difficulty_display_name)) or "-"

    return difficulty_text
end

function LobbyListEx.lobby_status_text(lobby_data)
    local is_private = lobby_data.matchmaking == "false"
    local is_full = lobby_data.num_players == MatchmakingSettings.MAX_NUMBER_OF_PLAYERS
    local is_in_inn = lobby_data.level_key == "inn_level"
    local is_broken = lobby_data.is_broken
    local status = (is_broken and "lb_broken") or (is_private and "lb_private") or (is_full and "lb_full") or (is_in_inn and "lb_in_inn") or "lb_started"
    local status_text = (status and Localize(status)) or ""

    return status_text
end

function LobbyListEx.lobby_heroes_icons(lobby_data)
    local heroes_icons = {
        "icon_loot_trinket_witch_hunter",
        "icon_loot_trinket_bright_wizard",
        "icon_loot_trinket_dwarf_ranger",
        "icon_loot_trinket_waywatcher",
        "icon_loot_trinket_empire_soldier"
        }

    local active_icons = {}

    for i=5,1,-1 do
        local player_slot = "player_slot_" .. i

        if lobby_data[player_slot] and lobby_data[player_slot] ~= "available" then
            active_icons[#active_icons + 1] = heroes_icons[i]
        end
    end

    return active_icons
end

function LobbyListEx.lobby_country_text(lobby_data)
    local country_code = lobby_data.country_code
	local country_text = (country_code and iso_countries[country_code]) or ""

	return country_text
end

function LobbyListEx.level_is_locked(lobby_data)
    local level = lobby_data.selected_level_key or lobby_data.level_key

    if not level then
        return false
    end

    local in_inn = lobby_data.level_key == "inn_level"

    if in_inn then
        return false
    end

    local player_manager = Managers.player
    local player = player_manager.local_player(player_manager)
    local statistics_db = player_manager.statistics_db(player_manager)
    local player_stats_id = player.stats_id(player)
    local level_unlocked = LevelUnlockUtils.level_unlocked(statistics_db, player_stats_id, level)

    if not level_unlocked then
        return true
    end

    return
end

function LobbyListEx.difficulty_is_locked(lobby_data)
    local level_key = lobby_data.selected_level_key or lobby_data.level_key
    local player_manager = Managers.player
    local player = player_manager.local_player(player_manager)
    local statistics_db = player_manager.statistics_db(player_manager)
    local player_stats_id = player.stats_id(player)
    local difficulty = lobby_data.difficulty

    if not difficulty or not level_key then
        return false
    end

    local in_inn = lobby_data.level_key == "inn_level"

    if in_inn then
        return false
    end

    local unlocked_level_difficulty_index = LevelUnlockUtils.unlocked_level_difficulty_index(statistics_db, player_stats_id, level_key)

    if not unlocked_level_difficulty_index then
        return true
    end

    local difficulty_manager = Managers.state.difficulty
    local level_difficulties = difficulty_manager.get_level_difficulties(difficulty_manager, level_key)
    local unlocked_difficulty_key = level_difficulties[unlocked_level_difficulty_index]
    local unlocked_difficulty_settings = DifficultySettings[unlocked_difficulty_key]
    local difficulty_setting = DifficultySettings[difficulty]

    if unlocked_difficulty_settings.rank < difficulty_setting.rank then
        return true
    end

    return
end

function LobbyListEx.status_is_locked(lobby_data)
    local num_players = lobby_data.num_players
    local matchmaking = lobby_data.matchmaking

    if not num_players or not matchmaking then
        return false
    end

    local is_private = lobby_data.matchmaking == "false"
    local is_full = lobby_data.num_players == MatchmakingSettings.MAX_NUMBER_OF_PLAYERS
    local is_broken = lobby_data.is_broken

    return is_broken or is_full or is_private
end

function LobbyListEx.create_lobby_list_entry_content(lobby_data)
    local my_peer_id = Network:peer_id()
    local host = lobby_data.host or lobby_data.Host
    local title_text = LobbyListEx.make_utf8_valid(lobby_data.server_name or lobby_data.unique_server_name or host)

    if host == my_peer_id or not title_text then
        return
    end

    local level_text = LobbyListEx.lobby_level_display_name(lobby_data)
    local num_players_text = lobby_data.num_players or 0
    local difficulty_text = LobbyListEx.lobby_difficulty_display_name(lobby_data)
    local status_text = LobbyListEx.lobby_status_text(lobby_data)
    local heroes_icons = LobbyListEx.lobby_heroes_icons(lobby_data)
    local is_invalid = not lobby_data.valid
    local status_text_parsed = (is_invalid and "[INV]" .. status_text) or status_text
    local country_text = LobbyListEx.lobby_country_text(lobby_data)
    local content = {
        locked_difficulty = "locked_icon_01",
        locked_status = "locked_icon_01",
        background_selected = "lb_list_item_clicked",
        background_normal_hover = "lb_list_item_hover",
        visible = true,
        background_selected_hover = "lb_list_item_clicked",
        background_normal = "lb_list_item_normal",
        locked_level = "locked_icon_01",
        button_hotspot = {},
        lobby_data = lobby_data,
        title_text = title_text,
        level_text = level_text,
        difficulty_text = difficulty_text,
        num_players_text = num_players_text .. "/4",
        status_text = status_text_parsed,
        country_text = country_text,
        level_is_locked = LobbyListEx.level_is_locked(lobby_data),
        difficulty_is_locked = LobbyListEx.difficulty_is_locked(lobby_data),
        status_is_locked = LobbyListEx.status_is_locked(lobby_data)
    }

    for i=1,5 do
        content["hero_icon_"..i] = ""
    end

    for i,hero_icon in ipairs(heroes_icons) do
        content["hero_icon_"..i] = hero_icon
    end

    return content
end

function LobbyListEx.create_empty_lobby_list_entry_content()
    local content = {
        difficulty_text = "",
        title_text = "",
        num_players_text = "",
        background_normal = "lb_list_item_bg",
        background_normal_hover = "lb_list_item_bg",
        fake = true,
        country_text = "",
        background_selected = "lb_list_item_bg",
        level_text = "",
        status_text = "",
        background_selected_hover = "lb_list_item_bg",
        button_hotspot = {}
    }

    for i=1,5 do
        content["hero_icon_"..i] = ""
    end

    return content
end

LobbyListEx.create_lobby_buttons()

mod:hook(LobbyItemsList, "populate_lobby_list", function(func, self, lobbies, ignore_scroll_reset)
    local settings = self.settings
    local item_list_widget = self.item_list_widget
    local list_content = {}
    local list_style = self.list_style
    local num_lobbies = 0
    local sort_func = self.sort_lobbies_function
    local selected_lobby = self.selected_lobby(self)
    local lobbies_array = self.convert_to_array(self, lobbies)

    if sort_func then
        self.sort_lobbies(self, lobbies_array, sort_func)
    end

    for lobby_id, lobby_data in pairs(lobbies_array) do
        local style = LobbyListEx.create_lobby_list_entry_style()
        local content = LobbyListEx.create_lobby_list_entry_content(lobby_data)

        if content then
            num_lobbies = num_lobbies + 1
            list_content[num_lobbies] = content
            list_style.item_styles[num_lobbies] = style

            if LobbyListEx.max_list_entries <= num_lobbies then
                break
            end
        end
    end

    self.lobbies = lobbies_array
    self.number_of_items_in_list = num_lobbies
    item_list_widget.content.list_content = list_content
    item_list_widget.style.list_style = list_style
    item_list_widget.style.list_style.start_index = 1
    item_list_widget.style.list_style.num_draws = settings.num_list_items
    item_list_widget.element.pass_data[1].num_list_elements = nil
    local num_draws = item_list_widget.style.list_style.num_draws

    if num_lobbies < num_draws then
        local num_empty = num_draws - num_lobbies%num_draws

        if num_empty <= num_draws then
            for i = 1, num_empty, 1 do
                local content = LobbyListEx.create_empty_lobby_list_entry_content()
                local style = LobbyListEx.create_lobby_list_entry_style()
                local index = #list_content + 1
                list_content[index] = content
                list_style.item_styles[index] = style
            end
        end
    end

    self.set_scrollbar_length(self, nil, ignore_scroll_reset)

    if selected_lobby then
        self.set_selected_lobby(self, selected_lobby)
    else
        self.on_lobby_selected(self, 1, false)
    end

    return
end)

mod:hook(LobbyItemsList, "create_ui_elements", function(func, self)
    self.scenegraph_definition.players_text_button.position = {750, 0, 2}
    self.scenegraph_definition.status_text_button.position = {850, 0, 2}

    local _heroes_text_button = {
        parent = "label_root",
        horizontal_alignment = "left",
        position = {950, 0, 2},
        size = {
                110,
                40
               }
    }

    self.scenegraph_definition.heroes_text_button = _heroes_text_button

    local passes = self.widget_definitions.inventory_list_widget.element.passes[1].passes

    for i=1,5 do
        local found_pass = false

        for _,pass in ipairs(passes) do
            if pass.style_id == "hero_icon_"..i then
                found_pass = true
                break
            end
        end

        if not found_pass then
            local _heroes_pass = {
                pass_type = "texture",
                style_id = "hero_icon_"..i,
                texture_id = "hero_icon_"..i,
                content_check_function = function(ui_content)
                    return ui_content and ui_content["hero_icon_"..i] ~= ""
                end
            }
            self.widget_definitions.inventory_list_widget.element.passes[1].passes[#self.widget_definitions.inventory_list_widget.element.passes[1].passes + 1] = _heroes_pass
        end
    end

    self.ui_scenegraph = UISceneGraph.init_scenegraph(self.scenegraph_definition)
    local scrollbar_scenegraph_id = "scrollbar_root"
    local scrollbar_scenegraph = self.scenegraph_definition[scrollbar_scenegraph_id]
    self.scrollbar_widget = UIWidget.init(UIWidgets.create_scrollbar(scrollbar_scenegraph.size[2], scrollbar_scenegraph_id))
    self.item_list_widget = UIWidget.init(self.widget_definitions.inventory_list_widget)
    self.scroll_field_widget = UIWidget.init(self.widget_definitions.scroll_field)
    self.host_text_button = UIWidget.init(self.widget_definitions.host_text_button)
    self.level_text_button = UIWidget.init(self.widget_definitions.level_text_button)
    self.difficulty_text_button = UIWidget.init(self.widget_definitions.difficulty_text_button)
    self.players_text_button = UIWidget.init(self.widget_definitions.players_text_button)
    self.status_text_button = UIWidget.init(self.widget_definitions.status_text_button)
    self.heroes_text_button = UIWidget.init(LobbyListEx.heroes_button)
    self.country_text_button = UIWidget.init(self.widget_definitions.country_text_button)
    self.loading_overlay = UIWidget.init(self.widget_definitions.loading_overlay)
    self.loading_icon = UIWidget.init(self.widget_definitions.loading_icon)
    self.loading_text = UIWidget.init(self.widget_definitions.loading_text)
    self.country_text_button.style.text.horizontal_alignment = "right"
    self.country_text_button.style.text_hover.horizontal_alignment = "right"

    UIRenderer.clear_scenegraph_queue(self.ui_renderer)

    return
end)

mod:hook(LobbyItemsList, "draw", function(func, self, dt)
    func(self, dt)

    local ui_renderer = self.ui_renderer
    local ui_scenegraph = self.ui_scenegraph
    local input_manager = self.input_manager
    local input_service = input_manager.get_service(input_manager, self.input_service_name)

    UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt)
    UIRenderer.draw_widget(ui_renderer, self.heroes_text_button)
	UIRenderer.end_pass(ui_renderer)

    return
end)

mod:hook(LobbyItemsList, "update", function(func, self, dt, loading, ignore_gamepad_input)
    local lobbies = self.lobbies

    func(self, dt, loading, ignore_gamepad_input)

    local heroes_button_hotspot = self.heroes_text_button.content.button_text

    if heroes_button_hotspot.on_pressed then
        local sort_func = self._pick_sort_func(self, LobbyListEx.sort_lobbies_on_heroes_asc, LobbyListEx.sort_lobbies_on_heroes_desc)
        local lobbies = self.lobbies

        self.populate_lobby_list(self, lobbies, true)
        self.play_sound(self, "Play_hud_select")
    end

    return
end)