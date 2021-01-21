extends Node
var collision_pos = []

var tile_types= ["Template", "Floor", "Bad", "Bounce", "Start"]
var tile_scenes = {} 


var start_pos: Vector2 = Vector2(0,0)


func _ready():
	print ("ready global")
	for t in tile_types:
		tile_scenes[t] = load("res://scenes/tiles/" + t + ".tscn")
		

func grid_snap(v: Vector2):
	return Vector2(stepify(v.x, 64), stepify(v.y, 64))

func to_world(v: Vector2):
	return grid_snap(v * 64)

func to_grid(v: Vector2):
	return Vector2(int(round(v.x / 64)),int(round(v.y / 64)))

var level = {}
var block_class = load("res://block.gd")

func level_importer(scene_node: Node2D, level_json: String):
	level = parse_json(level_json)
	for b in level.blocks:
		if !tile_types.has(b.type):
			print("Bad block type, skipping " + b.type)
			break
		if b.type == "Start":
			start_pos = Vector2(b.x, b.y)
		var block = block_class.new()
		block.construct(scene_node, b.type, Vector2(b.x, b.y))
		block.spawn()
		
	return start_pos

