extends Panel


@export var category_scene := preload("res://scenes/category.tscn")
@export var question_container_scene := preload("res://scenes/question_container.tscn")
@export var team_scene := preload("res://scenes/team.tscn")

@onready var categories_container = $QuestionField/HBoxContainer2/CenterContainer/VBoxContainer/CategoriesContainer

var file = "res://jeopardyFormat.json"
var teamArray = []

func _ready() -> void:
	var json_string = FileAccess.get_file_as_string(file)
	GlobalData.scores_updated.connect(_on_scores_updated)
	GlobalData.change_current_team.connect(_on_change_team)
	
	var json_as_dict: Dictionary = JSON.parse_string(json_string)
	if !json_as_dict:
		print("Error parsing JSON")
		return
	
	createCategories(json_as_dict.categories)
	createTeams()

func createCategories(categoriesData: Dictionary):
	for categoryName in categoriesData:
		var category_instance = category_scene.instantiate()
		categories_container.add_child(category_instance)
		category_instance.provideCategoryData(categoriesData[categoryName])
		category_instance.popup_question.connect(_on_popup_question)

func createTeams():
	for i in range(5):
		var teamInstance = team_scene.instantiate()
		$QuestionField/HBoxContainer2/TeamContainer.add_child(teamInstance)
		teamInstance.setTeam("Team %d" % (i), i)
		teamArray.append(teamInstance)

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
	
func _on_scores_updated(new_scores: Array):
	for i in range(teamArray.size()):
		teamArray[i].setScore(new_scores[i])

func _on_change_team(teamNumber: int):
	for i in range(teamArray.size()):
		teamArray[i].toggleActive(i == teamNumber)
