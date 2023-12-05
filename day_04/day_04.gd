# Not gonna lie, I got pretty stuck on part 2 of this. I was originally going 
# down the route of keeping a stack/queue of duplicate cards. But also I felt
# that there was a better way just by adding up the "wins" somehow.
#
# Anyway after many hours I was too tired and ended up looking at other people's 
# solutions. This is the reference I used which helped me: 
# https://github.com/chandlerklein/AdventOfCode/blob/main/src/main/java/com/chandler/aoc/year23/Day04.java
#
# And this video visually explains what's going on:
# https://twitter.com/gereleth/status/1731755093366550767
#
# So I didn't figure out this one all by myself. Oh well.

extends Node

func _init() -> void:
	assert(run("res://day_04/example_1.txt") == [13, 30])
	assert(run("res://day_04/input.txt") == [21485, 11024379])
	
func to_int_array(array: PackedStringArray) -> Array[int]:
	var ints: Array[int]
	
	for string in array:
		if string.is_empty(): continue
		ints.append(int(string))
	
	return ints
	
func get_number_of_wins(card: String) -> int:
	var all_numbers = card.substr(8).split(" | ")
	var winning_numbers = to_int_array(all_numbers[0].split(" "))
	var submitted_numbers = to_int_array(all_numbers[1].split(" "))
	
	var number_of_wins: int = 0
	
	for submitted_number in submitted_numbers:
		if winning_numbers.has(submitted_number):
			number_of_wins += 1
	
	return number_of_wins

func run(path: String) -> Array[int]:
	var file = FileAccess.open(path, FileAccess.READ)
	assert(file, "Failed to read file")
	
	var sum: int
	var total_number_of_cards: int
	var line: String = file.get_line()
	
	var card_totals: Array[int]
	card_totals.resize(221)
	card_totals.fill(0)
	
	var index: int
	
	while line:
		var wins = get_number_of_wins(line)
		
		# Increment a total for the original card.
		card_totals[index] += 1
		
		var number_of_cards = card_totals[index]
		total_number_of_cards = total_number_of_cards + number_of_cards
		
		# Add the current card total to all the duplicate card totals.
		for clone_index in range(index + 1, index + 1 + wins):
			card_totals[clone_index] += number_of_cards
		
		# Originally I tried to do `pow` but didn't realise I had to subtract 
		# one from the total wins.
		sum += pow(2, wins - 1)
		
		index += 1
		line = file.get_line()
	
	print(sum, ", ", total_number_of_cards)
	return [sum, total_number_of_cards]
