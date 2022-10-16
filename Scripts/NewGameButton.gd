extends Button




func _on_NewGameButton_pressed():
	get_tree().change_scene("res://Scences/World.tscn")
	print("button pressed")
