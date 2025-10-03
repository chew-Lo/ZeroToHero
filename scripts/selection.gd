extends Node2D

const WARRIOR_SCENE = "res://scenes/characters/warrior.tscn"
const ARCHER_SCENE = "res://scenes/characters/archer.tscn"
const MAGE_SCENE = "res://scenes/characters/mage.tscn"

func _ready():
	$warriorButton.pressed.connect(_on_warrior_selected)
	$ArcherButton.pressed.connect(_on_archer_selected)
	$MageButton.pressed.connect(_on_mage_selected)

func _on_warrior_selected():
	GameState.set_player_stats("warrior", 175, 18)
	GameState.selected_character_path = WARRIOR_SCENE
	print("Warrior selected! HP: 175, Damage: 15")
	start_game()

func _on_archer_selected():
	GameState.set_player_stats("archer", 125, 25)
	GameState.selected_character_path = ARCHER_SCENE
	print("Archer selected! HP: 125, Damage: 25")
	start_game()

func _on_mage_selected():
	GameState.set_player_stats("mage", 100, 35)
	GameState.selected_character_path = MAGE_SCENE
	print("Mage selected! HP: 100, Damage: 35")
	start_game()

func start_game():
	get_tree().change_scene_to_file("res://scenes/Character_scene.tscn")
