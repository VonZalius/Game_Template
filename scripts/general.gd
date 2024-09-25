extends Node

var music_bus = AudioServer.get_bus_index("Music")
var sound_bus = AudioServer.get_bus_index("Sound")

var music_volum
var sound_volum

const MAX_SCORES = 50
const SCORE_FILE = "user://high_scores.save"

func _ready():
	load_settings()

func play_menu_music():
	if $MenuMusic.playing == false:
		$GameMusic.stop()
		$MenuMusic.play()
	
func play_game_music():
	if $GameMusic.playing == false:
		$MenuMusic.stop()
		$GameMusic.play()
		
func play_clic_sound():
	$ClicSound.play()
		
func change_music_volum(value):
	music_volum = value
	var volume_db = value_to_db(value)
	AudioServer.set_bus_volume_db(music_bus, volume_db)
	
func change_sound_volum(value):
	sound_volum = value
	var volume_db = value_to_db(value)
	AudioServer.set_bus_volume_db(sound_bus, volume_db)

func value_to_db(value: float) -> float:
	if value == 0:
		return -80 
	return lerp(-20, 6, value)  # Interpolation linéaire entre -80 dB et +6 dB


func load_settings():
	var config = ConfigFile.new()
	var error = config.load("user://settings.cfg")  # Charge depuis le fichier de configuration
	
	if error == OK:
		music_volum = config.get_value("audio", "music_volum", 0.7)  # 0.7 est la valeur par défaut
		sound_volum = config.get_value("audio", "sound_volum", 0.7)
	else:
		music_volum = 0.7
		sound_volum = 0.7
		save_settings()
		load_settings()

func save_settings():
	var config = ConfigFile.new()
	config.set_value("audio", "music_volum", music_volum)
	config.set_value("audio", "sound_volum", sound_volum)
	
	var error = config.save("user://settings.cfg")  # Sauvegarde dans le répertoire utilisateur
	if error != OK:
		print("Erreur lors de la sauvegarde des paramètres")

func save_score(current_score):
	var scores = load_scores()

	scores.append(current_score)

	scores.sort()
	scores.reverse()

	if scores.size() > MAX_SCORES:
		scores.resize(MAX_SCORES)

	var file = FileAccess.open(SCORE_FILE, FileAccess.WRITE)
	if file:
		for score in scores:
			file.store_line(str(score))
		file.close()

func load_scores() -> Array:
	var scores = []
	if FileAccess.file_exists(SCORE_FILE):
		var file = FileAccess.open(SCORE_FILE, FileAccess.READ)
		if file:
			while not file.eof_reached():
				var line = file.get_line()
				var score = int(line)
				scores.append(score)
			file.close()
	scores.sort()
	scores.reverse()
	return scores


