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

