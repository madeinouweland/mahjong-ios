extends RefCounted
class_name Geo

const COLS := 15
const ROWS := 8
const STONE_ASPECT := 1.0 / 1.2    # width / height
const OVERLAP := .15

var board_size: Vector2
var stone_size: Vector2
var stone_shift: Vector2
var board_offset: Vector2

func _init(viewport_size: Vector2) -> void:
	board_size = viewport_size
	var stone_width = min(viewport_size.x / COLS, (viewport_size.y / ROWS) * STONE_ASPECT)
	stone_size = Vector2(stone_width, stone_width / STONE_ASPECT) * 1.10
	stone_shift = stone_size * .85

	var occupied_size = Vector2(
		(COLS - 1) * stone_shift.x + stone_size.x,
		(ROWS - 1) * stone_shift.y + stone_size.y
	)

	board_offset = (viewport_size - occupied_size) / 2.0
