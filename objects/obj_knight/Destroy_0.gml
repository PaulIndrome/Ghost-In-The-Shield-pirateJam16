with(obj_shield){
    instance_destroy();
}

time_source_destroy(random_dir_time_source);
time_source_destroy(random_speed_fluctuate_time_source);

call_later(4, time_source_units_seconds, room_restart);