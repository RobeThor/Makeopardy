extends Node

signal scores_updated(new_score: Array)
signal change_current_team(teamNumber: int)
signal page_complete(pageNumber: int)
signal game_finished(winningTeam: int)

var question_open: bool = false
var teamScores: Array[int] = [0,0,0,0,0]
var currentTeam: int = 9
var numberOfQuestions: int
var questionsAnswered: int = 0

var currentPage: int = 0
var pageArray = []

func updateScore(scoreChanges: Array):
	for i in range(teamScores.size()):
		teamScores[i] += scoreChanges[i]
	scores_updated.emit(teamScores)

func changeCurrentTeam(teamNumber: int):
	currentTeam = teamNumber
	change_current_team.emit(teamNumber)

func updateQuestionsAnswered():
	questionsAnswered = questionsAnswered + 1
	if questionsAnswered >= pageArray[currentPage][1]:
		currentPage += 1
		if currentPage < pageArray.size():
			page_complete.emit(currentPage)
			return
		game_finished.emit(teamScores.find(teamScores.max()))
	
func addQuestion():
	numberOfQuestions = numberOfQuestions + 1
