extends Node2D


var example_level_json = '{"blocks":[{"type":"Start","x":5,"y":4},{"type":"Bounce","x":6,"y":5}, {"type":"Floor","x":5,"y":5},{"type":"Bounce","x":5,"y":6,"bounce_force":2000}]}'

var start_pos: Vector2 = Vector2(0,0)


func _ready():
	start_pos = Global.level_importer($World, example_level_json)
	spawn_player()
	pass # Replace with function body.

func spawn_player():
	$Player.set_position(Global.to_world((start_pos)))

func _process(delta):
	if Input.is_action_pressed("restart"):
		spawn_player()



