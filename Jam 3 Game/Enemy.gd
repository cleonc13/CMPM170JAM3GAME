extends Node2D

const BattleUnits = preload("res://BattleUnits.tres")

export (int) var hp = 25 setget set_hp
export (int) var damage = 3
export (int) var shield = 5 setget set_shield

onready var hpLabel = $HpLabel
onready var animationPlayer = $AnimationPlayer
onready var shieldLabel = $ShieldLabel

#Nick's Vars
var move = 0
var rng = RandomNumberGenerator.new()

signal on_death
signal end_turn

func set_shield(new_shield):
	shield = new_shield
	if shieldLabel != null:
		shieldLabel.text = str(shield) + "shield"

func take_shield(shieldamount):
	if self.shield == 0:
		shieldamount = 0
	else:
		self.shield -= max(shieldamount, 0)


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
			BattleUnits.PlayerStats.hp -= damage
		5:
			BattleUnits.PlayerStats.hp -= damage + 1
		8:
			BattleUnits.PlayerStats.hp -= damage + 2
		9,14:
			BattleUnits.PlayerStats.hp -= damage + 3
		3:
			self.hp += 3
			set_hp(self.hp);
		6,15:
			self.hp += 5
			set_hp(self.hp);
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
		
