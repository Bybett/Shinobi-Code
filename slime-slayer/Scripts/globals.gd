extends Node

var score: int = 0

const MIN_X = 00.0 #map x size
const MAX_X = 500.0 #map x size
const MIN_Y = 0.0 #map y size
const MAX_Y = 500.0 #map y size

const MAX_ATTEMPTS = 10 # how man you can fit in map

var enemies = [] # list of enemies
const MIN_DISTANCE = 150.0 # distance from each enemy
