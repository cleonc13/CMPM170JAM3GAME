extends Node2D

const BattleUnits = preload("res://BattleUnits.tres")

export (int) var hp = 25 setget set_hp
export (int) var damage = 3

onready var hpLabel = $HpLabel
onready var animationPlayer = $AnimationPlayer

signal on_death
signal end_turn

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
	BattleUnits.PlayerStats.hp -= damage
	
func is_dead():
	return hp <= 0
	
func take_damage(amount):
	self.hp -= amount
	if is_dead():
		emit_signal("on_death")
		queue_free()
	else:
		animationPlayer.play("Shake")
