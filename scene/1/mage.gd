class_name Mage extends PanelContainer


@onready var vortex = $VBox/Vortex
@onready var defense = $VBox/Defense
@onready var offense = $VBox/Offense


func release_offense() -> void:
	offense.occupied_slots
