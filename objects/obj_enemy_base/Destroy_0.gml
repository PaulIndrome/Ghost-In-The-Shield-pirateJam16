with(obj_enemy_spawner){
    if(is_instanceof(current_flood, EnemyFlood) == false) exit;
	
	current_flood.remaining--;
	//show_debug_message($"remaining: {current_flood.remaining}");
}