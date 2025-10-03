extends "res://scripts/PlayerBase.gd"

const FIREBALL_CHANCE = 0.4

func on_ready():
	print("Mage's magic is ready!")

func perform_class_attack() -> Dictionary:
	var damage = player_damage
	var message = ""
	var random_chance = randf()
	
	if random_chance < FIREBALL_CHANCE:
		damage = int(player_damage * 2.5)
		message = "🔥 FIREBALL! -" + str(damage) + " HP"
		return {"damage": damage, "message": message}
	
	if GameState.has_skill("Lightning Bolt") and randf() < 0.3:
		damage = int(player_damage * 2.5)
		message = "⚡ LIGHTNING BOLT! -" + str(damage) + " HP (Chains!)"
		return {"damage": damage, "message": message}
	
	if GameState.has_skill("Ice Shard") and randf() < 0.35:
		damage = player_damage * 2
		message = "❄️ ICE SHARD! -" + str(damage) + " HP (Frozen!)"
		return {"damage": damage, "message": message}
	
	if GameState.has_skill("Meteor") and randf() < 0.15:
		damage = player_damage * 5
		message = "☄️ METEOR! -" + str(damage) + " HP"
		return {"damage": damage, "message": message}
	
	message = "✨ Magic bolt -" + str(damage) + " HP"
	return {"damage": damage, "message": message}

func check_defensive_skills(damage: int) -> int:
	if GameState.has_skill("Mana Shield") and randf() < 0.4:
		var reduced = int(damage * 0.5)
		DebugLogger.debug_log("🔮 MANA SHIELD! Damage reduced from " + str(damage) + " to " + str(reduced))
		return reduced
	
	if GameState.has_skill("Teleport") and randf() < 0.2:
		DebugLogger.debug_log("✨ TELEPORTED! No damage taken!")
		return 0
	
	return damage

func on_victory():
	DebugLogger.debug_log("The mage's power prevails!")

func on_defeat():
	DebugLogger.debug_log("The mage's magic has faded...")
