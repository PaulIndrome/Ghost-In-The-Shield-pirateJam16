#macro BROADCAST_MESSAGE event_data[? "message"]
#macro BROADCAST_ID event_data[? "element_id"]
#macro BROADCAST_TYPE event_data[? "event_type"]
#macro BROADCAST_ID_MATCH (layer_instance_get_instance(event_data[? "element_id"]) == id)
