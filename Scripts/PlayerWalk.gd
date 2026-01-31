extends Node2D

@export var torso: RigidBody2D
@export var leftLeg: RigidBody2D
@export var rightLeg: RigidBody2D

@export var kp := 1200.0
@export var kd := 120.0
@export var max_torque := 9000.0
@export var rotation_power := 0.01

var leftTarget := 0.0
var rightTarget := 0.0
var hipLimit := 90.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("button_Q"):   
		leftTarget -= 0.02
	if Input.is_action_pressed("button_W"):   
		leftTarget += 0.02
	if Input.is_action_pressed("button_E"):   
		rightTarget -= 0.02
	if Input.is_action_pressed("button_R"):   
		rightTarget += 0.02
	leftTarget  = clamp(leftTarget,  -hipLimit, hipLimit)
	rightTarget = clamp(rightTarget, -hipLimit, hipLimit)

func ApplyHipTorque(leg: RigidBody2D, target: float):
	var theta = wrapf(leg.rotation - torso.rotation, -PI, PI)
	var omega = leg.angular_velocity - torso.angular_velocity
	
	theta = clamp(theta, -hipLimit, hipLimit)
	if theta == target:
		return
	
	var diff = target - theta
	
	var torque = kp * diff - kd * omega
	torque = clamp(torque, -max_torque, max_torque)
	
	leg.apply_torque(torque)
	#torso.apply_toque(torque), kan brukes for å få realistisk motkraft.
	
	
