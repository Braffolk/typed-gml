


log("@@@@")

var a = array_create(1, 5)

log(is_struct(is_undefined))
log(is_method(is_undefined))

log(is_struct(Struct))
log(is_method(Struct))

log(asset_get_type(is_undefined))
log((obj_tests))



log()
log("RUNNING TESTS:")


var tests = [
	[
		function() {
			var _struct = new Struct(new Entity("name"), new Vec2(0, 0));
		}, 
		true, 
		"struct with correct arguments created.", 
		"couldn't create struct with correct arguments."
	],
	[
		function() {
			var _struct = new Struct(new Entity(""), new Entity(""));
			log(_struct)
		}, 
		false, 
		"wrong anonymous struct successfully found in constructor arguments.", 
		"couldn't stop wrong anonymous struct argument being passed to constructor."
	],
	[
		function() {
			var _struct = new Struct(new Vec2(0, 0), new Vec2(0, 0));
		},
		false, 
		"wrong non-anonymous struct successfully found in constructor arguments.", 
		"couldn't stop wrong non-anonymous struct argument being passed to constructor."
	],
	[
		function() {
			var _struct = new Struct(new Entity("name"), new Vec2(0, 0));
			_struct.set_entity(new Entity("name"))
		}, 
		true, 
		"successfully updated a struct field that has type assertion.", 
		"failed to updated a struct field with type assertion."
	],
	[
		function() {
			var _struct = new Struct(new Entity("name"), new Vec2(0, 0));
			_struct.set_entity(new Vec2(0, 0))
		}, 
		false, 
		"stopped wrong struct type from being passed to a struct method.", 
		"couldn't stop wrong struct type from being passed to a struct method."
	]
];


successful_tests = 0;
for(var i = 0; i < array_length(tests); i++){
	var _args = tests[i]
	var _fun = _args[0];
	var _error_not_expected = _args[1];
	var _success_message = _args[2];
	var _failure_message = _args[3];
	
	try {
		_fun()
		if(!_error_not_expected) {
			log("FAILURE:", _failure_message)
		} else {
			log("SUCCESS:", _success_message)
			successful_tests += 1;
		}
	} catch( _ex) {
		if(_error_not_expected) {
			log("FAILURE:", _failure_message, string(_ex))
		} else {
			log("SUCCESS:", _success_message, string(_ex))
			successful_tests += 1;
		}
	}
	
}

log(successful_tests, "/", array_length(tests), "TESTS WERE SUCCESSFUL");
log();


log("RUNNING PERFORMANCE TESTS")


log()