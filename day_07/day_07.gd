extends Node

const valid_cards = ["2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K", "A"]

func _init() -> void:
	assert(run("res://day_07/example_1.txt") == 6440)
	#assert(run("res://day_07/input.txt") == 248174859)
	
func get_hand_strength(hand: String) -> int:
	var totals: Dictionary
	
	for card in hand:
		if not totals.has(card): totals[card] = 0
		totals[card] += 1
	
	var highest_total: int
	
	for total in totals.values():
		if total > highest_total:
			highest_total = total
	
	return highest_total
	
func compare_cards_in_hand(hand_a: String, hand_b: String) -> int:
	for index in hand_a.length():
		var card_a = hand_a[index]
		var card_b = hand_b[index]
		
		if card_a == card_b: continue
		
		return 0 if valid_cards.find(card_a) > valid_cards.find(card_b) else 1
		
	return -1

func run(path: String) -> int:
	var file = FileAccess.open(path, FileAccess.READ)
	assert(file, "Failed to read file")
	
	var hands_and_binds: Array # Array of tuple [hand: String, bid: int]
	
	while not file.eof_reached():
		var row := file.get_csv_line(" ")
		if row[0].is_empty(): continue
		
		hands_and_binds.append([row[0], int(row[1])])
	
	hands_and_binds.sort_custom(func(a: Array, b: Array):
		var strength_a = get_hand_strength(a[0])
		var strength_b = get_hand_strength(b[0])
		
		if strength_a == strength_b:
			return bool(compare_cards_in_hand(a[0], b[0]))
		
		return strength_a < strength_b
	)
	
	var sum: int
	
	for index in hands_and_binds.size():
		sum += hands_and_binds[index][1] * (index + 1)
	
	print(sum)
	return sum
	
