extends Node2D

const BattleUnits = preload("res://BattleUnits.tres")

export (int) var hp = 25 setget set_hp
export (int) var damage = 3
export (int) var shield = 10 setget set_shield

onready var hpLabel = $HpLabel
onready var animationPlayer = $AnimationPlayer
onready var shieldLabel = $ShieldLabel

#Nick's Vars
var move = 0
var rng = RandomNumberGenerator.new()
var curse_flag = 0
var cry = 0;
var defend = 0


signal on_death
signal end_turn

func set_shield(new_shield):
	shield = new_shield
	if shieldLabel != null:
		shieldLabel.text = str(shield) + "shield"

func take_shield(shieldamount):
	if self.shield <= 0:
		shieldamount = 0
		self.shield = 0
	else:
		print(self.shield)
		self.shield -= max(shieldamount, 0)
		if self.shield <= 0:
			self.shield = 0

func set_hp(new_hp):
	hp = new_hp
	if hpLabel != null:
		hpLabel.text = str(hp) + "hp"
	
func _ready():
	BattleUnits.Enemy = self

func _exit_tree():
	BattleUnits.Enemy = null


func attack() -> void:
	yield(get_tree().create_timer(0.4), "timeout")
	animationPlayer.play("Attack")
	yield(animationPlayer, "animation_finished")
	emit_signal("end_turn")
	
func deal_damage():
	if move > 15:
		move = 0
	set_moves(move)
	move += 1
	
	
func is_dead():
	return hp <= 0
	
func take_damage(amount):
	self.hp -= amount
	if is_dead():
		emit_signal("on_death")
		queue_free()
	else:
		animationPlayer.play("Shake")

func set_moves(move_set):
	var ran_num = rng.randi_range(0,3)
	move_set = move_set + ran_num;
	
	if move_set > 15:
		move_set = 15
	
	#Attack dmg
	match move_set:
		0,1,2:
			if defend == 0:
				BattleUnits.PlayerStats.hp -= (damage - cry)
				cry = 0
			else:
				defend = 0
		5:
			if defend == 0:
				BattleUnits.PlayerStats.hp -= (damage + 1 - cry)
				cry = 0
			else:
				defend = 0
		8:
			if defend == 0:
				BattleUnits.PlayerStats.hp -= (damage + 2 - cry)
				cry = 0
			else:
				defend = 0
		9,14:
			if defend == 0:
				BattleUnits.PlayerStats.hp -= (damage + 3 - cry)
				cry = 0
			else:
				defend = 0
		3:
			if curse_flag == 0:
				self.hp += 3
				set_hp(self.hp);
			else:
				print("Heal negated")
				curse_flag = 0
		6,15:
			if curse_flag == 0:
				self.hp += 5
				set_hp(self.hp);
			else:
				print("Heal negated")
				curse_flag = 0
		4,7:
			BattleUnits.PlayerStats.ap -= damage + 2
		10,12,13:
			BattleUnits.PlayerStats.mp -= damage 


#extends Node2D
#
#const BattleUnits = preload("res://BattleUnits.tres")
#
#export (int) var hp = 25 setget set_hp
#export (int) var damage = 3
#
#onready var hpLabel = $HpLabel
#onready var animationPlayer = $AnimationPlayer
#
#signal on_death
#signal end_turn
#
#func set_hp(new_hp):
#	hp = new_hp
#	if hpLabel != null:
#		hpLabel.text = str(hp) + "hp"
#
#func _ready():
#	BattleUnits.Enemy = self
#
#func _exit_tree():
#	BattleUnits.Enemy = null
#
#
#func attack() -> void:
#	yield(get_tree().create_timer(0.4), "timeout")
#	animationPlayer.play("Attack")
#	yield(animationPlayer, "animation_finished")
#	emit_signal("end_turn")
#
#func deal_damage():
#	BattleUnits.PlayerStats.hp -= damage
#
#func is_dead():
#	return hp <= 0
#
#func take_damage(amount):
#	self.hp -= amount
#	if is_dead():
#		emit_signal("on_death")
#		queue_free()
#	else:
#		animationPlayer.play("Shake")
		


func _on_ShieldBreakerButton_ShieldBreaker():
	take_shield(4)


func _on_CurseButton_curse():
	curse_flag = 1


func _on_WarCryButton_warcry():
	cry = 3


func _on_DefendButton_defend():
	defend = 1
