function log() {
	var out = "";
	for(var i = 0; i < argument_count; i++){
		out += string(argument[i]) + " ";
	}
	show_debug_message(out);
}
