globalvar Entity;
Entity = function(_name) constructor {
	static _ = typify(self)
	name = _name
}


function Vec2(_x, _y) constructor {
	static _ = typify(self)
	
	x = _x;
	y = _y;
	
	static Add = function( _other ){
		x += _other.x;
		y += _other.y;
	}
}

globalvar Struct;
Struct = function(_entity, _vector) constructor {
	static _ = typify(self)
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
}

