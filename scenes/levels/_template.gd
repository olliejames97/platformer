extends Node2D

var tile_offset_x = 0
var tile_offset_y = 0

var start_pos: Vector2 = Vector2(0,0)


func _ready():
	var tile_scenes = Global.tile_scenes
	var tile_types = Global.tile_types
	# convert tilemap to nodes
	var tile_rect = $TileMap.get_used_rect()
	
	for tile_position in $TileMap.get_used_cells():
		var tileNum = $TileMap.get_cellv(tile_position)
		var world_pos = $TileMap.map_to_world(tile_position)
		var tile_type = tile_types[tileNum]
		var instance = tile_scenes[tile_type].instance()
		instance.set_name(tile_type)
		instance.position.x = world_pos.x + tile_offset_x
		instance.position.y = world_pos.y + tile_offset_x
		if tile_type == "Start":
			start_pos = instance.position
		$World.add_child(instance)
	remove_child($TileMap)
	spawn_player()
	# set players pos

func spawn_player():
	$Player.set_position(Vector2(start_pos.x - tile_offset_x + 16, start_pos.y - tile_offset_y + 16))

func _process(delta):
	if Input.is_action_pressed("restart"):
		spawn_player()
