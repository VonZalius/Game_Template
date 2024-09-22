extends Control

@onready var main_menu_button = $Options/MarginContainer/VBoxContainer/MainMenu

var options_node
var before_node
var is_options_visible = false

func _ready():
	$Options/Music/MusicSlider.value = Musics.music_volum
	Musics.change_music_volum( Musics.music_volum)
	$Options/Sound/SoundSlider.value = Musics.sound_volum
	Musics.change_sound_volum(Musics.sound_volum)

func _on_music_slider_value_changed(value):
	Musics.change_music_volum(value)

func _on_sound_slider_value_changed(value):
	Musics.change_sound_volum(value)

func _on_back_pressed():
	Musics.play_clic_sound()
	close_options()
	
func _on_main_menu_pressed():
	Musics.play_clic_sound()
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	
func open_options(node_to_hide, node_to_show, show_main_menu):
	is_options_visible = true
	before_node = node_to_hide
	options_node = node_to_show
	before_node.visible = false
	if show_main_menu:
		main_menu_button.visible = true
	options_node.visible = true
	
func close_options():
	is_options_visible = false
	before_node.visible = true
	main_menu_button.visible = false
	options_node.visible = false







