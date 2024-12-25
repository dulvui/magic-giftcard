# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Control

const GIFTS = [
	"3x TEATRO",
	"3x CINEMA",
	"1x BRUNCH",
	"1x MIHO",
	"2x VIKTORS",
	"1x TERME MERANO"
]

const JOKE_GIFTS = [
	"",
	"",
	"",
	"",
	"",
	""
]

const LABEL_HEIGHT:int = 122
const SCROLL_TIME:int = 5

onready var scroll:ScrollContainer = $ScrollContainer
onready var list:VBoxContainer = $ScrollContainer/List
onready var tween:Tween = $Tween
onready var retry_button:Button = $Retry
onready var animation_player:AnimationPlayer = $AnimationPlayer


var gift_labels:Array = []

func _ready() -> void:
	for i in range(GIFTS.size() * 1000):
		_add_label(GIFTS[i % GIFTS.size()])
		_add_label(JOKE_GIFTS[i % JOKE_GIFTS.size()])
		
	yield(get_tree().create_timer(0.8), "timeout")
	_spin()


	
func _add_label(text:String) -> void:
	var label:Label = Label.new()
	label.align = Label.ALIGN_CENTER
	label.text = text
	list.add_child(label)
	
	gift_labels.append(label)

func _spin() -> void:
	var random_gift_position:int = int(rand_range(10, 500)) * LABEL_HEIGHT
	print(random_gift_position)
	tween.interpolate_property(scroll, "scroll_vertical", 0, random_gift_position, SCROLL_TIME, Tween.TRANS_SINE)
	tween.connect("tween_all_completed", self, "_show_retry")
	tween.start()
	

func _on_Retry_pressed()  -> void:
	get_tree().change_scene("res://src/gift_roulette/gift_roulette.tscn")
	
func _show_retry() -> void:
	animation_player.play("RetryFadeIn")
