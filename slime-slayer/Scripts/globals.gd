extends Node

var SCORE: int = 0
var ROUND: int = 0
var PLAYER_HEALTH: int = 100

#Map Dimensions
var MIN_X: int = 0 # -x size
var MAX_X: int = ProjectSettings.get_setting("display/window/size/viewport_width") # +x size
var MIN_Y: int = 0 # -y size
var MAX_Y: int = ProjectSettings.get_setting("display/window/size/viewport_height") # +y size

# Base entity values
const entity_size: int = 20

#Grab Player node as PLAYER
const PLAYER_SCENE = preload("res://Scenes/Player Scenes/player_scene.tscn")
var PLAYER = PLAYER_SCENE.instantiate() 

# Grab slime scene as SLIME_SCENE
const SLIME_SCENE = preload("res://Scenes/slime_scene.tscn")

# Grab sword swipe scene as SWORD_SWIPE_SCENE
const SWORD_SWIPE_SCENE = preload("res://Scenes/Player Scenes/sword_swipe.tscn")

# list of all interactable objects/entities
var ENTITIES = [] 
