extends Node

signal scores_updated(new_score: Array)
signal change_current_team(teamNumber: int)

var question_open: bool = false
var teamScores: Array[int] = [0,0,0,0,0]
var currentTeam: int = 9

func updateScore(scoreChanges: Array):
	for i in range(teamScores.size()):
		teamScores[i] += scoreChanges[i]
	scores_updated.emit(teamScores)

func changeCurrentTeam(teamNumber: int):
	currentTeam = teamNumber
	change_current_team.emit(teamNumber)
