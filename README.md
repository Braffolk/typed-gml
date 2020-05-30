# typed-gml
Typed GML is an attempt to add type checking to functions, constructors and methods in the new Game Maker Studio 2.3 beta.

An example usage:
```JavaScript
globalvar Entity;


Entity = typify(function(_name) constructor {
	name = _name
})


function Vec2(_x, _y) constructor {
	static _ = typify(self)
	
	x = _x;
	y = _y;
	
	static Add = function( _other ){
		x += _other.x;
		y += _other.y;
	}
}


Struct = typify(function(_entity, _vector) constructor {
	assert_types([_entity, Entity], [_vector, Vec2])
	
	entity = _entity
	vector = _vector
	static get_entity = function() {
		return entity
	}
	
	static set_entity = function(_entity) {
		assert_types([_entity, Entity])
		entity = _entity
	}
})

// Successful
var _struct = new Struct(new Entity(), new Vec2());

// Will throw a type error
var _struct = new Struct(new Entity(), new Entity());
```

To typify a struct constructor wrap it into typify or call the typify inside the constructor passing self (the constructor context) to the function. The latter should be stored in a static variable so that the struct is only typified once. This will store the constructor into a global lookup map which is used to check whether the type of a struct instance was created using a constructor or not.

To assert types for a method simply call assert_types and pass in arguments of lists, where the first index is the instance of a struct and the second is the struct constructor.

# Planned features
1. Optmisations to the lookup map, should preferably be replaced with a simpler array lookup
2. Method type checks
3. Add non-struct types (strings, numbers, etc)

# Known Issues
* Only struct initialised in a script can be used right now, struct constructors created in an object will fail
