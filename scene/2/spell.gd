@tool
class_name Spell extends PanelContainer


var slot_scene = preload("res://scene/4/slot.tscn")

#@export_enum("creation", "preparation", "realization") var phase: String = "creation":
	#set(phase_):
		#phase = phase_
		#
		#match phase:
			#"creation","realization":
				#for slot in slots.get_children():
					#slot.cover.visible = false
					#slot.essence.visible = true
			#"preparation":
				#for slot in slots.get_children():
					#slot.cover.visible = true
					#slot.essence.visible = false
	#get:
		#return phase

@onready var essences = $Essences
@onready var slots = $Slots
@onready var covers = $Covers

var limit = 7
var occupied_slots: Array[Slot]
var accessible_slots: Array[Slot]


func _ready() -> void:
	await get_tree().process_frame
	
	for _i in limit:
		add_slot()
	
func add_slot() -> void:
	var slot = slot_scene.instantiate()
	var index = slots.get_child_count()
	var grid = Vector2(index % limit, index / limit) + Vector2.ONE * 0.5
	slot.position = Global.vec.size.slot * grid
	slots.add_child(slot)
	slot.panel = self
