extends Node2D

const WARRIOR_SKILLS = [
	{"name": "Shield Bash", "description": "30% chance to deal 1.5x damage and stun"},
	{"name": "Berserker Rage", "description": "20% chance to deal 3x damage"},
	{"name": "Whirlwind", "description": "25% chance to hit twice"},
	{"name": "Shield Block", "description": "25% chance to block all damage"},
	{"name": "Iron Skin", "description": "Reduce all damage by 30%"}
]

const ARCHER_SKILLS = [
	{"name": "Multi-Shot", "description": "30% chance to fire multiple arrows (2x damage)"},
	{"name": "Piercing Arrow", "description": "25% chance to deal 4x damage"},
	{"name": "Poison Arrow", "description": "35% chance to poison enemy (1.5x + DoT)"},
	{"name": "Evasion", "description": "30% chance to dodge attacks completely"}
]

const MAGE_SKILLS = [
	{"name": "Lightning Bolt", "description": "30% chance for chain lightning (2.5x damage)"},
	{"name": "Ice Shard", "description": "35% chance to freeze and damage (2x)"},
	{"name": "Meteor", "description": "15% chance for devastating impact (5x damage)"},
	{"name": "Mana Shield", "description": "40% chance to absorb 50% damage"},
	{"name": "Teleport", "description": "20% chance to dodge attacks"}
]

# Attribute bonuses
const HP_BONUS = 50
const DAMAGE_BONUS = 10

var selected_skill = null

func _ready():
	$SkillButton.pressed.connect(_on_new_skill_selected)
	$AttributeButton.pressed.connect(_on_attributes_selected)
	
	selected_skill = get_random_available_skill()
	
	update_skill_display()

func get_random_available_skill() -> Dictionary:
	var player_class = GameState.player_class
	var skill_pool = []
	
	match player_class:
		"warrior":
			skill_pool = WARRIOR_SKILLS
		"archer":
			skill_pool = ARCHER_SKILLS
		"mage":
			skill_pool = MAGE_SKILLS
	
	var available_skills = []
	for skill in skill_pool:
		if not GameState.has_skill(skill["name"]):
			available_skills.append(skill)
	
	if available_skills.is_empty():
		return {"name": "Power Boost", "description": "All abilities strengthened!"}
	
	return available_skills[randi() % available_skills.size()]

func update_skill_display():
	var skill_text = "NEW SKILL\n" + selected_skill["name"] + "\n" + selected_skill["description"]
	
	if $SkillButton.has_node("Label"):
		$SkillButton.get_node("Label").text = skill_text
	
	var attr_text = "ADDITIONAL ATTRIBUTES\n+%d HP, +%d Damage" % [HP_BONUS, DAMAGE_BONUS]
	if $AttributeButton.has_node("Label"):
		$AttributeButton.get_node("Label").text = attr_text

func _on_new_skill_selected():
	print("Player chose new skill: ", selected_skill["name"])
	
	GameState.add_skill(selected_skill)
	
	DebugLogger.debug_log("✨ New skill learned: " + selected_skill["name"] + "!")
	
	continue_game()

func _on_attributes_selected():
	print("Player chose attribute boost")
	
	GameState.player_hp += HP_BONUS
	GameState.player_damage += DAMAGE_BONUS
	
	DebugLogger.debug_log("💪 Attributes increased! HP +%d, Damage +%d" % [HP_BONUS, DAMAGE_BONUS])
	
	continue_game()

func continue_game():
	await get_tree().create_timer(1.5).timeout
	
	get_tree().change_scene_to_file("res://scenes/battle_2.tscn")
