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
	
	part_knight_play(ps_hiccups, x, y);

	alarm_set(1, knight_drunk_effect_next() );
}