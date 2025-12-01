extends Sprite2D

const GUEST_SKIN_1 = preload("uid://b2eq0iq3u6ojl")
const GUEST_SKIN_2 = preload("uid://c3puofdax3g4q")
const GUEST_SKIN_3 = preload("uid://dy1nhu6l3lfnf")
const GUEST_SKIN_4 = preload("uid://b0q3iq6g1ipuy")
const GUEST_SKIN_5 = preload("uid://bj3r6kts354t1")
const GUEST_SKIN_6 = preload("uid://dljgcgpwsbb6g")

@onready var random_skin := [GUEST_SKIN_1, GUEST_SKIN_2, GUEST_SKIN_3, GUEST_SKIN_4, GUEST_SKIN_5, GUEST_SKIN_6]

func _ready() -> void:
	var skin = random_skin.pick_random()
	set_texture(skin)
