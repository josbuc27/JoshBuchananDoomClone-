extends Area



var ball_speed = 15
var ball_damage = 25
var ball_splash = 25

func deal_damage():
	var enimies = get_overlapping_bodies()
	for body in enimies:
		if body.is_in_group("Player"):
			body.take_damage(ball_damage)
	enimies =$SplashDamage.get_overlapping_bodies()
	for body in enimies:
		if body.is_in_group("Player"):
			body.take_damage(ball_damage)
		
	
func _process(delta):
	translate(Vector3.FORWARD * ball_speed * delta ) 

func _on_Ball_body_entered(body):
	if body.is_in_group("Enemy"):
		return
	set_process(false)
	$AnimatedSprite3D.play("explode")
	deal_damage()
	yield($AnimatedSprite3D,"animation_finished")
	queue_free()


func _on_SplashDamage_body_entered(body):
	pass # Replace with function body.



