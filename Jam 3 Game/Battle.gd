extends Node

const BattleUnits = preload("res://BattleUnits.tres")

export(Array, PackedScene) var enemies = []

onready var battleActionButtons = $UI/BattleActionButtons
onready var animationPlayer = $AnimationPlayer
onready var nextRoomButton = $UI/CenterContainer/NextRoomButton
onready var enemyPosition = $EnemyPosition

onready var Player1 = $Player1
onready var Player2 = $Player2
onready var Player3 = $Player3

onready var playerStats = BattleUnits.PlayerStats

onready var sword = $UI/BattleActionButtons/SwordActionButton
onready var enhance = $UI/BattleActionButtons/EnhanceButton
onready var shieldBreaker = $UI/BattleActionButtons/ShieldBreakerButton

onready var shieldAction = $UI/BattleActionButtons/ShieldActionButton
onready var defend = $UI/BattleActionButtons/DefendButton
onready var Warcry = $UI/BattleActionButtons/WarCryButton

onready var heal = $UI/BattleActionButtons/HealActionButton
onready var magic = $UI/BattleActionButtons/MagicButton
onready var curse = $UI/BattleActionButtons/CurseButton
#boss health
#onready var hpLabel = $"Boss (Enemy)/Label"


func _ready():
	randomize()
	start_player_turn()
	var enemy = BattleUnits.Enemy
	if enemy != null:
		enemy.connect("on_death", self, "_on_Enemy_died")

func start_player_turn():
	_on_SwapButton_player_Number_changed(playerStats.player_Number)
#
	battleActionButtons.show()
	playerStats.ap = playerStats.max_ap
	yield(playerStats, "end_turn")
	playerStats.player_Number = (playerStats.player_Number + 1)%3
	start_enemy_turn()
	
func start_enemy_turn():
	battleActionButtons.hide()
	var enemy = BattleUnits.Enemy
	if enemy != null and not enemy.is_queued_for_deletion():
		enemy.attack()
		yield(enemy, "end_turn")
	start_player_turn()
	
func create_new_enemy():
	enemies.shuffle()
	var Enemy = enemies.front()
	var enemy = Enemy.instance()
	enemyPosition.add_child(enemy)
	enemy.connect("on_death", self, "_on_Enemy_died")

func _on_Enemy_died():
	nextRoomButton.show()
	battleActionButtons.hide()

func _on_NextRoomButton_pressed():
	nextRoomButton.hide()
	animationPlayer.play("FadetoNewRoom")
	yield(animationPlayer, "animation_finished")
	var playerStats = BattleUnits.PlayerStats
	playerStats.ap = playerStats.max_ap
	battleActionButtons.show()
	create_new_enemy()


#func _on_AttackButton_pressed():
	#hpLabel.text

func _on_SwapButton_player_Number_changed(value):
	if playerStats.player_Number == 0:
		print(playerStats.player_Number)
		sword.show()
		enhance.show()
		shieldBreaker.show()
		
		shieldAction.hide()
		defend.hide()
		Warcry.hide()
		
		heal.hide()
		magic.hide()
		curse.hide()
		
		Player1.show()
		Player2.hide()
		Player3.hide()
	elif playerStats.player_Number == 1:
		print(playerStats.player_Number)
		heal.show()
		magic.show()
		curse.show()
		
		sword.hide()
		enhance.hide()
		shieldBreaker.hide()
		
		shieldAction.hide()
		defend.hide()
		Warcry.hide()
		
		Player1.hide()
		Player2.show()
		Player3.hide()
	elif playerStats.player_Number == 2:
		print(playerStats.player_Number)
		shieldAction.show()
		defend.show()
		Warcry.show()
		
		sword.hide()
		enhance.hide()
		shieldBreaker.hide()
		
		heal.hide()
		magic.hide()
		curse.hide()
		
		
		Player1.hide()
		Player2.hide()
		Player3.show()
