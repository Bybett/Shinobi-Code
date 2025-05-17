extends Node

var SCORE: int = 0
var ROUND: int = 0
var PLAYER_HEALTH: int = 100

#Map Dimensions
const MIN_X: int = 00 # -x size
const MAX_X: int = 500 # +x size
const MIN_Y: int = 0 # -y size
const MAX_Y: int = 500 # +y size

#Grab Player node as PLAYER
const PLAYER_SCENE = preload("res://Scenes/Player Scenes/player_scene.tscn")
var PLAYER = PLAYER_SCENE.instantiate() 

# Grab slime scene as SLIME_SCENE
const SLIME_SCENE = preload("res://Scenes/slime_scene.tscn")

# Grab sword swipe scene as SWORD_SWIPE_SCENE
const SWORD_SWIPE_SCENE = preload("res://Scenes/Player Scenes/sword_swipe.tscn")

# list of all interactable objects/entities
var ENTITIES = [] 
