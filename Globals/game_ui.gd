extends Control

@onready var pause_screen: Pause = null
@onready var x_1: TextureRect = %X1
@onready var x_2: TextureRect = %X2
@onready var x_3: TextureRect = %X3
@onready var x_4: TextureRect = %X4
@onready var x_5: TextureRect = %X5
@onready var x_6: TextureRect = %X6
@onready var x_7: TextureRect = %X7

@onready var x_array: Array[TextureRect] = [
	x_1, x_2, x_3, x_4, x_5, x_6, x_7
]

var happiness_bar_amount = 0.0
var current_x_number := 0


func _ready() -> void:
	Happiness.total_complaints.connect(update_complaint_bar)

func update_complaint_bar() -> void:
	var visible_x = x_array[current_x_number]
	visible_x.visible = true
	current_x_number += 1

func _on_settings_button_pressed() -> void:
	Happiness.play_sound(Happiness.CLICK_SHORT_1)
	pause_screen.toggle()

func _on_help_button_pressed() -> void:
	Happiness.play_sound(Happiness.CLICK_SHORT_1)
	var help_screen := preload("res://help_screen.tscn").instantiate()
	Happiness.add_child(help_screen)

func _on_empty_button_pressed() -> void:
	Happiness.play_sound(Happiness.CLICK_LONG_1)
	Happiness.empty_handed.emit()

func _on_broom_button_pressed() -> void:
	Happiness.play_sound(Happiness.CLICK_LONG_1)
	Happiness.sweeping.emit()

func _on_stock_button_pressed() -> void:
	Happiness.play_sound(Happiness.CLICK_LONG_1)
	Happiness.stocking.emit()
