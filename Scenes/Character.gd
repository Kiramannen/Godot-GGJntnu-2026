extends CharacterBody2D

@export var speed := 200.0
@export var jump_velocity := -400.0
@export var gravity := 1000.0
var moving = false
var h_dir = 1
var jumping = false
func _ready():
	for button in $ButtonContainer.get_children():
		print(button, typeof(button))
		button.action_selected.connect(recieve_action)

func recieve_action(action):
	match action:
		"Skull":
			print("Slimed")
		"Play":
			moving = true
			h_dir = h_dir*-1
		"Cross":
			moving = false
		"Star":
			jumping = !jumping

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if moving:
		velocity.x = h_dir * speed
	else:
		velocity.x = 0

	# Hopping
	if jumping and is_on_floor():
		velocity.y = jump_velocity

	move_and_slide()
