shield_position_offset = 24;
lerp_speed = 16;
max_cursor_distance = 64;
shield_distance_curve = animcurve_get_channel(ac_shield_distance_curve, 0);

dist_factor = 0;

ps_layer = layer_create(-600, "shield_effects");
part_sys = part_system_create_layer(ps_layer, false);

window_set_cursor(cr_none);

///@self obj_shield
function part_shield_play(_ps_asset, _x, _y, _dir){
	part_system_position(part_sys, _x,  _y);
	part_system_angle(part_sys, _dir);
	part_particles_burst(part_sys, 0, 0, _ps_asset);
}