# Typed GML
Typed GML is an attempt to add typed functions, constructors and methods in the new Game Maker Studio 2.3 beta.

Supported type checks:
* check if a struct came from a specific constructor
* instance object_index checks
* all is_ functions (is_real, is_array, is_string etc)


# When and why to use?
Type checking gets rid of the worst bugs by stopping any buggy code right where the bug occurs. For example if you made a typo in your code some days ago and have been working on unrelated things, but then find an undefined variable showing up in a random place, there is no simple way to know what caused it. Many functions handle undefined values just fine (e.g. a list, grid set instead of a multiplication) and the source of a bug can hence be hard to track down.

The aim of Typed GML is to solve that by letting the programmer assert inputs and outputs. This is especially useful when dealing with unknown data, large data pipelines, networking or any other complex example. For release mode, type assertions can be turned off by modifying a global macro.


# Example Usage
```JavaScript
globalvar Entity;
Entity = function(_name, _instance) constructor {
	assert_types(is_string(_name));
	
	name = _name;
	instance = _instance;
}

function SimpleStorer(_instance) constructor {
	assert_types(is_instance_of(_instance, obj_simple));
	
	instance = _instance
}

function Vec2(_x, _y) constructor {
	assert_types(is_real(_x), is_real(_y));
	
	x = _x;
	y = _y;
	
	static Add = function( _other ){
		assert_types([_other, self]);
		
		x += _other.x;
		y += _other.y;
	}
}

globalvar Struct;
Struct = function(_entity, _vector) constructor {
	assert_types([_entity, Entity], [_vector, Vec2]);
	
	entity = _entity;
	vector = _vector;
	
	static get_entity = function() {
		return entity;
	}
	
	static set_entity = function(_entity) {
		assert_types([_entity, Entity]);
		entity = _entity;
	}
}

// Successful
var _struct = new Struct(new Entity("name"), new Vec2(0.0, 0.0));

// Will throw a type error
var _struct = new Struct(new Entity("name"), new Entity("name"));
```

# Performance
The project has performance and unit tests. These were run on a mac and performance may differ between platforms. If someone has another platform to test this on and send the results as an issue, it would be helpful.

```
RUNNING PERFORMANCE TESTS 
TEST: assert a real variable running 20000 time 
0 took 45.44 microseconds per one run 
1 took 47.90 microseconds per one run 
extra time from type assertions:  2.47 microseconds per one assertion 

TEST: assert a vec2 struct type running 20000 time 
0 took 42.28 microseconds per one run 
1 took 48.35 microseconds per one run 
extra time from type assertions:  6.07 microseconds per one assertion 

TEST: for comparison, a ds_grid lookup running 20000 time 
0 took 1.00 microseconds per one run 

TEST: for comparison, a ds_map lookup running 20000 time 
0 took 1.45 microseconds per one run 

TEST: for comparison, a ds_grid write running 20000 time 
0 took 1.12 microseconds per one run 

TEST: for comparison, a ds_map write running 20000 time 
0 took 1.15 microseconds per one run 
```
