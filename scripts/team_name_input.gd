extends LineEdit

signal submit_team_name(newName: String, teamIndex: int)

var teamNumber := -1

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("enter") && teamNumber >= 0:
		submit_team_name.emit(text, teamNumber)
		teamNumber = -1
		visible = false
		text = ""
		

func activate(teamIndex: int):
	visible = true
	teamNumber = teamIndex
	grab_focus()
