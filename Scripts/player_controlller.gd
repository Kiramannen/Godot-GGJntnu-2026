extends Control

signal button_pressed

func _ready():
	for button in $ButtonContainer.get_children():
		button.selected.connect(on_button_pressed)


func on_button_pressed(action):
	button_pressed.emit(action)
