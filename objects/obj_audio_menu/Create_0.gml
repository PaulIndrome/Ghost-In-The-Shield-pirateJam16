music_index = undefined;

function start_music(){
	if(music_index == undefined || audio_is_playing(music_index) == false){
		music_index = audio_play_sound(music_menu, 1, true, 0.5);
		audio_sound_loop(music_index, true);
	}
}