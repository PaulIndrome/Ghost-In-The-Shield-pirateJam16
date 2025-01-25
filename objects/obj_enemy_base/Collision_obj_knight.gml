switch (enemy_state) {
	case ENEMY_STATE.WALK:
	case ENEMY_STATE.IDLE:
	case ENEMY_STATE.SLOWED:
		enemy_state = ENEMY_STATE.ATTACK;
		enemy_attack(other.knight_state != KNIGHT_STATE.DEAD);
		break;
	default:
		break;
}