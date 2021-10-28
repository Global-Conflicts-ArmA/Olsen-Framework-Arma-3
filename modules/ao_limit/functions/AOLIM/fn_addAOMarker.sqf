#include "script_component.hpp"

params[
  ["_side", blufor, [blufor]],
  ["_name", "", [""]]
];

diag_log format ["INFO: Marker type = %1", (markerType _name)];

if !((markerType _name) isEqualTo "") then {
  GVAR(markers) pushBack [_side, _name];
} else {
	private _temp = format ["AO limit module:<br></br>Warning marker ""%1"", in file ""modules\ao_limit\settings.sqf"" does not exist.", _name];
	_temp call EFUNC(FW,DebugMessage);
}
