extends KinematicBody

#basic variables 
var velocity = Vector3()
var gravity = -30 
var max_speed = 8 
var mouse_sensitivty =0.009
var health = 100 

#gun variables 
onready var pistol = preload("res://Scences/Pistol.tscn")
onready var shotgun = preload("res://Scences/Shotgun.tscn")
onready var uzi = preload("res://Scences/Uzi.tscn")
onready var grenadelauncher = preload("res://Scences/GrenadeLauncher.tscn")
onready var knife =preload("res://Scences/Knife.tscn")
onready var flamethrower = preload("res://Scences/FlameThrower.tscn")
var current_gun = 0
onready var carried_guns = [pistol,shotgun,uzi,grenadelauncher,knife,flamethrower]


#functions 
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func get_input():
	var input_dir = Vector3()
	if Input.is_action_pressed("move_forward"):
		input_dir += -global_transform.basis.z
	if Input.is_action_pressed("move_back"):
		input_dir += global_transform.basis.z
	if Input.is_action_pressed("strafe_left"):
		input_dir += -global_transform.basis.x
	if Input.is_action_pressed("strafe_right"):
		input_dir += global_transform.basis.x
	return input_dir
	
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivty)
		$Pivot.rotate_x(-event.relative.y * mouse_sensitivty)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -1.2,1.2)

func _physics_process(delta):
	#gravity
	velocity.y += gravity * delta 
	var desired_velocity = get_input() * max_speed 
	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z
	velocity = move_and_slide(velocity,Vector3.UP, true )
	
func change_gun(gun):
	$Pivot/Gun.get_child(0).queue_free()
	var new_gun = carried_guns[gun].instance()
	$Pivot/Gun.add_child(new_gun)
	PlayerStats.current_gun =new_gun.name
	
func _process(delta):
	if Input.is_action_just_pressed("next_gun"):
		current_gun+= 1
		if current_gun > len(carried_guns)-1:
			current_gun = 0
		change_gun(current_gun)
	elif Input.is_action_just_pressed("prev_gun"):
		current_gun -=1
		if current_gun <0:
			current_gun = len(carried_guns)-1
		change_gun(current_gun)
	elif Input.is_action_just_pressed("use"):
		if $InteractCast.is_colliding():
			if $InteractCast.get_collider().is_in_group("Door"):
				$InteractCast.get_collider().get_node("AnimationPlayer").play("OpenDoor")
				print("Door Open")
			elif $InteractCast.get_collider().is_in_group("Blue Door") and str("blue key") in PlayerStats.inventory:
				$InteractCast.get_collider().get_node("AnimationPlayer").play("OpenDoor")
			elif$InteractCast.get_collider().is_in_group("Red Door") and str("red key") in PlayerStats.inventory:
				$InteractCast.get_collider().get_node("AnimationPlayer").play("OpenDoor")
			else :
				print("No Key")


func player_death():
	if is_in_group("player") and health == 0:
		get_tree().quit()
