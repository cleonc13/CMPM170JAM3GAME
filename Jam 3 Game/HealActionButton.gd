extends "res://ActionButton.gd"

func _on_pressed():
	var playerStats = BattleUnits.PlayerStats
	if playerStats != null:
		if playerStats.mp >= 2:
			playerStats.hp += 5
			playerStats.mp -= 2
			playerStats.ap -= 1
