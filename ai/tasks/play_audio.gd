#*
#* play_audio.gd
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
## PlayAudio: Starts playback of AudioStreamPlayer[2D, 3D] and returns SUCCESS.


## Specify audio player node.
@export var audio_player: BBNode

var _audio_player  # Note: Untyped to support different audio player nodes.


func _generate_name() -> String:
	return "PlayAudio %s" % [audio_player]


func _setup() -> void:
	_audio_player = audio_player.get_value(agent, blackboard)
	assert(_audio_player != null and _audio_player.has_method(&"play"))


func _tick(_delta: float) -> int:
	_audio_player.play()
	return SUCCESS
