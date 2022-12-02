extends "res://ActionButton.gd"

signal ShieldBreaker()

func _on_pressed():
	var playerStats = BattleUnits.PlayerStats
	if playerStats.ap >= 2:
		playerStats.ap -= 2
		emit_signal("ShieldBreaker")

