extends AudioStreamPlayer2D

const BELL_1 = preload("uid://e2mqyxo8qw48")
const BELL_2 = preload("uid://b00d4bi3eusd5")
const BELL_3 = preload("uid://cxa1sweb32isn")
const BELL_4 = preload("uid://b6si8n5lm12o6")
const BELL_5 = preload("uid://cvjs4jc6jfw2b")
const BELL_6 = preload("uid://cglw87j0u04w6")
const BELL_7 = preload("uid://wr86nf8vev51")
const BUTTON_1 = preload("uid://bvkdissxo8cch")
const BUTTON_2 = preload("uid://buwg3wphn7o8r")
const BUTTON_3 = preload("uid://10dlm7p3nji8")
const BUTTON_4 = preload("uid://crioyu1n2n4mt")
const BUTTON_5 = preload("uid://bjxl5hp0rarj0")
const BUTTON_6 = preload("uid://b0hl1gi42iinh")
const BUTTON_7 = preload("uid://c8d4ou3jgmc8v")
const BUTTON_8 = preload("uid://cpuu0iimr3t65")
const BUTTON_9 = preload("uid://e865l33o56q1")
const ERROR_SOUND = preload("uid://davgb5pqiocfm")

@onready var button_array: Array[AudioStreamWAV] = [
	BUTTON_1, BUTTON_2, BUTTON_3, BUTTON_4, BUTTON_5, BUTTON_6, BUTTON_7, BUTTON_8, BUTTON_9
]
@onready var bell_array: Array[AudioStreamWAV] = [
	BELL_1, BELL_1, BELL_1, BELL_1, BELL_1, BELL_1, BELL_1
]

func play_register_key() -> void:
	var random_button = button_array.pick_random()
	set_stream(random_button)
	play()

func play_checkout() -> void:
	var random_bell = bell_array.pick_random()
	set_stream(random_bell)
	play()

func play_error() -> void:
	set_stream(ERROR_SOUND)
	play()
