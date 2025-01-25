knight_state = KNIGHT_STATE.LURCH;
knight_debug_move_speed = 2;

charge_duration_s = 10;
charge_required_hits = 20;
charge_end_enemy_num_min = 5;
hit_count = 0;

random_dir_target = 0;
random_dir_change_interval = 1;

random_dir_time_source = -1;

random_speed_factor = 1;
random_speed_factor_change_interval = 1.5;
random_speed_fluctuate_time_source = -1;

direction_correction_radius = 200;

knight_effect_layer = layer_create(-500, "knight_effects");
ps_layer = part_system_create_layer(knight_effect_layer, false);

randomise();

function random_dir_choose() {
	var _dir_center = point_direction(x, y, room_mid_x(), room_mid_y());
	var _interval_factor = random_range(0.5, 1.5);
	
	switch(knight_state){
		case KNIGHT_STATE.LURCH:
			var _random = random_range(33, 90);
			var _sign = choose(-1, 1);
			random_dir_target = _dir_center + (_sign * _random); // turn 180 degrees +- between 45 and 90 degrees
			break;
		
		case KNIGHT_STATE.CHARGE:
			if(instance_exists(obj_enemy_base)){
			    var _nearest = instance_nearest(room_mid_x(), room_mid_y(), obj_enemy_base);
				var _dir_nearest_enemy = point_direction(x, y, _nearest.x, _nearest.y);
				random_dir_target =_dir_nearest_enemy;
			} else {
			    random_dir_target = _dir_center;
			}
			
			_interval_factor = 0.5;
			break;
			
		default:
			break;
		
	}

	time_source_reconfigure(random_dir_time_source, random_dir_change_interval * _interval_factor, time_source_units_seconds, method(self, random_dir_choose), [], -1);
	time_source_start(random_dir_time_source);
}


function random_speed_factor_choose(){
    random_speed_factor = random_range(1, 3);
	
	time_source_reconfigure(random_speed_fluctuate_time_source, random_speed_factor_change_interval * random_range(0.9, 2), time_source_units_seconds, method(self, random_speed_factor_choose), [], -1);
	time_source_start(random_speed_fluctuate_time_source);
}

function lerp_towards_random_dir_target(_turn_rate){
	var _angle_dif = angle_difference(direction, random_dir_target);
    direction = direction - _angle_dif * (delta_time / 1000000) * _turn_rate * (2 + get_fluctuation()) * (point_distance(x, y, room_mid_x(), room_mid_y()) / 128);
}

function get_fluctuation(_fluct_speed = 1){
    //return (sin(get_timer_s() * _fluct_speed) + 1) / 2;
	var _fluct = sin_between(-1, 1, get_timer_s() * _fluct_speed);
    return _fluct;
}
