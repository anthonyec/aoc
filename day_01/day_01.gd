extends Node

const spellings = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

func _init() -> void:
	# Trials.
	print("\nTrials:")
	assert(run("res://day_01/example_1.txt") == 142)
	assert(run("res://day_01/example_1.txt", true) == 142)
	assert(run("res://day_01/example_2.txt") == 577)
	assert(run("res://day_01/example_2.txt", true) == 671)
	assert(run("res://day_01/example_3.txt", true) == 281)
	assert(run("res://day_01/example_4.txt", true) == 26)
	assert(run("res://day_01/example_5.txt", true) == 282)
	
	# Challenges.
	print("\nPuzzle 1:")
	assert(run("res://day_01/input.txt") == 52974)
	assert(run("res://day_01/input.txt", true) == 53340)

func spelling_to_digit(spelling: String) -> String:
	var index = spellings.find(spelling)
	return str(index + 1)
	
func match_spelling_at_start(line: String, offset: int) -> String:
	for spelling in spellings:
		if line.substr(offset).begins_with(spelling):
			return spelling

	return ""

func match_spelling_at_end(line: String, offset: int) -> String:
	for spelling in spellings:
		if line.substr(0, offset + 1).ends_with(spelling):
			return spelling

	return ""

func run(path: String, use_spellings: bool = false) -> int:
	var file = FileAccess.open(path, FileAccess.READ)
	assert(file, "Failed to read file")
	
	var sum: int = 0
	var line: String = file.get_line()
	
	while line:
		var first_digit: String
		var last_digit: String
		
		for index in line.length():
			var reverse_index = (line.length() - 1) - index
			
			var start_char = line[index]
			var end_char = line[reverse_index]
			
			if not first_digit and start_char.is_valid_int():
				first_digit = start_char
				
			if not last_digit and end_char.is_valid_int():
				last_digit = end_char
				
			if use_spellings:
				var start_spelling_match = match_spelling_at_start(line, index)
				var end_spelling_match = match_spelling_at_end(line, reverse_index)
				
				if not first_digit and start_spelling_match:
					first_digit = spelling_to_digit(start_spelling_match)
					
				if not last_digit and end_spelling_match:
					last_digit = spelling_to_digit(end_spelling_match)
				
			if first_digit and last_digit:
				break
				
		sum += int(first_digit + last_digit)
		line = file.get_line()
	
	print(sum)
	return sum
