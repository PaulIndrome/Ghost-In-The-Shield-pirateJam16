/// @description check any enemies remaining?
if(instance_number(obj_enemy_base) < 1) {
     event_perform(ev_other, ev_room_start);
}

alarm_set(11, remaining_check_step_interval);