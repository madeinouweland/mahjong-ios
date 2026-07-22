extends PanelContainer

@onready var image: TextureRect = $MarginContainer/VBoxContainer/TextureRect
@onready var label: Label = $MarginContainer/VBoxContainer/Label

signal selected(map_name: String)
var _map_name: String

func setup(map_name: String) -> void:
	_map_name = map_name
	#print(get_tree_string_pretty())
	label.text = map_name

	var thumbnail_path = "res://assets/thumbnails/" + map_name + ".png"

	if ResourceLoader.exists(thumbnail_path):
		image.texture = load(thumbnail_path)

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			selected.emit(_map_name)

	if event is InputEventScreenTouch:
		if event.pressed:
			selected.emit(_map_name)
