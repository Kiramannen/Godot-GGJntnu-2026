extends Node2D

@export var torso: RigidBody2D
@export var leftLeg: RigidBody2D
@export var rightLeg: RigidBody2D

@export var kp := 1200.0
@export var kd := 120.0
@export var max_torque := 9000.0
@export var rotation_power := 0.05

var leftTarget := 0.0
var rightTarget := 0.0
var hipLimit := PI/2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("button_Q"):   
		leftTarget += 0.02
	if Input.is_action_pressed("button_W"):   
		leftTarget -= 0.02
	if Input.is_action_pressed("button_E"):   
		rightTarget += 0.02
	if Input.is_action_pressed("button_R"):   
		rightTarget -= 0.02
	leftTarget  = clamp(leftTarget,  -hipLimit, hipLimit)
	rightTarget = clamp(rightTarget, -hipLimit, hipLimit)
	
	ApplyHipTorque(rightLeg, rightTarget)
	ApplyHipTorque(leftLeg, leftTarget)
	
	#LimitRotation(rightLeg)
	#LimitRotation(leftLeg)

func ApplyHipTorque(leg: RigidBody2D, target: float):
	var theta = wrapf(leg.rotation - torso.rotation, -PI, PI)
	var omega = leg.angular_velocity - torso.angular_velocity
	theta = clamp(theta, -hipLimit, hipLimit)
	var diff = target - theta
	
	if abs(diff) < 0.002:
		return
	
	
	
	var torque = kp * diff - kd * omega
	torque = clamp(torque, -max_torque, max_torque)
	
	leg.apply_torque(torque)
	torso.apply_torque(-torque) #kan brukes for å få realistisk motkraft.
	
func LimitRotation(leg: RigidBody2D):
	var theta =  wrapf(leg.rotation - torso.rotation, -PI, PI)
	
	if theta > hipLimit:
		leg.angular_velocity = minf(leg.angular_velocity, 0.0)
		leg.transform = Transform2D(torso.rotation + hipLimit, Vector2(torso.position.x + 37, torso.position.y - 100))
		
	if theta < -hipLimit:
		leg.angular_velocity = maxf(leg.angular_velocity, 0.0)
		leg.transform = Transform2D(torso.rotation - hipLimit, Vector2(torso.position.x - 37, torso.position.y - 100))
	
