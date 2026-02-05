extends VBoxContainer

@export var category_title_scene := preload("res://scenes/category_title.tscn")
@export var question_option_scene := preload("res://scenes/question_option.tscn")

signal popup_question(reward, questionText, alt1, alt2, alt3, correctAnswer)

var score: int = 100

func provideCategoryData(categoryData: Dictionary):
	for questionNum in categoryData:
		if questionNum == "categoryName":
			var categoryTitle = categoryData[questionNum]
			setCategory(categoryTitle)
			continue
		var questionData = categoryData[questionNum]
		setQuestion(questionData)

func setCategory(category):
	var categoryTitleInstance = category_title_scene.instantiate()
	categoryTitleInstance.setText(category)
	add_child(categoryTitleInstance)
	

func setQuestion(question):
	var questionOptionInstance = question_option_scene.instantiate()
	questionOptionInstance.setData(score, question)
	questionOptionInstance.question_clicked.connect(_on_popup_question)
	add_child(questionOptionInstance)
	score += 100

func _on_popup_question(reward, questionText, alt1, alt2, alt3, correctAnswer):
	popup_question.emit(reward, questionText, alt1, alt2, alt3, correctAnswer)
	pass
