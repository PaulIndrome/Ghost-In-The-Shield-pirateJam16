if(obj_knight.knight_state == KNIGHT_STATE.CHARGE){
    instance_destroy(other);
	
	sfx_play_simple([retro_damage_hurt_ouch_34, retro_damage_hurt_ouch_37, retro_damage_hurt_ouch_48]);
	sfx_play_simple([retro_impact_hit_19, retro_impact_hit_24, retro_impact_hit_27]);
	
	var _dir = point_direction(obj_knight.x, obj_knight.y, other.x, other.y);
	part_system_color(part_sys, other.image_blend, 1);
	part_bonk_play(ps_kill, x, y, _dir);
	
	with(obj_knight){
		kill_count++;
	}
	
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
		// Feather ignore once GM2016
		enemy_shove(160, _dir, 1.5);
	}
	
	part_system_color(part_sys, other.image_blend, 1);
	part_bonk_play(ps_bonk, x, y, _dir);
	
	obj_screen_shake.screen_shake_add(0.05);
	
	with(obj_knight){
		hit_count++;
	
		if(hit_count % charge_required_hits == 0){
			// Feather ignore once GM2016
			knight_precharge();
		}
	}
}




