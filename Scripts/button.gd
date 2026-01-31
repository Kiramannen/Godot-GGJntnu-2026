extends Button

signal action_selected(action: String)

@export var action: String


func _ready():
	pressed.connect(on_pressed)

func on_pressed():
	action_selected.emit(String(action))
