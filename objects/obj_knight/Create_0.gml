randomise();

knight_state = KNIGHT_STATE.LURCH;
knight_debug_move_speed = 2;

charge_duration_s = 10;
charge_required_hits = 20;
charge_end_enemy_num_min = 5;
hit_count = 0;
kill_count = 0;

random_dir_target = 0;
random_dir_change_interval = 1;

random_dir_time_source = -1;

random_speed_factor = 1;
random_speed_factor_change_interval = 1.5;
random_speed_fluctuate_time_source = -1;

direction_correction_radius = 200;

//ps_layer = layer_create(-500, "knight_effects");
//part_sys_hiccups = part_system_create_layer(ps_layer, false, ps_hiccups_2);
//ps_precharge = create_precharge_ps();

knight_drunk_effect_interval_min = 4;
knight_drunk_effect_interval_max = 8;
knight_drunk_effect_next = function() { return random_range(knight_drunk_effect_interval_min, knight_drunk_effect_interval_max) * GAMESPEED_FPS; }
alarm_set(1, knight_drunk_effect_next() );

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
	
///@self obj_knight
function part_knight_play(_ps, x, y){
	part_particles_burst(part_sys, 0, 0, _ps);
}

function create_precharge_ps(){
	//ps_knight_precharge
	var _ps = part_system_create();
	part_system_draw_order(_ps, true);

	//sub
	var _ptype1 = part_type_create();
	part_type_shape(_ptype1, pt_shape_spark);
	part_type_size(_ptype1, 0.1, 0.25, 0, 0);
	part_type_scale(_ptype1, 1, 1);
	part_type_speed(_ptype1, 0.5, 1, 0, 0);
	part_type_direction(_ptype1, 0, 360, 0, 0);
	part_type_gravity(_ptype1, 0, 270);
	part_type_orientation(_ptype1, 0, 360, 0, 0, true);
	part_type_colour3(_ptype1, $FFFFFF, $FFFFFF, $FFFFFF);
	part_type_alpha3(_ptype1, 1, 1, 1);
	part_type_blend(_ptype1, false);
	part_type_life(_ptype1, 20, 80);
	
	ps_type_precharge_a = _ptype1;

	var _pemit1 = part_emitter_create(_ps);
	part_emitter_region(_ps, _pemit1, 0, 0, 0, 0, ps_shape_ellipse, ps_distr_invgaussian);
	part_emitter_burst(_ps, _pemit1, _ptype1, 64);
	part_emitter_delay(_ps, _pemit1, 0.1, 0.2, time_source_units_seconds)

	//Emitter
	var _ptype2 = part_type_create();
	part_type_shape(_ptype2, pt_shape_cloud);
	part_type_size(_ptype2, 0.5, 1, 0, 0);
	part_type_scale(_ptype2, 1, 1);
	part_type_speed(_ptype2, 3, 6, 0, 0);
	part_type_direction(_ptype2, 0, 360, 0, 0);
	part_type_gravity(_ptype2, 0, 270);
	part_type_orientation(_ptype2, 0, 360, 0, 0, true);
	part_type_colour3(_ptype2, $123960, $304860, $477CB2);
	part_type_alpha3(_ptype2, 1, 1, 1);
	part_type_blend(_ptype2, false);
	part_type_life(_ptype2, 10, 40);
	
	ps_type_precharge_b = _ptype2;

	var _pemit2 = part_emitter_create(_ps);
	part_emitter_region(_ps, _pemit2, 0, 0, 0, 0, ps_shape_ellipse, ps_distr_invgaussian);
	part_emitter_burst(_ps, _pemit2, _ptype2, 96);

	part_system_position(_ps, room_width/2, room_height/2);
	
	return _ps;
}
