/// @description extra spawn

extra_spawn_count++;

spawn_enemy(extra_spawn_count % 5 == 0 ? obj_demon_red : obj_demon_blue);

var _next_spawn = max(1, (10 - (wave_count * 0.1)) * GAMESPEED_FPS);
alarm_set(0, _next_spawn);
