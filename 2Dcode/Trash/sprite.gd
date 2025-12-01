extends Sprite2D

const ALCOHOL_1 = preload("uid://inr83t1567dj")
const ALCOHOL_2 = preload("uid://drwwvppdxe21u")
const ALCOHOL_3 = preload("uid://cdxgvps0ku2dp")
const ALCOHOL_4 = preload("uid://bq7kvvtm1bonw")
const CRUMPLED_PAPER_1 = preload("uid://b8h6hqci5q6g0")
const CRUMPLED_PAPER_2 = preload("uid://cn53fevf6tvgn")
const WATER_BOTTLE_CLEAN = preload("uid://b8m27gsy5kf1e")
const WATER_BOTTLE_CRUMPLED = preload("uid://l83nfef6jb5r")
const WATER_BOTTLE_DIRTY = preload("uid://batrruxufjnnd")

@onready var random_trash: Array = [
	ALCOHOL_1, ALCOHOL_2, ALCOHOL_3, ALCOHOL_4, CRUMPLED_PAPER_1, CRUMPLED_PAPER_2, WATER_BOTTLE_CLEAN, WATER_BOTTLE_CRUMPLED, WATER_BOTTLE_DIRTY
]

func _ready() -> void:
	var random_texture = random_trash.pick_random()
	set_texture(random_texture)
