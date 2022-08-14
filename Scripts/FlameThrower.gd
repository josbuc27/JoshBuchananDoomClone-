extends Spatial


var can_shoot = true 
onready var gunsprite = $CanvasLayer/Control/GunSprite
onready var spawn_location = $Position3D
onready var flame = preload("res://Scences/Flames.tscn")


func launch_projectile():
	var new_flame = flame.instance()
	get_node("/root/World").add_child(new_flame)
	new_flame.global_transform = spawn_location.global_transform
	
	
func _process(delta):
	if Input.is_action_pressed("shoot") and can_shoot and  PlayerStats.ammo_flame> 0:
		gunsprite.play("shoot")
		launch_projectile()
		can_shoot = false
		PlayerStats.change_flame_ammo(-1)
		yield(gunsprite,"animation_finished")
		can_shoot = true
		gunsprite.play("idle")
