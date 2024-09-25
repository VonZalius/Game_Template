extends Control

var score_node
var before_node
var is_score_visible = false
const max_display = 5

func _ready():
	charge_actual_score()

func _on_back_pressed():
	General.play_clic_sound()
	close_score()
	
func open_score(node_to_hide, node_to_show):
	is_score_visible = true
	before_node = node_to_hide
	score_node = node_to_show
	before_node.visible = false
	score_node.visible = true
	
func close_score():
	is_score_visible = false
	before_node.visible = true
	score_node.visible = false

func charge_actual_score():
	var actual_score = General.load_scores()
	for i in range(max_display):
		if(i < actual_score.size() && actual_score[i] != 0):
				$Score/ActualScore.text += str(actual_score[i]) + "\n"
