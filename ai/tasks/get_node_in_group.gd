#*
#* get_node_in_group.gd
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
## Stores a node from a scene group with the given index on the blackboard and returns [code]SUCCESS[/code]. [br]
## Returns [code]FAILURE[/code] if the group doesn't have a node with such index.


## Node group name.
@export var group: StringName = &"some_group"

## Order in the group.
@export var index: int = 0

## Blackboard variable that will hold the result.
@export var result_var: StringName = &"node"


func _generate_name() -> String:
	return "GetNodeInGroup \"%s\"  idx: %s  %s" % [
		group, index, LimboUtility.decorate_output_var(result_var)]


func _tick(_delta: float) -> Status:
	var nodes: Array[Node] = agent.get_tree().get_nodes_in_group(group)
	if index >= nodes.size() or index < 0:
		push_warning("GetNodeInGroup: Node not found in group \"%s\" with index %s" % [group, index])
		return FAILURE

	blackboard.set_var(result_var, nodes[index])
	return SUCCESS
