global.__type_increasing_id = 0;
global.__struct_index_lookup = ds_grid_create(1000, 1);

/*
is_string
is_real
is_numeric
is_bool
is_array
is_struct
is_method
is_ptr
is_int32
is_int64
is_vec3
is_vec4
is_matrix
is_undefined
is_nan
is_infinity
*/

function typify(_constructor) {
	/*log("typifying", "|",
		argument0, "|",
		instanceof(argument0), "|",
		asset_get_index(argument0), "|",
		asset_get_index(instanceof(argument0)), "|"
	)*/
	
	var _unique_id = global.__type_increasing_id;
	global.__type_increasing_id++;
	
	var _index = asset_get_index(instanceof(argument0)) - 100000;
	if(ds_grid_width(global.__struct_index_lookup) < _index + 1) {
		ds_grid_resize(
			global.__struct_index_lookup,
			_index + 1000,
			ds_grid_height(global.__struct_index_lookup)
		)
	}
	
	global.__struct_index_lookup[# _index, 0 ] = _unique_id;
	
	return argument0;
}


function is(_struct, _type) {
	var _index_struct = asset_get_index(instanceof(_struct)) - 100000;
	var _index_type = (is_method(_type) ? method_get_index(_type) : _type) - 100000;
	
	return (global.__struct_index_lookup[# _index_struct, 0] == global.__struct_index_lookup[# _index_type, 0 ])
}


function assert_types() {
	for(var i = 0; i < argument_count; i++) {
		var _tuple = argument[i];
		if(!is(_tuple[0], _tuple[1])){
			throw("Wrong type at argument" + string(i) + ", expected " + string(_tuple[1]));
		}
	}
}

