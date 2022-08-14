extends Area


var grenade_speed = 15
var grenade_damage = 25
var grenade_splash = 25

func deal_damage():
	var enimies = get_overlapping_bodies()
	for body in enimies:
		if body.is_in_group("Enemy"):
			body.take_damage(grenade_damage)
	enimies =$SplashDamage.get_overlapping_bodies()
	for body in enimies:
		if body.is_in_group("Enemy"):
			body.take_damage(grenade_damage)
		
	
func _process(delta):
	translate(Vector3.FORWARD * grenade_speed * delta ) 

func _on_Grenade_body_entered(body):
	if body.is_in_group("Player"):
		return
	set_process(false)
	$AnimatedSprite3D.play("explode")
	deal_damage()
	yield($AnimatedSprite3D,"animation_finished")
	queue_free()


func _on_SplashDamage_body_entered(body):
	pass # Replace with function body.
