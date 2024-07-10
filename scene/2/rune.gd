@tool
class_name Rune extends PanelContainer


var void_resource = preload("res://resource/element/void.tres")

#@export_range(1.0, 3.0, 0.5) var zoom: float = 1.0:
	#set(zoom_):
		#zoom = zoom_
		#
		#cell_size = base_cell_size * zoom
		#update_weight_lines()
	#get:
		#return zoom
#
#@export var cell_size: Vector2 = Vector2(32, 32):
	#set(cell_size_):
		#cell_size = cell_size_
		#
		#custom_minimum_size = cell_size * 3
		#size = cell_size * 3
		#
		#var elements = get_tree().get_nodes_in_group("rune_elements")
		#
		#for element in elements:
			#element.custom_minimum_size = custom_minimum_size / 2#cell_size * 3
			#element.size = custom_minimum_size / 2#cell_size * 3
		#
		#var values = get_tree().get_nodes_in_group("rune_values")
		#
		#for value in values:
			#value.custom_minimum_size = custom_minimum_size / 3#cell_size * 2
			#value.size = custom_minimum_size / 3#cell_size * 2
			#value.set("theme_override_font_sizes/font_size", zoom * 4)
		#
		##var offset = int(zoom )
		##%Values.set("theme_override_constants/h_separation", offset)
		##%Values.set("theme_override_constants/v_separation", offset)
	#get:
		#return cell_size
#const anchors = [[Vector2(0, 1), Vector2(1, 2)], [Vector2(0, 0), Vector2(2, 2)], [Vector2(1, 0), Vector2(2, 1)]]
#const shifts = [-Vector2.ONE, Vector2.ONE]
#const base_cell_size = Vector2(4, 4)
#const line_widht = 4
#func update_weight_lines() -> void:
	#var weights = get_tree().get_nodes_in_group("rune_weights")
	#
	#for _i in weights.size():
		#var line = weights[_i]
		#line.width = line_widht * zoom
		#
		#for _j in anchors[_i]:
			#var vertex = (anchors[_i][_j] * cell_size * 3 + shifts[_j] * line_widht) * zoom
			#line.set_point_position(_j, vertex)

@onready var cover = $Cover
@onready var essence = $Essence


func reset() -> void:
	essence.value = 0
	essence.element = void_resource
