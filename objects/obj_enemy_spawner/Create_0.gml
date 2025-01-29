current_flood = -1;
next_spawn_time = -1;
remaining_check_step_interval = 180;

flood_count = 0;
wave_count = 0;

threshold_minimum_enemies = 5;

extra_spawn_count = 0;
alarm_set(0, 10 * GAMESPEED_FPS);

///@param {Struct.EnemyFlood} _flood
function start_flood(_flood) {
	flood_count++;
	
	current_flood = _flood;
	current_flood.reset();
	
	if(flood_count > 1){
		current_flood.add_enemy(obj_demon_blue, 1, 0, 0.25);
		
		if(flood_count % 3 == 0){
			current_flood.add_enemy(obj_demon_red, 1, 0, 0.25);
		}
	}
	
	next_spawn_time = current_flood.next_spawn_time();
}

function stop_spawn(){
	next_spawn_time = -1;
}