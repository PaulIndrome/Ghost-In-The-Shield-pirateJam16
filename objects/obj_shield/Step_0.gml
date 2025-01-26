if(instance_exists(obj_knight) == false) exit;
if(obj_knight.knight_state == KNIGHT_STATE.DEAD) exit;

var _charging = obj_knight.knight_state == KNIGHT_STATE.CHARGE;

var _mouse_x = mouse_x;
var _mouse_y = mouse_y;
var _knight_x = obj_knight.x;
var _knight_y = obj_knight.y;
var _dir = point_direction(_knight_x, _knight_y, _mouse_x, _mouse_y);
var _dis = point_distance(_knight_x, _knight_y, _mouse_x, _mouse_y);
var _len = min(_dis, shield_position_offset * (_charging ? 2 : 1));

dist_factor = animcurve_channel_evaluate(shield_distance_curve, clamp(_dis / (max_cursor_distance * (_charging ? 2 : 1)), 0, 1));
var _lerp_speed = DELTA_TIME_S * dist_factor * lerp_speed;
_lerp_speed *= _charging ? 2 : 1;

x = lerp(x, _knight_x + lengthdir_x(_len, _dir), _lerp_speed);
y = lerp(y, _knight_y + lengthdir_y(_len, _dir), _lerp_speed);

image_angle -= angle_difference(image_angle, _dir) * _lerp_speed * 2;
direction = _dir;