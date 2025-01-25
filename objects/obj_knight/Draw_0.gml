draw_self();

var _x2 = lengthdir_x(30, random_dir_target);
var _y2 = lengthdir_y(30, random_dir_target);

//draw_set_color(c_aqua);
//draw_arrow(x, y, x + _x2, y + _y2, 10);



//draw_set_color(c_black);

////draw_text(x, y, string(num));

//draw_circle(room_mid_x(), room_mid_y(), direction_correction_radius, true);

draw_set_color(c_white);

if(knight_state == KNIGHT_STATE.CHARGE){
	var _charge_remaining_f = alarm_get(0);
	
	if(_charge_remaining_f > 0) {
	    var _progress = _charge_remaining_f / (charge_duration_s * game_get_speed(gamespeed_fps));
		draw_set_alpha(0.5);
		draw_healthbar(x - 10, y + 20, x + 10, y + 22, _progress * 100, c_dkgray, c_white, c_red, 0, true, false);
		draw_set_alpha(1);
	}
}