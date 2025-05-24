extends MarginContainer

@export var label_vida_player : Label
@export var label_vida_inimigo : Label

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
		get_tree().paused = true

	if enemy_life <=0:
		print("você ganhou")
		get_tree().paused = true

	if player_life <= 0 && enemy_life <=0:
		print("empate")
		get_tree().paused = true

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
	else:
		print("você não tem energia o suficiente")
	
func _on_comendo_button_up() -> void:
	player_defense = 0
	player_life += 6
	player_energy += 3
	
	var random_action = actions[randi() % actions.size()]
	call(random_action)
	
	player_life -= attack_received
	
	#atualização do label
	label_vida_inimigo.text = str(enemy_life)
	label_vida_player.text = str(player_life)
	
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
	else:
		print("você não tem energia o suficiente")


func puto():
	await get_tree().create_timer(1.0).timeout
	enemy_defense = 0
	attack_received = 4
	print("inimigo escolheu a carta puto")

func superputo():
	await get_tree().create_timer(1.0).timeout
	enemy_defense = -3
	attack_received = 8
	print("inimigo escolheu a carta superputo")

func jarra():
	await get_tree().create_timer(1.0).timeout
	if enemy_energy >= 2:
		enemy_defense = 4
		attack_received = 2
		print("inimigo escolheu a carta jarra")
	else:
		var random_action = actions[randi() % actions.size()]
		call(random_action)
	
func comendo():
	await get_tree().create_timer(1.0).timeout
	enemy_defense = 0
	enemy_life += 6
	enemy_energy += 3
	attack_received = 0
	print("inimigo escolheu a carta comendo")
	
func tuqui():
	await get_tree().create_timer(1.0).timeout
	if enemy_energy >=1:
		enemy_defense = 0
		enemy_energy -=1
		attack_received = 5
		enemy_life += -attack_received
		print("inimigo escolheu a carta tuqui")
	else:
		var random_action = actions[randi() % actions.size()]
		call(random_action)
