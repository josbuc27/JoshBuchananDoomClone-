extends KinematicBody

onready var nav = get_tree().get_nodes_in_group("NavMesh")[0]
onready var player = get_tree().get_nodes_in_group("Player")[0]
onready var ball = preload("res://Scences/Ball.tscn")
onready var spawn_location = $Position3D
var path = [] #hold  the path coordinates from the enemy to the player 
var path_index = 0 #keep track of which coorddinate to go to 
var speed = 3
var health = 20 
var move = true 



var direction = Vector2.ZERO
var searching = false
var shooting = false 
var dead = false
onready var ray = $Visual

var damage = 8

func _ready():
	pass
	
func take_damage(dmg_amount):
	health -= dmg_amount
	if health <= 0:
		death()
		return
		move = false 
	$AnimatedSprite3D.play("hit")
	yield($AnimatedSprite3D, "animation_finished")
#	$AnimatedSprite3D.play("walking")
	move = true 
	
	
	
	
	
func _physics_process(delta):

	if dead:
		return
	look_at_player()
	if searching and not shooting:
		if path_index < path.size(): 
			 direction =(path[path_index] - global_transform.origin)
		if direction.length() < 1:
				path_index += 1
		else:
			if move:
				$AnimatedSprite3D.play("walking")###	
				move_and_slide(direction.normalized()* speed, Vector3.UP)
	else:
		if not shooting:
			$AnimatedSprite3D.play("idle")
		
	
func look_at_player():
	ray.look_at(player.global_transform.origin, Vector3.UP)
	if ray.is_colliding():
		if ray.get_collider().is_in_group("Player"):
			searching = true 
		else:
			searching = false 
			var check_near = $Aural.get_overlapping_bodies()
			for body in check_near:
				if body.is_in_group("Player"):
					searching = true 
	
	
	
	
	
func find_path(target):
	path = nav.get_simple_path(global_transform.origin,target)
	path_index = 0
	

func death():
	dead = true
	#set_process(false)
	#set_physics_process(false)
	$CollisionShape.disabled = true
	if health < -20:
		$AnimatedSprite3D.play("explode") 
	else:
		$AnimatedSprite3D.play("die")
	
	
func shoot():
	if searching and not dead and not shooting:
		$AnimatedSprite3D.play("shoot") and launch_projectile()
		shooting = true
		yield($AnimatedSprite3D,"frame_changed")
		yield($AnimatedSprite3D,"animation_finished")
		launch_projectile()
		shooting = false
	


func _on_Timer_timeout():
	find_path(player.global_transform.origin)






func _on_ShootTimer_timeout():
	shoot()


func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		searching = true 

func launch_projectile():
	var new_ball = load("res://Scences/Ball.tscn").instance()
	get_node("/root/World").add_child(new_ball)
	
	new_ball.global_transform = global_transform
	new_ball.look_at(player)
	


