/// @description check any enemies remaining?

if(instance_number(obj_enemy_base) < 2 && is_instanceof(current_flood, EnemyFlood) && next_spawn_time < 0) {
	show_debug_message($"enemies remaining check starting flood");
	start_flood(current_flood);
}

alarm_set(11, remaining_check_step_interval);