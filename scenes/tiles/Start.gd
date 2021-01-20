extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



var v = 0

func _process(delta):
	self.rotation_degrees += delta * 100
	var scale = sin(v) * 0.5
	self.global_scale.x = scale
	self.global_scale.y = scale	
	
	v += 0.4 * delta
