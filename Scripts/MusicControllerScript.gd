extends Node
class_name MusicController

@export var default_bus := "Music"

var Player: AudioStreamPlayer
var CurrentPath: String = ""
var volumeDb: float = -20.0

func _ready() -> void:
	Player = AudioStreamPlayer.new()
	Player.name = "MusicPlayer"
	Player.bus = default_bus
	Player.autoplay = false
	Player.process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(Player)

func PlayMusic(stream: AudioStream, RestartIfSame: bool = false) -> void:
	var path := ""
	if stream == null:
		return
	if stream is Resource:
		path = (stream as Resource).resource_path
	
	if not RestartIfSame and path !="" and path == CurrentPath and Player.playing:
		return
	CurrentPath = path
	Player.stream = stream
	Player.volume_db = volumeDb
	Player.play()

func PlayMusicPath(path : String, RestartIfSame:bool=false) -> void:
	if path == "":
		return
	var stream := load(path) as AudioStream
	PlayMusic(stream, RestartIfSame)

func PauseMusic(pause: bool = true) -> void:
	Player.stream_paused = pause

func FadeTo(path: String, FadeOutSec := 0.4, FadeInSec := 0.4) -> void:
	var tween := create_tween()
	tween.tween_property(Player, "volume_db", -40.0, FadeOutSec)
	tween.tween_callback(func(): 
		PlayMusicPath(path,true)
		Player.volume_db = -40.0
	)
	tween.tween_property(Player, "volume_db", volumeDb, FadeInSec)
