extends Node
var collision_pos = []

var tile_types= ["Template", "Floor", "Bad", "Bounce", "Start"]
var tile_scenes = {} 


var start_pos: Vector2 = Vector2(0,0)

var hello = "world"
func _ready():
	print ("ready global")
	for t in tile_types:
		tile_scenes[t] = load("res://scenes/tiles/" + t + ".tscn")
		
