@tool
class_name Essence extends Node2D


@export var panel: PanelContainer

@export var slot: Slot:
	set(slot_):
		if slot != null:
			slot.essence = null
			slot.panel.occupied_slots.erase(slot)
			slot.panel.accessible_slots.append(slot)
			
		slot = slot_
		slots.clear()
		slots.append(slot)
		slot.essence = self
		
		if slot.panel != panel:
			panel.essences.remove_child(self)
			panel = slot.panel
			panel.essences.add_child(self)
	get:
		return slot

@export var element: Element: 
	set(element_):
		element = element_
		%Element.modulate = element.color
		%Value.modulate = element.color
	get:
		return element

@export var known_element: bool = true:
	set(known_element_):
		known_element = known_element_
		%Element.visible = known_element
	get:
		return known_element

@export var known_value: bool = true:
	set(known_value_):
		known_value = known_value_
		%Value.visible = known_value
	get:
		return known_value

@export var value: int:
	set(value_):
		value = value_
		%Value.frame = value - 1
	get:
		return value

var draggable = false
var is_inside_dropable = false
var body_ref
var offset: Vector2
var initial_position: Vector2
var slots: Array[Slot]


func _process(delta):
	if draggable:
		if Input.is_action_just_pressed("click"):
			if slots.is_empty():
				initial_position = global_position
			else:
				initial_position = slot.global_position
			
			offset = get_global_mouse_position() - global_position
			Global.flag.is_dragging = true
			
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position()
		elif Input.is_action_just_released("click"):
			Global.flag.is_dragging = false
			var delay = 0.2
			
			if is_inside_dropable:
				move_to_nearest_slot(delay)
			else:
				move_to_initial_position(delay)
	
func _on_area_2d_body_entered(body):
	if body.is_in_group('dropable'):
		if body.essence == null:
			is_inside_dropable = true
			body.collision_shape.debug_color = Color(Color.SEA_GREEN, 0.3)
			
			if !slots.has(body):
				slots.append(body)
	
func _on_area_2d_body_exited(body):
	if body.is_in_group('dropable'):
		body.collision_shape.debug_color = Color(0, 0.6, 0.7, 0.42)
		slots.erase(body)
		
		if slots.is_empty():
			is_inside_dropable = false
	
func _on_area_2d_mouse_entered():
	if not Global.flag.is_dragging:
		draggable = true
		%Element.frame = 1
	
func _on_area_2d_mouse_exited():
	if not Global.flag.is_dragging:
		draggable = false
		%Element.frame = 0
	
func move_to_nearest_slot(delay_: float) -> void:
	slots.sort_custom(func(a, b): return a.global_position.distance_to(global_position) < b.global_position.distance_to(global_position))
	slot = slots.front()
	
	var tween = get_tree().create_tween()#.from(get_global_mouse_position())
	tween.tween_property(self, "global_position", slot.global_position, delay_).from(get_global_mouse_position()).set_ease(Tween.EASE_OUT)
	tween.tween_callback(reset_slots)
	initial_position = slot.global_position
	
	var dropables = get_tree().get_nodes_in_group("dropable")
	
	for body in dropables:
		body.collision_shape.debug_color = Color(0, 0.6, 0.7, 0.42)
	
func move_to_initial_position(delay_: float) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", initial_position, delay_).set_ease(Tween.EASE_OUT)
	tween.tween_callback(reset_slots)
	
func reset_slots() -> void:
	#await get_tree().process_frame
	var dropables = get_tree().get_nodes_in_group("dropable")
	
	for body in dropables:
		body.collision_shape.debug_color = Color(0, 0.6, 0.7, 0.42)
