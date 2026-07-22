class_name Stone

var tile: Tile
var position: Vector3i

func _init(tile_p: Tile, position_p: Vector3i) -> void:
	tile = tile_p
	position = position_p
	
static func compare(a: Stone, b: Stone) -> bool:
	if a.position.z != b.position.z:
		return a.position.z < b.position.z

	var da = int(a.position.x / 2) + a.position.y
	var db = int(b.position.x / 2) + b.position.y

	if da != db:
		return da < db

	return a.position.x < b.position.x
