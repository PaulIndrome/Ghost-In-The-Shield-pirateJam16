current_flood = -1;
next_spawn_time = -1;
remaining_check_step_interval = 180;

flood_count = 0;

threshold_minimum_enemies = 5;

///@param {Struct.EnemyFlood} _flood
function start_flood(_flood) {
	flood_count++;
	
	current_flood = _flood;
	current_flood.reset();
	next_spawn_time = current_flood.next_spawn_time();
}

function stop_spawn(){
	next_spawn_time = -1;
}