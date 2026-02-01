extends Node2D
@export var fade_time := 0.6

@onready var fade = $Fade
@onready var scenes := $StoryRoot.get_children()
@onready var enterText = $EnterText

var index := -1
var fading = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for s in scenes:
		s.visible = false
	fade.color.a = 1.0
	ShowScene(0)

func ShowScene(index: int):
	scenes[index-1].visible = false
	scenes[index].visible = true

func NextScene():
	enterText.visible = false
	if index ==len(scenes)-1:
		get_tree().change_scene_to_file("res://scenes/game.tscn")
		return
	await FadeIn()
	index+=1
	ShowScene(index)
	await FadeOut()

func FadeIn():
	fading = true
	await get_tree().create_tween().tween_property(fade, "color:a", 1.0, fade_time).finished
	fading = false

func FadeOut():
	fading = true
	await get_tree().create_tween().tween_property(fade, "color:a", 0.0, fade_time).finished
	fading = false
	
func _input(event):
	if event.is_action_pressed("ui_accept") and not fading:
		NextScene()
