#*
#* save_node_pos.gd
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
## SaveNodePos saves the position of a node on the blackboard and returns [code]SUCCESS[/code].


## Specify node.
@export var node: BBNode = BBNode.new()

## Specify blackboard variable to store result.
@export var position_var: StringName = &"target_pos"


func _generate_name() -> String:
	return "SaveNodePos %s  %s" % [
			node,
			LimboUtility.decorate_output_var(position_var),
		]


func _tick(_delta: float) -> Status:
	var node_inst = node.get_value(scene_root, blackboard) # Note: Untyped to support both Node2D and Node3D
	if not is_instance_valid(node_inst):
		push_warning("SaveNodePos: Failed to resolve node parameter: " + str(node))
		return FAILURE

	blackboard.set_var(position_var, node_inst.global_position)
	return SUCCESS
