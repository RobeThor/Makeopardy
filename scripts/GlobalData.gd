extends Node

var question_open: bool = false
var teamScores: Array[int] = [0,0,0,0,0]
var currentTeam: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func correctAnswer(team, score, ):
	pass

func updateScore(scoreChanges: Array[int]):
	for i in range(teamScores.size()):
		teamScores[i] += scoreChanges[i]
