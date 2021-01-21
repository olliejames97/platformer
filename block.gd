extends Node

var scene_node = self

var pos: Vector2 = Vector2(0,0)
var other_properties = {}
var obj = null
var flipped = false
var instance = null

func construct(parent_: Node2D, tile_type: String, pos_: Vector2, flipped_: bool):
	obj = Global.tile_scenes[tile_type]
	pos = pos_
	scene_node = parent_
	flipped = flipped_

func spawn():
	if(obj):
		var my_object = obj.instance()
		my_object.position = Global.to_world(pos)
		scene_node.add_child(my_object)
		if(flipped):
			my_object.scale.x = -1
		instance = my_object
			
	else:
		print("tried to spawn non object")

func set_block(type):
	scene_node.remove_child(instance)
	construct(scene_node, type, pos, flipped)
	spawn()
	
func flip():
	instance.scale.x = instance.scale.x*-1;
	flipped = !flipped
