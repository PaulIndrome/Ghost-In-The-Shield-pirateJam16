speed = random_range(move_speed_base_min, move_speed_base_max);
evade_bias = choose(-1, 1);
blocked = false;

dir_sprite_mod = function() { return sprite_get_number(sprite_index) / 4; }
dir_sprite_offset = function() { 
	var _quadrant = (direction + 315) % 360; // + 315 is equivalent to -45 but modulo-able
	
	var _offset_idx = DIR_OFFSET_INDEX.RIGHT
	
	if(_quadrant <= 90) _offset_idx = DIR_OFFSET_INDEX.UP
	else if(_quadrant <= 180) _offset_idx = DIR_OFFSET_INDEX.LEFT;
	else if(_quadrant <= 270) _offset_idx =  DIR_OFFSET_INDEX.DOWN;
	
	return _offset_idx;
}