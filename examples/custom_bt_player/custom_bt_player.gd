@tool
class_name CustomBTPlayer
extends Node
## Example of a custom BTPlayer implementation.
##
## Doesn't do anything special - it's just an example of how to make a custom behavior tree player. [br]
## Requirement: LimboAI v1.2+

## Specify behavior tree.
@export var behavior_tree: BehaviorTree:
	set(value):
		if behavior_tree:
			behavior_tree.disconnect("plan_changed", _update_blackboard_plan)
		behavior_tree = value
		if behavior_tree:
			# We should sync our blackboard plan with the BehaviorTree's plan (see _update_blackboard_plan).
			behavior_tree.connect("plan_changed", _update_blackboard_plan)
		_update_blackboard_plan()

## Specify blackboard variables.
@export var blackboard_plan: BlackboardPlan:
	set(value):
		# Ensuring that blackboard plan always exists.
		if value == null:
			blackboard_plan = BlackboardPlan.new()
		else:
			blackboard_plan = value
		_update_blackboard_plan()

var blackboard: Blackboard
var agent: Node
var bt_instance: BTInstance


func _init() -> void:
	# Ensuring that blackboard plan always exists.
	blackboard_plan = BlackboardPlan.new()


func _ready() -> void:
	# Since it is a tool script...
	if not Engine.is_editor_hint():
		# ...only load behavior tree when not in the editor.
		_load_bt()
	else:
		# ...disable physics process when in the editor.
		set_physics_process(false)


func _physics_process(delta: float) -> void:
	if bt_instance == null:
		return
	# Ticking behavior tree instance.
	bt_instance.update(delta)


## Initialize behavior tree instance.
func _load_bt() -> void:
	if behavior_tree == null:
		return

	agent = get_parent()
	var instance_owner: Node = self
	var scene_root: Node = get_owner()

	# Initializing blackboard and filling it with values from the blackboard plan.
	if blackboard_plan != null:
		blackboard = blackboard_plan.create_blackboard(scene_root)
	elif behavior_tree.blackboard_plan != null:
		# Unlikely to happen, as we force blackboard_plan to exist in this node.
		blackboard = behavior_tree.blackboard_plan.create_blackboard(scene_root)
	else:
		blackboard = Blackboard.new()

	# Creating behavior tree instance.
	bt_instance = behavior_tree.instantiate(agent, blackboard, instance_owner, scene_root)


## Synchronize blackboard plan with the behavior tree's plan.
func _update_blackboard_plan() -> void:
	if blackboard_plan == null:
		return
	# Setting BlackboardPlan into derived mode: it will only have variables that are declared in BehaviorTree's blackboard plan.
	# Note: This is done in order to allow our custom player node to satisfy dependencies for BehaviorTree,
	#       that could be declared in the BehaviorTree's blackboard_plan (like a variable that stores AnimationPlayer).
	blackboard_plan.set_base_plan(behavior_tree.blackboard_plan if behavior_tree else null)
