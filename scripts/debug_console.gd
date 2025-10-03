extends CanvasLayer

var debug_label: RichTextLabel
var max_lines = 15

func _ready():
	debug_label = RichTextLabel.new()
	debug_label.position = Vector2(10, 10)
	debug_label.size = Vector2(500, 300)
	debug_label.bbcode_enabled = true
	debug_label.scroll_following = true
	
	debug_label.add_theme_color_override("default_color", Color.WHITE)
	debug_label.add_theme_font_size_override("normal_font_size", 14)
	
	add_child(debug_label)
	debug_label.text = "[b]Debug Console[/b]\n"

func add_message(message: String):
	var lines = debug_label.text.split("\n")
	if lines.size() >= max_lines:
		lines.remove_at(1)
	debug_label.text = "\n".join(lines) + "\n" + message

static func log(message: String):
	var console = Engine.get_main_loop().root.get_node_or_null("DebugConsole")
	if console and console.has_method("add_message"):
		console.add_message(message)
