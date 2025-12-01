extends CharacterBody2D
class_name Player

@onready var ray: RayCast2D = %RayCast2D
@onready var smile_and_wave: Area2D = %SmileAndWave
@onready var tile_size = 32
@onready var sprite: Sprite2D = %Sprite2D

var moving = false
var input_dir
var conveyor_minigame := false

@warning_ignore("unused_private_class_variable")
@onready var _is_smiling := true
@warning_ignore("unused_private_class_variable")
@onready var _is_waving := false
@onready var visible_guests: Array = []
@onready var trash_in_range: Array = []
@onready var shelves_in_range: Array = []
@onready var _shelf_timer := Timer.new()

signal direction_up
signal direction_left
signal direction_down
signal direction_right

func _ready() -> void:
	add_child(_shelf_timer)
	_shelf_timer.wait_time = 1.0
	_shelf_timer.timeout.connect(stock_shelves)
	_shelf_timer.start()
	_shelf_timer.paused = true
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2

func stock_shelves() -> void:
	if !shelves_in_range.is_empty():
		for shelf in shelves_in_range:
			shelf.inventory += 1

func _physics_process(_delta: float) -> void:
	if conveyor_minigame:
		if Input.is_action_pressed("space"):
			if Input.is_action_just_pressed("move_left"):
				direction_left.emit()
			elif Input.is_action_just_pressed("move_right"):
				direction_right.emit()
			elif Input.is_action_just_pressed("move_up"):
				direction_up.emit()
			if Input.is_action_just_pressed("move_down"):
				direction_down.emit()
			return
		pass
	input_dir = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		input_dir = Vector2.LEFT
		sprite.set_rotation_degrees(270)
		move()
	elif Input.is_action_pressed("move_right"):
		input_dir = Vector2.RIGHT
		sprite.set_rotation_degrees(90)
		move()
	elif Input.is_action_pressed("move_up"):
		input_dir = Vector2.UP
		sprite.set_rotation_degrees(0)
		move()
	elif Input.is_action_pressed("move_down"):
		input_dir = Vector2.DOWN
		sprite.set_rotation_degrees(180)
		move()
	move_and_slide()

func move():
	if input_dir:
		if moving == false:
			ray.target_position = input_dir * tile_size
			ray.force_raycast_update()
			if !ray.is_colliding():
				moving = true
				var tween = create_tween()
				tween.tween_property(self, "position", position + (input_dir * tile_size), 0.15)
				tween.tween_callback(move_false)
			else:
				return

func move_false():
	moving = false
