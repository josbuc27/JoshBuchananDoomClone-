extends Area




func _on_KeyPickupred_body_entered(body):
	if body.is_in_group("Player"):
		PlayerStats.inventory.append("red key")
		queue_free()
