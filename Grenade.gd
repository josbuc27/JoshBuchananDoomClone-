extends Area

var grenade_spped = 10 
var grenade_dameage = 50 
var grenade_splash = 25

func deal_dameage(amount):
	var enimies = get_overlapping_bodies()
	for body in enimies:
		if body.is_in_group("Enemy"):
			body.take_dameage(grenade_dameage)
	
func _process(delta):
	translate(Vector3.FORWARD * speed * delta ) 

func _on_Grenade_body_entered(body):
	pass # Replace with function body.


func _on_SplashDamage_body_entered(body):
	pass # Replace with function body.
