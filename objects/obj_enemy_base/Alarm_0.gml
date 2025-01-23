/// @description reset to walk
call_later(1, time_source_units_seconds, method(id, function(){
	enemy_state = ENEMY_STATE.WALK;
	speed = random_range(move_speed_base_min, move_speed_base_max);
}));
