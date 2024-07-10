@tool
class_name Essence extends PanelContainer


@export var element: Element: 
	set(element_):
		element = element_
		
		%TextureRect.modulate = element.color
		%Label.modulate = element.color
	get:
		return element

@export var proprietor: Control

#@export var texture_size: Vector2 = Vector2(16, 16):
	#set(texture_size_):
		#texture_size = texture_size_
		#custom_minimum_size = texture_size
		#size = texture_size
		#
		##var textures = get_tree().get_nodes_in_group("essence_texture")
		##
		##for texture in textures:
			##texture.custom_minimum_size = texture_size
			##texture.size = texture_size
		##
		##if true:
			##return
		#var a = %TextureRect
		#if is_instance_valid(%TextureRect):
			#%TextureRect.custom_minimum_size = texture_size
			#%TextureRect.size = texture_size
	#get:
		#return texture_size

@export var known_element: bool = true:
	set(known_element_):
		known_element = known_element_
		
		#var textures = get_tree().get_nodes_in_group("essence_texture")
		#
		#for texture in textures:
			#texture.visible = known_element
		%TextureRect.visible = known_element
	get:
		return known_element

@export var known_value: bool = true:
	set(known_value_):
		known_value = known_value_
		%Label.visible = known_value
	get:
		return known_value

@export var value: int:
	set(value_):
		value = value_
		
		%Label.text = str(value)
	get:
		return value


func replicate(donor_: Essence) -> void:
	if donor_.value > 0:
		value = donor_.value
		element = donor_.element
