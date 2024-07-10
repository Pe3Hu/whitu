class_name Element extends Resource


@export_enum("earth", "wind", "fire", "water", "void") var type: String = "void":
	set(type_):
		type = type_
	get:
		return type

@export var color: Color

@export var values: Array[int]
