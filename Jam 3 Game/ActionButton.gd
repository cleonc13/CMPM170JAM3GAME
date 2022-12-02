extends Button

const BattleUnits = preload("res://BattleUnits.tres")

signal player_Number_changed(value)

func _on_pressed():
	var playerStats = BattleUnits.PlayerStats
	if playerStats != null:
		playerStats.player_Number = (playerStats.player_Number + 1)%3
		emit_signal("player_Number_changed", playerStats.player_Number)
		print(playerStats.player_Number)
