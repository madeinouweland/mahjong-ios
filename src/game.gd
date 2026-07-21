class_name Game

var stones: Array[Stone]
var _selected_stone: Stone

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
		result.stone1 = _selected_stone
		stones.erase(_selected_stone)
		stones.erase(stone)
		_selected_stone = null
	else:
		result.status = MoveResult.Status.NO_MATCH
		_selected_stone = stone

	return result

func is_match(tile1: Tile, tile2: Tile):
	return tile1.value == tile2.value and tile1.tile_type == tile2.tile_type
