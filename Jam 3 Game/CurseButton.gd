extends "res://ActionButton.gd"

signal curse()

func _on_pressed():
	var playerStats = BattleUnits.PlayerStats
	if playerStats.ap >= 3 && playerStats.mp >= 1:
		playerStats.ap -= 3
		playerStats.mp -= 1
		emit_signal("curse")
