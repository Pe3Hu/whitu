@tool
class_name Vortex extends PanelContainer


@export var mage: Mage

var slot_scene = preload("res://scene/4/slot.tscn")
var essence_scene = preload("res://scene/4/essence.tscn")
var water_resource = preload("res://resource/element/water.tres")
var wind_resource = preload("res://resource/element/wind.tres")
var fire_resource = preload("res://resource/element/fire.tres")
var earth_resource = preload("res://resource/element/earth.tres")

@onready var essences = $Essences
@onready var slots = $Slots

var limit = 6
var col = 6
var occupied_slots: Array[Slot]
var accessible_slots: Array[Slot]


func _ready() -> void:
	await get_tree().process_frame
	
	for _i in limit:
		add_slot()
	
	for _i in 3:
		add_essence()
	
	random_fill()
	#mage.conveyor.add_spell(mage.spell)
	#mage.spell.reset()

func add_slot() -> void:
	var slot = slot_scene.instantiate()
	var index = slots.get_child_count()
	var grid = Vector2(index % limit, index / limit) + Vector2.ONE * 0.5
	slot.position = Global.vec.size.slot * grid
	slots.add_child(slot)
	accessible_slots.append(slot)
	slot.panel = self
	
func add_essence() -> void:
	var slot = accessible_slots.pop_front()
	occupied_slots.append(slot)
	var essence = essence_scene.instantiate()
	essences.add_child(essence)
	
	var element = Global.arr.element.pick_random()
	var resource = get(element+"_resource")
	essence.element = resource
	essence.value = resource.values.pick_random()
	essence.panel = self
	essence.slots.append(slot)
	essence.move_to_nearest_slot(0)
	
func random_fill() -> void:
	var n = 3
	var orders = []
	orders.append_array(Global.arr.order)
	orders.shuffle()
	
	for _i in n:
		var slot = occupied_slots.back()
		var order = orders.pop_back()
		var offense_slot = mage.offense.slots.get_child(order)
		slot.essence.slot = offense_slot
		offense_slot.essence.move_to_nearest_slot(0)
