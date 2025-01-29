///@self obj_knight
function knight_precharge(){
	//if(knight_state == KNIGHT_STATE.CHARGE) exit;
	if(knight_state == KNIGHT_STATE.PRECHARGE) exit;
	
	// SOUNDTODO
	sfx_play_simple([voice_male_d_battle_shout_01, voice_male_d_battle_shout_04, voice_male_d_battle_shout_07]);
	
	knight_state = KNIGHT_STATE.PRECHARGE;
	
	speed = 0;
	
    var _x = x;
	var _y = y;
	with(obj_enemy_base){
		var _dist = point_distance(_x, _y, x, y);
		var _factor = 1 - clamp(_dist / 100, 0, 1);
		if(_factor <= 0.01) continue;
	
		var _shove_dist = _factor * 200;
		var _dir = point_direction(_x, _y, x, y);
	
		enemy_shove(_shove_dist, _dir, 2.5);
	}

	call_later(1, time_source_units_seconds, method(id, function(){
		obj_shield.image_blend = c_orange;
		knight_state = KNIGHT_STATE.CHARGE; 
		alarm_set(1, -1);
		alarm_set(0, charge_duration_s * game_get_speed(gamespeed_fps));
	}));
	
	part_particles_burst(ps_layer, x, y, ps_knight_precharge);
}