extends Area2D

@onready var _player: Player = $".."

func _on_body_entered(guest: Guest) -> void:
	if (!_player.visible_guests.has(guest)):
		_player.visible_guests.append(guest)

func _on_body_exited(guest: Guest) -> void:
	if (_player.visible_guests.has(guest)):
		_player.visible_guests.erase(guest)

func _process(delta: float) -> void:
	if _player.visible_guests.is_empty():
		return
	if _player._is_waving:
		for guest in _player.visible_guests:
			guest.happiness += 2 * delta
	if !_player._is_smiling:
		for guest in _player.visible_guests:
			guest.happiness -= guest.ramping_anger * delta
			guest.ramping_anger += 0.01
	elif _player._is_smiling:
		for guest in _player.visible_guests:
			guest.happiness += 2 * delta

func _on_area_entered(area: GroceryArea) -> void:
	if !_player.shelves_in_range.has(area):
		_player.shelves_in_range.append(area)
	
func _on_area_exited(area: GroceryArea) -> void:
	if _player.shelves_in_range.has(area):
		_player.shelves_in_range.erase(area)
