extends Control

func _ready():
	General.play_menu_music()

func _on_play_pressed():
	General.play_clic_sound()
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_score_pressed():
	General.play_clic_sound()
	$Score.open_score($MainMenu, $Score)
	
	
func _on_options_pressed():
	General.play_clic_sound()
	$Options.open_options($MainMenu, $Options, false)
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if $Options.is_options_visible == true:
			$Options.close_options()
		elif $Score.is_score_visible == true:
			$Score.close_score()
		elif $Options.is_options_visible == false:
			$Options.open_options($MainMenu, $Options, false)

func _on_quit_pressed():
	General.play_clic_sound()
	General.save_settings()
	await get_tree().create_timer(0.2).timeout
	get_tree().quit()


