extends Area

var flame_speed = 30
var flame_damage = 1

func _ready():
	$AnimatedSprite3D.play("explode")
	yield($AnimatedSprite3D,"animation_finished")
	queue_free()

func deal_damage():
	var enimies = get_overlapping_bodies()
	for body in enimies:
		if body.is_in_group("Enemy"):
			body.take_damage(flame_damage)
	enimies =$SplashDamage.get_overlapping_bodies()
	for body in enimies:
		if body.is_in_group("Enemy"):
			body.take_damage(flame_damage)
		
	
func _process(delta):
	translate(Vector3.FORWARD * flame_speed * delta ) 

func _on_Flames_body_entered(body):
	if body.is_in_group("Player"):
		return
	#set_process(false)
	deal_damage()
	


