# Typed GML
Typed GML is an attempt to add typed functions, constructors and methods in the new Game Maker Studio 2.3 beta.

Supported type checks:
* check if a struct came from a specific constructor (t_constructor_of)
* instance object_index checks (t_instance_of)
* all built in types functions (real, array, string, numeric, method etc) 


## When and why to use?
Type checking gets rid of the worst bugs by stopping any buggy code right where the bug occurs. For example if you made a typo in your code some days ago and have been working on unrelated things, but then find an undefined variable showing up in a random place, there is no simple way to know what caused it. Many functions handle undefined values just fine (e.g. a list, grid set instead of a multiplication) and the source of a bug can hence be hard to track down.

The aim of Typed GML is to solve that by letting the programmer assert inputs and outputs. This is especially useful when dealing with unknown data, large data pipelines, networking or any other more complex application. For release mode, type assertions can be turned off by modifying a global macro.


### Example Usage
```JavaScript
globalvar Entity;
Entity = function(_name, _instance) constructor {
	assert_types(t_string(_name));
	
	name = _name;
	instance = _instance;
}

function SimpleStorer(_instance) constructor {
	assert_types(t_instance_of(_instance, obj_simple));
	
	instance = _instance
}

function Vec2(_x, _y) constructor {
	assert_types(t_real(_x), t_real(_y));
	
	x = _x;
	y = _y;
	
	static Add = function( _other ){
		assert_types(t_struct_of(_other, self));
		
		x += _other.x;
		y += _other.y;
	}
}

globalvar Struct;
Struct = function(_entity, _vector) constructor {
	assert_types(t_struct_of(_entity, Entity), t_struct_of(_vector, Vec2));
	
	entity = _entity;
	vector = _vector;
	
	static get_entity = function() {
		return entity;
	}
	
	static set_entity = function(_entity) {
		assert_types(t_struct_of(_entity, Entity));
		entity = _entity;
	}
}
```

## Performance
The project has performance and unit tests. These were run on a mac and performance may differ between platforms. If someone has another platform to test this on and send the results as an issue, it would be helpful.

Type assertions can be turned off via a macro for release mode.

### Macbook Pro (2015), VM
```
RUNNING PERFORMANCE TESTS 
TEST: assert a real variable running 10000 times 
0 took 31.83 microseconds per one run 
1 took 46.56 microseconds per one run 
extra time from type assertions:  14.73 microseconds per one run 

TEST: assert 4 real type variables running 10000 times 
0 took 31.64 microseconds per one run 
1 took 59.73 microseconds per one run 
extra time from type assertions:  28.08 microseconds per one run 

TEST: assert a vec2 struct type running 10000 times 
0 took 30.15 microseconds per one run 
1 took 45.16 microseconds per one run 
extra time from type assertions:  15.01 microseconds per one run 

TEST: for comparison, a ds_grid lookup running 10000 times 
0 took 0.76 microseconds per one run 

TEST: for comparison, a ds_map_create and destroy running 10000 times 
0 took 4.80 microseconds per one run 

TEST: for comparison, an instance_create and destroy running 10000 times 
0 took 17.62 microseconds per one run 

TEST: for comparison, a ds_map lookup running 10000 times 
0 took 0.94 microseconds per one run 

TEST: for comparison, a ds_grid write running 10000 times 
0 took 0.18 microseconds per one run 

TEST: for comparison, a ds_map write running 10000 times 
0 took 0.89 microseconds per one run 

TEST: for comparison, an anonymous function call running 10000 times 
0 took 0.89 microseconds per one run 
```
