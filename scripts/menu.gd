extends Control

func _ready():
	Musics.play_menu_music()

func _on_play_pressed():
	Musics.play_clic_sound()
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_options_pressed():
	Musics.play_clic_sound()
	$Options.open_options($MainMenu, $Options, false)
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if $Options.is_options_visible == false:
			$Options.open_options($MainMenu, $Options, false)
		elif $Options.is_options_visible == true:
			$Options.close_options()

func _on_quit_pressed():
	Musics.play_clic_sound()
	Musics.save_settings()
	await get_tree().create_timer(0.2).timeout
	get_tree().quit()
