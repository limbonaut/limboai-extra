#*
#* is_time_elapsed.gd
#* =============================================================================
#* Copyright 2024 Serhii Snitsaruk
#*
#* Use of this source code is governed by an MIT-style
#* license that can be found in the LICENSE file or at
#* https://opensource.org/licenses/MIT.
#* =============================================================================
#*
@tool
extends BTCondition
## IsTimeElapsed checks if the given time passed since the root task started [code]RUNNING[/code].

## Specify duration in seconds.
@export_range(0.0, 1000.0, 0.01) var time_sec: float:
	set(v):
		time_sec = v
		emit_changed()


func _generate_name() -> String:
	return "IsTimeElapsed %s sec" % [snappedf(time_sec, 0.001)]


func _tick(_delta: float) -> Status:
	if get_root().elapsed_time >= time_sec:
		return SUCCESS
	return FAILURE
