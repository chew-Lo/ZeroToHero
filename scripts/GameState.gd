extends Node

static var selected_character_path: String = ""
static var player_class: String = ""
static var player_hp: int = 0
static var player_damage: int = 0

static var player_skills: Array = []

static func set_player_stats(class_type: String, hp: int, damage: int):
	player_class = class_type
	player_hp = hp
	player_damage = damage

static func get_player_stats():
	return {
		"class": player_class,
		"hp": player_hp,
		"damage": player_damage
	}

static func add_skill(skill: Dictionary):
	player_skills.append(skill)
	print("Skill added: ", skill["name"])

static func has_skill(skill_name: String) -> bool:
	for skill in player_skills:
		if skill["name"] == skill_name:
			return true
	return false

static func get_skills() -> Array:
	return player_skills

static func reset_run():
	player_skills.clear()
	selected_character_path = ""
	player_class = ""
	player_hp = 0
