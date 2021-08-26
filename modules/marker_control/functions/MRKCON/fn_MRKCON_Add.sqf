#include "script_component.hpp"

params[
  ["_side", blufor, [blufor]],
  ["_name", "", [""]],
  ["_deleteAfterStart", false, [false]]
];

diag_log format ["Markers: %1", GVAR(Markers)];

if !(markerType _name == "") then {
	GVAR(Markers) set [count GVAR(Markers), [_side, _name, _deleteAfterStart]];
} else {
	_temp = format ["Marker control module:<br></br>Warning marker ""%1"", in file ""modules\marker control\settings.sqf"" does not exist.", _name];
	_temp call FNC_DebugMessage;
};
