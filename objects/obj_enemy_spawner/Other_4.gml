floods_regenerate();

start_flood(global.floods[0]);

if(alarm_get(11) < 0) alarm_set(11, remaining_check_step_interval);