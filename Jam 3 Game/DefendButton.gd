extends "res://ActionButton.gd"

signal defend()

func _on_pressed():
	var playerStats = BattleUnits.PlayerStats
	if (playerStats.ap >= 3):
		playerStats.ap -= 3
		emit_signal("defend")
