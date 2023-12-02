extends Node

func _init() -> void:
	# Trials.
	assert(run("res://day_02/example_1.txt", { "red": 12, "green": 13, "blue": 14 }) == [8, 2286])
	
	# Challenge.
	assert(run("res://day_02/input.txt", { "red": 12, "green": 13, "blue": 14 }) == [2369, 66363])

## Returns a tuple of the answers for part 1 and part 2.
func run(path: String, rules: Dictionary = {}) -> Array[int]:
	var file = FileAccess.open(path, FileAccess.READ)
	assert(file, "Failed to read file")
	
	var sum: int = 0
	var power_sum: int = 0
	
	var id: int = 1
	var line: String = file.get_line()
	
	# Each line is an individual game.
	while line:
		var chunks = line.split(":")
		var rounds = chunks[1].split(";")
		
		var minimum_cube_count: Dictionary = {}
		var is_game_possible = true
		
		for round in rounds:
			var subsets = round.strip_edges().split(", ")
			
			for subset in subsets:
				var subset_chunks = subset.split(" ")
				var color = subset_chunks[1]
				var count = int(subset_chunks[0])
				
				var rule_count: int = rules.get(color, 0)

				if is_game_possible and count > rule_count:
					is_game_possible = false
					
				var current_minimum: int = minimum_cube_count.get(color, 0)
				
				if count > current_minimum:
					minimum_cube_count[color] = count
		
		# Calculate part 1.
		if is_game_possible: sum += id
		
		# Calculate part 2.
		var power: int = 1
		for count in minimum_cube_count.values():  power *= count
		power_sum += power
		
		id += 1
		line = file.get_line()
	
	print(sum, ", ", power_sum)
	return [sum, power_sum]
