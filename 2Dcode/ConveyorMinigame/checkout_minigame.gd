extends Node2D
class_name ConveyorTime

@onready var checking_out: Area2D = %CheckingOut
@onready var player_checkout: Area2D = %PlayerCheckout
@onready var popup_location: Node2D = %PopupLocation
@onready var conveyor_pop_w := preload("res://2Dcode/ConveyorMinigame/conveyor_pop_W.tscn")
@onready var conveyor_pop_a := preload("res://2Dcode/ConveyorMinigame/conveyor_pop_A.tscn")
@onready var conveyor_pop_s := preload("res://2Dcode/ConveyorMinigame/conveyor_pop_S.tscn")
@onready var conveyor_pop_d := preload("res://2Dcode/ConveyorMinigame/conveyor_pop_D.tscn")
@onready var _audio_player: AudioStreamPlayer2D = %AudioStreamPlayer2D

@onready var _timer := Timer.new()
@onready var checking_out_keys: Array = [conveyor_pop_w, conveyor_pop_a, conveyor_pop_s, conveyor_pop_d]
@onready var directions_to_press: Array = []

var remaining_keys := 0: set = keys_empty
var guest_waiting := false
var current_guest = null
var stunned := false

func _ready() -> void:
	add_child(_timer)
	Happiness.total_complaints.connect(reset_checkout)

func reset_checkout():
	if (!current_guest == null):
		_checked_guest_out()
	guest_waiting = false
	current_guest = null
	stunned = false
	for children in popup_location.get_children():
		children.queue_free()
	directions_to_press.clear()
	remaining_keys = 0

func conveyor_minigame():
	if guest_waiting:
		var current_position := 0
		for possible_game in randi_range(3, 8):
			var wasd = checking_out_keys.pick_random().instantiate()
			popup_location.add_child(wasd)
			wasd.position.x += current_position * 40
			var direction = wasd.my_direction
			directions_to_press.append(direction)
			remaining_keys += 1
			current_position += 1
	else:
		return

func keys_empty(new_amount: int) -> void:
	remaining_keys = maxi(0, new_amount)
	if remaining_keys <= 0:
		if current_guest == null:
			return
		if current_guest:
			remaining_keys = 0
			_checked_guest_out()

func _checked_guest_out():
	if !current_guest == null:
		_audio_player.play_checkout()
		guest_waiting = false
		current_guest.waiting_for_checkout = false
		current_guest.can_move = true
		current_guest = null

func _on_checking_out_body_entered(guest: Guest) -> void:
	if !(current_guest == null):
		return
	guest.can_move = false
	current_guest = guest
	guest.waiting_for_checkout = true
	guest_waiting = true
	conveyor_minigame()

func _on_player_checkout_body_entered(player: Player) -> void:
	player.conveyor_minigame = true

func _on_player_checkout_body_exited(player: Player) -> void:
	player.conveyor_minigame = false

func not_stunned():
	stunned = false

func _on_d_player_direction_down() -> void:
	if directions_to_press.is_empty():
		return
	elif stunned:
		return
	elif !directions_to_press[0] == 2:
		_audio_player.play_error()
		stunned = true
		current_guest.happiness -= 5
		var tween = create_tween()
		tween.tween_property(popup_location.get_child(0), "position", popup_location.position + Vector2(10, 0), 0.05)
		tween.tween_property(popup_location.get_child(0), "position", popup_location.position - Vector2(10, 0), 0.1)
		tween.tween_property(popup_location.get_child(0), "position", popup_location.position, 0.05)
		tween.tween_callback(not_stunned)
	elif directions_to_press[0] == 2:
		_audio_player.play_register_key()
		remaining_keys -= 1
		directions_to_press.remove_at(0)
		popup_location.get_child(0).queue_free()
		for pos in popup_location.get_children():
			var tween = create_tween()
			tween.tween_property(pos, "position", pos.position - Vector2(40, 0), 0.05)
	else:
		return

func _on_d_player_direction_left() -> void:
	if directions_to_press.is_empty():
		return
	elif stunned:
		return
	elif !directions_to_press[0] == 1:
		_audio_player.play_error()
		stunned = true
		current_guest.happiness -= 5
		var tween = create_tween()
		tween.tween_property(popup_location.get_child(0), "position", popup_location.position + Vector2(10, 0), 0.05)
		tween.tween_property(popup_location.get_child(0), "position", popup_location.position - Vector2(10, 0), 0.1)
		tween.tween_property(popup_location.get_child(0), "position", popup_location.position, 0.05)
		tween.tween_callback(not_stunned)
	elif directions_to_press[0] == 1:
		_audio_player.play_register_key()
		remaining_keys -= 1
		directions_to_press.remove_at(0)
		popup_location.get_child(0).queue_free()
		for pos in popup_location.get_children():
			var tween = create_tween()
			tween.tween_property(pos, "position", pos.position - Vector2(40, 0), 0.05)

func _on_d_player_direction_right() -> void:
	if directions_to_press.is_empty():
		return
	elif stunned:
		return
	elif !directions_to_press[0] == 3:
		_audio_player.play_error()
		stunned = true
		current_guest.happiness -= 5
		var tween = create_tween()
		tween.tween_property(popup_location.get_child(0), "position", popup_location.position + Vector2(10, 0), 0.05)
		tween.tween_property(popup_location.get_child(0), "position", popup_location.position - Vector2(10, 0), 0.1)
		tween.tween_property(popup_location.get_child(0), "position", popup_location.position, 0.05)
		tween.tween_callback(not_stunned)
	elif directions_to_press[0] == 3:
		_audio_player.play_register_key()
		remaining_keys -= 1
		directions_to_press.remove_at(0)
		popup_location.get_child(0).queue_free()
		for pos in popup_location.get_children():
			var tween = create_tween()
			tween.tween_property(pos, "position", pos.position - Vector2(40, 0), 0.05)
	else:
		return

func _on_d_player_direction_up() -> void:
	if directions_to_press.is_empty():
		return
	elif stunned:
		return
	elif !directions_to_press[0] == 0:
		_audio_player.play_error()
		stunned = true
		current_guest.happiness -= 5
		var tween = create_tween()
		tween.tween_property(popup_location.get_child(0), "position", popup_location.position + Vector2(10, 0), 0.05)
		tween.tween_property(popup_location.get_child(0), "position", popup_location.position - Vector2(10, 0), 0.1)
		tween.tween_property(popup_location.get_child(0), "position", popup_location.position, 0.05)
		tween.tween_callback(not_stunned)
	elif directions_to_press[0] == 0:
		_audio_player.play_register_key()
		remaining_keys -= 1
		directions_to_press.remove_at(0)
		popup_location.get_child(0).queue_free()
		for pos in popup_location.get_children():
			var tween = create_tween()
			tween.tween_property(pos, "position", pos.position - Vector2(40, 0), 0.05)
	else:
		return
