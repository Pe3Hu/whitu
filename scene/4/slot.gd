class_name Slot extends Node2D


@export var panel: PanelContainer

@onready var essence: Essence

@onready var collision_shape = $CollisionShape2D

#@export var object: DragObject:
	#set(object_):
		#object = object_
		##object.slot = self
	#get:
		#return object
#
#@export var style: StyleBoxFlat = StyleBoxFlat.new()
#
#@export var color: Color:
	#set(color_):
		#color = color_
		#style.bg_color = color
	#get:
		#return color
#
#func _ready():
	#color = Color(Color.SEA_GREEN, 0.2)
	#set("theme_override_styles/panel/", style)
#
#func _process(delta):
	#if Global.flag.is_dragging:
		#color.a = 1
	#else:
		#color.a = 0.5
