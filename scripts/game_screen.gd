extends Panel

@export var question_container_scene := preload("res://scenes/question_container.tscn")
@export var team_scene := preload("res://scenes/team.tscn")
@export var page_scene := preload("res://scenes/page.tscn")

@onready var page_container = $QuestionField/HBoxContainer2/CenterContainer/VBoxContainer/PageContainer

var file = "res://jeopardyFormat.json"
var teamArray = []

func _ready() -> void:
	var json_string = FileAccess.get_file_as_string(file)
	GlobalData.scores_updated.connect(_on_scores_updated)
	GlobalData.change_current_team.connect(_on_change_team)
	GlobalData.page_complete.connect(_on_page_complete)
	GlobalData.game_finished.connect(_on_game_finished)
	$TeamNameInput.submit_team_name.connect(_update_team_name)
	
	var json_as_dict: Dictionary = JSON.parse_string(json_string)
	if !json_as_dict:
		print("Error parsing JSON")
		return
	createPages(json_as_dict.pages)
	createTeams()

func createPages(pages: Dictionary):
	var pageCount := 0
	for page in pages:
		var page_instance = page_scene.instantiate()
		page_container.add_child(page_instance)
		page_instance.providePageData(pages[page], pageCount)
		GlobalData.pageArray.append([page_instance, GlobalData.numberOfQuestions])
		page_instance.popup_question.connect(_on_popup_question)
		page_instance.visible = false
		pageCount += 1
	GlobalData.pageArray[0][0].visible = true

func createTeams():
	for i in range(5):
		var teamInstance = team_scene.instantiate()
		$QuestionField/HBoxContainer2/TeamContainer.add_child(teamInstance)
		teamInstance.setTeam("Team %d" % (i), i)
		teamArray.append(teamInstance)
		teamInstance.team_clicked.connect(_activate_change_team_name)

func _on_popup_question(reward, questionText, alt1, alt2, alt3, correctAnswer):
	var questionContainerInstance = question_container_scene.instantiate()
	questionContainerInstance.setQuestionData(reward, questionText, alt1, alt2, alt3, correctAnswer)
	questionContainerInstance.close_popup_question.connect(_on_close_popup_question)
	$QuestionField/HBoxContainer2/CenterContainer.add_child(questionContainerInstance)
	GlobalData.question_open = true
	$GlobalLight.enabled = true
	
func _on_close_popup_question():
	GlobalData.question_open = false
	$GlobalLight.enabled = false
	GlobalData.updateQuestionsAnswered()
	
func _on_scores_updated(new_scores: Array):
	for i in range(teamArray.size()):
		teamArray[i].setScore(new_scores[i])

func _on_change_team(teamNumber: int):
	for i in range(teamArray.size()):
		teamArray[i].toggleActive(i == teamNumber)

func _activate_change_team_name(teamNumber: int):
	$TeamNameInput.activate(teamNumber)

func _update_team_name(newName: String, teamNumber: int):
	teamArray[teamNumber].changeTeamName(newName)

func _on_page_complete(newPageNumber: int):
	print("Page complete")
	GlobalData.pageArray[newPageNumber-1][0].visible = false
	GlobalData.pageArray[newPageNumber][0].visible = true

func _on_game_finished(winningTeam: int):
	teamArray[winningTeam].celebrate()
