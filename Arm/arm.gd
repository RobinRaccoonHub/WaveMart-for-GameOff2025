extends Node2D
class_name Arm

@onready var hand: RigidBody2D = %Hand
@onready var starting_position = hand.position
@onready var waving_timer = Timer.new()
@onready var _broom: Sprite2D = %Broom
@onready var _can_64: Sprite2D = %Can64
@onready var _audio_player: AudioStreamPlayer2D = %AudioPlayer

@export var _player: Player = null

var currently_waving = false
var currently_sweeping = false
var currently_stocking = false
var mouse_in_area = false
var sweeping = false
var empty_handed = true
var stocking = false

func _ready() -> void:
	waving_timer.wait_time = 1.0
	waving_timer.one_shot = true
	add_child(waving_timer)
	waving_timer.timeout.connect(waving_timer_reset)
	Happiness.sweeping.connect(sweeping_true)
	Happiness.empty_handed.connect(empty_handed_true)
	Happiness.stocking.connect(stocking_true)

func _physics_process(delta: float) -> void:
	if !currently_sweeping and !currently_waving:
		var reset_position = hand.position.distance_to(starting_position)
		hand.set_axis_velocity(starting_position.normalized() * (reset_position * 0.75))
	if !_player.trash_in_range.is_empty() and currently_sweeping:
		for trash in _player.trash_in_range:
			trash.modulate.a -= 1.0 * delta
			if trash.modulate.a <= 0.3:
				_player.trash_in_range.erase(trash)
				trash.queue_free()

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if !mouse_in_area:
			return
		if sweeping:
			currently_sweeping = true
			if !_audio_player.playing:
				_audio_player.play_broom_audio()
			if !_player.trash_in_range.is_empty():
				for trash in _player.trash_in_range:
					trash.modulate.a -= 0.1
		if empty_handed:
			currently_waving = true
		if stocking:
			if _player._shelf_timer.paused:
				_player._shelf_timer.paused = false
			currently_stocking = true
		var speed = 800.0
		var direction = position.direction_to(get_global_mouse_position())
		var distance_to_mouse = position.distance_to(get_global_mouse_position())
		if distance_to_mouse > 50.0:
			hand.apply_central_force(direction * speed)
		else:
			hand.set_axis_velocity(direction * (distance_to_mouse * 0.5))
	if Input.is_action_just_released("left_click"):
		if currently_sweeping:
			waving_timer.start()
		elif currently_waving:
			waving_timer.start()


func waving_timer_reset() -> void:
	currently_waving = false
	currently_sweeping = false
	currently_stocking = false
	_player._shelf_timer.paused = true

func sweeping_true() -> void:
	sweeping = true
	empty_handed = false
	stocking = false
	_broom.visible = true
	_can_64.visible = false

func empty_handed_true() -> void:
	empty_handed = true
	sweeping = false
	stocking = false
	_broom.visible = false
	_can_64.visible = false

func stocking_true() -> void:
	sweeping = false
	empty_handed = false
	stocking = true
	_broom.visible = false
	_can_64.visible = true

func _on_mouse_entered() -> void:
	mouse_in_area = true

func _on_mouse_exited() -> void:
	mouse_in_area = false
