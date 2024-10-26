extends TextureRect

var waiting_to_sai := []


func _ready() -> void:
	Globals.poti_squellette = self


func talk(what:Array):
	for i in what:
		waiting_to_sai.append(i)
	if waiting_to_sai.size() == what.size():
		_on_button_pressed()
		show()


func _on_button_pressed() -> void:
	if waiting_to_sai.size() == 0:
		hide()
		return
	$text_display.play("show")
	$RichTextLabel.text = waiting_to_sai[0]
	waiting_to_sai.erase(waiting_to_sai[0])
	


func _on__s_timeout() -> void:
	talk(["Well done, you killed them. They weren't many, but they'll definitely keep attacking you with bigger and stronger armies."])
