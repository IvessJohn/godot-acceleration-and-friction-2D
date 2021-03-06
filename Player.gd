extends KinematicBody2D

export(int) var SPEED: int = 200
export(int) var ACCELERATION: int = 30
export(int) var FRICTION: int = 50
var velocity: Vector2 = Vector2.ZERO

onready var sprite = $Sprite
onready var animPlayer = $AnimationPlayer


func _physics_process(delta):
	var input_dir: Vector2 = get_input_direction()
	# Moving
	if input_dir != Vector2.ZERO:
		accelerate(input_dir)
		animPlayer.play("run")
		
		# Turn around
		if input_dir.x != 0:
			sprite.scale.x = sign(input_dir.x)
	# Idle
	else:
		apply_friction()
		animPlayer.play("idle")
	move()

func move():
	velocity = move_and_slide(velocity)

func accelerate(direction: Vector2):
	velocity = velocity.move_toward(SPEED * direction, ACCELERATION)

func apply_friction():
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION)

func get_input_direction() -> Vector2:
	var input_direction = Vector2.ZERO
	
	input_direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_direction = input_direction.normalized()
	
	return input_direction
