if(obj_knight.knight_state == KNIGHT_STATE.CHARGE){
    instance_destroy(other);
} else {
    switch(other.enemy_state){
    case ENEMY_STATE.WALK:
    case ENEMY_STATE.IDLE:
		break;
	case ENEMY_STATE.BUMPED:
	case ENEMY_STATE.SHOVED:
		if(other.shove_progress < 0.5) exit;
		break;
		
	default:	
		exit;
	}

	var _dir = point_direction(obj_knight.x, obj_knight.y, other.x, other.y);
	with(other){
		enemy_shove(160, _dir, 1.5);
	}
	
	obj_screen_shake.screen_shake_add(0.05);
}

with(obj_knight){
	hit_count++;
	
	if(hit_count % charge_required_hits == 0){
		knight_precharge();
	}
}


