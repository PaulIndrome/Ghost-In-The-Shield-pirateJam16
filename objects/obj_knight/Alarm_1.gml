/// @description play drunk effect

// SOUNDTODO hicc


// PARTICLETODO hicc

if(knight_state == KNIGHT_STATE.LURCH){
	audio_play_sound(
		choose(comedy_burp_03, comedy_burp_04), 
		1, // prio
		false, // loop
		0.8, // gain
		0, // offset
		random_range(0.8, 1.1) // pitch
	);
	
	part_system_position(ps_hiccuping, x, y);
	part_emitter_burst(ps_hiccuping, ps_emit_hiccup_1, ps_type_hiccup_a, 5);
	part_emitter_burst(ps_hiccuping, ps_emit_hiccup_2, ps_type_hiccup_b, 2);
	part_emitter_burst(ps_hiccuping, ps_emit_hiccup_3, ps_type_hiccup_c, 1);

	alarm_set(1, knight_drunk_effect_next() );
}