extends AudioStreamPlayer2D

const CHATTER_1 = preload("uid://bc5sh0ydkmx63")
const CHATTER_2 = preload("uid://b624vda4u8g3u")
const CHATTER_3 = preload("uid://d1o5kpe5pmqa5")
const CHATTER_4 = preload("uid://cs57if7qlgj1n")
const CHATTER_5 = preload("uid://bc8rwaaxnwh3t")
const CHATTER_6 = preload("uid://ceuoe3vd78p5c")

@onready var random_chatter: Array[AudioStreamWAV] = [
	CHATTER_1, CHATTER_2, CHATTER_3, CHATTER_4, CHATTER_5, CHATTER_6
]

@onready var _timer := Timer.new()

func _ready() -> void:
	add_child(_timer)
	_timer.wait_time = randf_range(1.0, 3.0)
	_timer.one_shot = true
	var random_pitch = randf_range(0.8, 1.2)
	set_pitch_scale(random_pitch)
	_timer.timeout.connect(play_chatter)
	play_chatter()

func play_chatter() -> void:
	var chatter = random_chatter.pick_random()
	set_stream(chatter)
	play()


func _on_finished() -> void:
	_timer.start()
	_timer.wait_time = randf_range(1.0, 3.0)
	
