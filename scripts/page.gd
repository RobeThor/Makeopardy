extends MarginContainer

@export var category_scene := preload("res://scenes/category.tscn")
@export var question_container_scene := preload("res://scenes/question_container.tscn")

signal popup_question(reward, questionText, alt1, alt2, alt3, correctAnswer)
signal transition_complete()

@onready var categories_container = $CategoriesContainer

func providePageData(pageData: Dictionary, pageNumber: int):
	for categoryName in pageData:
		var category_instance = category_scene.instantiate()
		categories_container.add_child(category_instance)
		category_instance.provideCategoryData(pageData[categoryName], pageNumber)
		category_instance.popup_question.connect(_on_popup_question)

func _on_popup_question(reward, questionText, alt1, alt2, alt3, correctAnswer):
	popup_question.emit(reward, questionText, alt1, alt2, alt3, correctAnswer)
