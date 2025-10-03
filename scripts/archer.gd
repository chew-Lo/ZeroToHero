extends "res://scripts/PlayerBase.gd"

const CRITICAL_ARROW_CHANCE = 0.35

func on_ready():
	print("Archer ready to shoot!")

func perform_class_attack() -> Dictionary:
	var damage = player_damage
	var message = ""
	var random_chance = randf()
	
	if random_chance < CRITICAL_ARROW_CHANCE:
		damage = player_damage * 3
		message = "🏹 CRITICAL ARROW! -" + str(damage) + " HP"
		return {"damage": damage, "message": message}
	
	if GameState.has_skill("Multi-Shot") and randf() < 0.3:
		damage = player_damage * 2
		message = "🏹🏹 MULTI-SHOT! -" + str(damage) + " HP"
		return {"damage": damage, "message": message}
	
	if GameState.has_skill("Piercing Arrow") and randf() < 0.25:
		damage = player_damage * 4
		message = "🎯 PIERCING ARROW! -" + str(damage) + " HP"
		return {"damage": damage, "message": message}
	
	if GameState.has_skill("Poison Arrow") and randf() < 0.35:
		damage = int(player_damage * 1.5)
		message = "☠️ POISON ARROW! -" + str(damage) + " HP (Poisoned!)"
		return {"damage": damage, "message": message}
	
	# Normal attack
	message = "🏹 Arrow shot -" + str(damage) + " HP"
	return {"damage": damage, "message": message}

func check_defensive_skills(damage: int) -> int:
	if GameState.has_skill("Evasion") and randf() < 0.3:
		DebugLogger.debug_log("[color=cyan]💨 EVADED! No damage taken![/color]")
		return 0
	
	return damage

func on_victory():
	DebugLogger.debug_log("Archer's aim was true!")

func on_defeat():
	DebugLogger.debug_log("The archer's last arrow has been fired...")
