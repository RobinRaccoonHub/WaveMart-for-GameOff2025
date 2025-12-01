extends Control

@onready var audio_player: AudioStreamPlayer2D = $AudioPlayer
@onready var end_of_day: RichTextLabel = %EndOfDay
@onready var number_of_guests: RichTextLabel = %NumberOfGuests
@onready var guest_numbers: RichTextLabel = %GuestNumbers
@onready var average_happiness: RichTextLabel = %AverageHappiness
@onready var happiness_meter: RichTextLabel = %HappinessMeter
@onready var employment_status: RichTextLabel = %EmploymentStatus
@onready var you_have_been: RichTextLabel = %YouHaveBeen
@onready var fired: RichTextLabel = %FIRED
@onready var promoted: RichTextLabel = %PROMOTED
@onready var _blur_color_rect: ColorRect = %BlurColorRect

@export_range(0, 1.0) var blur_amount := 0.0:
	set = set_blur_amount

var guest_count: int = 0
var happiness: float = 0.0

var _tween = Tween

func _ready() -> void:
	guest_count = Happiness.total_guests
	happiness = Happiness.global_happiness
	get_tree().paused = true
	initiate_blur()

func set_blur_amount(amount: float) -> void:
	_blur_color_rect.material.set_shader_parameter("blur_amount", lerp(0.0, 1.5, amount))
	_blur_color_rect.material.set_shader_parameter("saturation", lerp(1.0, 0.3, amount))
	_blur_color_rect.material.set_shader_parameter("tint_strength", lerp(0.0, 0.2, amount))

func initiate_blur() -> void:
	_tween = create_tween()
	_tween.tween_property(self, "blur_amount", 1.0, 2.3)
	_tween.tween_callback(end_of_day_show_text)

func end_of_day_show_text() -> void:
	audio_player.play_receipt_1()
	_tween = create_tween()
	_tween.tween_property(end_of_day, "visible_ratio", 1.0, 1.15)
	_tween.tween_property(end_of_day, "visible_ratio", 1.0, 0.4)
	_tween.tween_callback(number_of_guests_show_text)

func number_of_guests_show_text() -> void:
	audio_player.play_receipt_2()
	_tween = create_tween()
	_tween.tween_property(number_of_guests, "visible_ratio", 1.0, 1.1)
	_tween.tween_property(number_of_guests, "visible_ratio", 1.0, 0.4)
	_tween.tween_callback(guest_numbers_show_text)

func guest_numbers_show_text() -> void:
	audio_player.play_stamp()
	guest_numbers.set_text(str(guest_count))
	_tween = create_tween()
	_tween.tween_property(guest_numbers, "visible_ratio", 0.0, 0.15)
	_tween.tween_property(guest_numbers, "visible_ratio", 1.0, 0.01)
	_tween.tween_property(guest_numbers, "visible_ratio", 1.0, 0.85)
	_tween.tween_callback(average_happiness_show_text)

func average_happiness_show_text() -> void:
	audio_player.play_receipt_1()
	_tween = create_tween()
	_tween.tween_property(average_happiness, "visible_ratio", 1.0, 1.15)
	_tween.tween_property(average_happiness, "visible_ratio", 1.0, 0.4)
	_tween.tween_callback(happiness_meter_show_text)

func happiness_meter_show_text() -> void:
	audio_player.play_stamp()
	var snapped_happiness = snapped(happiness, 0.1)
	happiness_meter.set_text(str(snapped_happiness))
	_tween = create_tween()
	_tween.tween_property(happiness_meter, "visible_ratio", 0.0, 0.15)
	_tween.tween_property(happiness_meter, "visible_ratio", 1.0, 0.01)
	_tween.tween_property(happiness_meter, "visible_ratio", 1.0, 0.85)
	_tween.tween_callback(employment_status_show_text)

func employment_status_show_text() -> void:
	audio_player.play_receipt_2()
	_tween = create_tween()
	_tween.tween_property(employment_status, "visible_ratio", 1.0, 1.1)
	_tween.tween_property(employment_status, "visible_ratio", 1.0, 0.4)
	_tween.tween_callback(you_have_been_show_text)

func you_have_been_show_text() -> void:
	audio_player.play_receipt_3()
	_tween = create_tween()
	_tween.tween_property(you_have_been, "visible_ratio", 1.0, 0.5)
	_tween.tween_property(you_have_been, "visible_ratio", 1.0, 1.5)
	_tween.tween_callback(fired_show_text)

func fired_show_text() -> void:
	audio_player.play_stamp()
	_tween = create_tween()
	_tween.tween_property(fired, "visible_ratio", 0.0, 0.15)
	_tween.tween_property(fired, "visible_ratio", 1.0, 0.01)
	_tween.tween_property(fired, "visible_ratio", 1.0, 0.85)

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Globals/title_screen.tscn")
	Happiness.change_to_title_screen()
	queue_free()
