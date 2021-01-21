extends Node

var scene_node = self

var pos: Vector2 = Vector2(0,0)
var other_properties = {}
var obj = null



func construct(parent: Node2D, tile_type: String, pos_: Vector2):
	obj = Global.tile_scenes[tile_type]
	pos = pos_
	scene_node = parent

func spawn():
	if(obj):
		var my_object = obj.instance()
		my_object.position = Global.to_world(pos)
		scene_node.add_child(my_object)
	else:
		print("tried to spawn non object")

