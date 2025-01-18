random_dir_target = 0;
random_dir_lerp_speed = 2;
random_dir_change_interval = 1;

random_dir_time_source = time_source_create(time_source_game, random_dir_change_interval, time_source_units_seconds, method(self, random_dir_choose), [], -1);

random_speed_factor = 1;
random_speed_factor_change_interval = 1.5;
random_speed_fluctuate_time_source = time_source_create(time_source_game, random_speed_factor_change_interval, time_source_units_seconds, method(self, random_speed_factor_choose), [], -1);

mid_x = room_width / 2;
mid_y = room_height / 2;

direction_correction_radius = 200;

randomise();

function random_dir_choose(){

	var _random = random_range(33, 90);
	var _new_dir = point_direction(x, y, mid_x, mid_y);
	var _sign = choose(-1, 1);
	
    random_dir_target = _new_dir + (_sign * _random); // turn 180 degrees +- between 45 and 90 degrees
	
	time_source_reconfigure(random_dir_time_source, random_dir_change_interval * random_range(0.5, 1.5), time_source_units_seconds, method(self, random_dir_choose), [], -1);
	time_source_start(random_dir_time_source);
}


function random_speed_factor_choose(){
    random_speed_factor = random_range(1, 3);
	
	time_source_reconfigure(random_speed_fluctuate_time_source, random_speed_factor_change_interval * random_range(0.9, 2), time_source_units_seconds, method(self, random_speed_factor_choose), [], -1);
	time_source_start(random_speed_fluctuate_time_source);
}

function lerp_towards_random_dir_target(){
	var _angle_dif = angle_difference(direction, random_dir_target);
    //direction = lerp(direction, direction + _angle_dif, random_dir_lerp_speed * (delta_time / 1000000));
    direction = direction - _angle_dif * (delta_time / 1000000) * (2 + get_fluctuation()) * (point_distance(x, y, mid_x, mid_y) / 128);
}

function get_fluctuation(_fluct_speed = 1){
    //return (sin(get_timer_s() * _fluct_speed) + 1) / 2;
	var _fluct = sin_between(-1, 1, get_timer_s() * _fluct_speed);
    return _fluct;
}

time_source_start(random_dir_time_source);
time_source_start(random_speed_fluctuate_time_source);