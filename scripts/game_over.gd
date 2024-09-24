extends Control

var game_over_node
var before_node
var is_game_over_visible = false
	
func _on_restart_pressed():
	General.play_clic_sound()
	get_tree().reload_current_scene()
	
func _on_main_menu_pressed():
	General.play_clic_sound()
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	
func open_game_over(node_to_hide, node_to_show):
	is_game_over_visible = true
	before_node = node_to_hide
	game_over_node = node_to_show
	before_node.visible = false
	game_over_node.visible = true
	
func close_game_over():
	is_game_over_visible = false
	game_over_node.visible = false

func final_score(score):
	$GameOver/ActualScore.text = "Your score is " + str(score)
	General.save_score(score)
