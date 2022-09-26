extends Area




func _on_KeyPickuppink_body_entered(body):
	if body.is_in_group("Player"):
		PlayerStats.inventory.append("pink key")
		queue_free()
