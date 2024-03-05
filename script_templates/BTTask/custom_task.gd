# meta-name: Custom Task
# meta-description: Custom task to be used in a BehaviorTree
# meta-default: true
@tool
extends _BASE_
## _CLASS_


# Display a customized name (requires @tool).
func _generate_name() -> String:
_TS_return "_CLASS_"


# Called once during initialization.
func _setup() -> void:
_TS_pass


# Called each time this task is entered.
func _enter() -> void:
_TS_pass


# Called each time this task is exited.
func _exit() -> void:
_TS_pass


# Called each time this task is ticked (aka executed).
func _tick(delta: float) -> Status:
_TS_return SUCCESS


# Strings returned from this method are displayed as warnings in the behavior tree editor (requires @tool).
func _get_configuration_warnings() -> PackedStringArray:
_TS_var warnings := PackedStringArray()
_TS_return warnings
