extends "res://ActionButton.gd"

signal warcry()

func _on_pressed():
	var playerStats = BattleUnits.PlayerStats
	if playerStats != null:
		if playerStats.ap >= 2:
			playerStats.ap -= 2
			emit_signal("warcry")
