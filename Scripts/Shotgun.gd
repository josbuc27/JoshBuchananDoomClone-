extends Spatial

onready var gun_sprite = $CanvasLayer/Control/GunSprite
onready var gun_rays = $GunRays.get_children()
onready var flash = preload("res://Scences/MuzzleFlash.tscn")
onready var blood = preload("res://Scences/Blood.tscn")
export var damage = 8 
export var can_flash = true
var can_shoot = true 
export var rapid_fire = false 


func _ready():
	gun_sprite.play("idle")
	
func check_hit():
	for ray in gun_rays:
		if ray.is_colliding():
			if ray.get_collider().is_in_group("Enemy"):
				ray.get_collider().take_damage(damage)
				var new_blood = blood.instance()
				get_node("/root/World").add_child(new_blood)
				new_blood.global_transform.origin = ray.get_collision_point()
				new_blood.emitting = true



func make_flash():	
	var f = flash.instance()
	add_child(f)
	
func _process(delta):
	if Input.is_action_just_pressed("shoot") and can_shoot and PlayerStats.ammo_shells> 0:
		gun_sprite.play("shoot")
		if can_flash:
			make_flash()
		check_hit()
		can_shoot = false 
		PlayerStats.change_shotgun_ammo(-1)
		yield (gun_sprite,"animation_finished")
		
		can_shoot = true 
		gun_sprite.play("idle")


func _on_Timer_timeout():
	can_shoot = true  # Replace with function body.
