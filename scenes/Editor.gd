extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Pointer.set_position(to_grid(get_global_mouse_position()))
	
	if(Input.is_action_pressed("mouse_left")):
		print("mouse")
		print(str(get_global_mouse_position()))


