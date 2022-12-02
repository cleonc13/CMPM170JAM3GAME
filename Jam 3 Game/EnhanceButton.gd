extends "res://ActionButton.gd"


func _on_pressed():
	var playerStats = BattleUnits.PlayerStats
	if playerStats != null:
		playerStats.ap -= 1
		playerStats.crit -= 15
