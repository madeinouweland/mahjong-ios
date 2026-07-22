extends Control

const GAME_SCENE := "res://gameview.tscn"

var maps := [
	"1942",
	"Africa",
	"Alps",
	"Anchor",
	"Atom",
	"Australia",
	"Avalanche",
	"Battery",
	"Candles",
	"Candy",
	"Canyon",
	"Caro",
	"Chemistry",
	"Classic",
	"Cocktail",
	"Coffee Bean",
	"Construction",
	"Cooking Pot",
	"Cosmos",
	"Dax",
	"Direct",
	"Donut",
	"Double U",
	"Dragonfly",
	"Drekar",
	"Duo Classic",
	"Eindhoven",
	"Elephant",
	"Evoluon",
	"Eye",
	"Fish",
	"Five",
	"Flower",
	"Fruit",
	"Gardener",
	"Happy Xmas",
	"Heart Too",
	"Heart",
	"ICE",
	"Key",
	"King Cobra",
	"Knapsack",
	"Koblenz",
	"Kraft",
	"Light House",
	"Limes",
	"Lowlands",
	"Marks",
	"Montezuma",
	"Mosaik",
	"Mushroom",
	"Music",
	"One Dollar",
	"Pagode",
	"Parapluie",
	"Pillar27",
	"Plus Minus",
	"Robin Hood",
	"Rubezahl",
	"Skull",
	"Sound Waves",
	"Spiral",
	"Star Stripes",
	"Star",
	"Sun Pyramid",
	"Tanis",
	"Tao",
	"Tilde",
	"Tipi",
	"Tor",
	"Tree",
	"Turtle",
	"Ukulele",
	"Window",
	"XO",
	"Yin",
]

@onready var grid := $ScrollContainer/MarginContainer/PanelContainer/GridContainer

func _ready() -> void:
	print("Show Menu")
	print("Window size: ", DisplayServer.window_get_size())
	print("Viewport size: ", get_viewport().get_visible_rect().size)
	
	for map_name in maps:
		var button := Button.new()
		button.custom_minimum_size = Vector2(180, 180)

		var vbox := VBoxContainer.new()
		vbox.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
		button.add_child(vbox)

		var image := TextureRect.new()
		image.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
		image.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		image.custom_minimum_size = Vector2(160, 120)

		var thumbnail_path = "res://assets/thumbnails/" + map_name + ".png"

		if ResourceLoader.exists(thumbnail_path):
			image.texture = load(thumbnail_path)

		vbox.add_child(image)

		var label := Label.new()
		label.text = map_name.get_basename()
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		vbox.add_child(label)

		button.pressed.connect(func():
			_map_selected(map_name)
		)

		grid.add_child(button)

func _map_selected(map_name: String) -> void:
	print("pietje")
	globals.selected_map = map_name
	get_tree().change_scene_to_file(GAME_SCENE)
