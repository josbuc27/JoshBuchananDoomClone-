extends Spatial


var can_shoot = true 
onready var gunsprite = $CanvasLayer/Control/GunSprite
onready var spawn_location = $Position3D
onready var grenade = preload("res://Scences/Grenade.tscn")

func launch_projectile():
	var new_grenade = grenade.instance()
	get_node("/root/World").add_child(new_grenade)
	new_grenade.global_transform = spawn_location.global_transform
	
	
func _process(delta):
	if Input.is_action_just_pressed("shoot") and can_shoot:
		gunsprite.play("shoot")
		launch_projectile()
		can_shoot = false
		yield(gunsprite,"animation_finished")
		can_shoot = true
		gunsprite.play("idle")
