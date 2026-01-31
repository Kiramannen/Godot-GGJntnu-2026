extends Node2D

enum State {
	IDLE,
	SET_HEIGHT,
	EXTEND,
	RETRACT
}

@export var base_x := -40.0
@export var extend_speed := 800.0
@export var retract_speed := 900.0
@export var max_length := 500.0

var state: State = State.IDLE
var target_y := 0.0
var current_length := 0.0

@onready var base: Node2D = $Base
@onready var arm_visual: = $ArmVisual
@onready var claw: CharacterBody2D = $Claw


func _ready():
	base.global_position.x = base_x
	reset_arm()


func _process(delta):
	handle_input()
	update_arm(delta)
	update_visual()


# =========================
# INPUT
# =========================

func handle_input():
	if Input.is_action_just_pressed("claw_action"):
		match state:
			State.IDLE:
				target_y = get_global_mouse_position().y
				state = State.SET_HEIGHT

			State.SET_HEIGHT:
				state = State.EXTEND

	if Input.is_action_just_released("claw_action"):
		if state == State.EXTEND:
			state = State.RETRACT


# =========================
# ARM LOGIKK
# =========================

func update_arm(delta):
	match state:
		State.SET_HEIGHT:
			base.global_position.y = lerp(
				base.global_position.y,
				target_y,
				0.25
			)

		State.EXTEND:
			current_length += extend_speed * delta
			current_length = min(current_length, max_length)

		State.RETRACT:
			current_length -= retract_speed * delta
			if current_length <= 0:
				reset_arm()


func reset_arm():
	current_length = 0
	state = State.IDLE


# =========================
# VISUELL + KLO
# =========================

func update_visual():
	# Arm-grafikk
	arm_visual.global_position = base.global_position
	arm_visual.scale.x = max(current_length / 100.0, 0.01)

	# Klo-bevegelse (CharacterBody2D)
	var target_pos := base.global_position + Vector2(current_length, 0)
	var move_vec := target_pos - claw.global_position

	claw.velocity = move_vec / get_process_delta_time()
	claw.move_and_slide()
