random_dir_time_source = time_source_create(time_source_game, random_dir_change_interval, time_source_units_seconds, method(id, random_dir_choose), [], -1);
random_speed_fluctuate_time_source = time_source_create(time_source_game, random_speed_factor_change_interval, time_source_units_seconds, method(id, random_speed_factor_choose), [], -1);

time_source_start(random_dir_time_source);
time_source_start(random_speed_fluctuate_time_source);