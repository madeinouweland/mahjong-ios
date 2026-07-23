class_name Game

var stones: Array[Stone]
var _selected_stone: Stone
var undo_stack: Array[Move] = []

func _init(stones_p: Array[Stone]) -> void:
	stones = stones_p
	
func make_move(stone: Stone) -> MoveResult:
	var result := MoveResult.new()
	if Map.is_stone_locked(stones, stone):
		result.status = MoveResult.Status.BLOCKED
	elif _selected_stone == stone:
		result.status = MoveResult.Status.SAME_STONE
		_selected_stone = null
	elif _selected_stone and is_match(stone.tile, _selected_stone.tile):
		result.status = MoveResult.Status.MATCH
		undo_stack.push_back(Move.new(stone, _selected_stone))
		result.stone1 = _selected_stone
		stones.erase(_selected_stone)
		stones.erase(stone)
		_selected_stone = null
	else:
		result.status = MoveResult.Status.NO_MATCH
		result.stone1 = _selected_stone
		_selected_stone = stone

	return result
	
func undo() -> Move:
	if undo_stack.is_empty():
		return
	var move: Move = undo_stack.pop_back()
	stones.append(move.stone_a)
	stones.append(move.stone_b)
	return move

func has_won_game() -> bool:
	return stones.is_empty()

func has_lost_game():
	var positions: Array[Vector3i] = []

	for stone in stones:
		positions.append(stone.position)

	var free_stones = Map.get_free_positions(positions)
	return free_stones.size() < 2

func is_match(tile1: Tile, tile2: Tile):
	return tile1.value == tile2.value and tile1.tile_type == tile2.tile_type
