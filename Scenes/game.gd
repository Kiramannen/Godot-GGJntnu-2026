extends Node2D

var npc_count = 6

func _ready() -> void:
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
		if npc.global_position.distance_to($Player.global_position) < 30:
			npc.texture = load("res://Assets/karakterDod.png")
