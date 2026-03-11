switch(knight_state){
    case KNIGHT_STATE.LURCH:
		lerp_towards_random_dir_target(1.5);
		speed = 0.5 + get_fluctuation(random_speed_factor) * 0.7
		image_angle = direction + get_fluctuation() * 45;
	break
	
	case KNIGHT_STATE.CHARGE:
		lerp_towards_random_dir_target(2);
		image_angle = direction;
		speed = 1;
	break;
	
	case KNIGHT_STATE.DEBUG:
		var _lr = keyboard_check(ord("D")) - keyboard_check(ord("A"));
		x += _lr * knight_debug_move_speed;
		
		var _ud = keyboard_check(ord("S")) - keyboard_check(ord("W"));
		y += _ud * knight_debug_move_speed;
	break;
}

flexpanel_node_style_set_width(obj_game_ui.fp_xp_fill_amount, frac(current_time / 10000) * 100, flexpanel_unit.percent);