class_name Tile

var tile_type: String
var value: String
var variation: int

func _init(tile_type_p, value_p, variation_p) -> void:
	tile_type = tile_type_p
	value = value_p
	variation = variation_p

func get_key() -> String:
	if variation == 0:
		return tile_type + "-" + value
	return tile_type + "-" + str(variation)

func _to_string() -> String:
	return "%s-%s-%d" % [tile_type, value, variation]
