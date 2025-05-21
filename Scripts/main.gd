"""Handle desktop logic and inputs"""
extends Node2D


@onready var icons : Array = [
	$MainMenu/QGIcon, $MainMenu/FolderIcon, $MainMenu/SettingsIcon, 
	$MainMenu/TextFileIcon, $MainMenu/CloseButton
]

	
	#for icon in icons:
		#icon.visible = false
