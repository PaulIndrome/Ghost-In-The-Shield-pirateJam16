switch(enemy_state){
	case ENEMY_STATE.ATTACK:
		instance_destroy(obj_knight);
		image_speed = 0;
		break;
	default:
		exit;
}