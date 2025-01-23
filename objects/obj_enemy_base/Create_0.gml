speed = random_range(move_speed_base_min, move_speed_base_max);
evade_bias = choose(-1, 1);
enemy_state = ENEMY_STATE.WALK;

dir_off_blocked = 0;
dir_off_blocked_len = 0;

shove_duration_frames = 0;
shove_progress = 0;
shove_speed_channel = animcurve_get_channel(ac_shove_speed, "speed");
shove_arc_height = 32;
shove_arc_height_channel = animcurve_get_channel(ac_shove_arc_height, "y-offset");
shove_start_x = 0;
shove_start_y = 0;
shove_end_x = 0;
shove_end_y = 0;

dir_sprite_mod = function() { return sprite_get_number(sprite_index) / 4; }
dir_sprite_offset = function() { 
	var _quadrant = (direction + 315) % 360; // + 315 is equivalent to -45 but modulo-able
	
	var _offset_idx = DIR_OFFSET_INDEX.RIGHT
	
	if(_quadrant <= 90) _offset_idx = DIR_OFFSET_INDEX.UP
	else if(_quadrant <= 180) _offset_idx = DIR_OFFSET_INDEX.LEFT;
	else if(_quadrant <= 270) _offset_idx =  DIR_OFFSET_INDEX.DOWN;
	
	return _offset_idx;
}