//Collision event of enemy parent with enemy parent
// code taken from: https://forum.gamemaker.io/index.php?threads/prevent-enemy-overlap.106604/post-642419

switch(enemy_state){
	case ENEMY_STATE.SHOVED:
	case ENEMY_STATE.BUMPED:
	case ENEMY_STATE.ATTACK:
		exit;
}

switch(other.enemy_state){
	case ENEMY_STATE.BUMPED:
	case ENEMY_STATE.ATTACK:
		exit;
	case ENEMY_STATE.SHOVED:
		var _dir_other = other.direction;
		var _dir_to_other = point_direction(x, y, other.x, other.y);
		var _diff = angle_difference(_dir_other, _dir_to_other);
		
		var _dir  = _dir_other - sign(_diff) * random_range(30, 60);
		var _bump_str = (1 - other.shove_progress) * 48;
		var _bump_height = (1 - other.shove_progress) * 36;
		
		enemy_shove(_bump_str, _dir, 0.5, ENEMY_STATE.BUMPED, _bump_height);
		exit;
}

var _dir = point_direction(x, y, other.x, other.y);
var _len = lerp(1, 0, point_distance(x, y, other.x, other.y) / max(abs(sprite_width), abs(sprite_height)));

x += lengthdir_x(_len, _dir + 180 + (random(10) * evade_bias) );
y += lengthdir_y(_len, _dir + 180 + (random(10) * evade_bias) );

other.x += lengthdir_x(_len, _dir + (random(10) * other.evade_bias) );
other.y += lengthdir_y(_len, _dir + (random(10) * other.evade_bias) );