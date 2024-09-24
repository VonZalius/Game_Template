extends Node2D

var this_score = 0

func _ready():
	General.play_game_music()
# TEST, TO BE DELETED ---------------------------------------------------------
	print("Loading Game scene")
# TEST, TO BE DELETED ---------------------------------------------------------

func _process(_delta):
	$UI/ActualScore.text = "Score : " + str(this_score)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if $Options.is_options_visible == false:
			$Options.open_options($Game, $Options, true)
		elif $Options.is_options_visible == true:
			$Options.close_options()
			
# TEST, TO BE DELETED ---------------------------------------------------------
	if event.is_action_pressed("ui_test_1"):
		if $GameOver.is_game_over_visible == false:
			game_over()
		elif $GameOver.is_game_over_visible == true:
			$GameOver.close_game_over()
			
	if event.is_action_pressed("ui_test_2"):
		add_score(1)
# TEST, TO BE DELETED ---------------------------------------------------------

func game_over():
	$GameOver.final_score(this_score)
	$GameOver.open_game_over($Game, $GameOver)
	
func add_score(points):
	this_score += points
