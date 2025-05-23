extends MarginContainer

@export var label_vida_player : Label
@export var label_vida_inimigo : Label

var enemy_life = Globals.enemy_life
var enemy_energy = Globals.enemy_energy
var enemy_defense : int = 0

var player_life = Globals.player_life
var player_energy = Globals.player_energy
var player_defense : int = 0

var damage : int
var damage_received : int
var attack : int
var attack_received : int

var actions = ["puto"]

func _ready():
	pass
	

func _on_puto_button_up() -> void:
	player_defense = 0
	attack = 4
	var random_action = actions[randi() % actions.size()]
	call(random_action)
	player_life -= attack_received
	enemy_life += -attack + enemy_defense
	
	#atualização do label
	label_vida_inimigo.text = str(enemy_life)
	label_vida_player.text = str(player_life)
	
func _on_superputo_button_up() -> void:
	if player_energy >= 3:
		print("player escolheu a carta superputo")
		player_energy -=3
		player_defense = -3
		attack = 8
		var random_action = actions[randi() % actions.size()]
		call(random_action)
		player_life += -attack_received + player_defense
		enemy_life += -attack + enemy_defense
		
		label_vida_inimigo.text = str(enemy_life)
		label_vida_player.text = str(player_life)
	else:
		print("você não tem energia o suficiente")

func _on_jarra_pressed() -> void:
	pass # Replace with function body.


func _on_jarra_button_up() -> void:
	pass # Replace with function body.


func _on_comendo_button_up() -> void:
	pass # Replace with function body.

func puto():
	enemy_defense = 0
	attack_received = 4
	print("inimigo escolheu a carta puto")

func superputo():
	enemy_defense = -3
	attack_received = 8
	print("inimigo escolheu a carta puto")
func jarra():
	pass
	
func comendo():
	pass
	
