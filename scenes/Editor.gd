extends Node2D

var start_pos = Vector2(0,0)

var this_level = {}
var tile_index = 1;
var selected_tile = Global.tile_types[tile_index]


func _ready():
	this_level.blocks = []
	refresh_pointer()

func refresh_pointer():
	print("refreshing pointer")
	var obj = Global.tile_scenes[selected_tile].instance()
	obj.name = "Pointer"
	$Pointer.replace_by(obj)

func reload():
	for n in $World.get_children():
		$World.remove_child(n)
		n.queue_free()
	start_pos = Global.level_importer($World, JSON.print(this_level))

func spawn_player():
	$Player.set_position(Global.to_world((start_pos)))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Pointer.set_position(Global.grid_snap(get_global_mouse_position()))
	var grid_pos = Global.to_grid(get_global_mouse_position())

	if(Input.is_action_pressed("mouse_left")):
		var obj =  {}
		obj.type = selected_tile
		obj.x = grid_pos.x
		obj.y = grid_pos.y
		this_level.blocks.push_back(obj)
		reload()
		
	if(Input.is_action_pressed("mouse_right")):
		for b in this_level.blocks:
			if b.x == grid_pos.x and b.y == grid_pos.y:
				this_level.blocks.erase(b)
		reload()
		
	if(Input.is_action_pressed("restart")):
		spawn_player()
	
	if(Input.is_action_just_released("next_block")):
		change_tile(true)
	if(Input.is_action_just_released("prev_block")):
		change_tile(false)
			
	if tile_index < 1:
		tile_index = len(Global.tile_types) - 1
	if tile_index > len(Global.tile_types) -1:
		tile_index = 1
	
	
func change_tile(next: bool):
	if next: 
		tile_index+=1
	else:
		tile_index-=1
		
	if tile_index < 1:
		tile_index = len(Global.tile_types) - 1
	if tile_index > len(Global.tile_types) -1:
		tile_index = 1
	
	selected_tile = Global.tile_types[tile_index]
	refresh_pointer()
		
