extends AudioStreamPlayer2D

const BROOM_1 = preload("uid://bho4d2x4lo4xx")
const BROOM_2 = preload("uid://dahwxn4sqe1kf")
const BROOM_3 = preload("uid://beypbs6wi3fci")
const BROOM_4 = preload("uid://dytamx5ekg21p")
const BROOM_5 = preload("uid://c3k88dnpovuy4")
const BROOM_6 = preload("uid://d1dfywvgutx8v")
const BROOM_7 = preload("uid://btictqii360u6")
const BROOM_8 = preload("uid://bt0t6vupvoqb1")

@onready var broom_array: Array[AudioStreamWAV] = [
	BROOM_1, BROOM_2, BROOM_3, BROOM_4, BROOM_5, BROOM_6, BROOM_7, BROOM_8
]

func play_broom_audio() -> void:
	set_stream(broom_array.pick_random())
	play()
