extends Node2D
class_name TextIndicator

@onready var _animation_player: AnimationPlayer = %AnimationPlayer
@onready var _label: Label = %Label

func _ready() -> void:
	_animation_player.animation_finished.connect(
		func (_anim_name: String) -> void:
			queue_free()
	)

func display_text(_text: String) -> void:
	position.x += randf_range(-40.0, -24.0)
	_label.text = _text
