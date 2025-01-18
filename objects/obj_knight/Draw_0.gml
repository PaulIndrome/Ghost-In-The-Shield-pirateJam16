draw_self();

var _x2 = lengthdir_x(30, random_dir_target);
var _y2 = lengthdir_y(30, random_dir_target);

draw_set_color(c_aqua);
//draw_arrow(x, y, x + _x2, y + _y2, 10);



draw_set_color(c_black);

draw_text(x, y, string(num));

draw_circle(mid_x, mid_y, direction_correction_radius, true);

draw_set_color(c_white);