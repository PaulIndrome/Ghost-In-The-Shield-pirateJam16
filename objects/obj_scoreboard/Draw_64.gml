if(instance_exists(obj_knight)){
	hit_count = obj_knight.hit_count;
	kill_count = obj_knight.kill_count;
}

if(instance_exists(obj_enemy_spawner)){
	flood_count = obj_enemy_spawner.flood_count;
	wave_count = obj_enemy_spawner.wave_count;
}

draw_set_font(fnt_harrington);

draw_set_color(c_black);
draw_text(30, 30, "bonk counter: " + string(hit_count));
draw_text(30, 50, "kill counter: " + string(kill_count));
draw_text(30, 70, "flood: " + string(flood_count));
draw_text(30, 90, "wave: " + string(wave_count));

draw_set_color(c_white);
draw_text(30, 30, "bonk counter: " + string(hit_count));
draw_text(30, 50, "kill counter: " + string(kill_count));
draw_text(30, 70, "flood: " + string(flood_count));
draw_text(30, 90, "wave: " + string(wave_count));

draw_set_font(-1);