extends Control

@onready var pause_screen = preload("res://Globals/pause_screen.tscn")
@onready var title_screen = preload("res://Globals/title_screen.tscn")
@onready var game_UI = preload("res://Globals/game_UI.tscn")
@onready var victory_screen = preload("res://Globals/victory_screen.tscn")
@onready var audio_stream: AudioStreamPlayer2D = %AudioStreamPlayer2D

const CLICK_LONG_1 = preload("uid://dxhcxn44y5yu5")
const CLICK_LONG_2 = preload("uid://5xgdkjwlr30f")
const CLICK_SHORT_1 = preload("uid://c2ccvarih7tb")
const CLICK_SHORT_2 = preload("uid://d0koupjndikl4")

@onready var global_happiness := 0.0
@onready var total_guests := 0
@onready var guest_complaints := 0: set = set_guest_complaints

@warning_ignore("unused_signal")
signal sweeping
@warning_ignore("unused_signal")
signal empty_handed
@warning_ignore("unused_signal")
signal stocking
signal total_complaints

@onready var game_ui = null
@onready var pause_ui = null

func _ready() -> void:
	global_happiness = 0

func change_to_title_screen() -> void:
	game_ui.queue_free()
	pause_ui.queue_free()

func add_ingame_ui() -> void:
	var game_ui_start = game_UI.instantiate()
	game_ui = game_ui_start
	add_child(game_ui_start)
	var pause_screen_start = pause_screen.instantiate()
	pause_ui = pause_screen_start
	add_child(pause_screen_start)
	game_ui_start.pause_screen = pause_screen_start

func add_end_of_day_screen() -> void:
	var victory = victory_screen.instantiate()
	add_child(victory)
	victory.guest_count = total_guests
	victory.happiness = global_happiness

func play_sound(sound: AudioStreamWAV) -> void:
	audio_stream.set_stream(sound)
	audio_stream.play()

func update_happiness(new_happiness: float) -> void:
	global_happiness += new_happiness

func set_guest_complaints(new_complaint: int) -> void:
	guest_complaints = new_complaint
	total_complaints.emit()
	if guest_complaints >= 7:
		add_end_of_day_screen()
