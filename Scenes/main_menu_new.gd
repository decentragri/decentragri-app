extends Control




func _ready() -> void:
	connect_signals()


func connect_signals() -> void:
	set_bottom_menu_buttons()
	
	
func set_bottom_menu_buttons() -> void:
	for button: TextureButton in get_tree().get_nodes_in_group(&"BottonMenuButtons"):
		var _1: int = button.pressed.connect(_on_set_botton_menu_buttons_pressed.bind(button.name))
		var _2: int = button.pressed.connect(_on_toggle_container_visibility.bind(button.name))
	
	
func _on_set_botton_menu_buttons_pressed(button_name: String) -> void:
	for button: TextureButton in get_tree().get_nodes_in_group("BottonMenuButtons"):
		var panel: Panel = button.get_parent()
		panel.mouse_filter = Control.MOUSE_FILTER_STOP
		var icon: TextureRect = button.get_child(0)
		var is_selected: bool = button.name == button_name

		button.button_pressed = is_selected

		# ✅ Mutate the existing stylebox (assumes per-panel instance)
		var stylebox: StyleBoxFlat = panel.get_theme_stylebox("panel")
		if is_selected:
			stylebox.bg_color = Color("9ff300")
			icon.modulate = Color("ffffff")
		else:
			stylebox.bg_color = Color("1d1d1d")
			icon.modulate = Color("a2a0a0")

			
func _on_toggle_container_visibility(button_name: String) -> void:
	for container: VBoxContainer in get_tree().get_nodes_in_group(&"MainContainers"):
		if button_name + "Container" == container.name:
			container.visible = true
		else:
			container.visible = false
	
	
func _on_home_container_forecast_button_pressed() -> void:
	%WeatherForecastContainer.visible = true
	_on_toggle_container_visibility("WeatherForecast")
	_on_set_botton_menu_buttons_pressed("WeatherForecast")
