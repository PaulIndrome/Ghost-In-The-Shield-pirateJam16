switch (enemy_state) {
	case ENEMY_STATE.WALK:
	case ENEMY_STATE.IDLE:
	case ENEMY_STATE.SLOWED:
		if(time_source_exists(kill_knight_coyote_timer) && time_source_get_state(kill_knight_coyote_timer) == time_source_state_active) exit;
			
		kill_knight_coyote_timer = call_later(10, time_source_units_frames, method(id, kill_knight));
		
		enemy_state = ENEMY_STATE.IDLE;
		kill_pos_x = x;
		kill_pos_y = y;
		break;
	default:
		break;
}