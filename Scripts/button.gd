extends Button

signal selected

@export var action: String

func on_pressed():
	selected.emit(action)
	print(action)
