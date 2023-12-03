extends Node

func _init() -> void:
	assert(run("res://day_03/example_1.txt") == [4361, 467835])
	assert(run("res://day_03/input.txt") == [535078, 75312571])

## Convert a 2D coordinate to an 1D array index.
func get_cell_index(size: Vector2i, coordinate: Vector2i) -> int:
	var x_w = clamp(coordinate.x, 0, size.x - 1)
	var y_w = clamp(coordinate.y, 0, size.y - 1)
	return x_w + size.x * y_w

## Returns a tuple of sum of engine part numbers and gear ratios.
func run(path: String) -> Array[int]:
	var file = FileAccess.open(path, FileAccess.READ)
	assert(file, "Failed to read file")
	
	# Remove newlines otherwise the wrong size is calculated.
	var schematic = file.get_as_text().replace("\n", "").split()
	var width = file.get_line().length()
	var height = schematic.size() / width
	var size = Vector2i(width, height)
	
	# Map gear coordinate to array of part numbers, e.g `{ (2,3): [12, 0] }`.
	var gears: Dictionary = {}
	var sum: int = 0
	
	var part_number_buffer: String
	var part_number_coordinate: Vector2i
	
	for index in schematic.size():
		# Check every character in the schematic.
		var value = schematic[index]
		var coordinate = Vector2i(index % size.x, index / size.x)
		
		# If the character is a integar, start building up a part number.
		if value.is_valid_int():
			# Build part number and set it's origin coordinate.
			if part_number_buffer.is_empty(): part_number_coordinate = coordinate
			part_number_buffer += value
			
		var not_int_or_at_end = not value.is_valid_int() or index == schematic.size() - 1
		
		# If the character is not a number or we're at end of the schematic, 
		# consume and process the part number, checking it's adjacent chars etc.
		if not_int_or_at_end and not part_number_buffer.is_empty():
			# Consume part number and flush buffer.
			var part_number_width = part_number_buffer.length()
			var part_number = int(part_number_buffer)
			part_number_buffer = "" 
		
			# Check around part number for adjacent symbols.
			var bounds = Vector2i(part_number_width + 2, 3)
			
			for x in bounds.x:
				for y in bounds.y:
					var adjacent_coordinate = part_number_coordinate + Vector2i(x - 1, y - 1)
					var adjacent_index = get_cell_index(size, adjacent_coordinate)
					var adjacent_value = schematic[adjacent_index]
					
					# Keep track of numbers next to gears for later.
					if adjacent_value == "*":
						var gear_ratios = gears.get(adjacent_coordinate, [])
						
						gear_ratios.append(part_number)
						gears[adjacent_coordinate] = gear_ratios
					
					# Sum the part number.
					if adjacent_value != "." and not adjacent_value.is_valid_int():
						sum += part_number
	
	# Sum up all the gears that have two part numbers.
	var ratio_sum: int = 0
	
	for coordinate in gears:
		var part_numbers = gears[coordinate]
		if part_numbers.size() != 2: continue
		
		ratio_sum += part_numbers[0] * part_numbers[1]
	
	print(sum, ", ", ratio_sum)
	return [sum, ratio_sum]
