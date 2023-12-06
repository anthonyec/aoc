extends Node

func _init() -> void:
	assert(run("res://day_06/example_1.txt") == 288)
	assert(run("res://day_06/input_1.txt") == 588588)
	
	# For part 2, remove the spaces between numbers in the input file.
	assert(run("res://day_06/example_2.txt") == 71503)
	assert(run("res://day_06/input_2.txt") == 34655848)
	
func to_string_array(array: PackedStringArray) -> Array[String]:
	var strings: Array[String]
	
	for string in array:
		if string.strip_edges().is_empty(): continue
		strings.append(string)
	
	return strings
	
func to_int_array(array: PackedStringArray) -> Array[int]:
	var ints: Array[int]
	
	for string in array:
		if string.is_empty(): continue
		ints.append(int(string))
	
	return ints

func run(path: String) -> int:
	var file = FileAccess.open(path, FileAccess.READ)
	assert(file, "Failed to read file")
	
	var race: Dictionary # Time/distance key to array of numbers.
	var race_count: int
	
	# Parse input.
	while not file.eof_reached():
		var row := to_string_array(file.get_csv_line(" "))
		if row.is_empty(): continue
		
		var key = row[0].replace(":", "").to_lower()
		var values = to_int_array(row.slice(1, row.size()))
		
		race[key] = values
		race_count = values.size()
	
	# The actual solution to work it out.
	var margin_of_error: int
		
	for index in race_count:
		var ways_to_win_count: int
		var total_time: int = race.get("time")[index]
		var total_distance: int = race.get("distance")[index]
		
		for time in total_time:
			var remaining = (total_time - time) - 1
			var distance_traveled = (time + 1) * remaining
			
			if distance_traveled > total_distance:
				ways_to_win_count += 1
		
		if margin_of_error == 0: margin_of_error = 1
		margin_of_error *= ways_to_win_count
	
	print(margin_of_error)
	return margin_of_error
