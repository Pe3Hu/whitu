extends Node


var rng = RandomNumberGenerator.new()
var arr = {}
var num = {}
var vec = {}
var color = {}
var dict = {}
var flag = {}
var node = {}
var scene = {}


func _ready() -> void:
	init_arr()
	init_num()
	init_vec()
	init_color()
	init_dict()
	init_flag()
	init_scene()


func init_arr() -> void:
	arr.element = ["water", "wind", "fire", "earth"]
	arr.order = [0, 1, 2, 3, 4, 5, 6]


func init_num() -> void:
	num.index = {}


func init_dict() -> void:
	init_direction()


func init_direction() -> void:
	dict.direction = {}
	dict.direction.linear3 = [
		Vector3( 0, 0, -1),
		Vector3( 1, 0,  0),
		Vector3( 0, 0,  1),
		Vector3(-1, 0,  0)
	]
	dict.direction.linear2 = [
		Vector2( 0,-1),
		Vector2( 1, 0),
		Vector2( 0, 1),
		Vector2(-1, 0)
	]
	dict.direction.diagonal = [
		Vector2( 1,-1),
		Vector2( 1, 1),
		Vector2(-1, 1),
		Vector2(-1,-1)
	]
	dict.direction.zero = [
		Vector2( 0, 0),
		Vector2( 1, 0),
		Vector2( 1, 1),
		Vector2( 0, 1)
	]
	dict.direction.hex = [
		[
			Vector2( 1,-1), 
			Vector2( 1, 0), 
			Vector2( 0, 1), 
			Vector2(-1, 0), 
			Vector2(-1,-1),
			Vector2( 0,-1)
		],
		[
			Vector2( 1, 0),
			Vector2( 1, 1),
			Vector2( 0, 1),
			Vector2(-1, 1),
			Vector2(-1, 0),
			Vector2( 0,-1)
		]
	]


func init_blank() -> void:
	dict.blank = {}
	dict.blank.rank = {}
	var exceptions = ["rank"]
	
	var path = "res://asset/json/maoiri_blank.json"
	var array = load_data(path)
	
	for blank in array:
		blank.rank = int(blank.rank)
		var data = {}
		
		for key in blank:
			if !exceptions.has(key):
				data[key] = blank[key]
			
		if !dict.blank.rank.has(blank.rank):
			dict.blank.rank[blank.rank] = []
	
		dict.blank.rank[blank.rank].append(data)


func init_flag() -> void:
	flag.is_dragging = false


func init_scene() -> void:
	pass


func init_vec():
	vec.size = {}
	vec.size.sixteen = Vector2(16, 16)
	vec.size.slot = Vector2(64, 64)
	
	init_window_size()


func init_window_size():
	vec.size.window = {}
	vec.size.window.width = ProjectSettings.get_setting("display/window/size/viewport_width")
	vec.size.window.height = ProjectSettings.get_setting("display/window/size/viewport_height")
	vec.size.window.center = Vector2(vec.size.window.width/2, vec.size.window.height/2)


func init_color():
	pass
	#var h = 360.0


func save(path_: String, data_: String):
	var path = path_ + ".json"
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(data_)


func load_data(path_: String):
	var file = FileAccess.open(path_, FileAccess.READ)
	var text = file.get_as_text()
	var json_object = JSON.new()
	var _parse_err = json_object.parse(text)
	return json_object.get_data()


func get_random_key(dict_: Dictionary):
	if dict_.keys().size() == 0:
		print("!bug! empty array in get_random_key func")
		return null
	
	var total = 0
	
	for key in dict_.keys():
		total += dict_[key]
	
	rng.randomize()
	var index_r = rng.randf_range(0, 1)
	var index = 0
	
	for key in dict_.keys():
		var weight = float(dict_[key])
		index += weight/total
		
		if index > index_r:
			return key
	
	print("!bug! index_r error in get_random_key func")
	return null


func get_all_placements_based_on_size(options_: Dictionary, size_: int) -> Array:
	var placements = {}
	placements[1] = []
	
	for value in options_:
		var placement = miniaturize(options_, {}, value)
		
		if !placements[1].has(placement):
			placements[1].append(placement)
	
	for _i in range(2, size_ + 1, 1):
		set_placements_based_on_size(placements, _i)
	
	return placements[size_]


func set_placements_based_on_size(placements_: Dictionary, size_: int) -> void:
	var parents = placements_[size_ - 1]
	placements_[size_] = []
	
	for parent in parents:
		for value in parent.options:
			var placement = miniaturize(parent.options, parent.results, value)
			
			if !placements_[size_].has(placement):
				placements_[size_].append(placement)

func miniaturize(options_: Dictionary, results_: Dictionary, value_: int) -> Dictionary:
	var miniature = {}
	miniature.options = options_.duplicate()
	miniature.options[value_] -= 1
	miniature.results = results_.duplicate()
	
	if !miniature.results.has(value_):
		miniature.results[value_] = 0
	
	miniature.results[value_] += 1
	
	if miniature.options[value_] == 0:
		miniature.options.erase(value_)
	
	return miniature
