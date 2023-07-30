extends Control

signal name_submitted(name)

func _on_submit_pressed():
	name_submitted.emit($Name.text)
