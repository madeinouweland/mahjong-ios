class_name Map

static func create_board(mapname: String) -> Array[Stone]:
	var path = "res://assets/maps/" + mapname + ".txt"
	var text = FileAccess.get_file_as_string(path)

	while true:
		var coordinates := coordinates_from_map_text(text)
		var pairs = create_tile_pairs()
		pairs.shuffle()
		var stones: Array[Stone] = []
		while coordinates.size() > 1 and pairs.size() > 0:
			var free_coordinates := get_free_positions(coordinates)
			if free_coordinates.size() < 2:
				break
				
			free_coordinates.shuffle()
			
			var c1 := free_coordinates[0]
			var c2 := free_coordinates[1]
			
			stones.append(Stone.new(pairs[0][0], c1))
			stones.append(Stone.new(pairs[0][1], c2))
			
			coordinates.erase(c1)
			coordinates.erase(c2)
			pairs.remove_at(0)
		if len(coordinates) == 0:
			return stones
	# fallback to satisfy compiler (never realistically reached)
	return []
	
static func is_stone_locked(stones: Array[Stone], stone: Stone) -> bool:
	var occupied: Dictionary = {}

	for s in stones:
		occupied[s.position] = true

	if has_position_above(occupied, stone.position):
		return true

	var left := occupied.has(stone.position + Vector3i(-2, 0, 0))
	var right := occupied.has(stone.position + Vector3i(2, 0, 0))

	return left and right
		
static func get_free_positions(positions: Array[Vector3i]) -> Array[Vector3i]:
	var occupied: Dictionary = {}

	for pos in positions:
		occupied[pos] = true

	var free: Array[Vector3i] = []

	for pos in positions:
		if has_position_above(occupied, pos):
			continue

		var left := occupied.has(pos + Vector3i(-2, 0, 0))
		var right := occupied.has(pos + Vector3i(2, 0, 0))

		if !left or !right:
			free.append(pos)

	return free


static func has_position_above(occupied: Dictionary, pos: Vector3i) -> bool:
	for dx in [-1, 0, 1]:
		for dy in [-1, 0, 1]:
			if occupied.has(pos + Vector3i(dx, dy, 1)):
				return true

	return false	

static func coordinates_from_map_text(text) -> Array[Vector3i]:
	var board: Array[Vector3i] = []
	var lines = text.strip_edges().replace("\r", "").split("\n")
	for line in lines:
		line = line.strip_edges()
		if line.length() < 32:
			continue
		var y = int(line.substr(1, 2))
		var z = int(line.substr(0, 1))
		for i in range(1, 32):
			if line[i] == "#":
				board.append(Vector3i(i - 3, y, z))
	return board

