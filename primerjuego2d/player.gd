extends Area2D
signal hit
@export var speed = 400 #aca definimos la velocidad inicial para el jugador

var screen_size; # con esto definimos el tamaño de la ventana para el juego



# Called when the node enters the scene tree for the first time.
func _ready() :
	screen_size = get_viewport_rect().size # con esto el nodo player ya entra en escena con lo que le programaremos
	#hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # es el vector des deonde se movera el jugador
	if Input.is_action_pressed("move_right"):
		
		velocity.x += 1# con esto se movera uno a la derecha
	
	if Input.is_action_pressed("move_left"):
		velocity.x -=1 # con esto hacemos q se mueva uno menos a la izquierda
		
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		
	if Input.is_action_pressed("move_up"):
		velocity.y -=1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	
	position += velocity * delta
	position =  position.clamp(Vector2.ZERO,screen_size) 
	
#En este metodo definimos que imagenes queremos que se vean segun el movimiento que efectue nuestro personaje
	if velocity.x !=0: $AnimatedSprite2D.animation="walk"
	$AnimatedSprite2D.flip_v=false
	$AnimatedSprite2D.flip_h= velocity.x >0 
	if velocity.y != 0: $AnimatedSprite2D.animation = "up"
	$AnimatedSprite2D.flip_v= false
	$AnimatedSprite2D.flip_v= velocity.y >0
	


func _on_body_entered(body):
	pass # Replace with function body.

	hide() # el jugador desaparecera luego de ser golpeado
	hit.emit()
	# esto se hace para no cambiar las propiedades fisicas
	$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos): # con esta funcion se desactiva el collisionshape luego de volver a iniciar el juego
	
	position = pos
	show()
	$CollisionShape2D.disabled = false
