extends PanelContainer

signal menu_button_clicked

func _ready():
	%MenuButton.pressed.connect(_on_button_pressed)
	
func _on_button_pressed() -> void:
	menu_button_clicked.emit()
