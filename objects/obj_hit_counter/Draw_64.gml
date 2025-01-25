if(instance_exists(obj_knight)){
	hit_count = obj_knight.hit_count;
}

draw_set_color(c_black);
draw_text(10, 10, "bonk counter: " + string(hit_count));

draw_set_color(c_white);