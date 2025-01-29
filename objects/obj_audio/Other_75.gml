var _is_audio_status_event = async_load[? "event_type"] == "audio_system_status";
var _is_available = async_load[? "status"] == "available";
if(_is_audio_status_event && _is_available){
	start_music();
}