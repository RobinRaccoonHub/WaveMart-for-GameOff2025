extends AudioStreamPlayer2D

const CHEESY_LOOP_A_1 = preload("uid://0g2hns3b7fkl")
const CHEESY_LOOP_A_2 = preload("uid://liidhwveiwhy")


func _on_finished() -> void:
	if stream == CHEESY_LOOP_A_1:
		set_stream(CHEESY_LOOP_A_2)
		play()
	elif stream == CHEESY_LOOP_A_2:
		set_stream(CHEESY_LOOP_A_1)
		play()
