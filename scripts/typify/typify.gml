function is_instance_of(_instance, _object_index) {
	if(instance_exists(_instance)) {
		with(_instance) {
			return object_index == _object_index;
		}
	} else {
		throw(string(_instance) + " instance does not exist, checked for object_index " + string(_object_index))
	}
	return false
}


function is_struct_of_type(_struct, _type) {
	var _index_struct = asset_get_index(instanceof(_struct));
	var _index_type = (is_method(_type) ? method_get_index(_type) : _type);
	return _index_struct == _index_type;
}

function is_array_of(_array, _function) {
	if(array_length(_array) == 0){
		return true;
	} else {
		return _function(_array[0]);
	}
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

