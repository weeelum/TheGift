extends Control

signal close_requested

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Connect Close button signal to close the app
	%CloseBtn.pressed.connect(_on_close_pressed)
	%HD.pressed.connect(_on_hd_pressed)
	%FullHD.pressed.connect(_on_full_hd_pressed)
	%QHD.pressed.connect(_on_qhd_pressed)
	%UHD.pressed.connect(_on_uhd_pressed)
	

func _on_close_pressed():
	emit_signal("close_requested")

func _on_hd_pressed():
	get_viewport().size = SettingsManager.hd


func _on_full_hd_pressed():
	get_viewport().size = SettingsManager.full_hd
	
	
func _on_qhd_pressed():
	get_viewport().size = SettingsManager.qhd
	

func _on_uhd_pressed():
	get_viewport().size = SettingsManager.uhd
