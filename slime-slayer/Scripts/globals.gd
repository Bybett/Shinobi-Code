extends Node

var score: int = 0

const MIN_X = 00.0 #map x size
const MAX_X = 500.0 #map x size
const MIN_Y = 0.0 #map y size
const MAX_Y = 500.0 #map y size

const MAX_ATTEMPTS = 10 # how man you can fit in map

const PLAYER_SCENE = preload("res://Scenes/Player Scenes/player_scene.tscn")
var PLAYER = PLAYER_SCENE.instantiate() #player node

var ROUND = 0

# Preload the Enemy scene
const ENEMY_SCENE = preload("res://Scenes/enemy_scene.tscn")

var ENTITIES = [] # list of all interactable objects/entities
const MIN_DISTANCE = 150.0 # distance from each enemy

@export var HERO_HEALTH: int = 100
