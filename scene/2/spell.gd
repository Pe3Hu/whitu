@tool
class_name Spell extends PanelContainer


@export_enum("creation", "preparation", "realization") var phase: String = "creation":
	set(phase_):
		phase = phase_
		
		match phase:
			"creation","realization":
				for rune in runes.get_children():
					rune.cover.visible = false
					rune.essence.visible = true
			"preparation":
				for rune in runes.get_children():
					rune.cover.visible = true
					rune.essence.visible = false
	get:
		return phase

@onready var runes = $Runes

var essences: Dictionary

func replicate(donor_: Spell) -> void:
	for _i in donor_.runes.get_child_count():
		var donor_rune = donor_.runes.get_child(_i)
		var rune = runes.get_child(_i)
		rune.essence.replicate(donor_rune.essence)
	
func place_essence_at(essence_: Essence, order_: int) -> void:
	var rune = runes.get_child(order_)
	essences[essence_] = rune
	rune.essence.replicate(essence_)
	
func reset() -> void:
	for rune in runes.get_children():
		rune.reset()
