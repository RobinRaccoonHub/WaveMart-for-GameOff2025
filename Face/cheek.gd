extends Area2D
class_name Cheek

@onready var smile_timer = Timer.new()
@onready var right_cheek: Area2D = %RightCheek
@onready var smile_wait_time = 6.0
@onready var character_face: Face = $".."
@onready var audio_player: AudioStreamPlayer2D = %AudioPlayer
@onready var _smile_sprite: Sprite2D = %SmileSprite
@onready var _smile_indicator: Node2D = %SmileIndicator

@onready var full_frown = 64.0
@onready var full_smile = 0.0
var mouse_in_area = false
var currently_moving = false

func _ready() -> void:
	full_smile = global_position.y
	full_frown = full_smile + 64
	smile_timer.wait_time = smile_wait_time
	smile_timer.one_shot = true
	add_child(smile_timer)
	smile_timer.start()

func _physics_process(_delta: float) -> void:
	if smile_timer.is_stopped():
		_smile_indicator.global_position.y = move_toward(_smile_indicator.global_position.y, full_frown, 0.2)
	if _smile_indicator.position.y <= 16.0:
		if !character_face._player._is_smiling:
			character_face._player._is_smiling = true
		_smile_sprite.pick_big_smile()
	elif _smile_indicator.position.y <= 32.0:
		if !character_face._player._is_smiling:
			character_face._player._is_smiling = true
		_smile_sprite.pick_slight_smile()
	elif _smile_indicator.position.y <= 48.0:
		if character_face._player._is_smiling:
			character_face._player._is_smiling = false
		_smile_sprite.pick_slight_frown()
	elif _smile_indicator.position.y <= 64.0:
		if character_face._player._is_smiling:
			character_face._player._is_smiling = false
		_smile_sprite.pick_big_frown()

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if !mouse_in_area:
			return
		if smile_timer.is_stopped():
			smile_timer.start()
		if !audio_player.playing:
			audio_player.play_stretch()
		smile_timer.paused = true
		currently_moving = true
		_smile_indicator.global_position.y = clampf(get_global_mouse_position().y, full_smile, full_frown)
	if Input.is_action_just_released("left_click") and currently_moving:
		audio_player.stop()
		audio_player._timer.stop()
		smile_timer.paused = false
		currently_moving = false
		smile_timer.start()

func _on_mouse_entered() -> void:
	mouse_in_area = true

func _on_mouse_exited() -> void:
	mouse_in_area = false
