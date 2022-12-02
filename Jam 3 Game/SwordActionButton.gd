extends "res://ActionButton.gd"

const Slash = preload("res://Slash.tscn")

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func _on_pressed():
	var enemy = BattleUnits.Enemy
	var playerStats = BattleUnits.PlayerStats
	var my_random_number = rng.randi_range(0, 100) #generate number from 0 to 100
	if enemy != null and playerStats != null:
		create_slash(enemy.global_position)
		print(playerStats.crit)
		if my_random_number >= max(playerStats.crit, 30): #will either be crit chance of crit or 30
			enemy.take_damage(max(0, 8 - enemy.shield))
		else:
			enemy.take_damage(max(0, 4 - enemy.shield))
		enemy.take_shield(1)
		playerStats.mp += 2
		playerStats.ap -= 1

func create_slash(position):
	var slash = Slash.instance()
	var main = get_tree().current_scene
	main.add_child(slash)
	slash.global_position = position



#extends "res://ActionButton.gd"
#
#const Slash = preload("res://Slash.tscn")
#
#func _on_pressed():
#	var enemy = BattleUnits.Enemy
#	var playerStats = BattleUnits.PlayerStats
#	if enemy != null and playerStats != null:
#		create_slash(enemy.global_position)
#		enemy.take_damage(4)
#		playerStats.mp += 2
#		playerStats.ap -= 1
#
#func create_slash(position):
#	var slash = Slash.instance()
#	var main = get_tree().current_scene
#	main.add_child(slash)
#	slash.global_position = position
