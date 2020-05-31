


// Units Tests
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
	],
	[
		function() {
			var o = instance_create_depth(0, 0, 0, obj_simple);
			var _struct = new SimpleStorer(o);
			
		}, 
		true, 
		"correct instance passed through SimpleStorer.", 
		"failed to pass correct instance through SimpleStorer."
	],
	[
		function() {
			var o = instance_create_depth(0, 0, 0, obj_2);
			var _struct = new SimpleStorer(o);
			
		}, 
		false, 
		"stopped wrong instance from being passed to SimpleStorer.", 
		"type assertion couldn't stop wrong instance from being passed to SimpleStorer."
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
			log("FAILURE:", _failure_message, "exception:", string(_ex))
		} else {
			log("SUCCESS:", _success_message, "exception:", string(_ex))
			successful_tests += 1;
		}
	}
	
}

log(successful_tests, "/", array_length(tests), "TESTS WERE SUCCESSFUL");
log();





// Performance tests
struct_real = function(_val) constructor {
	
}
struct_real_typed = function(_val) constructor {
	assert_types(is_real(_val))
}

struct_vec2 = function(_val) constructor {
	
}
struct_vec2_typed = function(_val) constructor {
	assert_types([_val, Vec2]);
}

// testing data
vec2 = new Vec2(0, 0);
test_map = ds_map_create()
test_map[? 0 ] = 0;
test_grid = ds_grid_create(1, 1);


log("RUNNING PERFORMANCE TESTS")
var _performance_tests = [
	new PerformanceTest(
		"assert a real variable",
		[
			function() {
				var _ = new struct_real(1);
			},
			function() {
				var _ = new struct_real_typed(1);
			}
		]
	),
	new PerformanceTest(
		"assert a vec2 struct type",
		[
			function() {
				var _ = new struct_vec2(vec2);
			},
			function() {
				var _ = new struct_vec2_typed(vec2);
			}
		]
	),
	new PerformanceTest(
		"for comparison, a ds_grid lookup",
		[
			function() {
				var _ = test_grid[# 0, 0 ];
			}
		]
	),
	new PerformanceTest(
		"for comparison, a ds_map lookup",
		[
			function() {
				var _ = test_map[? 0 ];
			}
		]
	),
	new PerformanceTest(
		"for comparison, a ds_grid write",
		[
			function() {
				var _ = test_grid[# 0, 0] = 0;
			}
		]
	),
	new PerformanceTest(
		"for comparison, a ds_map write",
		[
			function() {
				
				var _ = test_map[? 0 ];
			}
		]
	)
];

array_for_each(_performance_tests, function(_test) {
	var _steps = 20000;
	var _results = _test.run(_steps);
	
	log("TEST:", _test.title, "running", _steps, "times");
	
	array_for_each(_results, function(_result, i) {
		log(i, "took", _result * 1000000, "microseconds per one run");
	});
	
	
	if(array_length(_results) > 1) {
		var _min = array_reduce(_results, function(_l, _r, i) { return min(_l, _r) }, 10000);
		var _max = array_reduce(_results, function(_l, _r, i) { return max(_l, _r) }, 0);
	
		log("extra time from type assertions: ", 
			(_max - _min) * 1000000, 
			"microseconds per one assertion");
	}
	
	log();
});


log()