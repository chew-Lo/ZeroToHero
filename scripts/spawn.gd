extends Node2D

func _ready():
	spawn_player()

func spawn_player():
	if GameState.selected_character_path == "":
		print("No character selected!")
		return
	
	var player_scene = load(GameState.selected_character_path)
	var player_instance = player_scene.instantiate()
	add_child(player_instance)
	
	if has_node("PlayerSpawnPosition"):
		player_instance.global_position = $PlayerSpawnPosition.global_position
	print("Character spawned successfully!")
