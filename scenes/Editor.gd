extends Node2D

var start_pos = Vector2(0,0)

var this_level = {}
var block_instances = {}
var tile_index = 1;
var selected_tile = Global.tile_types[tile_index]

var block_class = load("res://block.gd")
var pointer = block_class.new()

var flipped = false

func _ready():
	this_level.blocks = []
	pointer.construct($World, selected_tile, Vector2(0,0), false)
	pointer.spawn()
	
	refresh_pointer()

func refresh_pointer():
	pointer.set_block(selected_tile)
	if pointer.flipped != flipped:
		pointer.flip()

func reload():
	for n in $World.get_children():
		$World.remove_child(n)
		n.queue_free()
	start_pos = Global.level_importer($World, JSON.print(this_level))
	refresh_pointer()
	print(JSON.print(this_level))

func spawn_player():
	$Player.set_position(Global.to_world((start_pos)))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(pointer.instance != null):
		pointer.instance.position = Global.grid_snap(get_global_mouse_position())
		
	
	var grid_pos = Global.to_grid(get_global_mouse_position())
	if(Input.is_action_pressed("mouse_left")):
		if !get_block_at(grid_pos):
			print("Placing block")
			place_block_at(grid_pos, selected_tile)
			


	if(Input.is_action_just_released("flip")):
		pointer.flip()
		flipped = !flipped
		refresh_pointer()
				
	if(Input.is_action_pressed("mouse_right")):
		for b in this_level.blocks:
			if b.x == grid_pos.x and b.y == grid_pos.y:
				this_level.blocks.erase(b)
		reload()
	
	if(Input.is_action_just_released("next_block")):
		change_tile(true)
	if(Input.is_action_just_released("prev_block")):
		change_tile(false)
			
	if(Input.is_action_pressed("restart")):
		spawn_player()
	

func place_block_at(pos: Vector2, block_type: String):
	var obj =  {}
	obj.type = block_type
	obj.x = pos.x
	obj.y = pos.y
	obj.flip = flipped
	this_level.blocks.push_back(obj)
	var block = block_class.new()
	block.construct($World, block_type, Vector2(obj.x, obj.y), flipped)
	block_instances[str(Vector2(obj.x, obj.y))] =  block.instance
	block.spawn()
	if(obj.type == "Start"):
		start_pos = Vector2(obj.x, obj.y)

func get_block_at(pos: Vector2):
	for b in this_level.blocks:
		if b.x == pos.x and b.y == pos.y:
			return b
	return false

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
		
