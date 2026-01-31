extends Control


func ready():
	for button in $ButtonContainer.get_children():
		button.selected.connect(on_button_pressed)
		


func on_button_pressed():
	pass
