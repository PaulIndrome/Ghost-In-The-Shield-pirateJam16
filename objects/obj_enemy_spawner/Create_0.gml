current_flood = -1;
next_spawn_time = -1;
remaining_check_step_interval = 180;
bonk_counter = 0;

///@param {Asset.GMObject} _obj
function spawn_enemy(_obj){
	var _random_dir = random(360);
	var _x_offset = lengthdir_x(room_width, _random_dir);
	var _y_offset = lengthdir_y(room_height, _random_dir);

	instance_create_layer(room_mid_x() + _x_offset, room_mid_y() + _y_offset, "Instances", _obj);
}