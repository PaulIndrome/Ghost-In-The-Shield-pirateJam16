/// @description reset to lurch

if(knight_state == KNIGHT_STATE.DEAD) exit;

var _hits_remaining = charge_required_hits - (hit_count % charge_required_hits);
var _num_enemies_remaining = instance_number(obj_enemy_base);
if(knight_state == KNIGHT_STATE.CHARGE && (_num_enemies_remaining < _hits_remaining / 4 || _num_enemies_remaining < charge_end_enemy_num_min) && obj_enemy_spawner.flood_count > 5) {
	//show_debug_message($"Post charge flood start");
	with (obj_enemy_spawner) {
		// Feather ignore once GM2016
		start_flood(current_flood);
	}
}

knight_state = KNIGHT_STATE.LURCH;
obj_shield.image_blend = c_white;
alarm_set(1, knight_drunk_effect_next() );