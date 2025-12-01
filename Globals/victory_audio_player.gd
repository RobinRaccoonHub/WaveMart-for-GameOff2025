extends AudioStreamPlayer2D

const RECEIPT_1 = preload("uid://cahbqqkx03o4b")
const RECEIPT_2 = preload("uid://c64pu5kie6rlj")
const RECEIPT_3 = preload("uid://bm5sufqao7d15")
const STAMP = preload("uid://b6ebxjltdhcb7")

func play_receipt_1() -> void:
	set_stream(RECEIPT_1)
	play()

func play_receipt_2() -> void:
	set_stream(RECEIPT_2)
	play()

func play_receipt_3() -> void:
	set_stream(RECEIPT_3)
	play()

func play_stamp() -> void:
	set_stream(STAMP)
	play()
