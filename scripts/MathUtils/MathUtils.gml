function sin_between(_min, _max, _t)
{
	return ((_max - _min) * sin(_t) + _max + _min) / 2;
}

enum QUADRANT {
	RIGHT = 0, 
	TOP = 1, 
	LEFT = 2, 
	BOTTOM = 3, 
}

function direction_quadrant(_dir = direction, _angle_offset = 45){
	_dir += _angle_offset < 0 ? _angle_offset + 360 : _angle_offset;
	_dir %= 360;
	
	var _quadrant = floor(_dir / 90) % 4;
	
	switch(_quadrant){
		case 0:
			return QUADRANT.RIGHT;
		case 1:
			return QUADRANT.TOP;
		case 2:
			return QUADRANT.LEFT;
		case 3:
			return QUADRANT.BOTTOM;
		default:
			return QUADRANT.BOTTOM;
	}
}