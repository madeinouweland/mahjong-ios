class_name Game

var _stones: Array[Stone]
var _selected_stone: Stone
var _undos: Array[Move] = []

func _init(_stones_p: Array[Stone]) -> void:
	_stones = _stones_p
	
func make_move(stone: Stone) -> MoveResult:
	"""
	Make a move with the stone from the clicked sprite. 
	Return a MoveResult that has BLOCKED/SAME_STONE/MATCH/NO_MATCH.
	In case of a match, MoveResult also contains the previously clicked stone it was used to match the new stone to.
	"""
	var result := MoveResult.new()
	if Map.is_stone_locked(_stones, stone):
		result.status = MoveResult.Status.BLOCKED
	elif _selected_stone == stone:
		result.status = MoveResult.Status.SAME_STONE
		_selected_stone = null
	elif _selected_stone and is_match(stone.tile, _selected_stone.tile):
		result.status = MoveResult.Status.MATCH
		_undos.push_back(Move.new(stone, _selected_stone))
		result.stone1 = _selected_stone
		_stones.erase(_selected_stone)
		_stones.erase(stone)
		_selected_stone = null
	else:
		result.status = MoveResult.Status.NO_MATCH
		result.stone1 = _selected_stone
		_selected_stone = stone

	return result
	
func undo() -> Move:
	if _undos.is_empty():
		return
	var move: Move = _undos.pop_back()
	_stones.append(move.stone_a)
	_stones.append(move.stone_b)
	return move

func board_is_empty() -> bool:
	return _stones.is_empty()

func get_possible_moves() -> Array:
	"""Go through free _stones and return list of moves."""
	var free__stones: Array[Stone] = []
	for stone in _stones:
		if !Map.is_stone_locked(_stones, stone):
			free__stones.append(stone)

	var groups: Dictionary = {}
	for stone in free__stones:
		var key := "%s_%s" % [stone.tile.tile_type, stone.tile.value]

		if !groups.has(key):
			groups[key] = []

		groups[key].append(stone)

	var moves: Array = []
	for group in groups.values():
		if group.size() >= 2:
			moves.append(group)

	return moves

func is_match(tile1: Tile, tile2: Tile):
	return tile1.value == tile2.value and tile1.tile_type == tile2.tile_type
