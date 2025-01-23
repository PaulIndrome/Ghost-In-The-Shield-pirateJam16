if(obj_knight.knight_state == KNIGHT_STATE.CHARGE){
    instance_destroy(other);
} else {
    switch(other.enemy_state){
    case ENEMY_STATE.WALK:
    case ENEMY_STATE.IDLE:
		break;
	default:	
		exit;
	}

	var _dir = point_direction(obj_knight.x, obj_knight.y, other.x, other.y);
	with(other){
		enemy_shove(128, _dir, 2);
	}
}

with(obj_enemy_spawner){
	bonk_counter++;
	
	if(bonk_counter % 20 == 0){
		with(obj_knight){
		    knight_precharge();
		}
	}
}


