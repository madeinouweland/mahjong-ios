extends TextureButton

var normal_scale := Vector2.ONE
var pressed_scale := Vector2(0.92, 0.92)

func _ready() -> void:
	await get_tree().process_frame
	pivot_offset = size / 2.0
	button_down.connect(_pressed)
	button_up.connect(_released)

func _pressed() -> void:
	var tween := create_tween()
	tween.tween_property(self, "scale", pressed_scale, 0.08)

func _released() -> void:
	var tween := create_tween()
	tween.tween_property(self, "scale", normal_scale, 0.08)
