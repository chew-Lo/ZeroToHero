extends Node2D

func _ready():
	DebugLogger.debug_log("The battle was over!")
	DebugLogger.debug_log("his family waited—scared, but alive.")
	DebugLogger.debug_log("They went home together.")
	DebugLogger.debug_log("The boy who left with nothing returned as a legend.")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/intro.tscn")
