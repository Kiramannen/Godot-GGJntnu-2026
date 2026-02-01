extends Node2D

var npc_count = 6
var killCounter := 0
var winAmount := 5
@onready var killCounterLabel := $Player/CounterContainer/KillCounter

func _ready() -> void:
	killCounterLabel.text = "Kills: " + str(killCounter) + "/5"
	generate_npcs()
	$Player.slimed.connect(on_slimed)

func generate_npcs():
	var x_pos = -800
	for i in range(npc_count):
		var npc = Sprite2D.new()
		x_pos += randi_range(50,400)
		npc.global_position = Vector2(x_pos, 650-32)
		npc.texture = load("res://Assets/npc.png")
		$Npcs.add_child(npc)

func on_slimed():
	for npc in $Npcs.get_children():
		if npc.global_position.distance_to($Player.global_position) < 30 and npc.texture != load("res://Assets/karakterDod.png"):
			npc.texture = load("res://Assets/karakterDod.png")
			print_debug("død")
			killCounter +=1
			killCounterLabel.text = "Kills: " + str(killCounter) + "/" +str(winAmount)
		if killCounter == winAmount:
			print("inside_tree:", is_inside_tree(), " tree:", get_tree(), " self:", self)
			win()
			return

func win():
	get_tree().change_scene_to_file("res://Scenes/win.tscn")
	
