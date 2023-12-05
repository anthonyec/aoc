extends Node

func _init() -> void:
	assert(run("res://day_05/example_1.txt") == [35])
	assert(run("res://day_05/input.txt") == [403695602])
	
func to_int_array(array: PackedStringArray) -> Array[int]:
	var ints: Array[int]
	
	for string in array:
		if string.is_empty(): continue
		ints.append(int(string))
	
	return ints
	
class MapRange:
	var start: int
	var end: int
	
	func _init(start: int, end: int) -> void:
		self.start = start
		self.end = end
		
	func _to_string() -> String:
		return str([start, end])
		
	func is_in_range(number: int) -> bool:
		return number >= start and number <= end
	
class MapInfo:
	var source: String
	var destination: String
	var source_ranges: Array[MapRange]
	var destination_ranges: Array[MapRange]
	
	# TODO: May not be needed.
	func _init(map_name: String) -> void:
		var chunks = map_name.split("-to-")
		source = chunks[0]
		destination = chunks[1]
		
	func _to_string() -> String:
		return "<" + source + "-" + destination + " sources: " + str(source_ranges) + " destinations: " + str(destination_ranges) + " >"
	
	func get_mapped_number(number: int) -> int:
		var range_index: int = -1
		
		for index in source_ranges.size():
			var range = source_ranges[index]
			
			if range.is_in_range(number):
				range_index = index
				break
		
		if range_index == -1:
			return number
		
		var source_range: MapRange = source_ranges[range_index]
		var destination_range: MapRange = destination_ranges[range_index]
		
		var remapped = remap(
			number,
			source_range.start,
			source_range.end,
			destination_range.start,
			destination_range.end
		)
		
		return int(remapped)
	
func run(path: String) -> Array[int]:
	var file = FileAccess.open(path, FileAccess.READ)
	assert(file, "Failed to read file")
	
	var seeds: Array[int]
	var maps: Dictionary = {} # Mapp name to `MapInfo`.
	
	var lines = file.get_as_text().split("\n")
	var current_map_name: String
	
	# Parse file and build data structures.
	for line in lines:
		if line.begins_with("seeds: "):
			seeds = to_int_array(line.substr(7, line.length()).split(" "))
			continue
			
		if line.ends_with(":"):
			current_map_name = line.replace(" map:", "")
			
			if not maps.has(current_map_name):
				maps[current_map_name] = MapInfo.new(current_map_name)
				
			continue
		
		if not line.is_empty() and current_map_name:
			var map_info = maps.get(current_map_name) as MapInfo
			var ranges = to_int_array(line.split(" "))
			
			var source_range = MapRange.new(ranges[1], ranges[1] + ranges[2] - 1)
			var destination_range = MapRange.new(ranges[0], ranges[0] + ranges[2] - 1)
			
			map_info.source_ranges.append(source_range)
			map_info.destination_ranges.append(destination_range)
			
		if line.is_empty() and current_map_name:
			current_map_name = ""
			
	# Run the seeds through the maps.
	for map_name in maps:
		var map = maps.get(map_name) as MapInfo
		
		for index in seeds.size():
			var seed = seeds[index]
			seeds[index] = map.get_mapped_number(seed)
	
	# Find the lowest seed.
	var lowest_seed: int = INF
	
	for seed in seeds:
		if seed < lowest_seed:
			lowest_seed = seed
	
	print(seeds)
	print(lowest_seed)
	return [lowest_seed]
