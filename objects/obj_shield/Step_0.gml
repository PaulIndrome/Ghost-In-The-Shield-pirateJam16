if(instance_exists(obj_knight) == false) exit;
if(obj_knight.knight_state == KNIGHT_STATE.DEAD) exit;

var _mouse_x = mouse_x;
var _mouse_y = mouse_y;
var _knight_x = obj_knight.x;
var _knight_y = obj_knight.y;
var _dir = point_direction(_knight_x, _knight_y, _mouse_x, _mouse_y);
var _len = min(point_distance(_knight_x, _knight_y, _mouse_x, _mouse_y), shield_position_offset);

x = _knight_x + lengthdir_x(_len, _dir);
y = _knight_y + lengthdir_y(_len, _dir);

image_angle = _dir;
direction = _dir;