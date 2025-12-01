extends Sprite2D

const LEFT_EYE_1 = preload("uid://caqxxv7kcl034")
const LEFT_EYE_2 = preload("uid://bcecw6sflndi8")
const LEFT_EYE_3 = preload("uid://dai16oyecs1w7")
const LEFT_EYE_4 = preload("uid://b4o8qajen3t4i")
const LEFT_EYE_5 = preload("uid://b0s6a34xvtyaj")
const LEFT_EYE_6 = preload("uid://c5tdfea6rsf6f")
const LEFT_EYE_7 = preload("uid://iojj3gawmjoa")
const LEFT_EYE_8 = preload("uid://dci38goyw6mau")
const LEFT_EYE_9 = preload("uid://cy4fcgjxj6j1v")
const LEFT_EYE_CLOSED_1 = preload("uid://dkd4mlceyng08")
const LEFT_EYE_CLOSED_2 = preload("uid://db5sblhbb86jm")
const LEFT_EYE_CLOSED_3 = preload("uid://cr5uga53q8e3m")

@onready var eye_array: Array = [
	LEFT_EYE_1, LEFT_EYE_2, LEFT_EYE_3, LEFT_EYE_4, LEFT_EYE_5, LEFT_EYE_6, LEFT_EYE_7, LEFT_EYE_8, LEFT_EYE_9, LEFT_EYE_CLOSED_1, LEFT_EYE_CLOSED_2, LEFT_EYE_CLOSED_3
]

@onready var _timer := Timer.new()

@onready var current_eye = eye_array.pick_random()

func _ready() -> void:
	set_texture(current_eye)
	add_child(_timer)
	_timer.wait_time = 0.35
	_timer.start()
	_timer.timeout.connect(random_eye)

func random_eye() -> void:
	var random = eye_array.pick_random()
	if random == current_eye:
		random = eye_array.pick_random()
	current_eye = random
	set_texture(random)
