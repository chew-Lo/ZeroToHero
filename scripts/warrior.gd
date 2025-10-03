extends "res://scripts/PlayerBase.gd"

const DOUBLE_STRIKE_CHANCE = 0.3

func on_ready():
	print("Warrior ready for battle!")

func perform_class_attack() -> Dictionary:
	var damage = player_damage
	var message = ""
	var random_chance = randf()
	
	if random_chance < DOUBLE_STRIKE_CHANCE:
		damage = player_damage * 2
		message = "⚔️ DOUBLE STRIKE! -" + str(damage) + " HP"
		return {"damage": damage, "message": message}

	if GameState.has_skill("Shield Bash") and randf() < 0.3:
		damage = int(player_damage * 1.5)
		message = "🛡️ SHIELD BASH! -" + str(damage) + " HP (Stuns!)"
		return {"damage": damage, "message": message}
	
	if GameState.has_skill("Berserker Rage") and randf() < 0.2:
		damage = player_damage * 3
		message = "😡 BERSERKER RAGE! -" + str(damage) + " HP"
		return {"damage": damage, "message": message}
	
	# Check for Whirlwind skill (25% chance to hit twice)
	if GameState.has_skill("Whirlwind") and randf() < 0.25:
		damage = player_damage * 2
		message = "🌪️ WHIRLWIND! -" + str(damage) + " HP"
		return {"damage": damage, "message": message}
	
	message = "⚔️ Sword slash -" + str(damage) + " HP"
	return {"damage": damage, "message": message}

func check_defensive_skills(damage: int) -> int:
	if GameState.has_skill("Shield Block") and randf() < 0.25:
		DebugLogger.debug_log("[color=cyan]🛡️ BLOCKED! No damage taken![/color]")
		return 0
	
	if GameState.has_skill("Iron Skin"):
		var reduced = int(damage * 0.7)
		DebugLogger.debug_log("[color=cyan]🛡️ Iron Skin! Damage reduced from " + str(damage) + " to " + str(reduced) + "[/color]")
		return reduced
	
	return damage 

func on_victory():
	DebugLogger.debug_log("Warrior stands victorious!")

func on_defeat():
	DebugLogger.debug_log("The warrior has fallen...")
