extends PanelContainer

signal correct_answer(team: int, score: int)
signal wrong_answer(team: int, score:int)
signal close_popup_question()

var correctOption: int
var reward: int

var teamCanAnswer: Array[bool] = [true, true, true, true, true]

#TODO: Add time limit? Or other way to close a question

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if GlobalData.currentTeam == 9:
		if event.is_action_pressed("button_0") && teamCanAnswer[0]:
			GlobalData.changeCurrentTeam(0)
		if event.is_action_pressed("button_1") && teamCanAnswer[1]:
			GlobalData.changeCurrentTeam(1)
		if event.is_action_pressed("button_2") && teamCanAnswer[2]:
			GlobalData.changeCurrentTeam(2)
		if event.is_action_pressed("button_3") && teamCanAnswer[3]:
			GlobalData.changeCurrentTeam(3)
		if event.is_action_pressed("button_4") && teamCanAnswer[4]:
			GlobalData.changeCurrentTeam(4)
	
	#TODO: keybinding for the team buttons
	pass

func setQuestionData(score, questionText, alt1, alt2, alt3, correctAnswer):
	reward = score
	$QuestionBox/QuestionTextContainer/QuestionText.text = questionText
	$QuestionBox/OptionsList/Option1.text = alt1
	$QuestionBox/OptionsList/Option2.text = alt2
	$QuestionBox/OptionsList/Option3.text = alt3
	correctOption = correctAnswer

func closeQuestion():
	close_popup_question.emit()
	print(teamCanAnswer)
	GlobalData.changeCurrentTeam(9)
	queue_free()

func correctAnswer():
	correct_answer.emit(GlobalData.currentTeam, reward)
	var scoreArray := [0,0,0,0,0]
	scoreArray[GlobalData.currentTeam] += reward
	GlobalData.updateScore(scoreArray)
	closeQuestion()

func wrongAnswer(buttonNumber):
	teamCanAnswer[GlobalData.currentTeam] = false
	wrong_answer.emit(GlobalData.currentTeam, reward/2)
	get_node("QuestionBox/OptionsList/Option%d" %buttonNumber).disabled = true
	
	var scoreArray := [0,0,0,0,0]
	scoreArray[GlobalData.currentTeam] -= reward/2
	GlobalData.updateScore(scoreArray)
	
	GlobalData.changeCurrentTeam(9)

func _on_option_1_pressed() -> void:
	if GlobalData.currentTeam == 9:
		return
	if correctOption != 1:
		wrongAnswer(1)
		return
	correctAnswer()
	print("Pressed 1")


func _on_option_2_pressed() -> void:
	if GlobalData.currentTeam == 9:
		return
	if correctOption != 2:
		wrongAnswer(2)
		return
	correctAnswer()
	print("Pressed 2")


func _on_option_3_pressed() -> void:
	if GlobalData.currentTeam == 9:
		return
	if correctOption != 3:
		wrongAnswer(3)
		return
	correctAnswer()
	
	print("Pressed 3")
