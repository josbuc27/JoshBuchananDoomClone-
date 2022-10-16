extends Button



func _on_ControlsButton_pressed():
	get_tree().change_scene("res://Scences/Options.tscn")
	print("button pressed")
