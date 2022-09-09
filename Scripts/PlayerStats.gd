extends Node
#Player variables
var inventory = []
 
var health = 100
var max_health = 200
var armor = 0
var max_armor = 100
var guns_carried = []
var ammo_pistol = 100
var ammo_grenade = 100
var ammo_shells = 100
var ammo_flame = 100
var ammo_max_pistol = 200
var ammo_max_grenade = 50
var ammo_max_shells = 100
var ammo_max_flame = 200
 
var red_key = false
var blue_key = false
var yellow_key = false
var current_gun = "Pistol"
 
func reset():
	var health = 100
	var max_health = 200
	var armor = 0
	var max_armor = 100
	var guns_carried = []
	var ammo_pistol = 50
	var ammo_grenade = 0
	var ammo_shells = 0
	var ammo_plasma = 0
	var ammo_max_pistol = 200
	var ammo_max_grenade = 50
	var ammo_max_shells = 100
	var ammo_max_flame = 200
	var red_key = false
	var blue_key = false
	var yellow_key = false
	var current_gun = "Pistol"
 
func _ready():
	pass
	
func take_damage(amount):
	var tmp = amount
	if amount > armor:
		amount = amount - armor
		armor = 0
	else:
		change_armor(-amount)
		return
	###apply remaining damage to health
	change_health(-amount)
		
	
func change_health(amount):
	health += amount
	health = clamp(health, 0, max_health)
	
func change_armor(amount):
	armor += amount
	armor = clamp(armor,0,max_armor)
	
func change_pistol_ammo(amount):
	ammo_pistol+=amount
	ammo_pistol = clamp(ammo_pistol,0,ammo_max_pistol)
	
func change_shotgun_ammo(amount):
	ammo_shells+=amount
	ammo_shells = clamp(ammo_shells,0,ammo_max_shells)
	
func change_grenade_ammo(amount):
	ammo_grenade+=amount
	ammo_grenade = clamp(ammo_max_grenade,0,ammo_max_grenade)
	
func change_flame_ammo(amount):
	ammo_flame+=amount
	ammo_flame = clamp(ammo_flame,0,ammo_max_flame)
	
func get_pistol_ammo():
	return str(ammo_pistol)
 
func get_shotgun_ammo():
	return str(ammo_shells)
 
func get_grenade_ammo():
	return str(ammo_grenade)
	
func get_flame_ammo():
	return str(ammo_flame)
	
func get_health():
	return str(health)
 
func get_armor():
	return str(armor)
	
 
