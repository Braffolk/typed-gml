global.__type_increasing_id = 0;
global.__struct_id_lookup = ds_grid_create(1000, 1);


function is_instance_of(_instance, _object_index) {
	if(!is_undefined(_instance)) {
		with(_instance) {
			return object_index == _object_index;
		}
	} else {
		//on mac throw stops the run without any error, so right now false is returned instead of throwing the error.
		//throw(string(_instance) + " instance does not exist, checked for object_index " + string(_object_index))
		return false
	}
	return false
}

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
	if(ds_grid_width(global.__struct_id_lookup) < _index + 1) {
		ds_grid_resize(
			global.__struct_id_lookup,
			_index + 1000,
			ds_grid_height(global.__struct_id_lookup)
		)
	}
	
	global.__struct_id_lookup[# _index, 0 ] = _unique_id;
	
	return argument0;
}


function is_struct_of_type(_struct, _type) {
	var _index_struct = asset_get_index(instanceof(_struct)) - 100000;
	var _index_type = (is_method(_type) ? method_get_index(_type) : _type) - 100000;
	
	return (global.__struct_id_lookup[# _index_struct, 0] == global.__struct_id_lookup[# _index_type, 0 ])
}


function assert_types() {
	for(var i = 0; i < argument_count; i++) {
		if(is_array(argument[i])) {
			var _tuple = argument[i];
		
			if(!is_struct_of_type(_tuple[0], _tuple[1])){
				throw("Wrong struct type at argument " + string(i) + ", expected " + string(_tuple[1]));
			}
		} else if(argument[i] == false){
			throw("Wrong type at argument " + string(i));
		}
	}
}

