class_name Answer extends PanelContainer


func _ready():
	pass
	#calc_all()

func calc_all() -> void:
	#var values = [1, 2, 3, 4, 5, 6, 7, 8, 9]
	var values = {}
	var limit = 25
	var count = 5
	var k = 9
	
	for value in range(1, k + 1, 1):
		values[value] = count
	
	#var values = {
		#1: 1,
		#2: 1,
		#3: 1,
		#4: 1,
		#5: 1,
		#6: 1,
		#7: 1,
		#8: 1,
		#9: 1,
	#}
	#var options = []
	#
	#for _i in n:
		#options.append_array(values)
	
	var placements = Global.get_all_placements_based_on_size(values, count)
	var result = []
	
	for  placement in placements:
		var sum = 0
		var keys = placement.results.keys()
		keys.sort()
		var _values = []
		
		for value in keys:
			for _i in placement.results[value]:
				_values.append(value)
				sum += value
		
		if sum == limit:
			result.append(_values)
			print(_values)
	
	print(result.size())
