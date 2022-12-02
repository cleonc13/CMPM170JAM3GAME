extends "res://ActionButton.gd"

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func _on_pressed():
	var enemy = BattleUnits.Enemy
	var playerStats = BattleUnits.PlayerStats
	var my_random_number = rng.randi_range(0, 100) #generate number from 0 to 100
	if enemy != null and playerStats != null:
		if playerStats.mp >= 2:
			enemy.take_damage(max(0, 6 - enemy.shield))
			enemy.take_shield(1)
			playerStats.mp -= 2
			playerStats.ap -= 1

