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


Struct = function(_entity, _vector) constructor {
	static _ = typify(self);
	assert_types([_entity, Entity], [_vector, Vec2])
	
	
	entity = _entity
	vector = _vector
	static get_entity = function() {
		return entity
	}
}



log("Typing check:")
log("success: created struct", new Struct(new Entity(), new Vec2()))
try {
	log("failure: created struct", new Struct(new Entity(), new Entity()))
} catch(_ex) {
	log("success:", string(_ex))
}
try {
	log("failure: created struct", new Struct(new Vec2(), new Vec2()))
} catch(_ex) {
	log("success:", string(_ex))
}