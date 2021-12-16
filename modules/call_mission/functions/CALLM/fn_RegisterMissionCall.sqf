#include "script_component.hpp"

params [
	["_callID", "", [""]],
	["_callSide", sideUnknown, [sideUnknown]],
	["_callName", "", [""]],
	["_callArgs", [], [[], ""]]
];

GVAR(MissionCalls) pushBack [_callID, _callSide, _callName, _callArgs];
