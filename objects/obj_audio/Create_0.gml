var _ef_reverb = audio_effect_create(AudioEffectType.Reverb1);
_ef_reverb.size = 0.4;
_ef_reverb.mix = 0.2;
audio_bus_main.effects[0] = _ef_reverb;

audio_sound_loop_start(music_8bit_jammer, 0.5);
audio_sound_loop_end(music_8bit_jammer, 111.605);

music_index = undefined;

function start_music(){
	if(music_index == undefined || audio_is_playing(music_index) == false){
		music_index = audio_play_sound(music_8bit_jammer, 1, true, 0.5);
		audio_sound_loop(music_index, true);
	}
}