var _dir = point_direction(knight_object.x, knight_object.y, mouse_x, mouse_y);

x = knight_object.x + lengthdir_x(shield_position_offset, _dir);
y = knight_object.y + lengthdir_y(shield_position_offset, _dir);

image_angle = _dir;