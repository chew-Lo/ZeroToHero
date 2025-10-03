extends CharacterBody2D

var goblin_hp = 300
var goblin_damage = 25
var in_battle = false
var battle_target = null
var battle_timer = 0.0
const ATTACK_INTERVAL = 1.5
const HAMMER_CRUSH_CHANCE = 0.20
const DEVASTATING_BLOW_CHANCE = 0.15
const NEXT_SCENE = "res://scenes/reward_3.tscn"
var hp_label = null

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	add_to_group("enemies")
	create_hp_label()
	
	if animated_sprite:
		animated_sprite.play("idle")

func create_hp_label():
	hp_label = Label.new()
	hp_label.position = Vector2(-25, -40)
	hp_label.add_theme_font_size_override("font_size", 16)
	hp_label.text = "HP: " + str(goblin_hp)
	hp_label.visible = false
	add_child(hp_label)

func _physics_process(delta: float) -> void:
	if in_battle and battle_target != null:
		battle_timer += delta
		if battle_timer >= ATTACK_INTERVAL:
			battle_timer = 0.0
			attack_player()

func start_battle(player):
	in_battle = true
	battle_target = player
	hp_label.visible = true
	DebugLogger.debug_log("👹 Big Goblin enters battle!")

func attack_player():
	if battle_target != null and battle_target.has_method("take_damage"):
		if animated_sprite:
			animated_sprite.play("attack")
		
		var attack_result = perform_random_attack()
		battle_target.take_damage(attack_result["damage"])
		DebugLogger.debug_log("👹 " + attack_result["message"])
		
		if animated_sprite:
			get_tree().create_timer(0.5).timeout.connect(return_to_idle)

func return_to_idle():
	if animated_sprite and in_battle:
		animated_sprite.play("idle")

func perform_random_attack() -> Dictionary:
	var damage = goblin_damage
	var message = ""
	var random_chance = randf()
	
	if random_chance < DEVASTATING_BLOW_CHANCE:
		damage = int(goblin_damage * 2.5)
		message = "Big Goblin uses DEVASTATING BLOW! -" + str(damage) + " HP 💀"
		return {"damage": damage, "message": message}
	
	if random_chance < (DEVASTATING_BLOW_CHANCE + HAMMER_CRUSH_CHANCE):
		damage = goblin_damage * 2
		message = "Big Goblin uses HAMMER CRUSH! -" + str(damage) + " HP 💥"
		return {"damage": damage, "message": message}
	
	message = "Big Goblin uses HAMMER SMASH! -" + str(goblin_damage) + " HP 🔨"
	return {"damage": goblin_damage, "message": message}

func take_damage(damage: int):
	goblin_hp -= damage
	hp_label.text = "HP: " + str(goblin_hp)
	
	if goblin_hp <= 0:
		die()

func die():
	in_battle = false
	DebugLogger.debug_log("VICTORY!\n💀 Big Goblin defeated!")
	
	if animated_sprite:
		animated_sprite.play("death")
	
	hp_label.visible = true
	
	await get_tree().create_timer(2.0).timeout
	load_next_scene()

func load_next_scene():
	print("Attempting to load scene: ", NEXT_SCENE)
	
	if ResourceLoader.exists(NEXT_SCENE):
		print("Scene exists! Loading...")
		get_tree().change_scene_to_file(NEXT_SCENE)
	else:
		print("ERROR: Next scene not found at path: ", NEXT_SCENE)
		hp_label.text = "ERROR: Scene not found"

func end_battle():
	in_battle = false
	battle_target = null
	hp_label.visible = false
