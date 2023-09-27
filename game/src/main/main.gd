# SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

# SPDX-License-Identifier: AGPL-3.0-or-later

extends Control

func _on_Button_pressed():
	get_tree().change_scene("res://src/gift_roulette/gift_roulette.tscn")
