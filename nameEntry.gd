extends Control

signal name_submitted(name)

func _on_submit_pressed():
	name_submitted.emit($Name.text)


func _on_name_text_submitted(new_text):
	_on_submit_pressed()
