extends MarginContainer

var teamNumber: int
var audioRefArray = []

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
