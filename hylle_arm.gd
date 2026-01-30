extends Node2D

var speed = 3000 

@export var segmentScene: PackedScene 
var segmentCount = 3
var segmentSpacing = 10
var force = 12000
var segments = []

func _ready():
	build_arm()

func build_arm():

	var prev_body: PhysicsBody2D = $Anchor

	for i in segmentCount:
		var seg := segmentScene.instantiate()
		$Segments.add_child(seg)

		seg.global_position = prev_body.global_position + Vector2(0, -segmentSpacing)

		# VIKTIG: vent én frame så Godot registrerer noden
		await get_tree().process_frame

		var joint := PinJoint2D.new()
		add_child(joint)
		joint.node_a = prev_body.get_path()
		joint.node_b = seg.get_path()
		joint.global_position = (prev_body.global_position + seg.global_position) * 0.5

		segments.append(seg)
		prev_body = seg

func _physics_process(delta: float) -> void:
	var dir := Vector2(
		Input.get_action_strength("push_right") - Input.get_action_strength("push_left"),
		Input.get_action_strength("push_down") - Input.get_action_strength("push_up")
	)

	if dir.length() > 0.1:
		dir = dir.normalized()
		for seg in segments:
			seg.apply_force(dir * force)
