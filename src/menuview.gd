extends Control

const GAME_SCENE := "res://gameview.tscn"

var maps := [
	"1942",
	"Africa",
	"Alps",
	#"Anchor",
	"Atom",
	"Australia",
	"Avalanche",
	"Battery",
	#"Candles",
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
	#"Dax",
	#"Direct",
	"Donut",
	#"Double U",
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
	#"Heart Too",
	"Heart",
	"ICE",
	"Key",
	"King Cobra",
	#"Knapsack",
	"Koblenz",
	#"Kraft",
	"Light House",
	#"Limes",
	"Lowlands",
	#"Marks",
	"Montezuma",
	"Mosaik",
	"Mushroom",
	"Music",
	"One Dollar",
	"Pagode",
	"Parapluie",
	"Pillar27",
	#"Plus Minus",
	#"Robin Hood",
	#"Rubezahl",
	"Skull",
	"Sound Waves",
	#"Spiral",
	"Star Stripes",
	"Star",
	"Sun Pyramid",
	"Tanis",
	#"Tao",
	"Tilde",
	#"Tipi",
	"Tor",
	"Tree",
	"Turtle",
	"Ukulele",
	#"Window",
	#"XO",
	"Yin",
]

var menu_item_scene = preload("res://menuitem.tscn")

func _ready() -> void:
	print("Show Menu")
	print("Window size: ", DisplayServer.window_get_size())
	print("Viewport size: ", get_viewport().get_visible_rect().size)
	print("hbox", $HBoxContainer.size.x)
	print("scroll", $HBoxContainer/ScrollContainer.size.x)
	var kachel = 400 + 20 + 20 + 40 + 40
	var anzahl = int(get_viewport().get_visible_rect().size.x / kachel)
	$%GridContainer.columns = anzahl
	
	for map_name in maps:
		var item = menu_item_scene.instantiate()
		$%GridContainer.add_child(item)
		item.setup(map_name)
		item.selected.connect(_map_selected)
		
func _map_selected(map_name: String) -> void:
	globals.selected_map = map_name
	get_tree().change_scene_to_file(GAME_SCENE)
