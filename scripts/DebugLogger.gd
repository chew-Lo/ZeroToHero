extends CanvasLayer

@onready var debug_label = $Panel/RichTextLabel
@onready var panel = $Panel

var message_history: Array = []
var max_messages = 4
var dragging = false
var drag_offset = Vector2.ZERO

func _ready():
	if debug_label == null:
		push_error("DebugLogger: RichTextLabel not found!")
		return
	
	debug_label.bbcode_enabled = true
	debug_label.scroll_following = true
	debug_label.fit_content = true
	debug_label.add_theme_color_override("default_color", Color.WHITE)
	debug_label.add_theme_font_size_override("normal_font_size", 13)
	
	if panel:
		panel.mouse_filter = Control.MOUSE_FILTER_STOP

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		dragging = event.pressed and panel and panel.get_global_rect().has_point(event.position)
		if dragging:
			drag_offset = event.position - panel.position
	
	elif event is InputEventMouseMotion and dragging and panel:
		panel.position = event.position - drag_offset

func debug_log(message: String):
	if debug_label == null:
		print(message)
		return
	
	message_history.append(message)
	if message_history.size() > max_messages:
		message_history.remove_at(0)
	
	debug_label.text = "\n".join(message_history)
	print(message)
