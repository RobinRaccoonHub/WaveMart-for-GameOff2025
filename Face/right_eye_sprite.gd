extends Sprite2D

const RIGHT_EYE_1 = preload("uid://d3375wn6yvvin")
const RIGHT_EYE_2 = preload("uid://co6u0wopqn5s3")
const RIGHT_EYE_3 = preload("uid://cj2mj61oxnvpw")
const RIGHT_EYE_4 = preload("uid://bfqsjgg0b8vkt")
const RIGHT_EYE_5 = preload("uid://6cdoilft8cd6")
const RIGHT_EYE_6 = preload("uid://c4vyqyl40ou8e")
const RIGHT_EYE_7 = preload("uid://bmtrcu7ohn6gm")
const RIGHT_EYE_8 = preload("uid://c2c5owjku1oxc")
const RIGHT_EYE_9 = preload("uid://22hym24p1nyx")
const RIGHT_EYE_CLOSED_1 = preload("uid://gn1mnwy7uy2a")
const RIGHT_EYE_CLOSED_2 = preload("uid://bgxmiax6t8r77")
const RIGHT_EYE_CLOSED_3 = preload("uid://nbhjyrkoevb7")

@onready var eye_array: Array = [
	RIGHT_EYE_1, RIGHT_EYE_2, RIGHT_EYE_3, RIGHT_EYE_4, RIGHT_EYE_5, RIGHT_EYE_6, RIGHT_EYE_7, RIGHT_EYE_8, RIGHT_EYE_9, RIGHT_EYE_CLOSED_1, RIGHT_EYE_CLOSED_2, RIGHT_EYE_CLOSED_3
]

@onready var _timer := Timer.new()

@onready var current_eye = null

func _ready() -> void:
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
