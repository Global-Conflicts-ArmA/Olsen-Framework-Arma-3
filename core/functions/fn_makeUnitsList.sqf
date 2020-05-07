/*
 * Author: BlackHawk
 *
 * Creates array on the server containing all units with missing gear type
 *
 * Arguments:
 * 0: class <string>
 * 1: unit <object>
 *
 * Return Value:
 * nothing
 *
 * Public: No
 */

#include "..\script_macros.hpp"

params ["_class", "_unit"];

if (isNil QGVAR(missing_gear)) then {
	GVAR(missing_gear) = [];
	[{
	    publicVariable QGVAR(missing_gear);
	}, []] call CBA_fnc_execNextFrame;
};

private _index = -1;

{
	if ((_x select 0) isEqualTo _class) exitWith {_index = _forEachIndex};
} foreach GVAR(missing_gear);

if (_index != -1) then {
	((GVAR(missing_gear) select _index) select 1) pushBackUnique _unit;
} else {
	GVAR(missing_gear) pushBack [_class, [_unit]];
};

if (CBA_missionTime > 0) then {
	publicVariable "GVAR(missing_gear)";
};