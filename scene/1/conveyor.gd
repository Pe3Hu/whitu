class_name Conveyor extends PanelContainer


@export var mage: Mage

@onready var spells = $Spells

var spell_scene = preload("res://scene/2/spell.tscn")


func add_spell(donor_) -> void:
	var spell = spell_scene.instantiate()
	spells.add_child(spell)
	spell.replicate(donor_)
	#spell.phase = "preparation"
