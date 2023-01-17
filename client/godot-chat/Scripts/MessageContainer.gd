extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var messages: RichTextLabel
# Called when the node enters the scene tree for the first time.
func _ready():
	messages = $messages
	messages.bbcode_enabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Control_addToMessageLog(message):
	messages.text += message
	messages.newline()
