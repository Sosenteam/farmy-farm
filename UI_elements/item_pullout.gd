extends Control

var slot_scene = preload("res://UI_elements/item_slot.tscn")
var slots = []
var is_open = false
var selected_slot = null

signal item_selected(item_data)

func _ready() -> void:
    # Hide initially
    hide()
    Inventory.on_inventory_changed.connect(_update_slots)

func setup(category: String, items_list: Array, prices: Dictionary = {}):
    # Clear existing
    for slot in slots:
        slot.queue_free()
    slots.clear()
    
    # Create slots
    for item_type in items_list:
        var new_slot = slot_scene.instantiate()
        add_child(new_slot)
        var price = prices.get(item_type, 5)
        new_slot.setup(item_type, category, price)
        new_slot.slot_clicked.connect(_on_slot_clicked)
        slots.append(new_slot)
        new_slot.position = Vector2.ZERO # Start at center
    
    _update_slots()

func _update_slots():
    for slot in slots:
        slot.update_display()

func _on_slot_clicked(slot_node):
    for s in slots:
        s.selected_effect(false)
    
    if selected_slot == slot_node:
        selected_slot = null
        item_selected.emit(null)
        return
        
    selected_slot = slot_node
    selected_slot.selected_effect(true)
    item_selected.emit(selected_slot.item_data)

func open():
    if is_open: return
    is_open = true
    show()
    
    # Calculate spacing
    var spacing = 25
    var total_width = (slots.size() - 1) * spacing
    var start_x = -total_width / 2.0
    
    for i in range(slots.size()):
        var slot = slots[i]
        var target_pos = Vector2(start_x + i * spacing, -30) # Above the center
        
        var tween = create_tween()
        tween.set_parallel(true)
        tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
        
        # Animate position only
        slot.position = Vector2.ZERO
        slot.scale = Vector2.ONE
        tween.tween_property(slot, "position", target_pos, 0.25 + (i * 0.02))
        # Fade in
        slot.modulate.a = 0
        tween.tween_property(slot, "modulate:a", 1.0, 0.2)

func close():
    if not is_open: return
    is_open = false
    
    for slot in slots:
        var tween = create_tween()
        tween.set_parallel(true)
        tween.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
        
        tween.tween_property(slot, "position", Vector2.ZERO, 0.2)
        tween.tween_property(slot, "modulate:a", 0.0, 0.15)
    
    # Hide after all tweens?
    get_tree().create_timer(0.4).timeout.connect(hide)
