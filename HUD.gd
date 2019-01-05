extends CanvasLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	$BigMessage.add_color_override("font_color", Color(0, 0, 0))
	$BigMessage.add_color_override("font_color_shadow", Color(1, 1, 1))

func show_message(text):
	$BigMessage.text = text
	$BigMessage.show()


func hide_message():
	$BigMessage.hide()
	pass
