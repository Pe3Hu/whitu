class_name Vortex extends PanelContainer


@export var mage: Mage

var essence_scene = preload("res://scene/3/essence.tscn")
var water_resource = preload("res://resource/element/water.tres")
var wind_resource = preload("res://resource/element/wind.tres")
var fire_resource = preload("res://resource/element/fire.tres")
var earth_resource = preload("res://resource/element/earth.tres")

@onready var essences = $Essences


func _ready() -> void:
	await get_tree().process_frame
	for _i in 3:
		add_essence()
	
	random_fill()
	mage.conveyor.add_spell(mage.spell)
	mage.spell.reset()


func add_essence() -> void:
	var essence = essence_scene.instantiate()
	essences.add_child(essence)
	var element = Global.arr.element.pick_random()
	var resource = get(element+"_resource")
	essence.element = resource
	essence.value = resource.values.pick_random()


func random_fill() -> void:
	var n = 3
	var orders = []
	orders.append_array(Global.arr.order)
	orders.shuffle()
	
	for _i in n:
		var essence = essences.get_child(0)
		essences.remove_child(essence)
		var order = orders.pop_back()
		mage.spell.place_essence_at(essence, order)
