if(BROADCAST_TYPE == "sprite event" && BROADCAST_MESSAGE == "hit" && BROADCAST_ID_MATCH){
	if(obj_audio.played_death_grunt == false){
		obj_audio.played_death_grunt = true;
		call_later(0.5, time_source_units_seconds, function(){ 
			sfx_play_simple([voice_male_grunt_pain_death_01, voice_male_grunt_pain_death_02, voice_male_grunt_pain_death_03, voice_male_grunt_pain_death_04], 
			0.3,
			-0.2); 
		});
	}
	
	sfx_play_simple([bone_break_neck_snap_crack_01, bone_break_neck_snap_crack_02, bone_break_neck_snap_crack_03, bone_break_neck_snap_crack_04], 0.4, -0.2);
	sfx_play_simple(Impact_Flesh_1, 0.5);
}