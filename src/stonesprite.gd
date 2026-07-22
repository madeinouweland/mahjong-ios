class_name StoneSprite

extends Control

var stone: Stone
signal clicked(stone)

func set_dimension(position_p: Vector2i, size_p: Vector2i) -> void:
	size = size_p
	pivot_offset = size_p * 0.5
	position = position_p

func setup(stone_p: Stone, texture_p: Texture2D) -> void:
	stone = stone_p
	$TileTextureRect.texture = texture_p

func show_selection() -> void:
	$SelectionTextureRect.visible = true
	$SelectionTextureRect.modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property($SelectionTextureRect, "modulate:a", 1.0, 0.1)
	
func hide_selection() -> void:
	$SelectionTextureRect.visible = false

func show_locked() -> void:
	$LockedTextureRect.visible = true
	$LockedTextureRect.modulate.a = 0.0

	var tween = create_tween()

	tween.tween_property($LockedTextureRect, "modulate:a", 1.0, 0.12) \
		.set_trans(Tween.TRANS_QUAD) \
		.set_ease(Tween.EASE_OUT)

	tween.tween_property($LockedTextureRect, "modulate:a", 0.0, 0.25) \
		.set_trans(Tween.TRANS_QUAD) \
		.set_ease(Tween.EASE_IN)

	tween.finished.connect(func():
		$LockedTextureRect.visible = false
	)

func remove_stone() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE

	var tween := create_tween()
	tween.set_parallel(true)

	tween.tween_property(self, "scale", Vector2.ZERO, 0.2) \
		.set_trans(Tween.TRANS_CUBIC) \
		.set_ease(Tween.EASE_IN)

	tween.tween_property(self, "modulate:a", 0.0, 0.2) \
		.set_trans(Tween.TRANS_CUBIC) \
		.set_ease(Tween.EASE_IN)

	await tween.finished

	visible = false

	# Reset in case this node is reused.
	scale = Vector2.ONE
	modulate.a = 1.0
	mouse_filter = Control.MOUSE_FILTER_STOP	
func _gui_input(event):
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.pressed:
		clicked.emit(self)
