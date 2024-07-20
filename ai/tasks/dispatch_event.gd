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

## Specify event to be dispatched.
@export var event_name: String

## Specify [LimboHSM] or [LimboState] node.
@export var hsm_node: BBNode


func _generate_name() -> String:
	return "DispatchEvent \"%s\"  hsm: %s" % [event_name, hsm_node]


func _tick(_delta: float) -> Status:
	var state: LimboState = hsm_node.get_value(scene_root, blackboard)
	if not is_instance_valid(state):
		push_error("DispatchEvent: LimboState not valid: " + str(hsm_node))
		return FAILURE

	state.dispatch(event_name)
	return SUCCESS
