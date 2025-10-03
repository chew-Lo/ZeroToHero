extends CharacterBody2D
class_name PlayerBase

const SPEED = 170.0
const DETECTION_DISTANCE = 75.0
const ATTACK_INTERVAL = 1.5

var is_moving = true
var enemy_node = null
var player_hp = 100
var max_hp = 100
var player_damage = 10
var player_class = ""
var in_battle = false
var battle_timer = 0.0
var battle_ended = false
var attacking = false

@onready var animated_sprite = $AnimatedSprite2D
var hp_label = null

func _ready():
	load_player_stats()
	create_hp_label()
	on_ready()
	await get_tree().process_frame
	find_enemy()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if is_moving and enemy_node and not battle_ended:
		var distance = global_position.distance_to(enemy_node.global_position)
		if distance <= DETECTION_DISTANCE:
			is_moving = false
			start_battle()
	
	handle_animations()
	velocity.x = SPEED if is_moving else 0
	move_and_slide()
	
	if in_battle:
		battle_timer += delta
		if battle_timer >= ATTACK_INTERVAL:
			battle_timer = 0.0
			process_battle_turn()

func handle_animations():
	if animated_sprite and not attacking:
		if is_moving:
			animated_sprite.play("walk")
		else:
			animated_sprite.play("idle")

func find_enemy():
	enemy_node = get_tree().get_first_node_in_group("enemies")

func load_player_stats():
	var stats = GameState.get_player_stats()
	player_class = stats["class"]
	player_hp = stats["hp"]
	max_hp = stats["hp"]
	player_damage = stats["damage"]

func create_hp_label():
	hp_label = Label.new()
	hp_label.position = Vector2(10, 10)
	hp_label.add_theme_font_size_override("font_size", 16)
	hp_label.text = player_class.capitalize() + " HP: " + str(player_hp)
	add_child(hp_label)

func start_battle():
	in_battle = true
	if enemy_node and enemy_node.has_method("start_battle"):
		enemy_node.start_battle(self)

func process_battle_turn():
	if player_hp <= 0:
		end_battle()
		return
	play_attack_animation()
	var attack_result = perform_class_attack()
	
	DebugLogger.debug_log(attack_result["message"])
	if enemy_node and enemy_node.has_method("take_damage"):
		enemy_node.take_damage(attack_result["damage"])
		
func play_attack_animation():
	if animated_sprite:
		attacking = true
		animated_sprite.play("attack")
		await animated_sprite.animation_finished
		attacking = false

func perform_class_attack() -> Dictionary:
	return {"damage": player_damage, "message": "Player attacks! Dealt " + str(player_damage) + " damage"}

func take_damage(damage: int):
	player_hp -= damage
	hp_label.text = player_class.capitalize() + " HP: " + str(player_hp)
	DebugLogger.debug_log("%s HP: %d" % [player_class, player_hp])
	
	if player_hp <= 0:
		end_battle()

func end_battle():
	in_battle = false
	battle_ended = true
	attacking = false
	if enemy_node and enemy_node.has_method("end_battle"):
		enemy_node.end_battle()
	if player_hp <= 0:
		handle_death()
	else:
		on_victory()

func handle_death():
	on_defeat()
	
	await get_tree().create_timer(2.0).timeout
	
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")

func on_ready(): pass
func on_defeat(): pass
func on_victory(): pass
