extends Area





func _on_KeyPickup_body_entered(body):
	if body.is_in_group("Player"):
		PlayerStats.inventory.append("blue key")
		queue_free()

