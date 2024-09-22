extends Node2D

func _ready():
	Musics.play_game_music()
# TEST, TO BE DELETED ---------------------------------------------------------
	print("Loading Game scene")
# TEST, TO BE DELETED ---------------------------------------------------------

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if $Options.is_options_visible == false:
			$Options.open_options($Game, $Options, true)
		elif $Options.is_options_visible == true:
			$Options.close_options()
			
# TEST, TO BE DELETED ---------------------------------------------------------
	if event.is_action_pressed("ui_test_1"):
		if $GameOver.is_game_over_visible == false:
			$GameOver.open_game_over($Game, $GameOver)
		elif $GameOver.is_game_over_visible == true:
			$GameOver.close_game_over()
# TEST, TO BE DELETED ---------------------------------------------------------
