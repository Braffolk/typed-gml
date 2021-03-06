


// Unit Tests

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
	assert_types(t_real(_val))
}

struct_real_4_arguments = function(_1, _2, _3, _4) constructor {
	
}
struct_real_4_arguments_typed = function(_1, _2, _3, _4) constructor {
	assert_types(t_real(_1), t_real(_2), t_real(_3), t_real(_4))
}

struct_real_16_arguments = function(_1, _2, _3, _4, _5, _6, _7, _8, 
										_9, _10, _11, _12, _13, _14, _15, _16) constructor {
	
}
struct_real_16_arguments_typed = function(_1, _2, _3, _4, _5, _6, _7, _8, 
										_9, _10, _11, _12, _13, _14, _15, _16) constructor {
	assert_types(
		t_real(_1), t_real(_2), t_real(_3), t_real(_4),
		t_real(_5), t_real(_6), t_real(_7), t_real(_8),
		t_real(_9), t_real(_10), t_real(_11), t_real(_12),
		t_real(_13), t_real(_14), t_real(_15), t_real(_16)
	)
}

struct_vec2 = function(_val) constructor {
	
}
struct_vec2_typed = function(_val) constructor {
	assert_types(t_struct_of(_val, Vec2));
}

// testing data
vec2 = new Vec2(0, 0);
test_map = ds_map_create()
test_map[? 0 ] = 0;
test_grid = ds_grid_create(16, 16);
array = array_create(10, 5);
array_2d = array_create(10, [1, 2, 3])
anonymous_function = function() {}

lookup_index = 0;

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
		"assert 4 real type variables",
		[
			function() {
				var _ = new struct_real_4_arguments(1, 1, 1, 1);
			},
			function() {
				var _ = new struct_real_4_arguments_typed(1, 1, 1, 1);
			}
		]
	),
	new PerformanceTest(
		"assert 16 real type variables",
		[
			function() {
				var _ = new struct_real_16_arguments(1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4);
			},
			function() {
				var _ = new struct_real_16_arguments_typed(1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4);
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
		"for comparison, a ds_map_create and destroy",
		[
			function() {
				var _ = ds_map_create();
				ds_map_destroy(_);
			}
		]
	),
	new PerformanceTest(
		"for comparison, an instance_create and destroy",
		[
			function() {
				var _ = instance_create_depth(0, 0, 0, obj_simple);
				instance_destroy(_);
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
				test_grid[# 0, 0] = 0;
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
	),
	new PerformanceTest(
		"for comparison, an anonymous function call",
		[
			function() {
				var _ = anonymous_function();
			}
		]
	),
	new PerformanceTest(
		"fasdf",
		[
			function() {
				return [1, 2, 3];
			},
			function() {
				lookup_index = 0;
			},
			function() {
				var _ = array_2d[lookup_index]
				_[0] = 1;
				_[1] = 2;
				_[2] = 3;
				lookup_index++;
				return _
			}
		]
	)
];


array_for_each(_performance_tests, function(_test) {
	var _steps = 10000;
	var _results = _test.run(_steps);
	
	log("TEST:", _test.title, ", running", _steps, "times");
	
	array_for_each(_results, function(_result, i) {
		log(i, "took", (_result), "microseconds per one run, ops/sec:", 1000000/_result);
	});
	
	
	if(array_length(_results) > 1) {
		var _min = array_reduce(_results, function(_l, _r, i) { return min(_l, _r) }, 1000000000000);
		var _max = array_reduce(_results, function(_l, _r, i) { return max(_l, _r) }, 0);
	
		log("extra time from type assertions: ", 
			((_max) - (_min)), 
			"microseconds per one run, ops/sec:",
			1000000/(_max-_min));
	}
	
	log();
});


log()