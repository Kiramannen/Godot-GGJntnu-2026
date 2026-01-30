extends Node2D

@export var torso: RigidBody2D
@export var leftLeg: RigidBody2D
@export var rightLeg: RigidBody2D

@export var kp := 1200.0
@export var kd := 120.0
@export var max_torque := 9000.0
@export var rotation_power := 0.01

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
