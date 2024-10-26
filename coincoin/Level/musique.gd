extends Node2D


const JOUR_MUSIC_01 = preload("res://dossier/musique + ambiance/jour music 01.mp3")
const JOUR_MUSIC_02 = preload("res://dossier/musique + ambiance/jour music 02.mp3")
const JOUR_MUSIC_03 = preload("res://dossier/musique + ambiance/jour music 03.mp3")

const NIGHT_MUSIC_02 = preload("res://dossier/musique + ambiance/night music02.mp3")
const NIGHT_MUSIC_03 = preload("res://dossier/musique + ambiance/night music03.mp3")
const NIGHT_MUSIC_1 = preload("res://dossier/musique + ambiance/night music1.mp3")

var last_moment
var boss_musique := false

func _ready() -> void:
	Globals.musique = self


func raid_musique(start):
	if start == true:
		for i in get_children():
			i.stop()
		$boss.play()
		boss_musique = true
	else:
		$boss.stop()
		transi(last_moment)
		boss_musique = false
		


func transi(moment):
	last_moment = moment
	if !boss_musique:
		if moment == "day":
			$"morning transi".play()
			$"morning ambiance".play()
			$"night ambiance".stop()
			
			$"night musique".stop()
			
			
		elif moment == "night":
			$"night transi".play()
			$"night ambiance".play()
			$"morning ambiance".stop()
			$"day musique".stop()


func _on_day_musique_finished() -> void:
	var check = randi()%3
	if check == 0:
		$"day musique".stream = JOUR_MUSIC_01
	elif check == 1:
		$"day musique".stream = JOUR_MUSIC_02
	elif check == 2:
		$"day musique".stream = JOUR_MUSIC_03
	$"day musique".play()


func _on_boss_finished() -> void:
	if boss_musique:
		$boss.play()


func _on_morning_transi_finished() -> void:
	$"day musique".play()


func _on_night_transi_finished() -> void:
	if Globals.bone_counter.current_bones > 130:
		$"night musique".stream = NIGHT_MUSIC_1
	elif Globals.bone_counter.current_bones > 70:
		$"night musique".stream = NIGHT_MUSIC_03
	else:
		$"night musique".stream = NIGHT_MUSIC_02
	$"night musique".play()
