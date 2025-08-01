extends Control



func _ready() -> void:
	connect_signals()
	
	
func connect_signals() -> void:
	var _2: int = Auth.login_complete.connect(_on_login_complete)
	
	
func _on_login_complete(message: Dictionary) -> void:
	if message.has("error"):
		%ErrorLabel.text = message.error
		%AnimationPlayer.play(&"error_message")
		%LoadingPanel.visible = false
		%LoginButton.disabled = false
		return
	var scene: PackedScene = preload("res://Scenes/main_menu_new.tscn")
	var _1: int = get_tree().change_scene_to_packed(scene)
	loading_start(false)
	
	
func _on_username_login_text_changed(_new_text: String) -> void:
	_update_login_button_state()
	
	
func _on_password_login_text_changed(_new_text: String) -> void:
	_update_login_button_state()
	
	
func _update_login_button_state() -> void:
	# Enable login button only if both fields are filled
	%LoginButton.disabled = false
	
	
func _on_login_button_pressed() -> void:
	var username: String = %UsernameLogin.text.strip_edges()
	var password: String = %PasswordLogin.text
	
	if username.is_empty() or password.is_empty():
		%ErrorLabel.text = "Please enter your username and password."
		%AnimationPlayer.play(&"error_message")
		return

	# Trigger login
	Auth.login(username, password)
	%LoginButton.disabled = true  # Optional: disable button while logging in
	loading_start(true)
	
	
func loading_start(is_loading: bool = false) -> void:
	%LoadingPanel.visible = is_loading
	if is_loading:
		await get_tree().create_timer(10.0).timeout
		%LoadingPanel.visible = false
	
	
func _on_username_login_editing_toggled(_toggled_on: bool) -> void:
	pass
	
	
func _on_username_login_focus_entered() -> void:
	for node: Variant in get_tree().get_nodes_in_group("HideWhileTyping"):
		node.visible = false

	
func _on_password_login_focus_entered() -> void:
	for node: Variant in get_tree().get_nodes_in_group("HideWhileTyping"):
		node.visible = false
	
func _on_login_button_focus_entered() -> void:
	for node: Variant in get_tree().get_nodes_in_group("HideWhileTyping"):
		node.visible = true
	
