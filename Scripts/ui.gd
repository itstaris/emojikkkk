extends MarginContainer

@export var label_vida_player : Label
@export var label_vida_inimigo : Label

@export var label_energia_player : Label
@export var label_energia_inimigo : Label

@export var label_status_inimigo : Label
@export var label_descricao : Label

var enemy_life = Globals.enemy_life
var enemy_energy = Globals.enemy_energy
var enemy_defense : int = 0

var player_life = Globals.player_life
var player_energy = Globals.player_energy
var player_defense : int = 0

var attack : int
var attack_received : int

var actions = ["puto", "superputo", "jarra", "comendo", "tuqui"]

func _ready():
	enemy_defense = 0
	player_defense = 0
	player_life = 20
	enemy_life = 20
	player_energy = 10
	enemy_energy = 10
	
	
func _process(_delta):
	if  player_life <= 0:
		print("você perdeu")
		get_tree().change_scene_to_file("res://Scenes/loser.tscn")

	if enemy_life <=0:
		print("você ganhou")
		get_tree().change_scene_to_file("res://Scenes/winner.tscn")

	if player_life <= 0 && enemy_life <=0:
		print("empate")
		get_tree().change_scene_to_file("res://Scenes/tie.tscn")

func _on_puto_button_up() -> void:
	print("player escdolheu a carta puto")
	player_defense = 0
	attack = 4
	
	var random_action = actions[randi() % actions.size()]
	call(random_action)
	
	player_life -= attack_received
	if -attack + enemy_defense < 0:
		enemy_life += - attack + enemy_defense
	
	#atualização do label
	label_vida_inimigo.text = str(enemy_life)
	label_vida_player.text = str(player_life)
	
	label_energia_player.text = str(player_energy)
	label_energia_inimigo.text = str(enemy_energy)
	
func _on_superputo_button_up() -> void:
	if player_energy >= 3:
		print("player escolheu a carta superputo")
		player_energy -=3
		player_defense = -3
		attack = 8
		
		var random_action = actions[randi() % actions.size()]
		call(random_action)
		
		if -attack_received + player_defense < 0:
			player_life += - attack_received + player_defense
		if -attack + enemy_defense < 0:
			enemy_life += - attack + enemy_defense
		
		label_vida_inimigo.text = str(enemy_life)
		label_vida_player.text = str(player_life)
		
		label_energia_player.text = str(player_energy)
		label_energia_inimigo.text = str(enemy_energy)
	else:
		print("você não tem energia o suficiente")

func _on_jarra_button_up() -> void:
	if player_energy >= 2:
		print("player escolheu a carta jarra")
		player_energy -=2
		player_defense = 4
		attack = 2
		
		var random_action = actions[randi() % actions.size()]
		call(random_action)
		
		if -attack_received + player_defense < 0:
			player_life += - attack_received + player_defense
		if -attack + enemy_defense < 0:
			enemy_life += - attack + enemy_defense
			
		#atualização do label
		label_vida_inimigo.text = str(enemy_life)
		label_vida_player.text = str(player_life)
		
		label_energia_player.text = str(player_energy)
		label_energia_inimigo.text = str(enemy_energy)
	else:
		print("você não tem energia o suficiente")
	
func _on_comendo_button_up() -> void:
	player_defense = 0
	player_life += 6
	player_energy += 3
	if player_life > 20:
		player_life = 20
	if player_energy > 10:
		player_energy = 10
	
	var random_action = actions[randi() % actions.size()]
	call(random_action)
	
	player_life -= attack_received
	
	#atualização do label
	label_vida_inimigo.text = str(enemy_life)
	label_vida_player.text = str(player_life)
	
	label_energia_player.text = str(player_energy)
	label_energia_inimigo.text = str(enemy_energy)
	
func _on_tuqui_button_up() -> void:
	if player_energy >= 1:
		print("player escolheu a carta tuqui")
		player_energy -=1
		attack = 5
		player_defense = 0
		
		var random_action = actions[randi() % actions.size()]
		call(random_action)
		
		player_life += -attack_received - attack
		if -attack + enemy_defense < 0:
			enemy_life += - attack + enemy_defense
		
		#atualização do label
		label_vida_inimigo.text = str(enemy_life)
		label_vida_player.text = str(player_life)
		
		label_energia_player.text = str(player_energy)
		label_energia_inimigo.text = str(enemy_energy)
	else:
		print("você não tem energia o suficiente")


func puto():
	enemy_defense = 0
	attack_received = 4
	label_status_inimigo.text = str("The enemy attacked using Puto!")
	print("inimigo escolheu a carta puto")

func superputo():
	enemy_defense = -3
	attack_received = 8
	label_status_inimigo.text = str("The enemy attacked using SuperPuto!")
	print("inimigo escolheu a carta superputo")

func jarra():
	if enemy_energy >= 2:
		enemy_defense = 4
		attack_received = 2
		print("inimigo escolheu a carta jarra")
		label_status_inimigo.text = str("The enemy attacked using Jarra!")
	else:
		var random_action = actions[randi() % actions.size()]
		call(random_action)
	
func comendo():
	enemy_defense = 0
	enemy_life += 6
	enemy_energy += 3
	attack_received = 0
	if enemy_life > 20:
		enemy_life = 20
	print("inimigo escolheu a carta comendo")
	if enemy_energy > 10:
		enemy_energy = 10
	label_status_inimigo.text = str("The enemy recovered 6 HP and 3 STA\nusing Comendo!")
	
func tuqui():
	if enemy_energy >=1:
		enemy_defense = 0
		enemy_energy -=1
		attack_received = 5
		enemy_life += -attack_received
		label_status_inimigo.text = str("The enemy attacked using Tuqui!")
		print("inimigo escolheu a carta tuqui")
	else:
		var random_action = actions[randi() % actions.size()]
		call(random_action)


func _on_puto_mouse_entered() -> void:
	label_descricao.text = str("PUTO\nA simple attack.\nDamage: 4\nDefense: 0")


func _on_superputo_mouse_entered() -> void:
	label_descricao.text = str("SUPERPUTO\nYour attack is stronger,\nbut you lose your defense.\nDamage: 8\nDefense: -3\nSTA: -3")


func _on_jarra_mouse_entered() -> void:
	label_descricao.text = str("JARRA\nYour defense is stronger,\nbut your attack is weaker.\nDamage: 2\nDefense: 4\nSTA: -2")


func _on_comendo_mouse_entered() -> void:
	label_descricao.text = str("COMENDO\nYou recover your energies.\nSTA: +3\nHP: +6")


func _on_tuqui_mouse_entered() -> void:
	label_descricao.text = str("TUQUI\nYour attack is stronger,\nbut you also take damage.\nSTA: -1\nDamage: 5\nHP: -5")


func _on_puto_mouse_exited() -> void:
	label_descricao.text = str(" ")


func _on_superputo_mouse_exited() -> void:
	label_descricao.text = str(" ")


func _on_jarra_mouse_exited() -> void:
	label_descricao.text = str(" ")


func _on_comendo_mouse_exited() -> void:
	label_descricao.text = str(" ")


func _on_tuqui_mouse_exited() -> void:
	label_descricao.text = str(" ")
