extends Area2D

signal hit

@export var speed = 400 # pixels/s
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		if (Input.is_action_pressed("sprint")):
			velocity *= 2
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta
	if (position.x < 0):
		position.x += screen_size.x
	elif (position.x > screen_size.x):
		position.x -= screen_size.x
	if (position.y < 0):
		position.y += screen_size.y
	elif (position.y > screen_size.y):
		position.y -= screen_size.y
			


func _on_body_entered(body):
	hide()
	hit.emit()
	# Must be deferred because we can't change physics properties during a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
