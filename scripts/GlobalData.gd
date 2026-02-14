extends Node

signal scores_updated(new_score: Array)
signal change_current_team(teamNumber: int)
signal game_finished(winningTeam: int)

var question_open: bool = false
var teamScores: Array[int] = [0,0,0,0,0]
var currentTeam: int = 9
var numberOfQuestions: int
var questionsAnswered: int = 0

func updateScore(scoreChanges: Array):
	for i in range(teamScores.size()):
		teamScores[i] += scoreChanges[i]
	scores_updated.emit(teamScores)

func changeCurrentTeam(teamNumber: int):
	currentTeam = teamNumber
	change_current_team.emit(teamNumber)

func updateQuestionsAnswered():
	questionsAnswered = questionsAnswered + 1
	if questionsAnswered >= numberOfQuestions:
		game_finished.emit(teamScores.find(teamScores.max()))
	
func addQuestion():
	numberOfQuestions = numberOfQuestions + 1
