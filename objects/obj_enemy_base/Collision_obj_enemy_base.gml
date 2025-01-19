//Collision event of enemy parent with enemy parent
// code taken from: https://forum.gamemaker.io/index.php?threads/prevent-enemy-overlap.106604/post-642419
var dir = direction;
var len = 1;

if(blocked){
    exit;
} else if(other.blocked) {
    var _dir_other = other.direction;
	var _dir_to_other = point_direction(x, y, other.x, other.y);
	var _diff = angle_difference(_dir_other, _dir_to_other);
	
	dir = _dir_other - sign(_diff) * 90;
	len = lerp(8, 0, point_distance(x,y,other.x,other.y) / max(abs(sprite_width), abs(sprite_height)));
} else {
    dir = point_direction(x, y, other.x, other.y);
	len = lerp(1, 0, point_distance(x,y,other.x,other.y) / max(abs(sprite_width), abs(sprite_height)));
	
	other.x += lengthdir_x(len,dir);
	other.y += lengthdir_y(len,dir);
}

x += lengthdir_x(len, dir + 160 + (random(20) * evade_bias) );
y += lengthdir_y(len, dir + 160 + (random(20) * evade_bias) );
