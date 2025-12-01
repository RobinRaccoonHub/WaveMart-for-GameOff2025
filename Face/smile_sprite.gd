extends Sprite2D

const BIG_SMILE_1 = preload("uid://bdosdenhrcels")
const BIG_SMILE_2 = preload("uid://c8m61o1rjgr32")
const BIG_SMILE_3 = preload("uid://bn5dpm5k0u1tk")
const BIG_SMILE_4 = preload("uid://bwq05fa4sgwwa")
const BIG_SMILE_5 = preload("uid://d27vmitfex1o8")
const BIG_FROWN_1 = preload("uid://t2prma4r47jk")
const BIG_FROWN_2 = preload("uid://c7jiyet8gxbbl")
const BIG_FROWN_3 = preload("uid://bd8eqf1osqmnc")
const SLIGHT_FROWN_1 = preload("uid://c7eo8ou2y0s7b")
const SLIGHT_FROWN_2 = preload("uid://bgoqgvpqm671t")
const SLIGHT_FROWN_3 = preload("uid://dsmg6cp5axii4")
const SLIGHT_FROWN_4 = preload("uid://da5pkxqgtx055")
const SLIGHT_FROWN_5 = preload("uid://csijgtvwi81g3")
const SLIGHT_SMILE_1 = preload("uid://2vdcweneubd5")
const SLIGHT_SMILE_2 = preload("uid://t0822x0v2lif")
const SLIGHT_SMILE_3 = preload("uid://bd7aiwvn51d0")
const SLIGHT_SMILE_4 = preload("uid://dwv5dtqlwyp4a")
const SLIGHT_SMILE_5 = preload("uid://ptb7k60u3edu")
const SLIGHT_SMILE_6 = preload("uid://dd1uhbfq1yy10")

@onready var big_smile_array: Array = [
	BIG_SMILE_1, BIG_SMILE_2, BIG_SMILE_3, BIG_SMILE_4, BIG_SMILE_5
]
@onready var big_frown_array: Array = [
	BIG_FROWN_1, BIG_FROWN_2, BIG_FROWN_3
]
@onready var slight_smile_array: Array = [
	SLIGHT_SMILE_1, SLIGHT_SMILE_2, SLIGHT_SMILE_3, SLIGHT_SMILE_4, SLIGHT_SMILE_5, SLIGHT_SMILE_6
]
@onready var slight_frown_array: Array = [
	SLIGHT_FROWN_1, SLIGHT_FROWN_2, SLIGHT_FROWN_3, SLIGHT_FROWN_4, SLIGHT_FROWN_5
]
@onready var _timer := Timer.new()

var current_mouth = big_smile_array.pick_random()

func _ready() -> void:
	set_texture(current_mouth)
	add_child(_timer)
	_timer.wait_time = 0.35
	_timer.one_shot = true
	_timer.start()

func pick_big_smile() -> void:
	if !_timer.is_stopped():
		return
	else:
		var random = big_smile_array.pick_random()
		if random == current_mouth:
			random = big_smile_array.pick_random()
		current_mouth = random
		set_texture(random)
		_timer.start()

func pick_big_frown() -> void:
	if !_timer.is_stopped():
		return
	else:
		var random = big_frown_array.pick_random()
		if random == current_mouth:
			random = big_frown_array.pick_random()
		current_mouth = random
		set_texture(random)
		_timer.start()

func pick_slight_smile() -> void:
	if !_timer.is_stopped():
		return
	else:
		var random = slight_smile_array.pick_random()
		if random == current_mouth:
			random = slight_smile_array.pick_random()
		current_mouth = random
		set_texture(random)
		_timer.start()

func pick_slight_frown() -> void:
	if !_timer.is_stopped():
		return
	else:
		var random = slight_frown_array.pick_random()
		if random == current_mouth:
			random = slight_frown_array.pick_random()
		current_mouth = random
		set_texture(random)
		_timer.start()
