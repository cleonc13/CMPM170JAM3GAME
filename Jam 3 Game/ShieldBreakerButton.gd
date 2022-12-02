extends "res://ActionButton.gd"


func _on_pressed():
	var enemy = BattleUnits.Enemy
	var playerStats = BattleUnits.PlayerStats
	if enemy != null and playerStats != null:
		enemy.take_shield(4)
		playerStats.ap -= 2

