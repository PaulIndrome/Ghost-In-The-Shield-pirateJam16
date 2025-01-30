played_death_grunt = false;

var _ef_reverb = audio_effect_create(AudioEffectType.Reverb1);
_ef_reverb.size = 0.4;
_ef_reverb.mix = 0.2;
audio_bus_main.effects[0] = _ef_reverb;

audio_music_bus = audio_bus_create();
audio_music_emitter = audio_emitter_create();
audio_emitter_bus(audio_music_emitter, audio_music_bus);

audio_sound_loop_start(music_game, 21.7);
audio_sound_loop_end(music_game, 78.8);

music_index = undefined;

function start_music(){
	if(music_index == undefined || audio_is_playing(music_index) == false){
		music_index = audio_play_sound_on(audio_music_emitter, music_game, true, 1, 0.5);
		audio_sound_loop(music_index, true);
	}
}