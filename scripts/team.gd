extends MarginContainer

signal team_clicked(teamNumber: int)

var teamNumber: int
var audioRefArray = []
var isWinner := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setTeam(teamName: String, teamIndex: int):
	$VBoxContainer/TeamName.text = teamName
	$VBoxContainer/Score.text = "0"
	teamNumber = teamIndex
	
	var audioStreamRandomizer = AudioStreamRandomizer.new()
	audioStreamRandomizer.random_pitch = 1.1
	for i in range(1, 7):
		audioRefArray.append(load("res://audio/%d_%d.mp3" % [teamNumber, i]))
		audioStreamRandomizer.add_stream(-1, audioRefArray[i-1])
	$AudioStreamPlayer.stream = audioStreamRandomizer

func setScore(score: int):
	$VBoxContainer/Score.text = str(score)
	
func toggleActive(active: bool):
	$TeamLight.enabled = active
	if (active):
		$AudioStreamPlayer.play()
		$Particles.emitting = true

func changeTeamName(newName: String):
	$VBoxContainer/TeamName.text = newName

func _on_button_pressed() -> void:
	team_clicked.emit(teamNumber)

func celebrate():
	isWinner = true
	$Particles.one_shot = false
	$Particles.explosiveness = 0
	$Particles.emitting = true
	$AudioStreamPlayer.play()


func _on_audio_stream_player_finished() -> void:
	if isWinner:
		$AudioStreamPlayer.play()
