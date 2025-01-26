if(is_instanceof(current_flood, EnemyFlood) == false) exit;

var _time = get_timer_s();
if(_time >= next_spawn_time){
    while(next_spawn_time > 0 && _time >= next_spawn_time){
	    next_spawn_time = current_flood.spawn();
	}
}

if(instance_number(obj_enemy_base) < 1 && next_spawn_time < 0){
	start_flood(current_flood);
}