static func create_tile_pairs() -> Array:
	var pairs = [
		[Tile.new("bamboo", "1", 0), Tile.new("bamboo", "1", 0)],
		[Tile.new("bamboo", "1", 0), Tile.new("bamboo", "1", 0)],
		[Tile.new("bamboo", "2", 0), Tile.new("bamboo", "2", 0)],
		[Tile.new("bamboo", "2", 0), Tile.new("bamboo", "2", 0)],
		[Tile.new("bamboo", "3", 0), Tile.new("bamboo", "3", 0)],
		[Tile.new("bamboo", "3", 0), Tile.new("bamboo", "3", 0)],
		[Tile.new("bamboo", "4", 0), Tile.new("bamboo", "4", 0)],
		[Tile.new("bamboo", "4", 0), Tile.new("bamboo", "4", 0)],
		[Tile.new("bamboo", "5", 0), Tile.new("bamboo", "5", 0)],
		[Tile.new("bamboo", "5", 0), Tile.new("bamboo", "5", 0)],
		[Tile.new("bamboo", "6", 0), Tile.new("bamboo", "6", 0)],
		[Tile.new("bamboo", "6", 0), Tile.new("bamboo", "6", 0)],
		[Tile.new("bamboo", "7", 0), Tile.new("bamboo", "7", 0)],
		[Tile.new("bamboo", "7", 0), Tile.new("bamboo", "7", 0)],
		[Tile.new("bamboo", "8", 0), Tile.new("bamboo", "8", 0)],
		[Tile.new("bamboo", "8", 0), Tile.new("bamboo", "8", 0)],
		[Tile.new("bamboo", "9", 0), Tile.new("bamboo", "9", 0)],
		[Tile.new("bamboo", "9", 0), Tile.new("bamboo", "9", 0)],
		[Tile.new("circle", "1", 0), Tile.new("circle", "1", 0)],
		[Tile.new("circle", "1", 0), Tile.new("circle", "1", 0)],
		[Tile.new("circle", "2", 0), Tile.new("circle", "2", 0)],
		[Tile.new("circle", "2", 0), Tile.new("circle", "2", 0)],
		[Tile.new("circle", "3", 0), Tile.new("circle", "3", 0)],
		[Tile.new("circle", "3", 0), Tile.new("circle", "3", 0)],
		[Tile.new("circle", "4", 0), Tile.new("circle", "4", 0)],
		[Tile.new("circle", "4", 0), Tile.new("circle", "4", 0)],
		[Tile.new("circle", "5", 0), Tile.new("circle", "5", 0)],
		[Tile.new("circle", "5", 0), Tile.new("circle", "5", 0)],
		[Tile.new("circle", "6", 0), Tile.new("circle", "6", 0)],
		[Tile.new("circle", "6", 0), Tile.new("circle", "6", 0)],
		[Tile.new("circle", "7", 0), Tile.new("circle", "7", 0)],
		[Tile.new("circle", "7", 0), Tile.new("circle", "7", 0)],
		[Tile.new("circle", "8", 0), Tile.new("circle", "8", 0)],
		[Tile.new("circle", "8", 0), Tile.new("circle", "8", 0)],
		[Tile.new("circle", "9", 0), Tile.new("circle", "9", 0)],
		[Tile.new("circle", "9", 0), Tile.new("circle", "9", 0)],
		[Tile.new("character", "1", 0), Tile.new("character", "1", 0)],
		[Tile.new("character", "1", 0), Tile.new("character", "1", 0)],
		[Tile.new("character", "2", 0), Tile.new("character", "2", 0)],
		[Tile.new("character", "2", 0), Tile.new("character", "2", 0)],
		[Tile.new("character", "3", 0), Tile.new("character", "3", 0)],
		[Tile.new("character", "3", 0), Tile.new("character", "3", 0)],
		[Tile.new("character", "4", 0), Tile.new("character", "4", 0)],
		[Tile.new("character", "4", 0), Tile.new("character", "4", 0)],
		[Tile.new("character", "5", 0), Tile.new("character", "5", 0)],
		[Tile.new("character", "5", 0), Tile.new("character", "5", 0)],
		[Tile.new("character", "6", 0), Tile.new("character", "6", 0)],
		[Tile.new("character", "6", 0), Tile.new("character", "6", 0)],
		[Tile.new("character", "7", 0), Tile.new("character", "7", 0)],
		[Tile.new("character", "7", 0), Tile.new("character", "7", 0)],
		[Tile.new("character", "8", 0), Tile.new("character", "8", 0)],
		[Tile.new("character", "8", 0), Tile.new("character", "8", 0)],
		[Tile.new("character", "9", 0), Tile.new("character", "9", 0)],
		[Tile.new("character", "9", 0), Tile.new("character", "9", 0)],
		[Tile.new("wind", "east", 0), Tile.new("wind", "east", 0)],
		[Tile.new("wind", "east", 0), Tile.new("wind", "east", 0)],
		[Tile.new("wind", "north", 0), Tile.new("wind", "north", 0)],
		[Tile.new("wind", "north", 0), Tile.new("wind", "north", 0)],
		[Tile.new("wind", "south", 0), Tile.new("wind", "south", 0)],
		[Tile.new("wind", "south", 0), Tile.new("wind", "south", 0)],
		[Tile.new("wind", "west", 0), Tile.new("wind", "west", 0)],
		[Tile.new("wind", "west", 0), Tile.new("wind", "west", 0)],
		[Tile.new("dragon", "green", 0), Tile.new("dragon", "green", 0)],
		[Tile.new("dragon", "green", 0), Tile.new("dragon", "green", 0)],
		[Tile.new("dragon", "red", 0), Tile.new("dragon", "red", 0)],
		[Tile.new("dragon", "red", 0), Tile.new("dragon", "red", 0)],
		[Tile.new("dragon", "white", 0), Tile.new("dragon", "white", 0)],
		[Tile.new("dragon", "white", 0), Tile.new("dragon", "white", 0)],
		[Tile.new("flower", "f", 1), Tile.new("flower", "f", 2)],
		[Tile.new("flower", "f", 3), Tile.new("flower", "f", 4)],
		[Tile.new("season", "s", 1), Tile.new("season", "s", 2)],
		[Tile.new("season", "s", 3), Tile.new("season", "s", 4)],
	]
	#assert(pairs.size() == 72)
	return pairs
