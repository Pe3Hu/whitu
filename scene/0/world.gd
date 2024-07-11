extends Node


@export var slot: float = 1.0:
	set(slot_):
		slot = slot_
	get:
		return slot


func _ready() -> void:
	#datas.sort_custom(func(a, b): return a.value < b.value)
	#012 description
	#Global.rng.randomize()
	#var random = Global.rng.randi_range(0, 1)
	pass
