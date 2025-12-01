extends Control

@onready var level_1 := "res://2Dcode/test_world.tscn"
@onready var _ui_panel_container: PanelContainer = %UIPanelContainer
@onready var _background_panel: PanelContainer = %BackgroundPanel
@onready var _about_label: RichTextLabel = %AboutLabel
@onready var _return_button: Button = %ReturnButton

func _on_play_button_pressed() -> void:
	Happiness.play_sound(Happiness.CLICK_SHORT_1)
	Happiness.add_ingame_ui()
	get_tree().change_scene_to_file(level_1)

func _on_quit_button_pressed() -> void:
	Happiness.play_sound(Happiness.CLICK_SHORT_1)
	Happiness.audio_stream.finished.connect(get_tree().quit)

func _on_about_button_pressed() -> void:
	Happiness.play_sound(Happiness.CLICK_SHORT_1)
	_ui_panel_container.visible = false
	_background_panel.visible = true
	_about_label.visible = true
	_return_button.visible = true

func _on_return_button_pressed() -> void:
	Happiness.play_sound(Happiness.CLICK_SHORT_1)
	_ui_panel_container.visible = true
	_background_panel.visible = false
	_about_label.visible = false
	_return_button.visible = false
