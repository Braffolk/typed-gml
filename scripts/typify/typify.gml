global.__struct_comparison_lookup = ds_map_create()

function typify(_constructor) {
	log("typifying", instanceof(argument0), asset_get_index(instanceof(argument0)))
	var _index = ds_map_size(global.__struct_comparison_lookup);
	global.__struct_comparison_lookup[? instanceof(argument0) ] = _index;
	global.__struct_comparison_lookup[? asset_get_index(instanceof(argument0)) ] = _index;
	global.__struct_comparison_lookup[? string(asset_get_index(instanceof(argument0))) ] = _index;
	global.__struct_comparison_lookup[? "function gml_Script_" + instanceof(argument0) ] = _index;
	return argument0;
}

function is(_struct, _type) {
	if(is_numeric(_type)){
		// This applies when the type is a non-anonymous constructor
		return (global.__struct_comparison_lookup[? asset_get_index(instanceof(_struct)) ] == global.__struct_comparison_lookup[? string(_type) ])
	}
	return global.__struct_comparison_lookup[? instanceof(_struct) ] == global.__struct_comparison_lookup[? string(_type) ]
}


function assert_types() {
	for(var i = 0; i < argument_count; i++) {
		var _tuple = argument[i]
		if(!is(_tuple[0], _tuple[1])){
			throw("Wrong type at argument" + string(i) + ", expected " + string(_tuple[1]))
		}
	}
}

