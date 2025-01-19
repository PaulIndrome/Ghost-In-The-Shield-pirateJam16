if(other.blocked) exit;

var _dir = point_direction(obj_knight.x, obj_knight.y, other.x, other.y);

with(other){
    blocked = true;
	alarm[0] = 60;
	direction = _dir;
	speed = 2;
}

obj_enemy_spawner.bonk_counter++;