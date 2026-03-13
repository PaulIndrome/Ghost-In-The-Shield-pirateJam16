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
shove_count = 0;

xp_on_kill = 10;

last_quadrant = direction_quadrant();

kill_pos_x = -1;
kill_pos_y = -1;

kill_knight_coyote_timer = undefined;
kill_knight = function(){
	if(instance_exists(obj_knight) == false) exit;
		
	switch(enemy_state){
		case ENEMY_STATE.BUMPED:
		case ENEMY_STATE.DYING:
		case ENEMY_STATE.DEAD:
		case ENEMY_STATE.SHOVED:
			exit;
	}
	
	enemy_state = ENEMY_STATE.ATTACK;
	enemy_attack(obj_knight.knight_state != KNIGHT_STATE.DEAD);	
};

sprite_update = function(){
	sprite_index = global.sprite_sets[? object_index][@ enemy_state][last_quadrant];
}

quadrant_update = function(){
	var _quadrant = direction_quadrant();
	
	if(_quadrant == last_quadrant) exit;
	
	last_quadrant = _quadrant;
	
	sprite_update();
}

sprite_update();
enemy_reset_speed();