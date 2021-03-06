function log() {
	var out = "";
	for(var i = 0; i < argument_count; i++){
		out += string(argument[i]) + " ";
	}
	show_debug_message(out);
}



function PerformanceTest(_title, _methods) constructor {
	assert_types(t_string(_title), t_array_of(_methods, is_method));
	
	title	= _title;
	methods	= _methods;
	
	static run = function(_steps) {
		assert_types(t_real(_steps))
		
		var _results = array_create(array_length(methods), 0);
		var _baseline_function = function() {}
		
		for(var i = 0; i < _steps; i++) {
			for(var j = 0; j < array_length(methods); j++) {
				var _time, _time_baseline;
				var _method = methods[j];
				
				// establish baseline
				_time = get_timer();
				_baseline_function();
				_time_baseline = get_timer() - _time;
				
				// calculate function time
				_time = get_timer();
				_method();
				_time = get_timer() - _time - _time_baseline;
				_results[j] += _time;
			}
		}
		
		for(var j = 0; j < array_length(methods); j++) {
			_results[j] /= _steps;
		}
		
		return _results;
	}
}



function array_for_each(_array, _function) {
	for(var i = 0; i < array_length(_array); i++) {
		_function(_array[i], i);
	}
}

function array_reduce(_array, _function, _initial_value) {
	var _val = _initial_value;
	for(var i = 0; i < array_length(_array); i++) {
		var _next_val = _array[i];
		
		var _val = _function(_val, _next_val, i);
	}
	return _val;
}