extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal message_sent(message)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func sendMessage():
	emit_signal("message_sent", $MessageInputBox.text)
	$MessageInputBox.text = ''
	
func _on_MessageInputBox_text_entered(new_text):
	sendMessage()


func _on_SendButton_pressed():
	sendMessage()
