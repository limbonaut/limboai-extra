#*
#* emit_signal.gd
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
## Emits a signal on a [Node] and returns [code]SUCCESS[/code].
## Returns [code]FAILURE[/code] if [member node] parameter fails to provide a valid [Node].


## Specify node that will emit the signal.
@export var node: BBNode

## Specify signal name.
@export var signal_name: StringName = &"some_signal"

## Specify signal arguments if any (up to 6).
@export var arguments: Array[BBVariant] = []


func _generate_name() -> String:
	return "EmitSignal \"%s\"  node: %s" % [signal_name, node]


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray = []
	if not node.is_valid():
		warnings.append("Specify node.")
		if arguments.size() > 6:
			warnings.append("Too many arguments.")
	return warnings


func _tick(_delta: float) -> Status:
	if not node:
		push_error("EmitSignal: Node not specified")
		return FAILURE

	var node_inst: Node = node.get_value(scene_root, blackboard)
	if not is_instance_valid(node_inst):
		push_warning("EmitSignal: Failed to resolve node parameter: " + str(node))
		return FAILURE

	match arguments.size():
		0:
			node_inst.emit_signal(signal_name)
		1:
			node_inst.emit_signal(signal_name, arguments[0].get_value(scene_root, blackboard))
		2:
			node_inst.emit_signal(signal_name, arguments[0].get_value(scene_root, blackboard), arguments[1].get_value(scene_root, blackboard))
		3:
			node_inst.emit_signal(signal_name, arguments[0].get_value(scene_root, blackboard), arguments[1].get_value(scene_root, blackboard), arguments[2].get_value(scene_root, blackboard))
		4:
			node_inst.emit_signal(signal_name, arguments[0].get_value(scene_root, blackboard), arguments[1].get_value(scene_root, blackboard), arguments[2].get_value(scene_root, blackboard), arguments[3].get_value(scene_root, blackboard))
		5:
			node_inst.emit_signal(signal_name, arguments[0].get_value(scene_root, blackboard), arguments[1].get_value(scene_root, blackboard), arguments[2].get_value(scene_root, blackboard), arguments[3].get_value(scene_root, blackboard), arguments[4].get_value(scene_root, blackboard))
		6:
			node_inst.emit_signal(signal_name, arguments[0].get_value(scene_root, blackboard), arguments[1].get_value(scene_root, blackboard), arguments[2].get_value(scene_root, blackboard), arguments[3].get_value(scene_root, blackboard), arguments[4].get_value(scene_root, blackboard), arguments[5].get_value(scene_root, blackboard))
		_:
			push_error("EmitSignal: Signal not emitted -- Unsupported number of arguments: " + str(arguments.size()))
	return SUCCESS
