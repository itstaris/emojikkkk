extends Control

func _on_play_again_button_button_up() -> void:
	await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_file("res://Scenes/ui.tscn")

func _on_quit_button_button_up() -> void:
	await get_tree().create_timer(1.5).timeout
	get_tree().quit()
