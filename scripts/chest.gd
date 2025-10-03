extends CharacterBody2D

const ATTACK_INTERVAL = 1.7
const NEXT_SCENE = "res://scenes/selection.tscn"

var chest_hp = 100
var chest_damage = 10
var in_battle = false
var battle_target = null
var battle_timer = 0.0
var hp_label = null

func _ready():
	add_to_group("enemies")
	hp_label = Label.new()
	hp_label.position = Vector2(-25, -40)
	hp_label.add_theme_font_size_override("font_size", 16)
	hp_label.text = "HP: " + str(chest_hp)
	hp_label.visible = false
	add_child(hp_label)

func _physics_process(delta: float) -> void:
	if in_battle and battle_target:
		battle_timer += delta
		if battle_timer >= ATTACK_INTERVAL:
			battle_timer = 0.0
			attack_player()

func start_battle(player):
	in_battle = true
	battle_target = player
	hp_label.visible = true

func attack_player():
	if battle_target and battle_target.has_method("take_damage"):
		battle_target.take_damage(chest_damage)

func take_damage(damage: int):
	chest_hp -= damage
	hp_label.text = "HP: " + str(chest_hp)
	if chest_hp <= 0:
		die()

func die():
	in_battle = false
	hp_label.text = "VICTORY!"
	await get_tree().create_timer(1.0).timeout
	load_next_scene()

func load_next_scene():
	if ResourceLoader.exists(NEXT_SCENE):
		get_tree().change_scene_to_file(NEXT_SCENE)

func end_battle():
	in_battle = false
	battle_target = null
	hp_label.visible = false
