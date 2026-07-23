extends Control

const MENU_SCENE := "res://menuview.tscn"

var StoneSprite = preload("res://stonesprite.tscn")
var _geo: Geo
var _textures := {}
var _game: Game
var _stone_sprites: Array[StoneSprite] = []

func _ready() -> void:
	_load_textures()
	await get_tree().process_frame
	
	if globals.selected_map == "TEST":
		var stones = Map.create_test_board()
		_create_sprites(stones)	
	else:
		var stones = Map.create_board(globals.selected_map)
		_create_sprites(stones)	
		
	$%WonDialog.menu_button_clicked.connect(_on_menu_button_pressed)
	$%LostDialog.menu_button_clicked.connect(_on_menu_button_pressed)
	$%TextureButtonMenu.pressed.connect(_on_menu_button_pressed)
	$%TextureButtonUndo.pressed.connect(_on_undo_button_pressed)
	
func _create_sprites(stones):
	_geo = Geo.new($%StoneControl.size)
	stones.sort_custom(Stone.compare)
	_game = Game.new(stones)
	for stone in stones:
		var stone_sprite = StoneSprite.instantiate()
		stone_sprite.clicked.connect(_on_stone_clicked)
		_stone_sprites.append(stone_sprite)
		$%StoneCanvas.add_child(stone_sprite)
		stone_sprite.set_dimension(
			Vector2(
				_geo.board_offset.x + stone.position.x * _geo.stone_shift.x / 2 - stone.position.z * _geo.stone_size.x * .09, 
				_geo.board_offset.y + stone.position.y * _geo.stone_shift.y / 2 - stone.position.z * _geo.stone_size.y * .09
			),
			_geo.stone_size
		)
		stone_sprite.setup(stone, _textures[stone.tile.get_key()])

func _on_stone_clicked(stone_sprite_p: StoneSprite):
	""" Handle stone sprite click.
		- make the move in the game class
		- match the result
	"""
	var result = _game.make_move(stone_sprite_p.stone)
		
	match result.status:
		MoveResult.Status.NO_MATCH:
			if result.stone1:
				var first_stone = Lib.first_or_null(_stone_sprites, func(s: StoneSprite): return s.stone == result.stone1)
				first_stone.hide_selection()
			stone_sprite_p.show_selection()
		MoveResult.Status.BLOCKED:
			stone_sprite_p.show_blocked()
		MoveResult.Status.MATCH:
			var first_stone = Lib.first_or_null(_stone_sprites, func(s: StoneSprite): return s.stone == result.stone1)
			first_stone.remove_stone()
			stone_sprite_p.remove_stone()
			first_stone.hide_selection()
			stone_sprite_p.hide_selection()
			# Check if gewonnen or lost
			if _game.board_is_empty():  # Board is empty. Game has been won.
				$%WonDialog.visible = true
			elif _game.get_possible_moves().size() == 0:
				$%LostDialog.visible = true
				
		MoveResult.Status.SAME_STONE:
			stone_sprite_p.hide_selection()

func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file(MENU_SCENE)

func _on_undo_button_pressed() -> void:
	var move: Move = _game.undo()
	if move:
		var first_stone = Lib.first_or_null(_stone_sprites, func(s: StoneSprite): return s.stone == move.stone_a)
		first_stone.show_stone()
		var first_stone2 = Lib.first_or_null(_stone_sprites, func(s: StoneSprite): return s.stone == move.stone_b)
		first_stone2.show_stone()








func _load_textures() -> void:
	_textures = {
		"bamboo-1": preload("res://assets/tiles/bamboo-1.png"),
		"bamboo-2": preload("res://assets/tiles/bamboo-2.png"),
		"bamboo-3": preload("res://assets/tiles/bamboo-3.png"),
		"bamboo-4": preload("res://assets/tiles/bamboo-4.png"),
		"bamboo-5": preload("res://assets/tiles/bamboo-5.png"),
		"bamboo-6": preload("res://assets/tiles/bamboo-6.png"),
		"bamboo-7": preload("res://assets/tiles/bamboo-7.png"),
		"bamboo-8": preload("res://assets/tiles/bamboo-8.png"),
		"bamboo-9": preload("res://assets/tiles/bamboo-9.png"),
		"circle-1": preload("res://assets/tiles/circle-1.png"),
		"circle-2": preload("res://assets/tiles/circle-2.png"),
		"circle-3": preload("res://assets/tiles/circle-3.png"),
		"circle-4": preload("res://assets/tiles/circle-4.png"),
		"circle-5": preload("res://assets/tiles/circle-5.png"),
		"circle-6": preload("res://assets/tiles/circle-6.png"),
		"circle-7": preload("res://assets/tiles/circle-7.png"),
		"circle-8": preload("res://assets/tiles/circle-8.png"),
		"circle-9": preload("res://assets/tiles/circle-9.png"),
		"character-1": preload("res://assets/tiles/character-1.png"),
		"character-2": preload("res://assets/tiles/character-2.png"),
		"character-3": preload("res://assets/tiles/character-3.png"),
		"character-4": preload("res://assets/tiles/character-4.png"),
		"character-5": preload("res://assets/tiles/character-5.png"),
		"character-6": preload("res://assets/tiles/character-6.png"),
		"character-7": preload("res://assets/tiles/character-7.png"),
		"character-8": preload("res://assets/tiles/character-8.png"),
		"character-9": preload("res://assets/tiles/character-9.png"),
		"wind-east": preload("res://assets/tiles/wind-east.png"),
		"wind-north": preload("res://assets/tiles/wind-north.png"),
		"wind-south": preload("res://assets/tiles/wind-south.png"),
		"wind-west": preload("res://assets/tiles/wind-west.png"),
		"dragon-red": preload("res://assets/tiles/dragon-red.png"),
		"dragon-green": preload("res://assets/tiles/dragon-green.png"),
		"dragon-white": preload("res://assets/tiles/dragon-white.png"),
		"flower-1": preload("res://assets/tiles/flower-1.png"),
		"flower-2": preload("res://assets/tiles/flower-2.png"),
		"flower-3": preload("res://assets/tiles/flower-3.png"),
		"flower-4": preload("res://assets/tiles/flower-4.png"),
		"season-1": preload("res://assets/tiles/season-1.png"),
		"season-2": preload("res://assets/tiles/season-2.png"),
		"season-3": preload("res://assets/tiles/season-3.png"),
		"season-4": preload("res://assets/tiles/season-4.png"),
	}
