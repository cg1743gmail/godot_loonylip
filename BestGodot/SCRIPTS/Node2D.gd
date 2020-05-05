extends Node2D

var prompt_info := ["your name","food you like","feeling after that"]
var player_input = []
var story_template = "oneday a man namded %s she ate a %s, then he %s"
var game_over = false
#知识点：  1  %s   % XX     占位符替换的使用

# 01 调用 prompt info 方法
func _ready():
	prompt_info()




#唯一的难点：
# 如果玩家输入 数组长度小于 提示信息的长度 ，则显示提示信息（内容替换为当前数组长度位置的内容）
#如果数组等于或者大于，则输入完毕  执行  讲故事方法
# 数组长度为3 要注意prompt_info中提示信息数组长度最大只能到3（第4次执行就要触发讲故事而不是
#继续添加成员）
func prompt_info():
	if player_input.size() < prompt_info.size():
		$RichTextLabel.text = "input your %s" % prompt_info[player_input.size()]
	else:
		tell_story()
		$Button.text = "restart"
		



# line edit  按enter 则调用此事件，也可以在其他函数调用此事件,也可以不使用此方法
func _on_LineEdit_text_entered(new_text):
	print("填入数字")
	player_input.append(new_text)
	prompt_info()

#按钮事件 输入不为空   就 把信息转入添加信息提示的方法,如果流程结束 按此键就走重玩分支
func _on_Button_pressed():
	if !game_over:
		if $LineEdit.get_text() != "":
			var temp = $LineEdit.get_text()
			_on_LineEdit_text_entered(temp)
			$LineEdit.clear()
	else:
		get_tree().reload_current_scene()
	
	
func tell_story():
	$RichTextLabel.text = story_template % player_input
	game_over = true
	
	


