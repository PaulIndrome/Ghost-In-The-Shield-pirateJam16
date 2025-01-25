depth = -bbox_bottom;

switch (enemy_state) {
	case ENEMY_STATE.WALK:
		if(instance_exists(obj_knight) == false) exit;
		direction = point_direction(x, y, obj_knight.x, obj_knight.y);
		quadrant_update();
		break;
		
	case ENEMY_STATE.SHOVED:
	case ENEMY_STATE.BUMPED:
		shove_progress = 1 - alarm_get(0) / shove_duration_frames;
		var _speed = animcurve_channel_evaluate(shove_speed_channel, shove_progress);
		
		x = lerp(shove_start_x, shove_end_x, _speed);
		y = lerp(shove_start_y, shove_end_y, _speed);
		y -= shove_arc_height * animcurve_channel_evaluate(shove_arc_height_channel, shove_progress);
		
		quadrant_update();
        break;
		
    default:
        // code here
        break;
}

