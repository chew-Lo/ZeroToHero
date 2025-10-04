extends "res://scripts/PlayerBase.gd"

const DOUBLE_PUNCH_CHANCE = 0.25 

func on_ready():
	player_hp = 100
	player_damage = 10
	player_class = "noob"
	
	if hp_label:
		hp_label.text = "HP: " + str(player_hp)
	
	DebugLogger.debug_log("A young boy's village was raided by goblins who captured his family.")
	DebugLogger.debug_log("He grabbed nothing but his courage and set off a journey to save them.")

func perform_class_attack() -> Dictionary:
	var result = {"damage": player_damage, "message": ""}
	var random_chance = randf()
	
	if random_chance < DOUBLE_PUNCH_CHANCE:
		result["damage"] = player_damage * 2
		result["message"] = "👊DOUBLE PUNCH! -" + str(result["damage"]) + " HP"
	else:
		result["message"] = "👊 Punch -" + str(result["damage"]) + " HP"
	
	return result

func on_victory():
	DebugLogger.debug_log("Noob wins!")

func on_defeat():
	DebugLogger.debug_log("Noob has been defeated...")
