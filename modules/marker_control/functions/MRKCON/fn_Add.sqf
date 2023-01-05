#include "script_component.hpp"

params [
  ["_side", blufor, [blufor, []]],
  ["_name", "", [""]],
  ["_deleteAfterStart", false, [false]]
];

if ((markerType _name isNotEqualTo "") || (markerShape _name isNotEqualTo "")) then {
  GVAR(Markers) pushBack [_side, _name, _deleteAfterStart];
} else {
	private _temp = format ["Marker control module:<br></br>Warning marker ""%1"", in file ""modules\marker control\settings.sqf"" does not exist.", _name];
	_temp call EFUNC(FW,DebugMessage);
};
