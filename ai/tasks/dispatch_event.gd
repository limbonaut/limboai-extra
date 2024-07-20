#*
#* dispatch_event.gd
#* =============================================================================
#* Copyright 2024 Serhii Snitsaruk
#*
#* Use of this source code is governed by an MIT-style
#* license that can be found in the LICENSE file or at
#* https://opensource.org/licenses/MIT.
#* =============================================================================
#*
@tool
extends BTAction
## Dispatches an event to a [LimboHSM] and returns [code]SUCCESS[/code]. [br]
## Returns [code]FAILURE[/code] if [member hsm_var] doesn't refer to a valid [LimboState] on the blackboard.

## Event to be dispatched.
@export var event_name: String

## Blackboard variable that holds a reference to [LimboHSM] or [LimboState].
@export var hsm_var: StringName


func _generate_name() -> String:
	return "DispatchEvent \"%s\"  hsm: %s" % [event_name, LimboUtility.decorate_var(hsm_var)]


func _tick(_delta: float) -> Status:
	var hsm: LimboState = blackboard.get_var(hsm_var)
	if not is_instance_valid(hsm):
		push_error("DispatchEvent: HSM not found on the blackboard")
		return FAILURE

	hsm.dispatch(event_name)
	return SUCCESS
