
#macro ASSERT_TYPES true


function is_instance_of(_instance, _object_index) {
	/// @description	
	
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


enum Types {
	StructOf,
	ArrayOf,
	InstanceOf,
	
	// built in
	String,
	Real,
	Numeric,
	Bool,
	Array,
	Struct,
	Method,
	Ptr,
	Int32,
	Int64,
	Vec3,
	Vec4,
	Matrix,
	Undefined,
	Nan,
	Infinity,
	__size
}

global.__type_names = array_create(Types.__size, "MISSING TYPE NAME");
global.__type_names[Types.StructOf] = "struct of";
global.__type_names[Types.ArrayOf] = "array of";
global.__type_names[Types.InstanceOf] = "instance of";
global.__type_names[Types.String] = "string";
global.__type_names[Types.Real] = "real";
global.__type_names[Types.Numeric] = "numeric";
global.__type_names[Types.Bool] = "boolean";
global.__type_names[Types.Array] = "array";
global.__type_names[Types.Struct] = "struct";
global.__type_names[Types.Method] = "method";
global.__type_names[Types.Ptr] = "pointer";
global.__type_names[Types.Int32] = "int32";
global.__type_names[Types.Int64] = "int64";
global.__type_names[Types.Vec3] = "vec3";
global.__type_names[Types.Vec4] = "vec4";
global.__type_names[Types.Matrix] = "vec4";
global.__type_names[Types.Undefined] = "undefined";
global.__type_names[Types.Nan] = "NaN";
global.__type_names[Types.Infinity] = "infinity";


function t_struct_of(_struct, _type) constructor		{ return [Types.StructOf, _struct, _type]; }
function t_array_of(_array, _items_type) constructor	{ return [Types.ArrayOf, _array, _items_type]; }
function t_instance_of(_instance, _type) constructor	{ return [Types.InstanceOf, _instance, _type]; }
function t_string(_value) constructor					{ return [Types.String, _value]; }
function t_real(_value) constructor						{ return [Types.Real, _value]; }
function t_numeric(_value) constructor					{ return [Types.Numeric, _value]; }
function t_bool(_value) constructor						{ return [Types.Bool, _value]; }
function t_array(_value) constructor					{ return [Types.Array, _value]; }
function t_struct(_value) constructor					{ return [Types.Struct, _value]; }
function t_method(_value) constructor					{ return [Types.Method, _value]; }
function t_ptr(_value) constructor						{ return [Types.Ptr, _value]; }


global.__type_check_functions = array_create(Types.__size);
global.__type_check_functions[Types.StructOf]	= function(_pars) { return is_struct_of_type(_pars[1], _pars[2]); }
global.__type_check_functions[Types.ArrayOf]	= function(_pars) { return is_array_of(_pars[1], _pars[2]); }
global.__type_check_functions[Types.InstanceOf] = function(_pars) { return is_instance_of(_pars[1], _pars[2]); }
global.__type_check_functions[Types.String]		= function(_pars) { return is_string(_pars[1]); }
global.__type_check_functions[Types.Real]		= function(_pars) { return is_real(_pars[1]); }
global.__type_check_functions[Types.Numeric]	= function(_pars) { return is_numeric(_pars[1]); }
global.__type_check_functions[Types.Bool]		= function(_pars) { return is_bool(_pars[1]); }
global.__type_check_functions[Types.Array]		= function(_pars) { return is_array(_pars[1]); }
global.__type_check_functions[Types.Struct]		= function(_pars) { return is_struct(_pars[1]); }
global.__type_check_functions[Types.Method]		= function(_pars) { return is_method(_pars[1]); }
global.__type_check_functions[Types.Ptr]		= function(_pars) { return is_ptr(_pars[1]); }



function value_type_name_fuzzy(_value) {
	if(!is_undefined(instanceof(_value))) {
		return string(instanceof(_value));
	} else {
		return typeof(_value);
	}
}

function assert_types() {
	//if(ASSERT_TYPES){
		for(var i = 0; i < argument_count; i++) {
			var _type_pars = argument[i];
			var _check_function = global.__type_check_functions[_type_pars[0]];
			var _is_expected_type = _check_function(_type_pars);
			
			if(!_is_expected_type) {
				var _expected_name = global.__type_names[_type_pars[0]];
				var _found_name = value_type_name_fuzzy(_type_pars[1]);
				var _err;
				
				if(array_length(_type_pars) > 2){
					var _target_name;
					if(_type_pars[0] == Types.InstanceOf) {
						_target_name = object_get_name(_type_pars[2]);
					} else {
						_target_name = _type_pars[2];
					}
					
					_err = ("Wrong type at argument " + string(i) + ", expected " + _expected_name + "'" +
						string(_target_name) + 
						"'" + " found " + _found_name);
				} else {
					_err = ("Wrong type at argument " + string(i) + ", expected '" + _expected_name + "' found " + _found_name);
				}
				
				throw(_err);
			}
		}
	//}
}


