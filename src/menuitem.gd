extends PanelContainer

@onready var image: TextureRect = $MarginContainer/VBoxContainer/TextureRect
@onready var label: Label = $MarginContainer/VBoxContainer/Label

signal selected(map_name: String)

var _map_name: String
var press_position := Vector2.ZERO
var cancelled := false

const DRAG_THRESHOLD := 20.0

var normal_scale := Vector2.ONE
var pressed_scale := Vector2(0.92, 0.92)


func _ready() -> void:
	await get_tree().process_frame
	pivot_offset = size / 2.0


func setup(map_name: String) -> void:
	_map_name = map_name
	label.text = map_name

	var thumbnail_path = "res://assets/thumbnails/" + map_name + ".png"
	if ResourceLoader.exists(thumbnail_path):
		image.texture = load(thumbnail_path)


func _gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			press_position = event.position
			cancelled = false
			_press_effect()
		else:
			_release_effect()

			if not cancelled:
				selected.emit(_map_name)

	elif event is InputEventScreenDrag:
		if press_position.distance_to(event.position) > DRAG_THRESHOLD:
			cancelled = true
			_release_effect()


func _press_effect() -> void:
	var tween := create_tween()
	tween.tween_property(self, "scale", pressed_scale, 0.08)


func _release_effect() -> void:
	var tween := create_tween()
	tween.tween_property(self, "scale", normal_scale, 0.08)
