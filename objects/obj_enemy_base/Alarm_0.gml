/// @description reset to walk

call_later(1, time_source_units_seconds, method(id, function(){
	if(enemy_state == ENEMY_STATE.SLOWED || obj_knight.knight_state == KNIGHT_STATE.DEAD) exit;
	enemy_state = ENEMY_STATE.WALK;
	enemy_reset_speed();
}));