extends Area2D
class_name Trash

var created_by = null

func _on_player_exited(body: CharacterBody2D) -> void:
	if body is Player:
		if (body.trash_in_range.has(self)):
			body.trash_in_range.erase(self)
	else:
		return

func _on_body_entered(body: CharacterBody2D) -> void:
	if created_by == body:
		return
	if body is Player:
		if (!body.trash_in_range.has(self)):
			body.trash_in_range.append(self)
	if body is Guest:
		body.happiness -= 5.0
