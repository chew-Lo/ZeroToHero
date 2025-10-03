extends Node2D

const SPEED = 100
var auto_move_direction := 1
var player_instance = null

func _ready():
	spawn_player()

func spawn_player():
	if GameState.selected_character_path == "":
		print("No character selected!")
		return
	
	var player_scene = load(GameState.selected_character_path)
	player_instance = player_scene.instantiate()
	add_child(player_instance)
	
	if has_node("PlayerSpawnPosition"):
		player_instance.global_position = $PlayerSpawnPosition.global_position
	print("Character spawned successfully!")

func _physics_process(delta: float) -> void:
	if player_instance == null:
		return
	
	if not player_instance.is_on_floor():
		player_instance.velocity += player_instance.get_gravity() * delta
	
	player_instance.velocity.x = auto_move_direction * SPEED
	player_instance.move_and_slide()
	
	check_level_end()

func check_level_end():
	if player_instance != null and player_instance.global_position.x > 1200:
		go_to_next_scene()

func go_to_next_scene():
	get_tree().change_scene_to_file("res://scenes/battle.tscn")
