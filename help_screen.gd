extends Control

@onready var _blur_color_rect: ColorRect = %BlurColorRect

@export_range(0, 1.0) var blur_amount := 0.0:
	set = set_blur_amount

var _tween = Tween

func _ready() -> void:
	initiate_blur()

func set_blur_amount(amount: float) -> void:
	_blur_color_rect.material.set_shader_parameter("blur_amount", lerp(0.0, 1.5, amount))
	_blur_color_rect.material.set_shader_parameter("saturation", lerp(1.0, 0.3, amount))
	_blur_color_rect.material.set_shader_parameter("tint_strength", lerp(0.0, 0.2, amount))

func initiate_blur() -> void:
	_tween = create_tween()
	_tween.tween_property(self, "blur_amount", 1.0, 1.2)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		queue_free()

func _on_texture_button_pressed() -> void:
	Happiness.play_sound(Happiness.CLICK_SHORT_1)
	queue_free()
