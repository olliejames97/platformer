extends Node2D


var example_level_json = '{"blocks":[{"type":"Start","x":5,"y":4},{"type":"Bounce","x":6,"y":5}, {"type":"Floor","x":5,"y":5},{"type":"Bounce","x":5,"y":6,"bounce_force":2000}]}'

var start_pos: Vector2 = Vector2(0,0)



func _ready():
	print("Making request")
	
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")
	$HTTPRequest.request("https://run.mocky.io/v3/d11d6f08-887e-4000-88c8-f9024b327c4a")
	
	pass # Replace with function body.

func _on_request_completed(result, response_code, headers, body):
	print("got data")
	start_pos = Global.level_importer($World, body.get_string_from_utf8())
	spawn_player()

func spawn_player():
	print(get_parameter("l"))
	$Player.set_position(Global.to_world((start_pos)))

func _process(delta):
	if Input.is_action_pressed("restart"):
		spawn_player()



func get_parameter(parameter):
	if OS.has_feature('JavaScript'):
		return JavaScript.eval(""" 
				var url_string = window.location.href;
				console.log('hey js')
				url_string
			""")
	else:
		print("no JS")
	return null
