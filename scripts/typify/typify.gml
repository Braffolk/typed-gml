global.__struct_comparison_lookup = ds_map_create()
global.__struct_increasing_index = 0;

function typify(_constructor) {
	/*log("typifying", "|",
		argument0, "|",
		instanceof(argument0), "|",
		asset_get_index(argument0),"|",
		asset_get_index(instanceof(argument0)))*/
	var _index = global.__struct_increasing_index;
	global.__struct_increasing_index++;
	global.__struct_comparison_lookup[? instanceof(argument0) ] = _index;
	global.__struct_comparison_lookup[? asset_get_index(instanceof(argument0)) ] = _index;
	global.__struct_comparison_lookup[? string(asset_get_index(instanceof(argument0))) ] = _index;
	global.__struct_comparison_lookup[? "function gml_Script_" + instanceof(argument0) ] = _index;
	return argument0;
}

function is(_struct, _type) {
	var _v1, _v2;
	if(is_numeric(_type)){
		// This applies when the type is a non-anonymous constructor
		_v1 = global.__struct_comparison_lookup[? asset_get_index(instanceof(_struct)) ];
		
	} else {
		_v1 = global.__struct_comparison_lookup[? instanceof(_struct) ];
	}
	_v2 = global.__struct_comparison_lookup[? string(_type) ];
	
	
	if(is_undefined(_v1)){
		throw (string(asset_get_index(instanceof(_struct))) + " lookup value is undefined")
	}
	if(is_undefined(_v2)){
		throw (string(_type) + " lookup value is undefined")
	}
	
	return (_v1 == _v2);
}


function assert_types() {
	for(var i = 0; i < argument_count; i++) {
		var _tuple = argument[i];
		if(!is(_tuple[0], _tuple[1])){
			throw("Wrong type at argument" + string(i) + ", expected " + string(_tuple[1]));
		}
	}
}

