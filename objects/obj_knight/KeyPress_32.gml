var _random_dir = random(360);
var _x_offset = lengthdir_x(400, _random_dir);
var _y_offset = lengthdir_y(400, _random_dir);

instance_create_layer(mid_x + _x_offset, mid_y + _y_offset, "Instances", obj_projectile);