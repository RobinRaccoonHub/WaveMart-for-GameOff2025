extends Area2D

func _on_body_entered(guest: Guest) -> void:
	guest.checkout_queue = true
