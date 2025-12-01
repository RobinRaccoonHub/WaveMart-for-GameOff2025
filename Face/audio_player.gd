extends AudioStreamPlayer2D

const STRETCH_1 = preload("uid://bcomii6nllcd2")
const STRETCH_2 = preload("uid://cwxqr6it1j58t")
const STRETCH_3 = preload("uid://djrk4a7gb5xhc")
const STRETCH_4 = preload("uid://bvp7vtecg7egr")

@onready var _timer := Timer.new()

var random_stretch: Array[AudioStreamWAV] = [
	STRETCH_1, STRETCH_2, STRETCH_3, STRETCH_4
]

func _ready() -> void:
	add_child(_timer)
	_timer.wait_time = 1.5
	_timer.one_shot = true

func play_stretch() -> void:
	if _timer.is_stopped():
		var stretch = random_stretch.pick_random()
		set_stream(stretch)
		play()
		_timer.start()
