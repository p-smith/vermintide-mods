local mod = get_mod("rat_climb_teleport_fix")

-- Fix for rats skipping climb animations, which visually becomes a teleport (TP) and allows the rats to instantly attack players when they should finish climbing up ledges first.
-- This may also fix gutter runners from doing instant pounce after skipping climb animations. Note that instant pounce is a game design, but now with the fix they will have to wait until the end of the climb animations to do instant pounce.
-- This doesn't fix visual TP for clients due to lag or rat position desync.
-- 
-- fix for rats skipping landing animation
--
-- fix for rats skipping animation when jumping across gaps
-- 
-- Xq & VernonKun 2020

local clear_jump_climb_finished = function(blackboard)
	-- EchoConsole("jump_climb_finished set to nil")
	blackboard.jump_climb_finished = nil
	return
end

local clear_jump_start_finished = function(blackboard)
    -- EchoConsole("jump_start_finished set to nil")
    blackboard.jump_start_finished = nil
    return
end

local set_jump_climb_finished = function(blackboard)
	-- EchoConsole("jump_climb_finished set to true")
	blackboard.jump_climb_finished = true
	return
end

local JUMP_CLIMB_FINISHED_DELAY	= 0.3	-- seconds
local JUMP_CLIMB_FAILSAFE_TIME	= 4		-- seconds
local mod_climb_data = {}

mod:hook(BTClimbAction, "enter", function(func, self, unit, blackboard, t)
	local ret = func(self, unit, blackboard, t)
	
	--From testing: This fixes climb TP for single climb right after a fall; set the flag to nil if climb action hasn't start yet
	clear_jump_climb_finished(blackboard)
	
	mod_climb_data[unit] = nil
	
	return ret
end)

mod:hook(BTClimbAction , "run", function(func, self, unit, blackboard, t, dt)
	if not mod_climb_data[unit] then
		mod_climb_data[unit] =
		{
			climb_start_time	= nil,
			last_climb_state	= "",
			last_climb_state_1	= "",
		}
	end
	
	--From testing: This fixes climb TP for double climb; set the flag to nil if climb animation hasn't start yet
	if blackboard.climb_state ==  "moving_to_to_entrance" and blackboard.jump_climb_finished then
		clear_jump_climb_finished(blackboard)
	end

	--This marks the beginning of the climb animation (could be off by 1-2 frames)
	if blackboard.climb_state == "waiting_for_finished_climb_anim" and mod_climb_data[unit].last_climb_state_1 == "moving_to_to_entrance" then
		mod_climb_data[unit].climb_start_time = t
	end
	
	local climb_started		= mod_climb_data[unit].climb_start_time
	local climb_duration	= climb_started and t - climb_started
	
	--Fix for rat potentially getting stuck in the climb loop, but it doesn't happen in testing so far
	if climb_started and climb_duration > JUMP_CLIMB_FAILSAFE_TIME then
		-- EchoConsole("stuck in climb loop:" .. tostring(unit))	
		set_jump_climb_finished(blackboard)
	end

	--From testing: This fixes climb TP for triple climb (or more?); set the flag to nil if it set to true too early (i.e. within 0.3 second) because of previously unfinished climb animations
	if climb_started and blackboard.climb_state == "waiting_for_finished_climb_anim" and blackboard.jump_climb_finished then
		-- EchoConsole(climb_duration)
		if climb_duration < JUMP_CLIMB_FINISHED_DELAY then
			-- EchoConsole("bugged climb found")
			clear_jump_climb_finished(blackboard)
		else
			mod_climb_data[unit].climb_start_time = nil
		end
	end

	local ret = func(self, unit, blackboard, t, dt)
	
	mod_climb_data[unit].last_climb_state_1 = mod_climb_data[unit].last_climb_state
	mod_climb_data[unit].last_climb_state = blackboard.climb_state
	
	--Clear data for dead rats
	for loop_unit,_ in pairs(mod_climb_data) do
		if not Unit.alive(loop_unit) then
			mod_climb_data[loop_unit] = nil
		end
	end
	
	return ret
end)

mod:hook(BTFallAction, "enter", function(func, self, unit, blackboard, t)
    local ret = func(self, unit, blackboard, t)
    clear_jump_climb_finished(blackboard)
    return ret
end)

mod:hook(BTFallAction, "run", function(func, self, unit, blackboard, t, dt)
    if blackboard.climb_state ==  "waiting_to_collide_down" and blackboard.jump_climb_finished then
        clear_jump_climb_finished(blackboard)
    end
 
    local ret = func(self, unit, blackboard, t, dt)
    return ret
end)

mod:hook(BTJumpAcrossAction, "enter", function(func, self, unit, blackboard, t)
    local ret = func(self, unit, blackboard, t)
    
    clear_jump_start_finished(blackboard)
    
    return ret
end)

mod:hook(BTJumpAcrossAction, "run", function(func, self, unit, blackboard, t, dt)
    if blackboard.jump_state ==  "moving_towards_smartobject_entrance" and blackboard.jump_start_finished then
        clear_jump_start_finished(blackboard)
    end
    
    return func(self, unit, blackboard, t, dt)
end)